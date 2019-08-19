Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E77C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC06C2086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVWLikC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC06C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzajc-0007FK-Q2
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 02:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzai8-0006Re-DC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzai7-0001Qp-EC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:00:08 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:41484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzai7-0001Mj-6b; Mon, 19 Aug 2019 02:00:07 -0400
Received: by mail-ed1-x541.google.com with SMTP id w5so525496edl.8;
 Sun, 18 Aug 2019 23:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=7FV0L/iFSvlfwmjmAtqTerMajiBAcMMl2MayHrzyomg=;
 b=eVWLikC+fP00fSmER2iprzf/YK9rXK15I3H2EgH/uke3zOoFQuzygk59tOAW4/Dtir
 eVWgxnBv48ie8uL4gORfDu6i2hbMX2OVGFOsmDLb15iRioXUseDc7ppHkzmec8sMUND5
 srJ8QfMI8un/nnaskRzR37NaQ74MY+iAkStMKh0JgeBD0oJKHNfWyFrq7LFVVqGoNOu/
 yr6RvoMf94r8I+89lPudqzAUK07djyK2bacAVB7b8K2L1AV7ob1aMBIw09nolUhIx4cL
 nd+Pc/PxNSLxOAok1xwJn+LAFTVDjWIKbY1PKO/eak+aIIygJwURCSFYyh9wOdbFZuvO
 Am1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=7FV0L/iFSvlfwmjmAtqTerMajiBAcMMl2MayHrzyomg=;
 b=hryUzN/rjnk8sxxlhbC95Is7j+DdPk3A2B2G+iuHO4vzkPvp6t/9n1IWChsgo3v10G
 gRJgKE80aH/lx0lPkW/EXRalGruI4+aYaL2K70m9CJn+W5c0HpppXarju8ks4t7Zf/+D
 R+zN5UTdl2qiyjdgOjhdL5u/XI5QmojrJDhqlH/NsztIUb9dgfQwqbP//LZm4M7RCBVE
 Ztn3mXqjBmc+dfhxCMTENIkvApG7anhfHL+84Mv26yM5zGFneSZYzUnsqiNN3iatgYIp
 +kyP2YkliN8HuYaj986k0Crmxt9M5CLiXVyaZwN1GjBywzSohg8jjVvMEJdeA/68ACR9
 9UTA==
X-Gm-Message-State: APjAAAWsjQ7OeO0aNGvRwhn3yM+R6MNEiXV/5EeyrDIwOreTy+lgIazu
 tqqjswItD0I1Gp8StBPe9XTp47q56tG6Ffy/LWo=
X-Google-Smtp-Source: APXvYqwjPGd4ht2FWLFT7q1J2PQuWZ55JTOlwuo40nX/zFfSYjfHuU9J3Y3zCWj/t5F+3pxmzKVNja30UAxEvH6ZKBo=
X-Received: by 2002:a05:6402:128b:: with SMTP id
 w11mr21462026edv.182.1566194405719; 
 Sun, 18 Aug 2019 23:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <1565796812-25870-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565796812-25870-1-git-send-email-bmeng.cn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 19 Aug 2019 13:59:54 +0800
Message-ID: <CAEUhbmWacQtwTRYhCw6GwfGBabrWbe2Ss2JVCJ5XE7s3bVE-gA@mail.gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, 
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, 
 QEMU devel <qemu-devel@nongnu.org>, QEMU riscv <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v4] riscv: hmp: Add a command to show
 virtual memory mappings
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

On Wed, Aug 14, 2019 at 11:33 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> This adds 'info mem' command for RISC-V, to show virtual memory
> mappings that aids debugging.
>
> Rather than showing every valid PTE, the command compacts the
> output by merging all contiguous physical address mappings into
> one block and only shows the merged block mapping details.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> ---
>
> Changes in v4:
> - restore to v2, that does not print all harts's PTE, since we
>   should switch to a cpu context via the 'cpu' command
>
> Changes in v3:
> - print PTEs for all harts instead of just current hart
>
> Changes in v2:
> - promote ppn to hwaddr when doing page table address calculation
>
>  hmp-commands-info.hx       |   2 +-
>  target/riscv/Makefile.objs |   4 +
>  target/riscv/monitor.c     | 229 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/monitor.c
>

Ping?

What's the status of this patch?

Regards,
Bin

