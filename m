Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E14C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BD3207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BD3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tGh-0000nx-7G
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1j9tFy-0000Ky-08
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1j9tFw-0000e1-Nh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:21:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45952
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1j9tFw-0000dM-IN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:21:52 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025GK9XC097371
 for <qemu-devel@nongnu.org>; Thu, 5 Mar 2020 11:21:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yj6nkr2g6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 11:21:51 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Thu, 5 Mar 2020 16:21:50 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Mar 2020 16:21:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 025GLjYl58458296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 16:21:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56C3C11C070;
 Thu,  5 Mar 2020 16:21:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B786E11C058;
 Thu,  5 Mar 2020 16:21:44 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.81.94])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 16:21:44 +0000 (GMT)
Subject: Re: [PATCH 1/1] s390/ipl: sync back loadparm
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>
References: <20200224150213.21253-1-pasic@linux.ibm.com>
 <05f7dcf7-a0c7-8811-6b88-df86d5fa0974@redhat.com>
 <20200225125641.72e8cc86.pasic@linux.ibm.com>
 <853387e3-4425-731b-bb09-a7210ea6b299@linux.ibm.com>
 <c019ecc6-900e-8653-a603-de8d03017e95@de.ibm.com>
 <20200305151119.6cd63e96.pasic@linux.ibm.com>
 <98038ac5-c2dd-7536-2399-459fea7dc6ce@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Thu, 5 Mar 2020 17:21:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <98038ac5-c2dd-7536-2399-459fea7dc6ce@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030516-0016-0000-0000-000002ED84AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030516-0017-0000-0000-00003350D939
Message-Id: <4ff1004f-7db7-29af-45b2-45d6b3299978@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_05:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050104
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 025GK9XC097371
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 05.03.20 15:25, Christian Borntraeger wrote:
>=20
>=20
> On 05.03.20 15:11, Halil Pasic wrote:
>> On Thu, 5 Mar 2020 13:44:31 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>>
>>>
>>> On 25.02.20 15:35, Viktor Mihajlovski wrote:
>>>>
>>>>
>>>> On 2/25/20 12:56 PM, Halil Pasic wrote:
>>>>> On Tue, 25 Feb 2020 10:39:40 +0100
>>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>>> On 24.02.20 16:02, Halil Pasic wrote:
>>>>>>> We expose loadparm as a r/w machine property, but if loadparm is =
set by
>>>>>>> the guest via DIAG 308, we don't update the property. Having a
>>>>>>> disconnect between the guest view and the QEMU property is not ni=
ce in
>>>>>>> itself, but things get even worse for SCSI, where under certain
>>>>>>> circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works a=
s
>>>>>>> expected" for details) we call s390_gen_initial_iplb() on resets
>>>>>>> effectively overwriting the guest/user supplied loadparm with the=
 stale
>>>>>>> value.
>>>>>>>
>>>>>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>>>>>> Fixes: 7104bae9de "hw/s390x: provide loadparm property for the ma=
chine"
>>>>>>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>>>>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>>> Reviewed-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
>>>>>>> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>>>>>> ---
>>>>>>> =C2=A0 hw/s390x/ipl.c | 21 +++++++++++++++++++++
>>>>>>> =C2=A0 1 file changed, 21 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>>> [...]
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0 /* Sync loadparm */
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char ascii_loadparm[8=
];
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *ebcdic_loadp=
arm =3D iplb->loadparm;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 8 &=
& ebcdic_loadparm[i]; i++) {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ascii_loadparm[i] =3D ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ascii_loadparm[i] =3D=
 0;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_s=
tr(mo, ascii_loadparm, "loadparm", NULL);
>>>>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_s=
tr(mo, "", "loadparm", NULL);
>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>
>>>>>> &error_abort instead of NULL, we certainly want to know if this wo=
uld
>>>>>> ever surprisingly fail.
>>>>>
>>>>> IMHO this is a typical assert() situation where one would like to h=
ave
>>>>> a fast and obvious failure when testing, but not in production.
>>>>>
>>>>> AFAIU the guest can trigger this code at any time, and crashing the
>>>>> whole (production) system seems a bit heavy handed to me. The sette=
r
>>>>> should only fail if something is buggy.
>>>>>
>>>>> But if the majority says &error_abort I can certainly do. Other opi=
nions?
>>>>>
>>>> We might consider to return 0x0402 (invalid parameter) from the diag=
308 "set", which is less drastic and would allow the OS to do whatever it=
 finds appropriate to deal with the failure. Not that Linux would care ab=
out that today :-).
>>>
>>> I think it is not an error. It is perfectly fine for a guest to not s=
et DIAG308_FLAGS_LP_VALID if the guest does not want to set it. The LOADP=
ARM is supposed to be ignored then.
>>>
>>
>> I believe David's concern was not the else branch, but the last
>> parameter of object_property_set_str(), which tells us what to do if t=
he
>> validation/normalization done by the setter of the loadparm qemu
>> property fails the set operation.
>=20
> Ah I see. I still think that the guest could provoke the an error by pu=
tting
> invalid characters in the loadparm field. So error_abort seems wrong.
> And in fact for that case, the 0x0402 proposal from Viktor seems like t=
he
> right thing to do.

FWIW, right now we do not check the content of the loadparm and just acce=
pt
any kind of garbage via diag308 and we return that garbage.
And I checked what LPAR does. LPAR also does not use 0x0402 and it silent=
ly
takes the garbage.
So in essence I would suggest to leave the patch as is.


