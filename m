Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3942C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876482071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876482071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBqD-0001mM-Lh
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 08:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdBp7-0001E9-FN; Mon, 25 May 2020 08:03:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3512
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdBp6-0007fC-7w; Mon, 25 May 2020 08:03:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04PBY8xh179971; Mon, 25 May 2020 08:03:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316yqh3707-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 08:03:14 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04PBYbas181331;
 Mon, 25 May 2020 08:03:14 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316yqh36yd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 08:03:13 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04PC1avN012350;
 Mon, 25 May 2020 12:03:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04fra.de.ibm.com with ESMTP id 316uf89kp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 12:03:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04PC39cQ4129258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 May 2020 12:03:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98E1F11C04C;
 Mon, 25 May 2020 12:03:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46A4D11C052;
 Mon, 25 May 2020 12:03:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.30.189])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 May 2020 12:03:09 +0000 (GMT)
Subject: Re: [PATCH v2 4/9] pc-bios: s390x: Rename and use PSW_MASK_ZMODE
 constant
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-5-frankja@linux.ibm.com>
 <45c70387-c5e6-ef45-9535-de1c4002b683@redhat.com>
 <3f7cd050-a3a5-452b-d596-e075dd213110@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <db21e269-c4af-2ffd-f151-2c190a32478e@linux.ibm.com>
Date: Mon, 25 May 2020 14:03:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3f7cd050-a3a5-452b-d596-e075dd213110@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CZqL18eyOprU4VqmOjoeOSzmsyHgqTfqv"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-25_05:2020-05-25,
 2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:03:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CZqL18eyOprU4VqmOjoeOSzmsyHgqTfqv
Content-Type: multipart/mixed; boundary="c5rQP1EOdqy3UlYTeFbZw0SA4it5p5Cgo"

--c5rQP1EOdqy3UlYTeFbZw0SA4it5p5Cgo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/21/20 7:47 AM, Thomas Huth wrote:
> On 21/05/2020 07.44, Thomas Huth wrote:
>> On 14/05/2020 14.37, Janosch Frank wrote:
>>> ZMODE has a lot of ambiguity with the ESAME architecture mode, but is=

>>> actually 64 bit addressing.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  pc-bios/s390-ccw/dasd-ipl.c  | 3 +--
>>>  pc-bios/s390-ccw/s390-arch.h | 2 +-
>>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.=
c
>>> index 0fc879bb8e..b932531e6f 100644
>>> --- a/pc-bios/s390-ccw/dasd-ipl.c
>>> +++ b/pc-bios/s390-ccw/dasd-ipl.c
>>> @@ -229,7 +229,6 @@ void dasd_ipl(SubChannelId schid, uint16_t cutype=
)
>>>      run_ipl2(schid, cutype, ipl2_addr);
>>> =20
>>>      /* Transfer control to the guest operating system */
>>> -    pswl->mask |=3D PSW_MASK_EAMODE;   /* Force z-mode */
>>> -    pswl->addr |=3D PSW_MASK_BAMODE;   /* ...          */
>>> +    pswl->mask |=3D PSW_MASK_64;   /* Force 64 bit addressing */
>>
>> This is not only a rename (as announced in the subject), but also a
>> change in behavior since you now do not change pswl->addr anymore. So
>> this is even a bug fix? Could you please mention this in the patch
>> description, too?
>=20
> Ah, wait, pswl is of type PSWLegacy, and ->mask and ->addr are of type
> uint32_t here! So it seems wrong to use a 64-bit value for mask here,
> doesn't it?

Absolutely, how did that even compile?

I'm tempted to just make it a unsigned long ptr instead. The legacy PSW
struct doesn't seem to be used correctly anyway, the lowcore one is in
fact never used and this is the only other occurrence.


--c5rQP1EOdqy3UlYTeFbZw0SA4it5p5Cgo--

--CZqL18eyOprU4VqmOjoeOSzmsyHgqTfqv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7Ls/wACgkQ41TmuOI4
ufhzTRAArWTduFSrB/Ekk2RohSVHBoWwxYkZP87ebTeN3pY50457ZF0AQk6ZGLrR
bKQHX1J7PEqebehKKAiExd674vZ5JgJv4ctQVKZSS2d142bRVVkIOUG81bs5PxnH
oTW9VuACMfkAEoJcc6aBbCi5neJBOCZupUCE0R4OH0ubEo02WRGGZF+oc/GlkYjH
2WaNw75Z33bEGdzj+Iw1Em/yOFvbYWo5gXmk95ipQV6aJgBweLJcJv6U7bHJfhW4
4rtRoRe5uXDCvgA9CL+dBwhEuhPN76gvaEYY4KfPihc3XdS4pFMhpvciacazcoIl
6GZcDRA2S6UuqgK030e8+8o/oH6HdoR8hnExyhkhN3Zyev+eHZz1RSbE1gv8PxWk
E4XuaxGt4wf5wxeWuJIFFGJhfcG0dNYj9dVVZDoJinSAyfeSmq3hiOP6Zvd5xfKR
6DTjCeQJq6iyPXgSM/qp3hcG4scZOGg4NqCeeYkpuRZ3DIokj3vuCgkcniTHdio3
h/9PSdhs78x5iFH7LCnP1hYh5hFoLVCogSpsDiVCd+tVMNKeKl1L0iO8vOLNMmQH
PLDiwmBCwQ8F64RoCuRXYgrShy4FVBS/R9jTuyr+B74l1gXLpqgdDw3cSHoRKS0N
1dvOTsL9RLJMzDYU5522dMJ2WtW8SoO9N4Bxh/1D1Ip4hFiF7Es=
=6vde
-----END PGP SIGNATURE-----

--CZqL18eyOprU4VqmOjoeOSzmsyHgqTfqv--


