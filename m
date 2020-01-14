Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1F9C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 07:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA833207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 07:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="FYkUwao1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA833207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irGh4-0006jS-VH
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 02:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ilg@livius.net>) id 1irGgI-0005sC-Pb
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ilg@livius.net>) id 1irGgH-00005k-Ry
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:32:06 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ilg@livius.net>) id 1irGgH-00005E-Bn
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:32:05 -0500
Received: by mail-wr1-x430.google.com with SMTP id t2so11082426wrr.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=gZnEP6uZAH9ok1af2x2KSlY6860iu5C7sbphf32Rr/I=;
 b=FYkUwao11/xmenGN7AVxRXDDKq6nnLR4o9JxLiL7GXlcU9F4S8OYnBJritvySFewKB
 zbUleu5wFjVD295DCoK0VBJWFW+HkIQAbgJMKIZLWstKgFOFY3PGGnWSfmsIM5s4VuJR
 lZCNWhHJKkEvodU0udS452endY4t6yF6TdDJ1Guupx7jOwZMZyHi89wcCwmiK/KCFHG3
 V3R50FFJxZgCNByCsy3nynJxaaCOaNthI/JuybpqbuWwrNNkzS5PicCJiZV+9FttrpvS
 a4CHn94LcQUK5AFjWzQSaohu9RLMtgYsDCih5vhrJa/MqX8x9DafZ/Ml6hhJ7MKZ8BpB
 Vl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=gZnEP6uZAH9ok1af2x2KSlY6860iu5C7sbphf32Rr/I=;
 b=Mnu7vDa0ZDkXCoLY+Sy4+f9zxh3/RpX8kmtspcMqzUCqtVk0boyqbe1ga9QxTKFPr6
 Vg9VoM40gDrfdgKugjMthlUIpH33dk0Dq3TiAWf/XXQvGZFUPvx0AfJsSDMgdgUtCt7f
 ptCGuLoSnSau097OSO8/oo6BnisxGDJl88c2m3cq9iL7Gt9MBUy0YhLSL/HonBrLKmFf
 JRtL8Lx0OVMG+Ds/3Z9Fbx2+FzAGjFCDLSXxsn/HYtgiU6bsM5eQhd2LjbeiUHYCsua0
 i596wDoiF9AKldlcwkurw+ncVdkMh9nK3WrLGW5i49ExcpEtRrqafVJV6lYK1Qn2UWkM
 41kw==
X-Gm-Message-State: APjAAAWJvUtzHjkV4kZmGgHnJkIchZ6MQjX1DCWM9rAil6mdXWhoFON7
 hYYb3cwo3p2NTMk1hR0x60AEqw==
X-Google-Smtp-Source: APXvYqzDtaEnwHPyOErO02TDJZFUVd8ZAouL1qi/EoU02YZ3zt2Yeq0H7GSkKNM83OdoapZCbnv8NA==
X-Received: by 2002:adf:d183:: with SMTP id v3mr23385941wrc.180.1578987123563; 
 Mon, 13 Jan 2020 23:32:03 -0800 (PST)
Received: from wks.local ([188.26.232.206])
 by smtp.gmail.com with ESMTPSA id 124sm18323074wmc.29.2020.01.13.23.32.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2020 23:32:02 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Semihosting, arm, riscv, ppc and common code
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
Date: Tue, 14 Jan 2020 09:32:01 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, keithp@keithp.com, qemu-arm@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 14 Jan 2020, at 08:25, Benjamin Herrenschmidt =
<benh@kernel.crashing.org> wrote:
>=20
> I noticed that the bulk of arm-semi.c (or riscv-semi.c) is trivially
> made completely generic by doing a couple of changes:

Last year I did a similar exercise in OpenOCD, where I took the Arm =
semihosting code from the Arm specific location, extracted the common =
part, updated it for latest Arm 64-bit specs, and then used the common =
code for both Arm and RISC-V.

If you think useful, you might take a look there too.


Regards,

Liviu


