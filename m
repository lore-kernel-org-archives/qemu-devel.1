Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A25C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EE422CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJERPI3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EE422CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3d5A-0008O6-OY
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3d4X-0007xG-Ii
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:24:29 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:42615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3d4V-0004j8-9R
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:24:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id q17so27253550pls.9
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=4ER4fkikP/KS0w1Gum0nBUXhNQjCgF+lmRdY/Ay4+y4=;
 b=XJERPI3GxXFimrrJzmzqhxCU65CxZc79HhiU3GHtenAr/ZXMdHQEMj/yK7jp2fCIp7
 1rLsXzXS4dd4Is229EG7JMxhsnyJf27rChCBJ4ZQPR2qI/ST1uCZhd4Yq8cvVnTFzFu1
 XSj9u2Wdt5kZw8NO1HzUWbDOsX8N0LdQHJ267yDim8LBnYQnwyjkrH3PLH0EsxpCHURF
 YS1lpNaDRLztyuB+0zq07FEkMDhp28XNVBm6DcSrAjLYeihDDVJCOCi1KvGgANKZgXyR
 HRFxJbUQyQBlMk6zHkj2Vo21lghDpX5whkN0BaPLE73QVPvTqqsPdDxcAEI+q3qcBBBm
 4uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=4ER4fkikP/KS0w1Gum0nBUXhNQjCgF+lmRdY/Ay4+y4=;
 b=az1gX+M3kELlNjihvceCzCq5VfRhu0pxBjWrT8r2fpiAIbRqFj/+YDHibcfZtYtsRT
 euDeMykV2CugQroBg1Xif7gto6tQQ4gJCr3ORVL7gnDXsY9fybA/7wGH6PE8iRuVkkSn
 jyAhwh8t0CYJ0q/31Vi9RGERGd1v6B8yYPhjiSvTAr+1ElCHou/qYC1wruLIem7kspHN
 rZNOA4xu9TcUMxdloR2GqNnnGM8Sjlmm++nvPFtWbHYMG69hB6vY2NWjRa3Q2abLEqU1
 2IGhX0qPDxvkLKxf11t1XLkIDlig+WhggEo08SxEqY+tDUXxuTe2nO0Pprrq75kVAlba
 eGUg==
X-Gm-Message-State: AOAM533Cj7gQGDtnOLyDD+5CY+bSyvgy0jRHtI5BBLoUCM1x74XxTIMF
 OOICPPoLDO1W+nGt7hO7TC7AqkQPQ29hSQ22aYcYWtddArs=
X-Google-Smtp-Source: ABdhPJz26CtuxJHuodPkItETFpK9ZeOyHnlnPsbFUNCVig8D5IHMXIWuw/82FDhXKOg/KXZp5CAxzEDxZtV80k11sbY=
X-Received: by 2002:a17:902:6b45:: with SMTP id
 g5mr7240015plt.42.1596709464392; 
 Thu, 06 Aug 2020 03:24:24 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 6 Aug 2020 11:24:13 +0100
Message-ID: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
Subject: Why QEMU should move from C to Rust (clickbait alert ;))
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Dave Gilbert <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just posted this on my blog, but my intention is to continue the
discussion around moving to Rust in the QEMU community. Thoughts about
how to increase safety in QEMU, both for and against moving to Rust
are welcome!

My KVM Forum 2018 presentation titled Security in QEMU: How Virtual
Machines provide Isolation reviewed security bugs in QEMU and found
the most common causes were C programming bugs. This includes buffer
overflows, use-after-free, uninitialized memory, and more. In this
post I will argue for using Rust as a safer language that prevents
these classes of bugs.

In 2018 the choice of a safer language was not clear. C++ offered safe
abstractions without an effective way to prohibit unsafe language
features. Go also offered safety but with concerns about runtime
costs. Rust looked promising but few people had deep experience with
it. In 2018 I was not able to argue confidently for moving away from C
in QEMU.

Now in 2020 the situation is clearer. C programming bugs are still the
main cause of CVEs in QEMU. Rust has matured, its ecosystem is growing
and healthy, and there are virtualization projects like Crosvm,
Firecracker, and cloud-hypervisor that prove Rust is an effective
language for writing Virtual Machine Monitors (VMM). In the QEMU
community Paolo Bonzini and Sergio Lopez's work on rust-vmm and
vhost-user code inspired me to look more closely at moving away from
C.

Do we need to change programming language?
---------------------------------------------------------------
Most security bugs in QEMU are C programming bugs. This is easy to
verify by looking through the CVE listings. Although I have only
reviewed CVEs it seems likely that non-security bugs are also mostly C
programming bugs.

Eliminating C programming bugs does not necessarily require switching
programming languages. Other approaches to reducing bug rates in
software include:

Coding style rules that forbid unsafe language features.
Building safe abstractions and prohibiting unsafe language features or
library APIs.
Static checkers that scan source code for bugs.
Dynamic sanitizers that run software with instrumentation to identify bugs.
Unit testing and fuzzing.

The problem is, the QEMU community has been doing these things for
years but new bugs are still introduced despite these efforts. It is
certainly possible to spend more energy on these efforts but the
evidence shows that bugs continue to slip through.

There are two issues with these approaches to reducing bugs. First,
although these approaches help find existing bugs, eliminating classes
of bugs so they cannot exist in the first place is a stronger
approach. This is hard to do with C since the language is unsafe,
placing the burden of safety on the programmer.

Second, much of the ability to write safe C code comes with
experience. Custom conventions, APIs, tooling, and processes to reduce
bugs is a hurdle for one-time contributors or newcomers. It makes the
codebase inaccessible unless we accept lower standards for some
contributors. Code quality should depend as little on experience as
possible but C is notorious for being a programming language that
requires a lot of practice before you can write production-quality
code.

Why Rust?
--------------
Safe languages eliminate memory safety bugs (and other classes like
concurrency bugs). Rust made this a priority in its design:

Use-after-free, double-free, memory leaks, and other lifetime bugs are
prevented at compile-time by the borrow checker where the compiler
checks ownership of data.
Buffer overflows and other memory corruptions are prevented by
compile-time and runtime bounds-checking.
Pointer deference bugs are prevented by the absense of NULL pointers
and strict ownership rules.
Uninitialized memory is prevented because all variables and fields
must be initialized.

Rust programs can still "panic" at runtime when safety cannot be
proven at compile time but this does not result in undefined behavior
as seen in C programs. The program simply aborts with a backtrace.
Bugs that could have resulted in arbitrary code execution in C become
at most denial-of-service bugs in Rust. This reduces the severity of
bugs.

As a result of this language design most C programming bugs that
plague QEMU today are either caught by the compiler or turn into a
safe program termination. It is reasonable to expect CVEs to reduce in
number and in severity when switching to Rust.

At the same time Rust eliminates the need for many of the measures
that the QEMU community added onto C because the Rust programming
language and its compiler already enforce safety. This means newcomers
and one-time contributors will not need QEMU-specific experience, can
write production-quality code more easily, and can get their code
merged more quickly. It also means reviewers will have to spend less
time pointing out C programming bugs or asking for changes that comply
with QEMU's way of doing things.

That said, Rust has a reputation for being a scary language due to the
borrow checker. Most programmers have not thought about object
lifetimes and ownership as systematically and explicitly as required
by Rust. This raises the bar to learning the language, but I look at
it this way: learning Rust is humanly possible, writing bug-free C
code is not.

How can we change programming language?
------------------------------------------------------------
When I checked in 2018 QEMU was 1.5 million lines of code. It has
grown since then. Moving a large codebase to a new programming
language is extremely difficult. If people want to convert QEMU to
Rust that would be great, but I personally don't have the appetite to
do it because I think the integration will be messy, result in a lot
of duplication, and there is too much un(der)maintained code that is
hard to convert.

The reason I am writing this post is because device emulation, the
main security attack surface for VMMs, can be done in a separate
program. That program can be written in any language and this is where
Rust comes in. For vhost devices it is possible to write Rust device
backends today and I hope this will become the default approach to
writing new devices.

For non-vhost devices the vfio-user project is working on an interface
out-of-process device emulation. It will be possible to implement
devices in Rust there too.

If you are implementing new device emulation code please consider
doing it in Rust!

Conclusion
---------------
Most security bugs in QEMU today are C programming bugs. Switching to
a safer programming language will significantly reduce security bugs
in QEMU. Rust is now mature and proven enough to use as the language
for device emulation code. Thanks to vhost-user and vfio-user using
Rust for device emulation does not require a big conversion of QEMU
code, it can simply be done in a separate program. This way attack
surfaces can be written in Rust to make them less susceptible to
security bugs going forward.

