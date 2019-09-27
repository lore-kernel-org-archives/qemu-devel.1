Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C35FC32774
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCB02075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR6Fbp6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCB02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDlAH-0008Vw-O3
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iDl7v-0006aF-Gx
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iDl7u-0001DL-J6
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:19 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:46186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iDl7u-0001D9-FU; Fri, 27 Sep 2019 03:57:18 -0400
Received: by mail-yw1-xc41.google.com with SMTP id 201so592255ywn.13;
 Fri, 27 Sep 2019 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mXTeuiqm/z5Z9C62l5YttCMEIYMavfLAhwCxufoKKfI=;
 b=IR6Fbp6JTkvxKsI8ijuEVpdDJpZWz4s/WnuAe4wclPPfJ5BQkplN+1ZenqV5oA6KSS
 /dIqUnlV5vkh0ZTycHy+MO8CUfR4PwHqwam2xNCHcnnVqInvCN5+piXvvnz0wkq2zeA9
 ufhQCk/bJ4zz5BN5n5Nkq4kA5STLt2xohQhdTQfmdzTO0bM5+O+15vuITDlNJBERSXi6
 x5nSb9DUIYBOCrSWmiXHEEzMPeGHKce8zoL8Jh4n1y4+04zR3Dd8to7bEiAfVGl1gkF5
 k+Rf4GrUZyuwL4BXQe6AWrTsvkhPp0f5Etme9cEbs4U5qBgq8jAvoAXlUtRVMB7b89ov
 VSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mXTeuiqm/z5Z9C62l5YttCMEIYMavfLAhwCxufoKKfI=;
 b=DvjvODFsFxWai9WILGWWOOVDXHW2Oqk6DY5z8f+Wnye3GANbYLr8stLSuhUzGFd7w1
 L91QffRi2d5A+bv1ilZG/VF4dtDiUoVkx04d1acnSyKZFxbf4m5VkgxjT8iAqArYStj0
 FKomgs93w7qmhLw2WlZGwhMqBIyuSfeIJbFtEvWHQrZ5cYz09O4bNma5ow0OXBFSPnnz
 aGgf8ln8Us2uTn4yt9yCA+dBhfvUdLxXehdXzzIT9DbwZFU20tjOYVDzA9yAbOGz9kyh
 xsT3vp/XpCEk5hKZCKxU3GrLFkYvA+Lan8b9Vc1ECA3bsOeRq0I12mToj5m8DBtIvro/
 vLQA==
X-Gm-Message-State: APjAAAW7jrv8LwVWQCpRsUbYhOtBPtXGahPaSUPRjL8QzbUMah6XIycX
 Tuai8AbIcz69x5BycG+dL9IFDM1aag0UQSpm8ZY=
X-Google-Smtp-Source: APXvYqy6ZIZzRW8jqSPSQDxSDFakntRulJ59VLXV7Ia29zHPZ1efEpI1OQ2Jac2EBMegiosJdrb/JCti77xnfF4LQL4=
X-Received: by 2002:a81:310f:: with SMTP id x15mr1700622ywx.257.1569571038133; 
 Fri, 27 Sep 2019 00:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569545046.git.alistair.francis@wdc.com>
 <737cb09136e20293c82da7b07eb2020cc7bb99a2.1569545046.git.alistair.francis@wdc.com>
In-Reply-To: <737cb09136e20293c82da7b07eb2020cc7bb99a2.1569545046.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 27 Sep 2019 15:57:06 +0800
Message-ID: <CAEUhbmXPZCKRLODhU8XLhp7J3xV+-c4S-SNDXMJxn_V2FDk9kQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] riscv/virt: Manually define the machine
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 8:51 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Instead of using the DEFINE_MACHINE() macro to define the machine let's
> do it manually. This allows us to use the machine object to create
> RISCVVirtState. This is required to add children and aliases to the
> machine.
>
> This patch is no functional change.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt.c         | 30 ++++++++++++++++++++++++------
>  include/hw/riscv/virt.h |  7 ++++++-
>  2 files changed, 30 insertions(+), 7 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

