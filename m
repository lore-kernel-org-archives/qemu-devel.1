Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B402AC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CB6212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aERU0Szv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CB6212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfOKR-0004t1-Ux
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 08:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55273)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfOJU-0004QY-Ee
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfOJT-0000AB-Ai
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:43:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfOJT-00006t-27
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:43:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id f15so3866282wrp.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=G28Q+EMDKkzGh3KaTkKxgT2SRhdPorEtwOi6uXEbimM=;
 b=aERU0SzvlekmvNXZmd2LV7en3U6PRriPj6Ej6vlmg3kayDCz9rWrw8hIbwGSEu+WuH
 e66KzUkKqr2qvCgLnKi+l1qU5681r7T1vlOOOQO6KA7en07/YkQyqM1TAf9r7OtATm7/
 GcDrX8+QeWrbrYCmgK2QoPrXfln6dp9OFZ1sNHKHSPekuy0MLtLJP+PNdvI8znLDrnfz
 S7OL3gDRcf47kFL6acECHKoBtM1J6F4lrkTsqY+8NzypicwLd7UOowBltpCkEZCeA2rN
 Nz4GooYymJTSoWeSQZsHIXN49jIqfvwSuHoj7hwuvvbWBPSVtPK/CxiBYjhI5MR7cZjf
 Tnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=G28Q+EMDKkzGh3KaTkKxgT2SRhdPorEtwOi6uXEbimM=;
 b=PnJgopDUPT5DfMzWWrn1Tps49/Kv5i0kGeEdVlwmhoEcUpY7/hxNA02689LjzPAwYh
 2VB9i1TpYIXMNCMua/TnV++JSABr4c6gdqmNHPpJPUIO2Z+bCb0ZDvMH8mi+TlqUr+Tj
 DaVilaecRt+py5T4hRN41brye2eMxY/KXfVVVqgmtPSdmfAxptVdDi1Edvqn4HvnrH1v
 gwmTz5bgly1nxcVBgwzlMoUaTISJcZqEW7PPdqVIjFDlrPw+bHrjj/3hBJZklVR78Klv
 PZaxUBiFCL+23gdCNMDovsiwD+HGcS+PRlrSN8/qQA+hHeg7orL3mPtsge/WAV3OGxRW
 P5gw==
X-Gm-Message-State: APjAAAWOZZlOXAajh1UNksho2rZWNTeyjfwfYzZwjB8f9UJ2iQdMj6GL
 hXtzcucjgiK4zaP6tYc5UUKt+LY0q6k=
X-Google-Smtp-Source: APXvYqwXU4/qOoETdCnjHcextc1IySzcJ8yS4sd3HdEP+bCa/c05V6AqpeqPMhAHYBjEXUkbLzl2yg==
X-Received: by 2002:a5d:4fc1:: with SMTP id h1mr24125663wrw.83.1561380187880; 
 Mon, 24 Jun 2019 05:43:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j17sm8901509wrw.6.2019.06.24.05.43.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 05:43:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CDF481FF87;
 Mon, 24 Jun 2019 13:43:06 +0100 (BST)
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
 <20190523105440.27045-2-rkagan@virtuozzo.com>
 <87sgrz1c8g.fsf@zen.linaroharston> <20190624115045.GA2557@rkaganb.sw.ru>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roman Kagan <rkagan@virtuozzo.com>
In-reply-to: <20190624115045.GA2557@rkaganb.sw.ru>
Date: Mon, 24 Jun 2019 13:43:06 +0100
Message-ID: <87pnn317dx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] cpus-common: nuke finish_safe_work
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Roman Kagan <rkagan@virtuozzo.com> writes:

> On Mon, Jun 24, 2019 at 11:58:23AM +0100, Alex Benn=C3=A9e wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>>
>> > It was introduced in commit b129972c8b41e15b0521895a46fd9c752b68a5e,
>> > with the following motivation:
>>
>> I can't find this commit in my tree.
>
> OOPS, that was supposed to be ab129972c8b41e15b0521895a46fd9c752b68a5e,
> sorry.
>
>>
>> >
>> >   Because start_exclusive uses CPU_FOREACH, merge exclusive_lock with
>> >   qemu_cpu_list_lock: together with a call to exclusive_idle (via
>> >   cpu_exec_start/end) in cpu_list_add, this protects exclusive work
>> >   against concurrent CPU addition and removal.
>> >
>> > However, it seems to be redundant, because the cpu-exclusive
>> > infrastructure provides suffificent protection against the newly added
>> > CPU starting execution while the cpu-exclusive work is running, and the
>> > aforementioned traversing of the cpu list is protected by
>> > qemu_cpu_list_lock.
>> >
>> > Besides, this appears to be the only place where the cpu-exclusive
>> > section is entered with the BQL taken, which has been found to trigger
>> > AB-BA deadlock as follows:
>> >
>> >     vCPU thread                             main thread
>> >     -----------                             -----------
>> > async_safe_run_on_cpu(self,
>> >                       async_synic_update)
>> > ...                                         [cpu hot-add]
>> > process_queued_cpu_work()
>> >   qemu_mutex_unlock_iothread()
>> >                                             [grab BQL]
>> >   start_exclusive()                         cpu_list_add()
>> >   async_synic_update()                        finish_safe_work()
>> >     qemu_mutex_lock_iothread()                  cpu_exec_start()
>> >
>> > So remove it.  This paves the way to establishing a strict nesting rule
>> > of never entering the exclusive section with the BQL taken.
>> >
>> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
>> > ---
>> >  cpus-common.c | 8 --------
>> >  1 file changed, 8 deletions(-)
>> >
>> > diff --git a/cpus-common.c b/cpus-common.c
>> > index 3ca58c64e8..023cfebfa3 100644
>> > --- a/cpus-common.c
>> > +++ b/cpus-common.c
>> > @@ -69,12 +69,6 @@ static int cpu_get_free_index(void)
>> >      return cpu_index;
>> >  }
>> >
>> > -static void finish_safe_work(CPUState *cpu)
>> > -{
>> > -    cpu_exec_start(cpu);
>> > -    cpu_exec_end(cpu);
>> > -}
>> > -
>>
>> This makes sense to me intellectually but I'm worried I've missed the
>> reason for it being introduced. Without finish_safe_work we have to wait
>> for the actual vCPU thread function to acquire and release the BQL and
>> enter it's first cpu_exec_start().
>>
>> I guess I'd be happier if we had a hotplug test where we could stress
>> test the operation and be sure we've not just moved the deadlock
>> somewhere else.
>
> Me too.  Unfortunately I haven't managed to come up with an idea how to
> do this test.  One of the race participants, the safe work in a vCPU
> thread, happens in response to an MSR write by the guest.  ATM there's
> no way to do it without an actual guest running.  I'll have a look if I
> can make a vm test for it, using a linux guest and its /dev/cpu/*/msr.

Depending on how much machinery is required to trigger this we could
add a system mode test. However there isn't much point if it requires
duplicating the entire guest hotplug stack. It maybe easier to trigger
on ARM - the PCSI sequence isn't overly complicated to deal with but I
don't know what the impact of MSIs is.


--
Alex Benn=C3=A9e

