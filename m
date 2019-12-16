Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D8C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2111A206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO1zEIcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2111A206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpeQ-00052T-9z
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1igpde-0004Wu-8n
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1igpdd-0007Qh-7Q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:38:14 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1igpdd-0007Of-2B
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:38:13 -0500
Received: by mail-oi1-x244.google.com with SMTP id v140so3250050oie.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 04:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mImmblik8R4Ino+HQdCIyq9PyHNn7E242osM/3NmQAc=;
 b=HO1zEIcvblIIlZYGzGSt09h8QVOMaK5qRQlx6UeAvDBDFQdElXf21AQxVqtdb8FrU4
 RawoJOrVJOAzfWq+buYE63de7fXJrR6stmhoTMjcCpbozcHFtX9r/KljA0NaAlVCVRdp
 +M5uo1eoGIViYRWNlqijcKvWfMSYp8a0HGx8RwBz46/o+9LduTajfipuS9vf4J65EhHO
 NCeT7cbB5WGRF4C3tjdYcLNsjBHYeagPVKG0cIJwWVdaMh3oBREly/Uxc5dYrEycZeqD
 scSvP2yTAoa35nJ3+yJAuKK0TZ8KInsy9V4dK8+2awIeqCr/RRb/292cREAEFa6LixAZ
 vTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mImmblik8R4Ino+HQdCIyq9PyHNn7E242osM/3NmQAc=;
 b=AmJZkd8o5TTNWL4UysO23V3OhL/T6wNcVDlxNFdXSgtEgjXNSbOJStV5RNimhp9QLt
 TSmMqphvlOFKYTVmcT8g9KGWCdHYZ3M/Dl6ldspmtxUv156AN5HEdfifLN61gYmD7Fs5
 oWCUO3FOWoh1MPMvzHTXYVjY3yXFSXFhLrJu2FXF4xydBB32DxMphkIa+gPkz+BdNxFN
 wkbs3vj9+K10u3V9BZpG0E3YLCLCXpoTf8S409PMigURs5VKYyG/J0nhQ5q87DjQSflm
 wsHuBicJJSyZGComAK+Uu3RBNZUmpLyUuMX6H/tdPmt0Nxq4UoKZw7tV53XZbN37/W6c
 YaOg==
X-Gm-Message-State: APjAAAVKCvzrZknG3t3vU13J8u7+5odw7UYncEA9bZwlM9C2SrVP5Tnz
 ScKXgtXaDp2TxxaPmsWbvydqN29qBxkYSs9GCQ0=
X-Google-Smtp-Source: APXvYqxtAvDYk4ici8Okfyyufpo+G7pENyZYLmt5GrpdkRhsIBPUtMmOe26wWnUgrAzvIfyMrE0+cst1MwMfeWQIz0w=
X-Received: by 2002:aca:bd85:: with SMTP id n127mr9524495oif.136.1576499892308; 
 Mon, 16 Dec 2019 04:38:12 -0800 (PST)
MIME-Version: 1.0
References: <1575982519-29852-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1575982519-29852-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 16 Dec 2019 13:38:01 +0100
Message-ID: <CAL1e-=gL6aLFV2p45baffMP7NE1Tx3O5Rr_ta7_N6ebUAv2-TQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] MAINTAINERS: Fine adjustment for (mostly mips)
 content
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 1:57 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> v2->v3:
>
>   - changed patches 2, 3, 4 on Philippe's request
>   - add a patch on including acceptance test in MIPS section
>
> v1->v2:
>
>   - removed patch on new git infrastructure section
>   - added a patch that adds two files in Malta section
>
> The goal of this series is to:
>
>   * reduce the amount of "unmainatined" files (not having their
>     maintainer in "MAINTAINERS")
>   * reduce the amount of nominally maintained files, but unmaintained
>     in reality
>   * increase the role of non-mips open source participants in
>     maintaining and reviewing mips content
>
> Best wishes to all new and former maintainers in future activities
> and enavours!
>
> Aleksandar Markovic (5):
>   MAINTAINERS: Add a section on UI translation
>   MAINTAINERS: Adjust maintainership for Fulong 2E board
>   MAINTAINERS: Adjust maintainership for Malta board
>   MAINTAINERS: Add three files to Malta section
>   MAINTAINERS: Add a file to MIPS section
>
>  MAINTAINERS | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>

Applied to mips queue.

> --
> 2.7.4
>
>

