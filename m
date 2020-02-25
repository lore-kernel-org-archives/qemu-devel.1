Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1B5C35E15
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8723C2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYX42RXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723C2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6hI1-0003nT-Nt
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 15:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nikhil.accent@gmail.com>) id 1j6hHN-0003LG-6v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nikhil.accent@gmail.com>) id 1j6hHM-0003NQ-3j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:58:08 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136]:36010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nikhil.accent@gmail.com>)
 id 1j6hHL-0003JZ-T1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:58:08 -0500
Received: by mail-il1-x136.google.com with SMTP id b15so428664iln.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=NpQshM8KCqzopsAw/gitWGCty19KNpa+cS1uqvvfZXs=;
 b=nYX42RXMcTFVxex0Lf4uGDTbd6ihQHhnTq3zmCV1t3KIqimzRlIBcTyzQCg2jE8zW+
 MqKGeGf+djl+7VH1ylfn6XnEbVsyW0LoFY9ZXuV7QIaXoCMK5xVTRhISTBAf/IZN9Q40
 nrgbVWv4vcN+Mc8mPYRXp1lQvsHyYL5REPHr028/17IAN0C8sroTUmPhbuZaFkzBqyoF
 afrgBG7svQp8AmFjVMlahed8cs78KH0uP+qDdoLW5dwPssGBMCwIcCpDfE8Ic65ceqi/
 F/psoWzOunw03w3DC36KargRF6r9jQZniSdkeWa2lH7Cp2nm3ipUi0yUcexSjaANQi+n
 wcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=NpQshM8KCqzopsAw/gitWGCty19KNpa+cS1uqvvfZXs=;
 b=en915HQ18GC8vDeIEFcLG3FA1LN3lDUvk27tgB2KtjJ1bhs+okTZ+ThTglgxSEbY7S
 +YrPSlIr83DcJU8rOJEeo1SmXb2N404Vg++Q/pulpjqqFjEZDMWr9FNAzfstMBgtpAIf
 rr+9CKxBbsgbS+5r6Nd2KN5IKt+GBz+B1WDoDl0bmfQuct0RrJL7ps093oLqsh5D/ySA
 UwYAQF0+jz8rIx8WbcbrqY4DUxM3YBtK6lq9yvLRNZzYrr0S7VB1wNl+uUJ2xzFly80V
 KRoNnWGpri6cc9sa6ZGKW5HoPW0ota8ddZ9CGBabQ+3iQlhnLpqAFyld5qgp3kf7K+Ki
 QaKg==
X-Gm-Message-State: APjAAAXVNWEmutJv6GP3NzhGt6O/VaCcvMj8l12fk7eMcpFGxWk/fSk0
 AabcY4iE8DBQLW1ftU3niKh/keyqXLNXhgpRs7X/PXEu
X-Google-Smtp-Source: APXvYqzTFTh2kXIJ3/mHkC70HVM000Lc202EJDKoT4hKYOFwtslTVt+8lGAD2q3mKmlgJ6TJ1mWUSY6f12ALz5T9H6Q=
X-Received: by 2002:a92:85d1:: with SMTP id f200mr524639ilh.245.1582664286693; 
 Tue, 25 Feb 2020 12:58:06 -0800 (PST)
MIME-Version: 1.0
From: nikhil bansal <nikhil.accent@gmail.com>
Date: Wed, 26 Feb 2020 02:27:55 +0530
Message-ID: <CAGOqhAH7Xk2nrLjQ6WmAEtYsvbRh4FxNDQDAC=WG5wJSR9anfQ@mail.gmail.com>
Subject: Getting Program Counter
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009b707d059f6cbe26"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::136
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

--0000000000009b707d059f6cbe26
Content-Type: text/plain; charset="UTF-8"

Hi,

I need the memory access traces of an android system running on qemu.
trace_memory_region_ops_read/write in memory.c provide most of the
information I need. However, in addition to the trace information already
provided, I also need the program counter of the current instructions. What
changes should I make to memory.c to output pc along with the information
already printed?

Thanking you in advance.

--0000000000009b707d059f6cbe26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I need the memory access=
 traces of an android system running on qemu. trace_memory_region_ops_read/=
write in memory.c provide most of the information I need. However, in addit=
ion to the trace information already provided, I also need the program coun=
ter of the current instructions. What changes should I make to memory.c to =
output pc along with the information already printed?</div><div><br></div><=
div>Thanking you in advance.</div><div><br></div></div>

--0000000000009b707d059f6cbe26--

