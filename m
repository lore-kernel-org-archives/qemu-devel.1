Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C1BC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08C4206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08C4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQhf-0007bW-RW
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 04:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1icQX0-0004Bl-5S
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1icQWl-0004sp-5d
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:01:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21120
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1icQWk-0004kV-CQ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:00:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB48rrX8068799
 for <qemu-devel@nongnu.org>; Wed, 4 Dec 2019 04:00:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wnsuvs93c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 04:00:52 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Dec 2019 09:00:50 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Dec 2019 09:00:48 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xB490kLp36307270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2019 09:00:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8C9842057;
 Wed,  4 Dec 2019 09:00:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97CA542042;
 Wed,  4 Dec 2019 09:00:46 +0000 (GMT)
Received: from dyn-9-152-224-146.boeblingen.de.ibm.com (unknown
 [9.152.224.146])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Dec 2019 09:00:46 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] s390x: Add missing vcpu reset functions
To: Cornelia Huck <cohuck@redhat.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-3-frankja@linux.ibm.com>
 <20191203184459.0417a40a.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 mQINBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABtCVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+iQI3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbauQINBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABiQIfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
Date: Wed, 4 Dec 2019 10:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203184459.0417a40a.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DBMlGZtJGta0Whf4RUBXXIPH4WJD6g3hg"
X-TM-AS-GCONF: 00
x-cbid: 19120409-0028-0000-0000-000003C49639
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120409-0029-0000-0000-00002487B35C
Message-Id: <a84f5248-8255-0e9d-7253-91d53e4f7765@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_02:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=3 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040067
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DBMlGZtJGta0Whf4RUBXXIPH4WJD6g3hg
Content-Type: multipart/mixed; boundary="di91vNbWRWUbvi5zHIkrY9TgCMfchHdaH"

--di91vNbWRWUbvi5zHIkrY9TgCMfchHdaH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/3/19 6:44 PM, Cornelia Huck wrote:
> On Tue,  3 Dec 2019 08:28:11 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Up to now we only had an ioctl to reset vcpu data QEMU couldn't reach
>> for the initial reset, and that was also called for the clear
>> reset. To be architecture compliant, we also need to clear local
>> interrupts on a normal reset.
>>
>> Because of this and the upcoming protvirt support we need to add
>> ioctls for the missing clear and normal resets.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu.c       | 16 +++++++++++++--
>>  target/s390x/kvm-stub.c  | 10 +++++++++-
>>  target/s390x/kvm.c       | 42 ++++++++++++++++++++++++++++++++-------=
-
>>  target/s390x/kvm_s390x.h |  4 +++-
>>  4 files changed, 60 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 829ce6ad54..4973365d6c 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -139,8 +139,20 @@ static void s390_cpu_reset(CPUState *s, cpu_reset=
_type type)
>>      }
>> =20
>>      /* Reset state inside the kernel that we cannot access yet from Q=
EMU. */
>=20
> For the last iteration, I asked about the 'yet' here...

I have not written those comments, I merely refuse to delete them :)
We still reset some state in the kernel, I'm not sure how much of that
is already exposed via ioctls to QEMU, so I won't remove the comment.

>=20
>> -    if (kvm_enabled() && type !=3D S390_CPU_RESET_NORMAL) {
>> -        kvm_s390_reset_vcpu(cpu);
>> +    if (kvm_enabled()) {
>> +        switch (type) {
>> +        case S390_CPU_RESET_CLEAR:
>> +            kvm_s390_reset_vcpu_clear(cpu);
>> +            break;
>> +        case S390_CPU_RESET_INITIAL:
>> +            kvm_s390_reset_vcpu_initial(cpu);
>> +            break;
>> +        case S390_CPU_RESET_NORMAL:
>> +            kvm_s390_reset_vcpu_normal(cpu);
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>>      }
>>  }
>> =20
>=20
> (...)
>=20
>> @@ -403,17 +405,41 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>>      return 0;
>>  }
>> =20
>> -void kvm_s390_reset_vcpu(S390CPU *cpu)
>> +static void kvm_s390_reset_vcpu(S390CPU *cpu, unsigned long type)
>>  {
>>      CPUState *cs =3D CPU(cpu);
>> =20
>> -    /* The initial reset call is needed here to reset in-kernel
>> -     * vcpu data that we can't access directly from QEMU
>> -     * (i.e. with older kernels which don't support sync_regs/ONE_REG=
).
>> -     * Before this ioctl cpu_synchronize_state() is called in common =
kvm
>> -     * code (kvm-all) */
>> -    if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
>> -        error_report("Initial CPU reset failed on CPU %i", cs->cpu_in=
dex);
>> +    /*
>> +     * The reset call is needed here to reset in-kernel vcpu data tha=
t
>> +     * we can't access directly from QEMU (i.e. with older kernels
>> +     * which don't support sync_regs/ONE_REG).  Before this ioctl
>=20
> ...and this reference to 'older kernels' here.
>=20
> Are the comments still correct/relevant?

See above

>=20
>> +     * cpu_synchronize_state() is called in common kvm code
>> +     * (kvm-all).
>> +     */
>> +    if (kvm_vcpu_ioctl(cs, type)) {
>> +        error_report("CPU reset failed on CPU %i type %lx",
>> +                     cs->cpu_index, type);
>> +    }
>> +}
>=20



--di91vNbWRWUbvi5zHIkrY9TgCMfchHdaH--

--DBMlGZtJGta0Whf4RUBXXIPH4WJD6g3hg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3ndb4ACgkQ41TmuOI4
ufgnZQ/8COvee4u72c9hYhNXbcgHvINQQjS0SwFr2fNc/ItQyuTKdgaN/DWQ5TQP
fDVq6/1n2QHSRg81xFLxNcp9hVsU1UN2q29YetunRxKrOix7yeaUpmtYpVn+qakM
dt4f8NFjxFk4P1Oz7MlyCAq77gZtTPXTy0u3pHHPemzlVZNnnxT0i2V0SQT3rLLG
INgIs4vi3yJWOgPdjI6jqvv9iLPTpSgjhRf6ub1nT8lyavYeCxqmHQ99FrvHu3ST
L/e+9ogTK8dA/ZNgTKBdObCV3N25x/TTjImvtZM78LrvIzGtbHCI5Hpwk+jOHaBJ
eJ6DVy74gcKVIzV8HBBkwgkB44Q6W1CJtGSvDvtpOGimbAzn/uwvN9SOOYic0DA8
2xRqt3QOCZ9Yt7bFJfrcGUw5KiEItPFOiYwzBonuzB5tWgbFWWqdmYn9Prg8apE+
RoRiBqz4WYkputSNcIUdHpDqtN0qbFfzMYNg2FM9WqoOFFcYUfz/fSg6VISxFHUk
gc0b/RennHUogre3BfCbrcVf4gdR7BsWSgOBERTipVz0RqujpLt0fw7u7nQMvYEB
Kn2X81Y80PGlFHmYCvDsMxARGZQDhLAXHZLMtG99LbHA+MhaZqIXWT1pc4LQGA6q
I/GnLZ81Or7jVKTqnpSirCsfe+UdM355EqrQhCje8McRGDu7FEE=
=2ecZ
-----END PGP SIGNATURE-----

--DBMlGZtJGta0Whf4RUBXXIPH4WJD6g3hg--


