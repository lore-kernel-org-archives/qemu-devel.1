Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93399C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6D420C01
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GT2TciwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6D420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i01GQ-0000sK-EQ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 06:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i01FT-0008I8-63
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i01FR-0002WQ-NB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:20:18 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35]:43367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i01FR-0002U8-Hv
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:20:17 -0400
Received: by mail-io1-xd35.google.com with SMTP id 18so10991591ioe.10
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hq+M197GYsn02hijHhWJWXud6gpsnUI4NBlUgChhuLQ=;
 b=GT2TciwQIcYDuM0tUHeC8XCML0agAo3mcSy9gDdASeW7Kie6NwLQDkT/VB/XBnsNqY
 jFQFqWmhWifgQ+bCvYSF2QhQSY85nCnMaNnFQ6Kb2rNzxQ9itimtvAC8ZU9TXVps5Uta
 onmK91hZdDhhdnB+mfsaWmAQ+SLPt5RmI/g406cZDae3odef688iE65flwrKJ603Ub4a
 8Jtf/z38E27L8VH+DaDHjsZ7jJw7ejXuFobVJ/TOkCVHiTBizl3iQRJ5bdCYARfCnzAV
 JqIDOiiy6gs68NFx3vLzwGLY55uemgYvZx8l0EGZbKMtazMfco3B27gBFwCnzTtn/LYZ
 kTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hq+M197GYsn02hijHhWJWXud6gpsnUI4NBlUgChhuLQ=;
 b=ey3XJM9oRozP/UAfxSxjjm9hQL8Gsuso602UBz694ZiVvhs9T94AF+Y8c8Y4ATbQFE
 HsusWKpvQ6Xj2EO0LcfSOSYa7yvjsEku9EtbbhEsq4fESWO6QuZlwj7IDslW4rNwx03I
 6RsSsv8j6FSoeJ36FjS31oKV4j4Mmr2LqUcs4CatkktNNNJKjl0Dspp7S95W/48XXBvz
 lQ8YhfUtOCpr6YdKINi5jzgAC+g2PqU3vwYZtRJrNzuvvDGHbkR316ohduHuGSpoOHVF
 iVL2r/U1I7FoLhmJsVCHc8JMZDAo/Jw12NBhOGjZrr3TWq+8hgFj4fowH89KpeuZAtt8
 xwJg==
X-Gm-Message-State: APjAAAWa7c7MKOyVDSobpkgkxxQjrnqOEugZyuVfKMcWlYz/IpUVKvD7
 R1l1oeIcN9NDxqvUDNiRYlmaDpKFc9dsz2qtdSXt/A==
X-Google-Smtp-Source: APXvYqy3xHyH7sy3JyxIrURcvgT6PCBOnO4AT4SN9g4yhbuBc3SRc97wSfUspbl6feFLJqYmFDIlJ9+SZWkyo7uDqT0=
X-Received: by 2002:a6b:fd13:: with SMTP id c19mr7252633ioi.168.1566296416347; 
 Tue, 20 Aug 2019 03:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
In-Reply-To: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 11:20:04 +0100
Message-ID: <CAFEAcA_yg6E00jq9Rk39CRpMQMZudg4vyKjwMnsN37RaE0=erw@mail.gmail.com>
To: =?UTF-8?B?56uL?= <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d35
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 11:12, =E7=AB=8B <zhlb29@foxmail.com> wrote:
>
> I am working on a project that requires me to modify the ISA of the MIPS =
target. I have been staring at the source code for about a week, but found =
it really difficult due to me being a young rookie and the sparse comments.
> Specifically, I need to extend MIPS, by adding some new instructions and =
new CPU registers to the current architecture, and that sounds really easy.=
 I think the place for me to look at should be at the directory ${qemu_root=
}/target/mips/. With a MIPS Instruction Set Manual Release 6 handy, I have =
difficulty finding the source code where the ISA resides. Is it in op_helpe=
r.c? Or translate.c? Any guidance would be really appreciated. Thank you ve=
ry much in advance.

The general structure of a QEMU target front-end is that
there is a 'decoder', typically in translate.c, which
takes target instructions, figures out what they are,
and emits TCG operations (an intermediate representation)
for them. Sometimes a guest instruction is simple and
can be handled by directly generating TCG code to do
it. Some instructions are more complex, and we handle
them by generating TCG code which will at runtime call
a helper function to do the bulk of the work. Those
helpers (and some other code, like code to handle TLB
misses and various exceptions) lives in the various
helper.c files.

One important concept to be clear on is that QEMU is
a JIT -- this means that we generate host code that
corresponds to target code (at "translate time"), and
then later we will run the host code (at "run time");
code generated once can be run many times. You need
to be clear about whether QEMU C code you're looking at
is called at translate time or at run time, because
the things that you can do are very different.

thanks
-- PMM

