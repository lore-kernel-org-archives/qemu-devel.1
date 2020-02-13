Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A7FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD2D206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id8R+vW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD2D206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2IPk-0003g8-JQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 12:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangmuhui@gmail.com>) id 1j2IP6-0003GX-QV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangmuhui@gmail.com>) id 1j2IP5-0003VD-QL
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:35:56 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:34667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jiangmuhui@gmail.com>)
 id 1j2IP5-0003TS-IX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:35:55 -0500
Received: by mail-lj1-x22c.google.com with SMTP id x7so7579653ljc.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=bKFWVCorB7J/m+QkZxKSaGM41oLpc0WuFYG4BZEeKQM=;
 b=id8R+vW4YTq3KVDouBLp2cYRwPvJaG6+WIKg9AN4vJ72dJ+6nWygfMxEQn0H3nd2Zu
 WkPuvaX4s2lc9g6/qyEhrFT+ZwiHb8U9I8aMWynpdzW25TrTaeRgzZ1C6tw253/2amNU
 Ir6pNcbp4X8Z0zYPnj70PW3wprfVynYwKwJBFJvScF7ZL82+5Caof6ct7UMeV4rVU8NY
 KMFFmUjAdIZhQnQs0i/foFuKGaxZ4/MCamncDuDJsNt5ffWkMjpQPs0rztmvIBK+Uswq
 AoR3cwu+3w+51EY3nCPWrZwNqK5Snp2W5x+x+TqjYAEJWZpQfaI4O59D61DcX5oqxGci
 1A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=bKFWVCorB7J/m+QkZxKSaGM41oLpc0WuFYG4BZEeKQM=;
 b=ktii1DKtQJ5KjJMgyD1LlHGgVmaT7vuPJhfs9k6BdpXBtu3sI8awfYdI0Ea/jlTKqf
 iIYWHsAI22u18JNoDDqWnGGe+nfYvGUIuUgvH1qYFekjVp7TdNPqNNNdh7YoOtNQ1S/P
 PoRsbAuzDcl99pdIUynrIziLmqM19FTwjaFdhxmP3YaCnXMeTyHs6/F49lFwW36SpEes
 dQ/IWkFHSLCzQLmt8zTRpfk+LlaDIYqAEBbrY4JW7EWq+LqUf960opYpk4DzWKOJXwLL
 GRl6vCMyA2Mc8XQMIrNIw2GDZtZ2st39XzKK5yogR79zuLtI767GFU4Iqj0B10n1FNcd
 z7Mw==
X-Gm-Message-State: APjAAAUQmHy+gCXnD+8BR7mq2VZMN5WYmPPBXwrio/C1HJciPHfhVKoP
 xBd3qFzryeL12YQWC6C619+mao1bcz7lnfAyo21uMSjvB4g=
X-Google-Smtp-Source: APXvYqx50XMAmOpWbSfXzRMUtghZ3Vq4EGYHtXI3zsKbk5gZRuFGdufSM3QhCoQVAsrcG1B0MZsqT+PkXAMNSFgjUV8=
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr12459251ljj.265.1581615353160; 
 Thu, 13 Feb 2020 09:35:53 -0800 (PST)
MIME-Version: 1.0
From: Muhui Jiang <jiangmuhui@gmail.com>
Date: Fri, 14 Feb 2020 01:35:40 +0800
Message-ID: <CAF_eCeobcey65QJw10J85znetzNWSpmzo2ds=QT+0maNeK9acg@mail.gmail.com>
Subject: Mapping between Host virtual address and guest physical address
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004be928059e78856b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22c
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

--0000000000004be928059e78856b
Content-Type: text/plain; charset="UTF-8"

Dear All

I am recently using qemu-system-arm to boot a linux uImage.

I would like to do some dynamic instrumentation on the uncompressed kernel.
It seems that I need to focus on two key points.

Firstly, I need to know when the kernel is uncompressed, which means the
compression process is finished. By analyzing the vmlinux.elf  and the
trace I can figure it out.

Secondly, I need to know where the uncompressed is, which means where the
uncompressed linux kernel (Before translated into tcg) stores in the
virtual address of qemu. Does anyone have ideas? Many Thanks

Regards
Muhui

--0000000000004be928059e78856b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear All<div><br></div><div>I am recently using qemu-syste=
m-arm to boot a linux uImage.=C2=A0</div><div><br></div><div>I would like t=
o do some dynamic instrumentation on the uncompressed kernel. It seems that=
 I need to focus on two key points.=C2=A0</div><div><br></div><div>Firstly,=
 I need to know when the kernel is uncompressed, which means the compressio=
n process is finished. By analyzing the vmlinux.elf=C2=A0 and the trace I c=
an figure it out.</div><div><br></div><div>Secondly, I need to know where t=
he uncompressed is, which means where the uncompressed linux kernel (Before=
 translated into tcg) stores in the virtual address of qemu. Does anyone ha=
ve ideas? Many Thanks</div><div><br></div><div>Regards</div><div>Muhui</div=
></div>

--0000000000004be928059e78856b--

