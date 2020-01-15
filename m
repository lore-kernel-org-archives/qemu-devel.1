Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B251EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722B72465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="Czam+KsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722B72465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqlL-0000ss-LQ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ilg@livius.net>) id 1irqkK-0008Fm-5l
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ilg@livius.net>) id 1irqkI-0002M4-7d
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:02:39 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ilg@livius.net>) id 1irqkH-0002LP-OO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:02:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id t14so1638321wmi.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 14:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=BVP4NRhPFSHrJjIPjsLJjDTukdxB17WP9oLbQhCIBco=;
 b=Czam+KsK9C95nTf5qjQT9KAkUSAzIcYuTDwzhpTwj6u9yRv9OyTZYG3l9tTQw3d2x+
 zMjmX1KW86zl5B39fT73/mSd6Vwp6DYH7n+/zME4sFY3CNz2ikTffFv0/3ZvllRiP6pL
 KypTnMzXip1BvG22i8d5TglYMtdZE2Xcf9hafFZTU0Ys87+Kkwr5Wbii7fC7c9iUR5bf
 33WxaoxlIgPgSBdiiQzdHCArFB7A+8l++1yXlVERq2ge34+bcevxQBYqrg9F6OBC3R1I
 Uz9RMqy9TBIrdT1PdyJTxUbH523xcYqlaPcDN/033v7cxDL3C/a1EBNpGpl06bkc+Lo9
 +mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=BVP4NRhPFSHrJjIPjsLJjDTukdxB17WP9oLbQhCIBco=;
 b=JM4fkiTqKkMjd32oPdE1KhmUo5eVXpU/+xsUhV2UFH0bCi7t4sta79Kw79Lf+1Yk0a
 Wmt24ICWXSsRNYQ/SBhp79DrPSlgtEkCVA1M6C2lhNmIbeDdm/JgNtuMUWdw4Qn36MNc
 Xny77wpIGctx6EUtvZQQHTjJMjSBpznaZqvzx4z+Ul8llbFJ1jLrd2n63ZMb8A+srKNl
 tNF2hYlbgJDYMPjjLnTg0sl7Oz19FZW4FV1dCAzI9Sj4kjPid+BZoZ9ck+yDirdPOr4V
 trGR844jApNMEp7ZgfSPUaJg4v5KpOGbVH+3051CXm/3N9/B1+eclOTVgWFWDrBd0OkO
 Fdew==
X-Gm-Message-State: APjAAAUv/DCtMOQmJLvBhF4L4q29Dzt/0pIAI+EstcIUUc4dZZ/dHiDF
 HYLF5Pw2/Vl4ZzTjNJuYPxjCcQ==
X-Google-Smtp-Source: APXvYqwc6ILREdvaPjw/6hgXNUkja5UGYqX1XBZwxQPckqc9HhSxHwL67CkmahIVcr4JRhvxsikXEA==
X-Received: by 2002:a05:600c:211:: with SMTP id
 17mr2294170wmi.60.1579125756350; 
 Wed, 15 Jan 2020 14:02:36 -0800 (PST)
Received: from wks.local ([188.26.232.206])
 by smtp.gmail.com with ESMTPSA id z4sm1665107wma.2.2020.01.15.14.02.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jan 2020 14:02:35 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Semihosting, arm, riscv, ppc and common code
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <81f25a9e-a52c-ca8d-4d4b-ca36fcee73ed@linaro.org>
Date: Thu, 16 Jan 2020 00:02:34 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4EE0480-C366-419B-84F1-3BEB794D1598@livius.net>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
 <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
 <87sgkimkma.fsf@linaro.org>
 <1309ca0ab6405d88cfd949c73130ad0f2af944a6.camel@kernel.crashing.org>
 <87wo9tkjxz.fsf@linaro.org> <81f25a9e-a52c-ca8d-4d4b-ca36fcee73ed@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 15 Jan 2020, at 23:28, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> For risc-v, the odd nop-full semi-hosting call sequence

That unfortunate call sequence was the least worst compromise that the =
RISC-V design team could agree on. :-(

The actual problem was that the RISC-V instruction set has a single =
BREAK op code, without any way to parametrise it, and they refused to =
spend another op code for an extra BREAK.

> was chosen to work with
> jtag debuggers on real silicon.

Yes, I know at least two, SEGGER J-Link of OpenOCD.=20

But again, there is nothing in the silicon related to the odd call =
sequence or the ABI, everything is implemented in the debuggers. The =
silicon has only to break to the debugger, then it's up to the debugger =
to decide if this is a semihosting call or a regular break.

> ... they did have the opportunity to do better, and did not.

I don't know why you present Arm semihosting as a disaster. It is not =
perfect, but it is functional, and common unit tests use only a small =
subset of the calls.

And there is no 'window of opportunity', if the RISC-V guys will ever =
want to reinvent the wheel and come with an official 'RISC-V =
semihosting' specs, they can do it at any time, and this will have no =
impact on existing devices, everything will continue to work as before, =
only the debuggers/emulators will need to be upgraded.

But the only immediate effect such a move will have is that software =
efforts in test frameworks will be increased, to support another =
protocol, while the advantages will be minimal.


Regards,

Liviu


