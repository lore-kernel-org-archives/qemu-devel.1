Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282FBC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7A82178F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7A82178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLlK-0007xy-Vb
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iaKes-0005qW-MB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iaKen-0000PU-4f
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:20:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iaKem-0000Ha-Pv
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:20:33 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASEH7x6032815
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 09:20:30 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjaegmfwq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 09:20:30 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 28 Nov 2019 14:20:28 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 14:20:25 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xASEKNG446989736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 14:20:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D15F95204F;
 Thu, 28 Nov 2019 14:20:23 +0000 (GMT)
Received: from dyn-9-152-224-146.boeblingen.de.ibm.com (unknown
 [9.152.224.146])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 985D552057;
 Thu, 28 Nov 2019 14:20:23 +0000 (GMT)
Subject: Re: [PATCH 06/15] s390x: protvirt: Support unpack facility
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-7-frankja@linux.ibm.com>
 <b00e03a4-6ed8-f109-102a-dfb40009c8e5@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 28 Nov 2019 15:20:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b00e03a4-6ed8-f109-102a-dfb40009c8e5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q3oreZI8S0pSme7CJIpTEYVaxOv5NgE2c"
X-TM-AS-GCONF: 00
x-cbid: 19112814-0008-0000-0000-000003396B48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112814-0009-0000-0000-00004A5877C2
Message-Id: <373342f7-0ce9-0278-4e06-d0d5d18cac9b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_03:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=11
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280125
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q3oreZI8S0pSme7CJIpTEYVaxOv5NgE2c
Content-Type: multipart/mixed; boundary="6goco4PDzxn7P7U2YmvJdIXtAXtcsG1Ss"

--6goco4PDzxn7P7U2YmvJdIXtAXtcsG1Ss
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/28/19 3:07 PM, Thomas Huth wrote:
> On 20/11/2019 12.43, Janosch Frank wrote:
>> When a guest has saved a ipib of type 5 and call diagnose308 with
>> subcode 10, we have to setup the protected processing environment via
>> Ultravisor calls. The calls are done by KVM and are exposed via an API=
=2E
>>
>> The following steps are necessary:
>> 1. Create a VM (register it with the Ultravisor)
>> 2. Create secure CPUs for all of our current cpus
>> 3. Forward the secure header to the Ultravisor (has all information on=

>> how to decrypt the image and VM information)
>> 4. Protect image pages from the host and decrypt them
>> 5. Verify the image integrity
>>
>> Only after step 5 a protected VM is allowed to run.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
> [...]
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index a077926f36..50501fcd27 100644
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
>> @@ -668,6 +669,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>>      cpu_physical_memory_unmap(addr, len, 1, len);
>>  }
>> =20
>> +int s390_ipl_prepare_pv_header(void)
>> +{
>> +    int rc;
>> +    IplParameterBlock *iplb =3D s390_ipl_get_iplb_secure();
>> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
>> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
>> +
>> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>> +                             ipib_pv->pv_header_len);
>> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
>> +                               ipib_pv->pv_header_len);
>> +    g_free(hdr);
>> +    return rc;
>> +}
>> +
>> +int s390_ipl_pv_unpack(void)
>> +{
>> +    int i, rc;
>> +    IplParameterBlock *iplb =3D s390_ipl_get_iplb_secure();
>> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
>> +
>> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
>> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
>> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].=
size),
>> +                            ipib_pv->components[i].tweak_pref);
>> +        if (rc) {
>> +            return rc;
>> +        }
>> +    }
>> +    return rc;
>> +}
>=20
> For both functions, s390_ipl_prepare_pv_header() and
> s390_ipl_pv_unpack(), you're ignoring the return code at the calling
> site, so errors go completely unnoticed. I suggest to either do an
> error_report() here or at the calling site...
>=20
>> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
>> new file mode 100644
>> index 0000000000..0218070322
>> --- /dev/null
>> +++ b/hw/s390x/pv.c
>> @@ -0,0 +1,118 @@
>> +/*
>> + * Secure execution functions
>> + *
>> + * Copyright IBM Corp. 2019
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
>> +
>> +#include <linux/kvm.h>
>> +
>> +#include "qemu/error-report.h"
>> +#include "sysemu/kvm.h"
>> +#include "pv.h"
>> +
>> +static int s390_pv_cmd(uint32_t cmd, void *data)
>> +{
>> +    int rc;
>> +    struct kvm_pv_cmd pv_cmd =3D {
>> +        .cmd =3D cmd,
>> +        .data =3D (uint64_t)data,
>> +    };
>> +
>> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
>> +    if (rc) {
>> +        error_report("KVM PV command failed cmd: %d rc: %d", cmd, rc)=
;
>> +        exit(1);
>> +    }
>> +    return rc;
>> +}
>> +
>> +static int s390_pv_cmd_vcpu(CPUState *cs, uint32_t cmd, void *data)
>> +{
>> +    int rc;
>> +    struct kvm_pv_cmd pv_cmd =3D {
>> +        .cmd =3D cmd,
>> +        .data =3D (uint64_t)data,
>> +    };
>> +
>> +    rc =3D kvm_vcpu_ioctl(cs, KVM_S390_PV_COMMAND_VCPU, &pv_cmd);
>> +    if (rc) {
>> +        error_report("KVM PV VCPU command failed cmd: %d rc: %d", cmd=
, rc);
>> +        exit(1);
>> +    }
>> +    return rc;
>> +}
>=20
> ... or even better, since these functions exit on error anyway, make
> these functions and all the others "void" instead?
>=20
>  Thomas
>=20

You're not the first stating this idea :-)
We might get a return code for diag308 that signals that we failed to
start the secure guest and then I might need them again.

If we don't get a rc, I'll definitely make all functions void, if we do
I'll make nearly all void:)


--6goco4PDzxn7P7U2YmvJdIXtAXtcsG1Ss--

--q3oreZI8S0pSme7CJIpTEYVaxOv5NgE2c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3f16cACgkQ41TmuOI4
ufj8vRAApwdkTsCd/gI1dFmxZoShjIc5Jt8VuRWxcEhF3hn8U5hPSunD4gKYBv6U
+nsvK+ACVmk4KhBmj4nKEE61gE5rh+LLJHhmo33hW1NkzCcbzjREOg7PvS5crwUH
vzlWNY9CuixR/zq5vTFOChcoPhsD4ThnZAKGp8WMs8CaUAw/KHrhsivz8goI3B8k
GEElxZbcYKWY8j2iDlbLzZTcBvq/8AOCbYqxFnL75rf0hdQHM6otG0nfkM34gZDU
nhyuC6mLkU5qeSDwjYWGCakMqv2igOaontXYZ2pcWPB+g/Dqkg76cHWiRSNcQEl3
3xfQAQon0no2FgaPNi4P86IO1yheJkcarDOohvToEfgoRYwTeRE+nFuCYFJ0DRzr
2YWdvjLMMG/CwmuKhtmWbBlxbeJiege5IpSM2UaEs605Ozn8aEZVYEKz8VugrkO0
7nHFyzAX/dOwn9unYxwimrUdeOr5iEvdWeOTpfpZt2i7ovda8NzJkp5Tccv2xd2f
6+Jqk49bm+VUL5b7HbNhp+zzPfRymVpKMcjV3DKayKFJtFE8n4yZicZOdeCmgjMX
L9lz7z4M2xVlHY8S9kLu4Fi1nwbcv1y0zs6/lfSjgvrzFRqu9mrITsnwKK4ymIaU
RWR7pZlq/Luut4u4tISNGISGtEYETyZEa2ywKCWUdmnU8cU5NZU=
=GaDq
-----END PGP SIGNATURE-----

--q3oreZI8S0pSme7CJIpTEYVaxOv5NgE2c--


