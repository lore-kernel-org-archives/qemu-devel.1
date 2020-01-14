Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51734C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDF8207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0Ea8JYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDF8207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irIz7-0007JV-1J
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irIrD-0004Za-UA
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irIrC-00052Y-Nq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:51:31 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irIrC-00052F-Gk
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:51:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id q9so12970025wmj.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 01:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dOKswLGEPFaBmNIUgF6osbnxjYbbrZmQviQwFYXYFEM=;
 b=w0Ea8JYUDWVsfrVgRxJYMgYozoJx9VHoHiTi7lhFSzrbKYLMkNRBsnQdVDr6Y1oHJe
 e9BYdtyYVVISpya12OGarHLyuHbxfNltgM+lF0OyLCapQ+luw7ZVXKeTzG4gNaUslZno
 GGgs0IUyuGPrw/Gd9qU0SresQllCY5YeJc76G4RPR/yL44Z88cjQCQbWdQKlsPmqaaPn
 FjpP2dUL5lRz6AjQNk/h2YK8FoSEx+Zj8Y1876/Yxq2igYPQCStVDll5sPYWDwfGyfAP
 MeVxMjiFecS1T4UFYBByCW6O8VFDI2F+BvTtE8cjdX4lD9brGN7LTAcA5x/TbakpE21p
 PtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dOKswLGEPFaBmNIUgF6osbnxjYbbrZmQviQwFYXYFEM=;
 b=kXlVOjHnQk3MhWWo74Pf4mwFCU7Wl1CsjpAN1jAhDpKwr56seKHGryy6GxeGLcUwLg
 ihCUvz5KF3Dhsrv7PLkODaUZtFFEDbI0d25ikVuvtZXgj3u5Ed54NpIn8lFb8mKMAX/a
 hmB2RRPFQbDH8pX0xizl/xzyr9mWkWLKeDXnqKp229wrPaThmxooyjUp+u1pbokAuUvG
 SOwM9yy2Yfsmu0NqvxhIt44t757VX/02n/wsjPMSnJ9uPEhskE7Oy/d053zkhlthiAA2
 p9k8ZMq+259NuVYI82cuAi1TxZHqyZ4f46ytmt3I9dOcbbIBl4QRpcibCeaAFqjgEtwZ
 kU/g==
X-Gm-Message-State: APjAAAWMwfeG4FrOD6xlAtUQEvIgn4djFTzr3mQtGnWOMHBxZgr8jueI
 z+JiIUlLS0OHDUWqpRLW1geO5A==
X-Google-Smtp-Source: APXvYqx+hyU45Eq4pPgoRQpwOK8Lo5fwSdPxHWhYa9CaCVhHHNf6gfhY45nYw1j8clq3AJa7A0a5JQ==
X-Received: by 2002:a1c:1d8c:: with SMTP id d134mr26628772wmd.16.1578995488898; 
 Tue, 14 Jan 2020 01:51:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm17482019wmc.47.2020.01.14.01.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 01:51:27 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FC501FF87;
 Tue, 14 Jan 2020 09:51:25 +0000 (GMT)
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
 <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Semihosting, arm, riscv, ppc and common code
In-reply-to: <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
Date: Tue, 14 Jan 2020 09:51:25 +0000
Message-ID: <87sgkimkma.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Liviu Ionescu <ilg@livius.net>, keithp@keithp.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2020-01-14 at 09:32 +0200, Liviu Ionescu wrote:
>> > On 14 Jan 2020, at 08:25, Benjamin Herrenschmidt <
>> > benh@kernel.crashing.org> wrote:
>> >=20
>> > I noticed that the bulk of arm-semi.c (or riscv-semi.c) is
>> > trivially
>> > made completely generic by doing a couple of changes:
>>=20
>> Last year I did a similar exercise in OpenOCD, where I took the Arm
>> semihosting code from the Arm specific location, extracted the common
>> part, updated it for latest Arm 64-bit specs, and then used the
>> common code for both Arm and RISC-V.
>>=20
>> If you think useful, you might take a look there too.
>
> Well, one of the LCA talks wasn't that interesting so I started doing
> it and am almost done :-)
>
> I'll look at doing something for arm, riscv and ppc and send patches
> once I get it working.

Cool. Are you considering linux-user as well or are these only things
that make sense for system emulation?

>
> Cheers,
> Ben.
>
>>=20
>> Regards,
>>=20
>> Liviu


--=20
Alex Benn=C3=A9e

