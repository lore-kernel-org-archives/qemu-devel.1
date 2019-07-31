Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB26C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937D920693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937D920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hskYZ-0002Wu-TW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55237)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hskYA-00022v-T9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hskY9-0000Up-LT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:05:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>)
 id 1hskY7-0000Ty-81; Wed, 31 Jul 2019 05:05:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97F51550CF;
 Wed, 31 Jul 2019 09:05:28 +0000 (UTC)
Received: from ptitpuce (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4423F60852;
 Wed, 31 Jul 2019 09:05:21 +0000 (UTC)
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <7a78ef04-4120-20d9-d5f4-6572c5676344@redhat.com>
 <dc9c2e70-c2a6-838e-f191-1c2787e244f5@de.ibm.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <dc9c2e70-c2a6-838e-f191-1c2787e244f5@de.ibm.com>
Date: Wed, 31 Jul 2019 11:05:19 +0200
Message-ID: <m136imo9ps.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 31 Jul 2019 09:05:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] i386/kvm: initialize struct at full
 before ioctl call
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, den@openvz.org, mtosatti@redhat.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, kvm@vger.kernel.org,
 pbonzini@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Christian Borntraeger writes:

> On 30.07.19 18:44, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 7/30/19 6:01 PM, Andrey Shinkevich wrote:
>>> Not the whole structure is initialized before passing it to the KVM.
>>> Reduce the number of Valgrind reports.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>  target/i386/kvm.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>> index dbbb137..ed57e31 100644
>>> --- a/target/i386/kvm.c
>>> +++ b/target/i386/kvm.c
>>> @@ -190,6 +190,7 @@ static int kvm_get_tsc(CPUState *cs)
>>>          return 0;
>>>      }
>>>
>>> +    memset(&msr_data, 0, sizeof(msr_data));
>>
>> I wonder the overhead of this one...
>
> Cant we use designated initializers like in
>
> commit bdfc8480c50a53d91aa9a513d23a84de0d5fbc86
> Author:     Christian Borntraeger <borntraeger@de.ibm.com>
> AuthorDate: Thu Oct 30 09:23:41 2014 +0100
> Commit:     Paolo Bonzini <pbonzini@redhat.com>
> CommitDate: Mon Dec 15 12:21:01 2014 +0100
>
>     valgrind/i386: avoid false positives on KVM_SET_XCRS ioctl
>
> and others?
>
> This should minimize the impact.

Oh, when you talked about using designated initializers, I thought you
were talking about fully initializing the struct, like so:

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dbbb13772a..3533870c43 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -180,19 +180,20 @@ static int kvm_get_tsc(CPUState *cs)
 {
     X86CPU *cpu =3D X86_CPU(cs);
     CPUX86State *env =3D &cpu->env;
-    struct {
-        struct kvm_msrs info;
-        struct kvm_msr_entry entries[1];
-    } msr_data;
     int ret;

     if (env->tsc_valid) {
         return 0;
     }

-    msr_data.info.nmsrs =3D 1;
-    msr_data.entries[0].index =3D MSR_IA32_TSC;
-    env->tsc_valid =3D !runstate_is_running();
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[1];
+    } msr_data =3D {
+        .info =3D { .nmsrs =3D  1 },
+        .entries =3D { [0] =3D { .index =3D MSR_IA32_TSC } }
+    };
+     env->tsc_valid =3D !runstate_is_running();

     ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, &msr_data);
     if (ret < 0) {


This gives the compiler maximum opportunities to flag mistakes like
initializing the same thing twice, and make it easier (read no smart
optimizations) to initialize in one go. Moving the declaration past the
'if' also addresses Philippe's concern.

>>
>>>      msr_data.info.nmsrs =3D 1;
>>>      msr_data.entries[0].index =3D MSR_IA32_TSC;
>>>      env->tsc_valid =3D !runstate_is_running();
>>> @@ -1706,6 +1707,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>
>>>      if (has_xsave) {
>>>          env->xsave_buf =3D qemu_memalign(4096, sizeof(struct kvm_xsave=
));
>>> +        memset(env->xsave_buf, 0, sizeof(struct kvm_xsave));
>>
>> OK
>>
>>>      }
>>>
>>>      max_nested_state_len =3D kvm_max_nested_state_length();
>>> @@ -3477,6 +3479,7 @@ static int kvm_put_debugregs(X86CPU *cpu)
>>>          return 0;
>>>      }
>>>
>>> +    memset(&dbgregs, 0, sizeof(dbgregs));
>>
>> OK
>>
>>>      for (i =3D 0; i < 4; i++) {
>>>          dbgregs.db[i] =3D env->dr[i];
>>>      }
>>
>> We could remove 'dbgregs.flags =3D 0;'
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>


--
Cheers,
Christophe de Dinechin (IRC c3d)

