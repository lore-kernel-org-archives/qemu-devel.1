Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04321C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C462C207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="eWx8eefF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C462C207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is02N-0003t0-Op
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 02:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ilg@livius.net>) id 1is01Z-00039L-Hn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ilg@livius.net>) id 1is01Y-0000aC-BN
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:57:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:33840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ilg@livius.net>) id 1is01X-0000VG-Tc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:57:04 -0500
Received: by mail-wm1-x333.google.com with SMTP id w5so6521042wmi.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 23:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=f4mxqX9LLsSLzuRn9mQiTps97UO/GJpJd6GT88WP5as=;
 b=eWx8eefF7kMfRVqF5A5gY4hrH54bhDEPrVaCZkRBvACD9GXrTqyWzy8r8mfV4nbOK2
 ACjSv1HZcLtPNvPC1F3Qoq92VO6vvxZqURPO0OXPiOj0icCjvA9kVNXcuNAVC78t/d4H
 9Cvfbv0JaH52ZES0mymQZG7hyWC+bNx04bxQW78G5sBsV8KFGLLYfXdmJEzqCJ/6Yno2
 gu/0NFNn0kebgi4CxaC5p45NjF1bV44cpkCA8JK/IU+7yMi7QmcGnDJYeShNNqV1gqlR
 5BuuPzRlLfLhmYsv6DCLE8HNG4VLDKWzXX2zuKESzZICBANb0/OtV3iPxFgkYAEpxelk
 30vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=f4mxqX9LLsSLzuRn9mQiTps97UO/GJpJd6GT88WP5as=;
 b=ME2oxCbJ6mhCzMOzoVf2u3aBvZQCkKruUwzkTs0WMEpSh8ZEUygkhrsHLiRzeGlV2w
 G7pmrzoIlI7Iv9xZJnhnt5A4TKu9KrGwiRHaLOp97y9DFvCJFvR/SHUvE8mS9Y8QEbDB
 X3oj+UoZpiqgEJ+GZkZxBurr8QgYpCTb/CcyS2wq6I7JK2zKEXWj5S/xGNthkcVJFoaq
 at7nNfERy8XUrt8IaYW8N0izjr1iZojbn9Vq87fr4BVB8A2j4/RLzZ7+kkNx0siGHOJ+
 R1CmgWbKJCsJ2WvnYTCjKxXU4URpIWxmswfIOgQWqsnLvbuoeuJPTsKjH8GjQF+XdH49
 HeIg==
X-Gm-Message-State: APjAAAVkT44pyY46bbJp/l5bT0VpVh+l/FEeEWIVcRZEqb/NpCPaeFoN
 vvVYdx6zAZTrE90BgEh/hi4W7w==
X-Google-Smtp-Source: APXvYqzZTNDvCFYCKFTGI8zeYUUtaiIHKereRkn7eyDQgAbvzQqZJLLhI3qnE1HRpAMmNxKW9qvZ+w==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr4388826wma.121.1579161422474; 
 Wed, 15 Jan 2020 23:57:02 -0800 (PST)
Received: from wks.local ([188.26.232.206])
 by smtp.gmail.com with ESMTPSA id o15sm28550179wra.83.2020.01.15.23.57.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jan 2020 23:57:01 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Semihosting, arm, riscv, ppc and common code
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <1a1cecb5128134e681b9145b9c6bc10a8db00ea9.camel@kernel.crashing.org>
Date: Thu, 16 Jan 2020 09:57:00 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <3724D35F-AC4B-44A9-9537-FCCA930D463E@livius.net>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
 <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
 <87sgkimkma.fsf@linaro.org>
 <1309ca0ab6405d88cfd949c73130ad0f2af944a6.camel@kernel.crashing.org>
 <87wo9tkjxz.fsf@linaro.org> <81f25a9e-a52c-ca8d-4d4b-ca36fcee73ed@linaro.org>
 <C4EE0480-C366-419B-84F1-3BEB794D1598@livius.net>
 <1a1cecb5128134e681b9145b9c6bc10a8db00ea9.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: keithp@keithp.com, Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 16 Jan 2020, at 04:04, Benjamin Herrenschmidt =
<benh@kernel.crashing.org> wrote:
>=20
> ... I agree, which is also why I want to use the same interface for
> powerpc, it will simply make life easier for everybody.


I don't know the current implementation in QEMU, but I suggest you also =
take a look at the current Arm specs:

	https://static.docs.arm.com/100863/0200/semihosting.pdf

The implementation in OpenOCD is:

	=
https://github.com/xpack-dev-tools/openocd/blob/xpack/src/target/semihosti=
ng_common.c

> The calls
> aren't perfect but they do work sufficiently well to be useful and I
> haven't yet been convinced that it can't be extended if necessary.

In theory it can, in practice it'll not be easy.

Imagine that you decide to use Arm semihosting for your architecture, =
and implement it in QEMU.

Then you try to convince other tool developers to do the same. If you =
ask them nicely, they might copy/paste the Arm code, and you're done, =
major commercial tools will have Arm semihosting support for your =
architecture and it becomes a de facto standard.

If at a later time you decide to extend the protocol, you have to go =
again to all commercial tool vendors and ask them to implement the =
extension. You'll need good reasons to convince them.

In my case it was easier to convince SEGGER to add Arm semihosting =
support to their RISC-V JTAG, because we had a long relationship, but =
even so I doubt they'll be happy to implement extensions.

---

Anyway, from my experience, for practical cases the Arm semihosting is =
more than enough, once you have a functional implementation for the =
client side you simply forget about it, and you can use it for any =
architecture.

My implementation is the following:

	=
https://github.com/micro-os-plus/semihosting-xpack/blob/xpack/src/syscalls=
-semihosting.cpp


Regards,

Liviu



