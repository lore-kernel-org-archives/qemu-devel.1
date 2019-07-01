Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BFFC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EC7206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj73yvcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EC7206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3mm-0008Sy-4j
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:24:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47769)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi3JT-00069o-8M
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi3JN-0003t1-4Q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hi3JM-0003sH-R9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id m202so11133389oig.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=F1CAFMJ2ugwhLJyIZk8aVSxYO+A7/m98waF1eglWTiQ=;
 b=Mj73yvcpkbDKkzosWfTPPcJXZUIEHwXoxlBB/Ch0L/D2jSscqpYYQBfPJ8AKWDuoaV
 +kBs73I5eG0/mPdh8/Ic9CanD/ym6vN5/uvCpdqLFTVmFfztI1G3kwf1qxtdtBmhg7RZ
 Wcbu+VkehSKsAuENaAl+cKZM6uApKvxiyxak870mNMdVYyxIf0QFPYXlr04Mbwx3w5No
 Tg82JwPEJZ9mphp88IbnBVguv6GgQR8cU3p2SCxXBHkllfcUHBGznVy5O3kMRR55CJ9D
 gJ1ldxdOTduxIsXPkpr8RtC4TpS7Cg4pZLua1X99La+2+CFWI8y/DGusYHL9Vnx/n76O
 Z03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=F1CAFMJ2ugwhLJyIZk8aVSxYO+A7/m98waF1eglWTiQ=;
 b=DU9ZchKP8lU1VG3iXhXs260V09qvz2C2WN62zJq68fcmbJdkS0wxfzhVqpf30xP7iu
 zkqbmkV2PTNAChnZwDIa0jQxEAPLuONmNkEBREP8fYwxlOGyE1H7xIebraS892K9qLCh
 tml7exPpacvWiN90ePPKweqHL0aXHvhLDOu3wfm67t8Xfg++lZAi4q6+Z4cY5BZG7lvI
 CmBUr5A+HG35p4a2ccA2i8xmzoVuTFQWHpyfyxGZkIO41jK/+Hu3abbq+hDKKZim/Osy
 OyqNoQ1dCJnvXpL6iUk9h3J8WtYUvkySnTUq2TYSUgJLmfnOcezhz1ISoTtSkPdwQBmm
 xwOg==
X-Gm-Message-State: APjAAAXRiJ62KzN9xHwpW8VNOSIueJH4TtL+oeDuiWveO8zIPso2KKWM
 1UyoGVSsNqsVofSxCigWhS2lEdxNL2AE02GQsPHiHA==
X-Google-Smtp-Source: APXvYqx4fV7FfSrMltTULwuUTbtm7wFMOVmkBDN/rEU7qUOmegzLvOTYOpx0aLfgfViwmqntT39H5xaLEz6pjrJyRAU=
X-Received: by 2002:aca:4083:: with SMTP id n125mr211010oia.106.1562001089638; 
 Mon, 01 Jul 2019 10:11:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 10:11:29 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 10:11:29 -0700 (PDT)
In-Reply-To: <20190701112612.14758-1-philmd@redhat.com>
References: <20190701112612.14758-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jul 2019 19:11:29 +0200
Message-ID: <CAL1e-=hyQ-SArX7fOavpYoSuZSVg2yV1DDW-j6D1rV6UWEnNTw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.193
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Kconfig dependencies for some MIPS
 machines
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 1, 2019 1:26 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> w=
rote:
>
> Express the MIPS machine dependencies with Kconfig.
>
> Various issues prevent to use Kconfig with the Boston and Malta
> boards. They will be switched later.
>

I am going to select the whole series for mips queue scheduled tomorrow.

Yours,
Aleksandar

> v4:
> - dropped Boston (Aleksandar required the ITU to be selectable)
> - comment why use 'imply' in Jazz (Thomas)
>
> v3:
> - addressed review comments from Thomas and Aleksandar
>   (noted in each patch)
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00887.html
> - Do not remove machines from the default config (Thomas)
> - Corrected comment about CONFIG_PCI_BONITO (Thomas)
>
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg593013.html
>
> $ git backport-diff -u kconfig_mips-v3
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream
patch
> The flags [FC] indicate (F)unctional and (C)ontextual differences,
respectively
>
> 001/4:[down] 'hw/mips: Explicit the semi-hosting feature is always
required'
> 002/4:[----] [--] 'hw/mips: Express dependencies of the MIPSsim machine
with Kconfig'
> 003/4:[----] [-C] 'hw/mips: Express dependencies of the Jazz machine with
Kconfig'
> 004/4:[0005] [FC] 'hw/mips: Express dependencies of the r4k platform with
Kconfig'
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/mips: Explicit the semi-hosting feature is always required
>   hw/mips: Express dependencies of the MIPSsim machine with Kconfig
>   hw/mips: Express dependencies of the Jazz machine with Kconfig
>   hw/mips: Express dependencies of the r4k platform with Kconfig
>
>  default-configs/mips-softmmu-common.mak |  7 +++---
>  default-configs/mips64-softmmu.mak      |  5 -----
>  default-configs/mips64el-softmmu.mak    |  5 -----
>  hw/mips/Kconfig                         | 30 +++++++++++++++++++++++++
>  4 files changed, 33 insertions(+), 14 deletions(-)
>
> --
> 2.20.1
>
>
