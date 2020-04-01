Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A6C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 06:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A7A2077D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 06:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A7A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJWVe-0007nq-9W
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 02:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJWUt-0007GX-T4
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJWUr-0004Mb-Ny
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:05:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60932
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jJWUr-0004L5-I3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:05:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03164Sw7013119
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2020 02:05:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 304gsrxep8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:05:04 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Wed, 1 Apr 2020 07:04:48 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 1 Apr 2020 07:04:46 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03164w6t50725060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2020 06:04:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 382CEA4053;
 Wed,  1 Apr 2020 06:04:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9306FA404D;
 Wed,  1 Apr 2020 06:04:57 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.20.146])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  1 Apr 2020 06:04:57 +0000 (GMT)
Subject: Re: [PATCH v1] vl/s390: fixup ram sizes for compat machines
To: Igor Mammedov <imammedo@redhat.com>
References: <20200331153554.69341-1-borntraeger@de.ibm.com>
 <20200331234940.29d228a3@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 xsFNBE6cPPgBEAC2VpALY0UJjGmgAmavkL/iAdqul2/F9ONz42K6NrwmT+SI9CylKHIX+fdf
 J34pLNJDmDVEdeb+brtpwC9JEZOLVE0nb+SR83CsAINJYKG3V1b3Kfs0hydseYKsBYqJTN2j
 CmUXDYq9J7uOyQQ7TNVoQejmpp5ifR4EzwIFfmYDekxRVZDJygD0wL/EzUr8Je3/j548NLyL
 4Uhv6CIPf3TY3/aLVKXdxz/ntbLgMcfZsDoHgDk3lY3r1iwbWwEM2+eYRdSZaR4VD+JRD7p8
 0FBadNwWnBce1fmQp3EklodGi5y7TNZ/CKdJ+jRPAAnw7SINhSd7PhJMruDAJaUlbYaIm23A
 +82g+IGe4z9tRGQ9TAflezVMhT5J3ccu6cpIjjvwDlbxucSmtVi5VtPAMTLmfjYp7VY2Tgr+
 T92v7+V96jAfE3Zy2nq52e8RDdUo/F6faxcumdl+aLhhKLXgrozpoe2nL0Nyc2uqFjkjwXXI
 OBQiaqGeWtxeKJP+O8MIpjyGuHUGzvjNx5S/592TQO3phpT5IFWfMgbu4OreZ9yekDhf7Cvn
 /fkYsiLDz9W6Clihd/xlpm79+jlhm4E3xBPiQOPCZowmHjx57mXVAypOP2Eu+i2nyQrkapaY
 IdisDQfWPdNeHNOiPnPS3+GhVlPcqSJAIWnuO7Ofw1ZVOyg/jwARAQABzUNDaHJpc3RpYW4g
 Qm9ybnRyYWVnZXIgKDJuZCBJQk0gYWRkcmVzcykgPGJvcm50cmFlZ2VyQGxpbnV4LmlibS5j
 b20+wsF5BBMBAgAjBQJdP/hMAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQEXu8
 gLWmHHy/pA/+JHjpEnd01A0CCyfVnb5fmcOlQ0LdmoKWLWPvU840q65HycCBFTt6V62cDljB
 kXFFxMNA4y/2wqU0H5/CiL963y3gWIiJsZa4ent+KrHl5GK1nIgbbesfJyA7JqlB0w/E/SuY
 NRQwIWOo/uEvOgXnk/7+rtvBzNaPGoGiiV1LZzeaxBVWrqLtmdi1iulW/0X/AlQPuF9dD1Px
 hx+0mPjZ8ClLpdSp5d0yfpwgHtM1B7KMuQPQZGFKMXXTUd3ceBUGGczsgIMipZWJukqMJiJj
 QIMH0IN7XYErEnhf0GCxJ3xAn/J7iFpPFv8sFZTvukntJXSUssONnwiKuld6ttUaFhSuSoQg
 OFYR5v7pOfinM0FcScPKTkrRsB5iUvpdthLq5qgwdQjmyINt3cb+5aSvBX2nNN135oGOtlb5
 tf4dh00kUR8XFHRrFxXx4Dbaw4PKgV3QLIHKEENlqnthH5t0tahDygQPnSucuXbVQEcDZaL9
 WgJqlRAAj0pG8M6JNU5+2ftTFXoTcoIUbb0KTOibaO9zHVeGegwAvPLLNlKHiHXcgLX1tkjC
 DrvE2Z0e2/4q7wgZgn1kbvz7ZHQZB76OM2mjkFu7QNHlRJ2VXJA8tMXyTgBX6kq1cYMmd/Hl
 OhFrAU3QO1SjCsXA2CDk9MM1471mYB3CTXQuKzXckJnxHkHOwU0ETpw8+AEQAJjyNXvMQdJN
 t07BIPDtbAQk15FfB0hKuyZVs+0lsjPKBZCamAAexNRk11eVGXK/YrqwjChkk60rt3q5i42u
 PpNMO9aS8cLPOfVft89Y654Qd3Rs1WRFIQq9xLjdLfHh0i0jMq5Ty+aiddSXpZ7oU6E+ud+X
 Czs3k5RAnOdW6eV3+v10sUjEGiFNZwzN9Udd6PfKET0J70qjnpY3NuWn5Sp1ZEn6lkq2Zm+G
 9G3FlBRVClT30OWeiRHCYB6e6j1x1u/rSU4JiNYjPwSJA8EPKnt1s/Eeq37qXXvk+9DYiHdT
 PcOa3aNCSbIygD3jyjkg6EV9ZLHibE2R/PMMid9FrqhKh/cwcYn9FrT0FE48/2IBW5mfDpAd
 YvpawQlRz3XJr2rYZJwMUm1y+49+1ZmDclaF3s9dcz2JvuywNq78z/VsUfGz4Sbxy4ShpNpG
 REojRcz/xOK+FqNuBk+HoWKw6OxgRzfNleDvScVmbY6cQQZfGx/T7xlgZjl5Mu/2z+ofeoxb
 vWWM1YCJAT91GFvj29Wvm8OAPN/+SJj8LQazd9uGzVMTz6lFjVtH7YkeW/NZrP6znAwv5P1a
 DdQfiB5F63AX++NlTiyA+GD/ggfRl68LheSskOcxDwgI5TqmaKtX1/8RkrLpnzO3evzkfJb1
 D5qh3wM1t7PZ+JWTluSX8W25ABEBAAHCwV8EGAECAAkFAk6cPPgCGwwACgkQEXu8gLWmHHz8
 2w//VjRlX+tKF3szc0lQi4X0t+pf88uIsvR/a1GRZpppQbn1jgE44hgF559K6/yYemcvTR7r
 6Xt7cjWGS4wfaR0+pkWV+2dbw8Xi4DI07/fN00NoVEpYUUnOnupBgychtVpxkGqsplJZQpng
 v6fauZtyEcUK3dLJH3TdVQDLbUcL4qZpzHbsuUnTWsmNmG4Vi0NsEt1xyd/Wuw+0kM/oFEH1
 4BN6X9xZcG8GYUbVUd8+bmio8ao8m0tzo4pseDZFo4ncDmlFWU6hHnAVfkAs4tqA6/fl7RLN
 JuWBiOL/mP5B6HDQT9JsnaRdzqF73FnU2+WrZPjinHPLeE74istVgjbowvsgUqtzjPIG5pOj
 cAsKoR0M1womzJVRfYauWhYiW/KeECklci4TPBDNx7YhahSUlexfoftltJA8swRshNA/M90/
 i9zDo9ySSZHwsGxG06ZOH5/MzG6HpLja7g8NTgA0TD5YaFm/oOnsQVsf2DeAGPS2xNirmknD
 jaqYefx7yQ7FJXXETd2uVURiDeNEFhVZWb5CiBJM5c6qQMhmkS4VyT7/+raaEGgkEKEgHOWf
 ZDP8BHfXtszHqI3Fo1F4IKFo/AP8GOFFxMRgbvlAs8z/+rEEaQYjxYJqj08raw6P4LFBqozr
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Wed, 1 Apr 2020 08:04:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331234940.29d228a3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20040106-4275-0000-0000-000003B768D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040106-4276-0000-0000-000038CCBA79
Message-Id: <6aa2bac0-36e4-7adb-f79d-0c4dfe59d4ee@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_07:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010049
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 03164Sw7013119
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 31.03.20 23:49, Igor Mammedov wrote:
> On Tue, 31 Mar 2020 11:35:54 -0400
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> compat machines did fixup the ram size to match what can be reported v=
ia
>> sclp. We need to mimic those for machines 4.2 and older to not fail on
>> inbound migration.
> not entirely correct, migration wouldn't fail if target was started
> with correct ram size, so OLD machine with incorrect size can still
> be migrated to new QEMU provided target QEMU CLI has corrected ram size.
>=20
> this probably should be captured in commit message so it
> would be clear that we are adding hack to keep rounding bug so users
> won't have to care about correcting it on their side.

ack
>=20
> Probably also add here the table, David composed, about how much
> RAM user would loose (but still pay for :/) in case of fixup kicks in.
>=20
> PS:
> Shall we add deprecation message along with this patch, so that
> eventually we could remove fixup altogether, like we do with other
> CLI breaking changes?
> Something along the lines:
> "
> S390:
> If user using -m explicitly specified ram size not aligned according
> to the table below, 4.2 and older machine types will actually silently
> round it down and VM will get less RAM than it was asked for on alignme=
nt
> value.
>=20
> Alignment table:
>  VM size (<=3D) | Alignment
> --------------------------
>       1020M   |     1M
>       2040M   |     2M
>       4080M   |     4M
>       8160M   |     8M
>      16320M   |    16M
>      32640M   |    32M
>      65280M   |    64M
>     130560M   |   128M
>     261120M   |   256M
>     522240M   |   512M
>    1044480M   |     1G
>    2088960M   |     2G
>    4177920M   |     4G
>    8355840M   |     8G
>=20
> Suggested action is to replace unaligned -m value with a suitable align=
ed one,
> future versions will add strict check for valid initial RAM sizes
> so VM started on old QEMU with unaligned size won't be able to migrate
> strait away since new QEMU won't start with incorrect size. However the=
re is
> still possibility to migrate old running VM if migration target is star=
ted with
> corrected RAM size according to above table.=20


yes, that makes sense. I would like to keep the hack at least > 2 years o=
r
so as this will allow to migrate from one Ubuntu LTS to the next.


> "
>=20
>=20
>> For Machines >=3D 5.0 we can simply use an increment
>> size of 1M und use the full range of increment number which allows for
>              ^^^ and=20
>> all possible memory sizes. The old limitation of having a maximum of
>> 1020 increments was added for standby memory, which we no longer
>> support. With that we can now support even weird memory sizes like
>> 10001234 MB.
>>
>> Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> RFC->v1:
>> - also fix mamram
>> - provide full granularity for machine 5.0
>>
>>  hw/s390x/s390-skeys.c              |  2 +-
>>  hw/s390x/s390-stattrib-kvm.c       |  4 ++--
>>  hw/s390x/s390-virtio-ccw.c         | 20 ++++++++++++++++++++
>>  hw/s390x/sclp.c                    | 19 ++++++-------------
>>  include/hw/boards.h                |  1 +
>>  include/hw/s390x/s390-virtio-ccw.h |  4 +++-
>>  softmmu/vl.c                       |  3 +++
>>  7 files changed, 36 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
>> index 5da6e5292f..a9a4ae7b39 100644
>> --- a/hw/s390x/s390-skeys.c
>> +++ b/hw/s390x/s390-skeys.c
>> @@ -176,7 +176,7 @@ static void qemu_s390_skeys_init(Object *obj)
>>      QEMUS390SKeysState *skeys =3D QEMU_S390_SKEYS(obj);
>>      MachineState *machine =3D MACHINE(qdev_get_machine());
>> =20
>> -    skeys->key_count =3D machine->maxram_size / TARGET_PAGE_SIZE;
>> +    skeys->key_count =3D machine->ram_size / TARGET_PAGE_SIZE;
>>      skeys->keydata =3D g_malloc0(skeys->key_count);
>>  }
>> =20
>> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm=
.c
>> index c7e1f35524..f89d8d9d16 100644
>> --- a/hw/s390x/s390-stattrib-kvm.c
>> +++ b/hw/s390x/s390-stattrib-kvm.c
>> @@ -85,7 +85,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttrib=
State *sa,
>>  {
>>      KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
>>      MachineState *machine =3D MACHINE(qdev_get_machine());
>> -    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
>> +    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
>> =20
>>      if (start_gfn + count > max) {
>>          error_report("Out of memory bounds when setting storage attri=
butes");
>> @@ -104,7 +104,7 @@ static void kvm_s390_stattrib_synchronize(S390StAt=
tribState *sa)
>>  {
>>      KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
>>      MachineState *machine =3D MACHINE(qdev_get_machine());
>> -    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
>> +    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
>>      /* We do not need to reach the maximum buffer size allowed */
>>      unsigned long cx, len =3D KVM_S390_SKEYS_MAX / 2;
>>      int r;
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 3cf19c99f3..bdfd10f77d 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -579,6 +579,16 @@ static void s390_nmi(NMIState *n, int cpu_index, =
Error **errp)
>>      s390_cpu_restart(S390_CPU(cs));
>>  }
>> =20
>> +static ram_addr_t s390_align_ram(ram_addr_t sz)
>> +{
>> +    /* same logic as in sclp.c */
>> +    int increment_size =3D 20;
>> +    while ((sz >> increment_size) > 1020) {
>> +        increment_size++;
>> +    }
>=20
> Print a warning here that asked for ram size is incorrect (if that's th=
e case)?
> and will be fixed up to (and maybe suggest user to fix config to valid =
size we calculate here and how much size were lost due to alignment)
>

Yes, checking for sz !=3D sz >> incremenent_size << increment_size and th=
e warn makes sense.

=20
>> +    return sz >> increment_size << increment_size;
>> +}
>> +
>>  static void ccw_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>> @@ -590,6 +600,7 @@ static void ccw_machine_class_init(ObjectClass *oc=
, void *data)
>>      s390mc->cpu_model_allowed =3D true;
>>      s390mc->css_migration_enabled =3D true;
>>      s390mc->hpage_1m_allowed =3D true;
>> +    s390mc->mem_inc_1020 =3D false;
>>      mc->init =3D ccw_init;
>>      mc->reset =3D s390_machine_reset;
>>      mc->hot_add_cpu =3D s390_hot_add_cpu;
>> @@ -686,6 +697,11 @@ bool hpage_1m_allowed(void)
>>      return get_machine_class()->hpage_1m_allowed;
>>  }
>> =20
>> +bool mem_inc_1020(void)
>> +{
>> +    return get_machine_class()->mem_inc_1020;
>> +}
>> +
>>  static char *machine_get_loadparm(Object *obj, Error **errp)
>>  {
>>      S390CcwMachineState *ms =3D S390_CCW_MACHINE(obj);
>> @@ -807,7 +823,11 @@ static void ccw_machine_4_2_instance_options(Mach=
ineState *machine)
>> =20
>>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>>  {
>> +    S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
>> +
>>      ccw_machine_5_0_class_options(mc);
>> +    mc->machine_align_ram =3D s390_align_ram;
>> +    s390mc->mem_inc_1020 =3D true;
>>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_l=
en);
>>  }
>>  DEFINE_CCW_MACHINE(4_2, "4.2", false);
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index d8ae207731..d1fff18443 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -21,6 +21,7 @@
>>  #include "hw/s390x/sclp.h"
>>  #include "hw/s390x/event-facility.h"
>>  #include "hw/s390x/s390-pci-bus.h"
>> +#include "hw/s390x/s390-virtio-ccw.h"
>>  #include "hw/s390x/ipl.h"
>> =20
>>  static inline SCLPDevice *get_sclp_device(void)
>> @@ -346,7 +347,7 @@ static void sclp_realize(DeviceState *dev, Error *=
*errp)
>>       */
>>      qdev_set_parent_bus(DEVICE(sclp->event_facility), sysbus_get_defa=
ult());
>> =20
>> -    ret =3D s390_set_memory_limit(machine->maxram_size, &hw_limit);
>> +    ret =3D s390_set_memory_limit(machine->ram_size, &hw_limit);
>>      if (ret =3D=3D -E2BIG) {
>>          error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
>>                     hw_limit / GiB);
>> @@ -365,23 +366,15 @@ static void sclp_memory_init(SCLPDevice *sclp)
>>      int increment_size =3D 20;
>> =20
>>      /* The storage increment size is a multiple of 1M and is a power =
of 2.
>> -     * The number of storage increments must be MAX_STORAGE_INCREMENT=
S or fewer.
>> +     * The number of storage increments must be MAX_STORAGE_INCREMENT=
S or fewer
>> +     * for some machine types.
>>       * The variable 'increment_size' is an exponent of 2 that can be
>>       * used to calculate the size (in bytes) of an increment. */
>> -    while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) =
{
>=20
> if s/machine_align_ram/fixup_ram_size/
> then mem_inc_1020()&co could be replaced with
>=20
> machine_class->fixup_ram_size !=3D NULL

good idea.
>=20
>> +    while ( mem_inc_1020() &&
>> +           (initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) =
{
>>          increment_size++;
>>      }
>>      sclp->increment_size =3D increment_size;
>> -
>> -    /* The core memory area needs to be aligned with the increment si=
ze.
>> -     * In effect, this can cause the user-specified memory size to be=
 rounded
>> -     * down to align with the nearest increment boundary. */
>> -    initial_mem =3D initial_mem >> increment_size << increment_size;
>> -
>> -    machine->ram_size =3D initial_mem;
>> -    machine->maxram_size =3D initial_mem;
>> -    /* let's propagate the changed ram size into the global variable.=
 */
>> -    ram_size =3D initial_mem;
>>  }
>> =20
>>  static void sclp_init(Object *obj)
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 236d239c19..e3574f4b5f 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -218,6 +218,7 @@ struct MachineClass {
>>                                                           unsigned cpu=
_index);
>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machi=
ne);
>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int id=
x);
>> +    ram_addr_t (*machine_align_ram)(ram_addr_t size);
> I'd s/machine_//, looks redundant
> also I'd call it fixup_ram_size() +=20
> doc comment above saying something like:
>=20
> "
>  amends user provided ram size (with -m option) using machine
>  specific algorithm. to be used by old machine types for compat
>  purposes only.
>  Applies only to default memory backend (i.e. explicit memory backend
>  wasn't used.
> "

ack

>=20
>>  };
>> =20
>>  /**
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s39=
0-virtio-ccw.h
>> index cd1dccc6e3..022ee6685b 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
>>      bool cpu_model_allowed;
>>      bool css_migration_enabled;
>>      bool hpage_1m_allowed;
>> +    bool mem_inc_1020;
>>  } S390CcwMachineClass;
>> =20
>>  /* runtime-instrumentation allowed by the machine */
>> @@ -49,7 +50,8 @@ bool ri_allowed(void);
>>  bool cpu_model_allowed(void);
>>  /* 1M huge page mappings allowed by the machine */
>>  bool hpage_1m_allowed(void);
>> -
>> +/* Machine has only 1020 memory increments */
>> +bool mem_inc_1020(void);
>>  /**
>>   * Returns true if (vmstate based) migration of the channel subsystem
>>   * is enabled, false if it is disabled.
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index 1d33a28340..12b5758d12 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -2601,6 +2601,9 @@ static bool set_memory_options(uint64_t *ram_slo=
ts, ram_addr_t *maxram_size,
>>      }
>> =20
>>      sz =3D QEMU_ALIGN_UP(sz, 8192);
>> +    if (mc->machine_align_ram) {
>> +        sz =3D mc->machine_align_ram(sz);
>> +    }
>>      ram_size =3D sz;
>>      if (ram_size !=3D sz) {
>>          error_report("ram size too large");
>=20


Thanks a lot for the quick (and good) feedback.


