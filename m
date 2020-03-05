Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E288C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1203C20732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1203C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rJu-00052Y-6U
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9rIH-0003Yx-Hy
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9rIG-00050r-2m
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:16:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9rIF-0004zy-QN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:16:08 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025E8iHf114594
 for <qemu-devel@nongnu.org>; Thu, 5 Mar 2020 09:16:06 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhsvb61ug-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:16:04 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 5 Mar 2020 14:16:01 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Mar 2020 14:15:58 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 025EFvB161341910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 14:15:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 086DD52052;
 Thu,  5 Mar 2020 14:15:57 +0000 (GMT)
Received: from dyn-9-152-224-184.boeblingen.de.ibm.com (unknown
 [9.152.224.184])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D57BB5205A;
 Thu,  5 Mar 2020 14:15:56 +0000 (GMT)
Subject: Re: [PATCH v6 03/18] s390x: protvirt: Support unpack facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-4-frankja@linux.ibm.com>
 <7e19dc7d-2d5c-eed7-7ca0-a539047775c6@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 5 Mar 2020 15:15:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7e19dc7d-2d5c-eed7-7ca0-a539047775c6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZDFPCwPbyn5DoiPQKO3dWGKqM236xdwrc"
X-TM-AS-GCONF: 00
x-cbid: 20030514-0028-0000-0000-000003E12EE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030514-0029-0000-0000-000024A66408
Message-Id: <900baedf-4b4c-0ae0-d82c-3741f0c42e15@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_04:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=11 impostorscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050092
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZDFPCwPbyn5DoiPQKO3dWGKqM236xdwrc
Content-Type: multipart/mixed; boundary="chfdPmeFZeNg4FrvUhDc6nQZUqXSoJnFT"

--chfdPmeFZeNg4FrvUhDc6nQZUqXSoJnFT
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/5/20 2:52 PM, David Hildenbrand wrote:
> On 04.03.20 12:42, Janosch Frank wrote:
>> When a guest has saved a ipib of type 5 and calls diagnose308 with
>> subcode 10, we have to setup the protected processing environment via
>> Ultravisor calls. The calls are done by KVM and are exposed via an
>> API.
>>
>> The following steps are necessary:
>> 1. Enable protected mode for the VM (register it and its cpus with the=
 Ultravisor)
>> 2. Forward the secure header to the Ultravisor (has all information on=

>> how to decrypt the image and VM information)
>> 3. Protect image pages from the host and decrypt them
>> 4. Verify the image integrity
>>
>> Only after step 4 a protected VM is allowed to run.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes=

>> to machine]
>> ---
>>  hw/s390x/Makefile.objs              |   1 +
>>  hw/s390x/ipl.c                      |  33 +++++++++
>>  hw/s390x/ipl.h                      |   2 +
>>  hw/s390x/pv.c                       | 106 +++++++++++++++++++++++++++=
+
>>  hw/s390x/pv.h                       |  34 +++++++++
>>  hw/s390x/s390-virtio-ccw.c          |  91 ++++++++++++++++++++++++
>>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>>  target/s390x/cpu.c                  |   4 ++
>>  target/s390x/cpu.h                  |   1 +
>>  target/s390x/cpu_features_def.inc.h |   1 +
>>  10 files changed, 274 insertions(+)
>>  create mode 100644 hw/s390x/pv.c
>>  create mode 100644 hw/s390x/pv.h
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index e02ed80b68..a46a1c7894 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -31,6 +31,7 @@ obj-y +=3D tod-qemu.o
>>  obj-$(CONFIG_KVM) +=3D tod-kvm.o
>>  obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>>  obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
>> +obj-$(CONFIG_KVM) +=3D pv.o
>>  obj-y +=3D s390-ccw.o
>>  obj-y +=3D ap-device.o
>>  obj-y +=3D ap-bridge.o
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 80c6ab233a..3b241ea549 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -33,6 +33,7 @@
>>  #include "qemu/cutils.h"
>>  #include "qemu/option.h"
>>  #include "exec/exec-all.h"
>> +#include "pv.h"
>> =20
>>  #define KERN_IMAGE_START                0x010000UL
>>  #define LINUX_MAGIC_ADDR                0x010008UL
>> @@ -676,6 +677,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>>      cpu_physical_memory_unmap(addr, len, 1, len);
>>  }
>> =20
>> +int s390_ipl_prepare_pv_header(void)
>> +{
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
>> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
>> +    int rc;
>> +
>> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>> +                             ipib_pv->pv_header_len);
>> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>> +                          ipib_pv->pv_header_len);
>> +    g_free(hdr);
>> +    return rc;
>> +}
>> +
>> +int s390_ipl_pv_unpack(void)
>> +{
>> +    int i, rc =3D 0;
>> +    S390IPLState *ipl =3D get_ipl_device();
>> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
>> +
>> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
>> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
>> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].=
size),
>> +                            ipib_pv->components[i].tweak_pref);
>> +        if (rc) {
>> +            break;
>> +        }
>> +    }
>> +    return rc;
>> +}
>> +
>>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 04be63cee1..ad8090a02c 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -105,6 +105,8 @@ typedef union IplParameterBlock IplParameterBlock;=

>>  int s390_ipl_set_loadparm(uint8_t *loadparm);
>>  int s390_ipl_pv_check_components(IplParameterBlock *iplb);
>>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
>> +int s390_ipl_prepare_pv_header(void);
>> +int s390_ipl_pv_unpack(void);
>>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>>  IplParameterBlock *s390_ipl_get_iplb(void);
>>  IplParameterBlock *s390_ipl_get_iplb_secure(void);
>> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
>> new file mode 100644
>> index 0000000000..50b68b6c34
>> --- /dev/null
>> +++ b/hw/s390x/pv.c
>> @@ -0,0 +1,106 @@
>> +/*
>> + * Secure execution functions
>> + *
>> + * Copyright IBM Corp. 2020
>> + * Author(s):
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>> + * your option) any later version. See the COPYING file in the top-le=
vel
>> + * directory.
>> + */
>> +#include "qemu/osdep.h"
>> +#include <sys/ioctl.h>
>=20
> Do you really need that include? You're using kvm_vm_ioctl().
>=20

Compiles without it, so I removed it :)


--chfdPmeFZeNg4FrvUhDc6nQZUqXSoJnFT--

--ZDFPCwPbyn5DoiPQKO3dWGKqM236xdwrc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5hCZwACgkQ41TmuOI4
ufjFMg//eSU2qSqHoNFR/aefOO6/Du1mPpXUgW9vNjg4NWcsce3pAiwpiJnx5eQW
zYTV7oFnXyU0szKe+Ph9GGbArO5xtzpS5yIXQ5/U+QVvYDMBubxvFpqLNWv3f0ZX
CfDH+nskKLV0w83sJaOtaKptVmgkFpay3Z4XRBA5C/TyC8FTUg2OFdC68PUkGLkC
IjsunC2Dw8pizvKzad0T014SCJQUDM4RX2LjjAWJMSLK2jw9QOhvM3THxC0x0yfF
YasxrI6JI79Vk4XhpnC8ZaMGhuDzPzFGi/tannGqHRyPM78Bx3b+dTJKAf24GKYl
sVG2t+Z/W3XQU4GrUuevQOcw4dPhd5wVAwoSYFGWF5X286fbhcdJQcdzsxR+5py/
g73yLZ3gy+9vYuIgpTL3rsp94+DZa6+PsXtrI8ImZvHKH4InOD/JB4aOG77cL3yt
zS2rbOgiqE4WadjmztgKIcRd8vulLztZEbnTlHLCtey8Fm9YgX8n6QKBuVYYRH9v
6QTssIlQnihqRLVhxPkeU/+qCVmbBeSytopv7DXu90sXHRivmvC/6Ep6F3IpUKL/
e142+eR48p/Vykz/Z5Zeq3v84EBqJbcv2eoviDu6N5nVi8sDvpCcHzRM7V2Vy8iJ
psQS+cRkDeQHgiMizcidVXsRNWE3Azx4bs/PMuMfUhANG3iBfc8=
=Fp1v
-----END PGP SIGNATURE-----

--ZDFPCwPbyn5DoiPQKO3dWGKqM236xdwrc--


