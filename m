Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89833C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3965A2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3965A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53319 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic81Q-00064K-7K
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1ic7qR-000761-LT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1ic7qP-0000dL-N0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:03:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1ic7qO-0000a6-N0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:03:57 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB3Cw8Mh011481
 for <qemu-devel@nongnu.org>; Tue, 3 Dec 2019 08:03:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wnp65e3xj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 08:03:52 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 3 Dec 2019 13:03:50 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 3 Dec 2019 13:03:49 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB3D3meU43843804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 3 Dec 2019 13:03:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65DBBA405C
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 13:03:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39A6EA4064
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 13:03:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.18.156])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 13:03:48 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] s390x: Add missing vcpu reset functions
To: qemu-devel@nongnu.org
References: <20191202140146.3910-1-frankja@linux.ibm.com>
 <20191202140146.3910-3-frankja@linux.ibm.com>
 <20191202164608.1b133a20.cohuck@redhat.com>
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
Date: Tue, 3 Dec 2019 14:03:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191202164608.1b133a20.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S0TQET6mpmUBHdgnC84onER0lE0Ow2Kkv"
X-TM-AS-GCONF: 00
x-cbid: 19120313-0016-0000-0000-000002D05C36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120313-0017-0000-0000-0000333255A4
Message-Id: <572646be-46cd-6c55-060f-314d042d015b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_03:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030101
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S0TQET6mpmUBHdgnC84onER0lE0Ow2Kkv
Content-Type: multipart/mixed; boundary="TYYsDoYdEnUDKaDBRuYwFCzDMgvcxflBM"

--TYYsDoYdEnUDKaDBRuYwFCzDMgvcxflBM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/2/19 4:46 PM, Cornelia Huck wrote:
> On Mon,  2 Dec 2019 09:01:45 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Up to now we only had an ioctl to reset vcpu data QEMU couldn't reach
>> for the initial reset, which was also called for the clear reset. To
>=20
> s/which/and that/ ?

Ok

>=20
>> be architecture compliant, we also need to clear local interrupts on a=

>> normal reset.
>>
>> Because of this and the upcoming protvirt support we need to add
>> ioctls for the missing clear and normal resets.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/cpu.c       | 14 ++++++++++++--
>>  target/s390x/kvm-stub.c  | 10 +++++++++-
>>  target/s390x/kvm.c       | 42 ++++++++++++++++++++++++++++++++-------=
-
>>  target/s390x/kvm_s390x.h |  4 +++-
>>  4 files changed, 58 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 829ce6ad54..906285888e 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -139,8 +139,18 @@ static void s390_cpu_reset(CPUState *s, cpu_reset=
_type type)
>>      }
>> =20
>>      /* Reset state inside the kernel that we cannot access yet from Q=
EMU. */
>=20
> Hm, why does this comment talk about 'yet'? Did we have any plans to
> change that?

You're asking the wrong person :)

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
>=20
> Add a default case to catch errors?

Sure, just did

>=20
>> +        }
>>      }
>>  }
>> =20
>=20
> (...)
>=20
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index ad6e38c876..7a2ec8b9f8 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -151,6 +151,7 @@ static int cap_s390_irq;
>>  static int cap_ri;
>>  static int cap_gs;
>>  static int cap_hpage_1m;
>> +static int cap_vcpu_resets;
>> =20
>>  static int active_cmma;
>> =20
>> @@ -342,6 +343,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>      cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>>      cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>>      cap_s390_irq =3D kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);=

>> +    cap_vcpu_resets =3D kvm_check_extension(s, KVM_CAP_S390_VCPU_RESE=
TS);
>> =20
>>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
>> @@ -403,20 +405,44 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
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
> Is the reference to sync_regs/ONE_REG still relevant? I'm a bit
> confused here, especially with regard to what we'll need for protected
> virt.

I just didn't want to move/remove stuff
Even with kvm_run we do a lot of stuff for the initial reset.

>=20
>> +     * cpu_synchronize_state() is called in common kvm code
>> +     * (kvm-all).
>> +     */
>> +    if (kvm_vcpu_ioctl(cs, type)) {
>> +        error_report("CPU reset failed on CPU %i", cs->cpu_index);
>>      }
>>  }
>> =20
>> +void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
>> +{
>> +    kvm_s390_reset_vcpu(cpu, KVM_S390_INITIAL_RESET);
>> +}
>> +
>> +void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
>> +{
>> +    if (!cap_vcpu_resets) {
>> +        kvm_s390_reset_vcpu(cpu, KVM_S390_INITIAL_RESET);
>> +    } else {
>> +        kvm_s390_reset_vcpu(cpu, KVM_S390_CLEAR_RESET);
>> +    }
>=20
> kvm_s390_reset_vcpu(cpu, cap_vcpu_resets ? KVM_S390_CLEAR_RESET : KVM_S=
390_INITIAL_RESET);
>=20
> One line, but maybe the conventional if is still better :)

I'd like to keep it as is.

>=20
>> +}
>> +
>> +void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
>> +{
>> +    if (!cap_vcpu_resets) {
>> +        return;
>> +    }
>> +    kvm_s390_reset_vcpu(cpu, KVM_S390_NORMAL_RESET);
>> +}
>> +
>>  static int can_sync_regs(CPUState *cs, int regs)
>>  {
>>      return cap_sync_regs && (cs->kvm_run->kvm_valid_regs & regs) =3D=3D=
 regs;
>> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
>> index caf985955b..0b21789796 100644
>> --- a/target/s390x/kvm_s390x.h
>> +++ b/target/s390x/kvm_s390x.h
>> @@ -34,7 +34,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *n=
otifier, uint32_t sch,
>>                                      int vq, bool assign);
>>  int kvm_s390_cmma_active(void);
>>  void kvm_s390_cmma_reset(void);
>> -void kvm_s390_reset_vcpu(S390CPU *cpu);
>> +void kvm_s390_reset_vcpu_clear(S390CPU *cpu);
>> +void kvm_s390_reset_vcpu_normal(S390CPU *cpu);
>> +void kvm_s390_reset_vcpu_initial(S390CPU *cpu);
>>  int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
>>  void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp);
>>  void kvm_s390_crypto_reset(void);
>=20
>=20



--TYYsDoYdEnUDKaDBRuYwFCzDMgvcxflBM--

--S0TQET6mpmUBHdgnC84onER0lE0Ow2Kkv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3mXTMACgkQ41TmuOI4
ufjonhAA0NitNwZEiuK+EBhHea3LGNVWckoPSHhjecDyXyzXgHqa5zdMzVf0sX1m
lzAx6TU9ve7UmHrQN2PwB/gGcZQAADT30ieG0mY43qpBuQppRdVtWe0gQ3TszQt1
VGzPHOG8iWypXL5DkfcKLCB+4COiccR/YHTX7z/rsWSvwfhU1jSDdbtNchmBVOya
57vHTYJCAz1VnyG7IkkLRRVvLb4Lrp0uMh6qnyFzZKpROCC4UBefYjpijU3Gl8DZ
j+YwvphkROHrFiH0dI9qLy3GXNRRNrDk7CVUfejl/MhCY/0kmkT6+KQiJAZOoPJB
FjqPUYVfR5qU9IWjCgWLw2HBLgJIOU4G6Yf3l/ZWP2x+u/Wdvjht/9scPWXIw0z4
WhZFQ0mtYfJTHq0tudcjjaNUb3FIb84Md8XBmzbIdewTQWldlp6EwyzrOlY4loZX
kJQnZj46jkVlpeUqRvlbIbO6HMagL6zsLadkJHezMYM76+5d8C3EVb2O5P2kuLqx
EMl5yM+HvWOsKeBPd0V3JNqI6rwkqY6akI/r9d0eFqZmmjdzdlT1KwjNaIzC8OhX
G6kj9VxLoxmhk+EVxjKcJ3DsDcMePm2w9Jcg1rSAZPV7hKAP90yvM7Di87zPqEKN
PffeZqbU7A3jP5hdsm8wnHSXqWjopnwWq3DNbBBuFjdSP7z4xnU=
=1g9Z
-----END PGP SIGNATURE-----

--S0TQET6mpmUBHdgnC84onER0lE0Ow2Kkv--


