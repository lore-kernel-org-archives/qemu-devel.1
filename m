Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D89BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1F6206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1F6206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJmC-0008Lu-EK
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jCJiN-0001QK-4g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jCJiL-0005vo-Qa
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:01:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32310
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jCJiL-0005sx-Kc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:01:13 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02C8vixi029352
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:01:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yqh99hy20-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:00:55 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 12 Mar 2020 08:54:31 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Mar 2020 08:54:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02C8sS6Z61407478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 08:54:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 030634C044;
 Thu, 12 Mar 2020 08:54:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C87C14C04A;
 Thu, 12 Mar 2020 08:54:27 +0000 (GMT)
Received: from dyn-9-152-224-122.boeblingen.de.ibm.com (unknown
 [9.152.224.122])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Mar 2020 08:54:27 +0000 (GMT)
Subject: Re: [PATCH v9 02/15] s390x: protvirt: Support unpack facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-3-frankja@linux.ibm.com>
 <a0edb6d5-284f-5f10-02e5-d2f252043d71@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 12 Mar 2020 09:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a0edb6d5-284f-5f10-02e5-d2f252043d71@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Gsn8wURgqIIp1Ybjr4EAOE0AIkSY4W14q"
X-TM-AS-GCONF: 00
x-cbid: 20031208-0012-0000-0000-0000038FD1CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031208-0013-0000-0000-000021CCA2F1
Message-Id: <f7f2c1ca-5547-d793-5508-5d6d64319ae0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_01:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 phishscore=0 suspectscore=3 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120048
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
--Gsn8wURgqIIp1Ybjr4EAOE0AIkSY4W14q
Content-Type: multipart/mixed; boundary="KoNdwDOuqePZPnRT3JgAjOZlJVdOzehc8"

--KoNdwDOuqePZPnRT3JgAjOZlJVdOzehc8
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/11/20 5:07 PM, David Hildenbrand wrote:
>=20
>> +++ b/include/hw/s390x/pv.h
>> @@ -0,0 +1,57 @@
>> +/*
>> + * Protected Virtualization header
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
>> +#ifndef HW_S390_PV_H
>> +#define HW_S390_PV_H
>> +
>> +#ifdef CONFIG_KVM
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +
>> +static inline bool s390_is_pv(void)
>> +{
>> +    static S390CcwMachineState *ccw;
>> +    Object *obj;
>> +
>> +    if (ccw) {
>> +        return ccw->pv;
>> +    }
>> +
>> +    /* we have to bail out for the "none" machine */
>> +    obj =3D object_dynamic_cast(qdev_get_machine(),
>> +                              TYPE_S390_CCW_MACHINE);
>> +    if (!obj) {
>> +        return false;
>> +    }
>> +    ccw =3D S390_CCW_MACHINE(obj);
>> +    return ccw->pv;
>> +}
>> +
>> +int s390_pv_vm_enable(void);
>> +void s390_pv_vm_disable(void);
>> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
>> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
>> +void s390_pv_perf_clear_reset(void);
>> +int s390_pv_verify(void);
>> +void s390_pv_unshare(void);
>> +#else
>> +static inline bool s390_is_pv(void) { return false; }
>> +static inline int s390_pv_vm_enable(void) { return 0; }
>> +static inline void s390_pv_vm_disable(void) {}
>> +static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t len=
gth) { return 0; }
>> +static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64=
_t tweak) { return 0; }
>> +static inline void s390_pv_perf_clear_reset(void) {}
>> +static inline int s390_pv_verify(void) { return 0; }
>> +static inline void s390_pv_unshare(void) {}
>> +#endif
>=20
> Maybe /* CONFIG_KVM */ for the else and endif. Whatever you prefer.

Ack

>=20
>> +
>> +
>> +
>=20
> Nit: too many newlines.

Ack

>=20
>> +#endif /* HW_S390_PV_H */
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s39=
0-virtio-ccw.h
>> index 8aa27199c9123bab..cd1dccc6e3ba8645 100644
>=20
>=20
> Nothing jumped at me :)
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks

>=20



--KoNdwDOuqePZPnRT3JgAjOZlJVdOzehc8--

--Gsn8wURgqIIp1Ybjr4EAOE0AIkSY4W14q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5p+MMACgkQ41TmuOI4
ufiQdQ//Z3g8EB26f52NXpFz2FspM/DlzupZYW01LbJKuK3YS+7aLqgAL10Puhf9
UpR0ls2CRwEG8dl1GAy9ewefQWyGLhm05ImGoXEODdX0Mc5WhYgjKyVJtSyAz2Qw
JHrSErkCzF+bfuQLOE6KIiZk2OejSqTdFm70S6yFKU81JWI8XUBbgv0aPdg51qMD
t2gykHU0kRpcFDgqpLh/cYLndju9TaTi/qs+8OkuL4T/eAFDH0uLuuGXErm6lADI
K7/pF2d3zFLQrCDoUvrhyUUUTB6qz3e9lBne5xML6PhKpCJmzCchvNUHSKPKSo87
MSh2W1W+jJ0vnWOIcQsMq/vpPFUfUDXYhZP4BNJA2RChBQZVx2I0Zof/N/Ftv7iV
UoHozZmHTODOBem0DRwj4WoU9dn7ZcL+bIcmpERxmeTpCu16KZUJRNNsPwp1m/Ms
foTRQJPxB4fDIMbpm5l3L8x+feNn2691iBPirEzwluVoFoGMBCa/FzqO3B6K9qnv
bCHa6IzxnJP2Zb1a42hdF/LZ781bBX+4m2kteeAEpxTuK8jfCrtEIPATwOZz6iyT
frFzZzM4lg/+wndbK4srmAp0u6B7WWPy8itoUPNIi9Kd9aXU2FiWvcsTwYK+apbD
xhkP+NpFS9ANaZGYSOTVYHC+f4JXrAiOvL9BwjlSyyPyhbbm3hU=
=NEBi
-----END PGP SIGNATURE-----

--Gsn8wURgqIIp1Ybjr4EAOE0AIkSY4W14q--


