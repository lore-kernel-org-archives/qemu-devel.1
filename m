Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35945CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030722084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030722084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNF0h-0006Hl-O0
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iNEdB-0004fz-NU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iNEdA-00012c-Cb
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:16:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iNEdA-00010v-3a
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:16:44 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A57FD81F01
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:16:41 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id e14so10695902wrm.21
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=fx+Qd1+oKx6AAPNgHaXOu8hmEaI2vLObi6OcuggfHxY=;
 b=GGJzTqIZMq98zBt3sZ2YWUHst0lxjwrSXMjDcfYSD4nQP8ndqirMqkhfgYI2fG4hvJ
 pHUGkmy4TTjJbdmWpUMHWSSPUYtDqBIrPPqnIvWTMhgscypvdv5T0HkIXvWR9/djOPbs
 ZKnp9rhIV6AFPc4QVJM1qyajzvqY98niwYNt9IaIr0IrfZvoGO/W/IwpVd4FWJ6rCY+I
 PPEft3rclRav/ruh16CJwYygqAJxOA05XZcReiz7wUeDvB8oj1GOxV7ye7JATX/9NIbo
 /fuiRZr/SeIjnJ5eAzsJrD7CEEZ/t1DlUat+BLkiVzl31oVpDaNrIbiSQaNhGTRHwRAU
 9Fhw==
X-Gm-Message-State: APjAAAVDKC/BBhFLk50KoC5yWRIOJXGC8uSTCpDatLwuJEbarRohbGJo
 Pa7t0nz8Ulxbdb1eKLKkbnReB7TyYEIQ1ORvhmAvNBh0rAf113qxJkpkvICsOSLLpHwgjJ2nFnQ
 mlIgq69rUP9mtuZI=
X-Received: by 2002:a5d:464f:: with SMTP id j15mr7877100wrs.366.1571829400309; 
 Wed, 23 Oct 2019 04:16:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvPY2Aw54n4lryuHsYi9FIHoD4hmOCmleqPALoYg9D4vAZ4O2bOAmFy3bGx/DXwQJiK52f6Q==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr7877072wrs.366.1571829399990; 
 Wed, 23 Oct 2019 04:16:39 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id z9sm21990839wrl.35.2019.10.23.04.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 04:16:39 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386/kvm: add NoNonArchitecturalCoreSharing Hyper-V
 enlightenment
In-Reply-To: <20191021171533.GT4084@habkost.net>
References: <20191018163908.10246-1-vkuznets@redhat.com>
 <4d89f852-85bc-8370-5929-848d24b80a6f@redhat.com>
 <878spe197z.fsf@vitty.brq.redhat.com>
 <66f1dd30-3e45-4dc6-ba0a-d52e5aae6501@redhat.com>
 <20191021171533.GT4084@habkost.net>
Date: Wed, 23 Oct 2019 13:16:38 +0200
Message-ID: <87k18vzp7t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Oct 21, 2019 at 06:26:14PM +0200, Paolo Bonzini wrote:
>> On 21/10/19 16:09, Vitaly Kuznetsov wrote:
>> >>> +    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
>> >>> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_NO_NONARCH_CORESHARING;
>> >>> +    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
>> >> Do you want to make auto the default if "-cpu host,migratable=off"?  It
>> >> can be done on top so I started queueing this patch.
>> > Hm, one thing is that CPUID 0x40000004 doesn't exist if no Hyper-V
>> > enlightenments are passed so we'll probably have to modify your idea to
>> > "-cpu host,migratable=off,+any-hyperv-enlightenment" but then the
>> > question is how conservative are we, like if QEMU command line doesn't
>> > change can new CPUID flags appear or not? And we'll probably need a way
>> > to explicitly disable HV_NO_NONARCH_CORESHARING if needed.
>> 
>> I would defer to Eduardo on whether "migratable=off" would allow adding
>> new CPUID flags.  The follow-up question however is whether we would
>> benefit from a "+hyperv" option that enables all known Hyper-V
>> enlightenment for a given machine type.
>
> I'm not sure what "adding new CPUID flags" means exactly, but on
> both cases, the answer is yes:
>
> If you mean having new flags appear with the same QEMU command
> line, this is 100% OK with "-cpu host".  Doubly so with
> "migratable=off".  "-cpu host" doesn't guarantee a stable guest
> ABI, and migratable=off doesn't guarantee the ability to live
> migrate.
>
> If you just mean the ability to write "-cpu
> host,migratable=off,+some-extra-flag", that's OK too.
>
> I would try to make "-cpu host,migratable=off" enable all
> features out of the box (because users probably expect that).
> But we you have a compelling reason to not enable the hyperv
> flags by default (do we?), it's OK to require something like
> "-cpu host,...,+hyperv".

I'm not sure if the reason is compelling enough but I remember some
Linux tools were only looking at the first hypervisor signature and
reporting that we're now running on Hyper-V. Also, more features you
enable larger the atack surface...

Actually, we already '-cpu host,hv_passthrough' option which implies
'migratable=off', not sure if another one is needed.

-- 
Vitaly

