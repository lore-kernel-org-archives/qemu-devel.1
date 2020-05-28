Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72593C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 02:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BEE2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 02:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faxkPafu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BEE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je8Nj-0000f8-AK
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 22:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1je8NB-0000BN-AM; Wed, 27 May 2020 22:34:21 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:43745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1je8NA-0000p2-He; Wed, 27 May 2020 22:34:20 -0400
Received: by mail-yb1-xb43.google.com with SMTP id r23so8823811ybd.10;
 Wed, 27 May 2020 19:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+EgEVzd/XW0O7MqDUyua+HsyHcfUL9OZAefOab3aXqQ=;
 b=faxkPafutgclxehTSfNz4LD9oBbKcXMi8Qwyr68z7Qp8drNwETWYePUBmgSQPaRaVG
 eyopC0kUiOUdGXWRJPtXm9qkIoI89DaxdD+Ya3uSMfCHEfzj514W35XxVNfRTH7zy8oQ
 WnT5GomxbpKnCYhzh+pLbTdkxt7k5wpgTjDrX+tpqlEgXGuF+oKtK5bNMOSgY8MtKFvD
 xWm9T+V5e7/zRrOPRIGZurS6d8pqR6Dedbn3M8fiq5UDqhCLGYvzkGeBmQslAZAtGFEA
 GhAxCXE66dGLJUd1QUtzGEhSzdH7/Bj4lId8cxb3q13Naqc6j0QDNnJEhWGLbGwEa2aI
 JAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+EgEVzd/XW0O7MqDUyua+HsyHcfUL9OZAefOab3aXqQ=;
 b=c8hefbNCgUtKIHTdfVyCR7PPBsUKbsWnpNPUK7yYsppxc/dIko3+o+5JbyvBo6kWPk
 U3GphoWWIfQh9+/XaEZp4FhfKlHHMwJIsuewaZIhyJPt4tnxm6510RGHBN9UstHKqmLP
 up13CowzqiNIW/QjjAUL4j7oNhU95ULrbZDQtYdpJ5Bv+7Z0Ky51aOFL8m4mPKSx8To3
 VomxPBval1LtqYCaZ4Ih8irOGsPffWrSxbKmeONlJavNFB7Tn2apa+iVzvCYGV8JIBgB
 9MErnyIRMRJR4mUc2BDHR8oaefzdHYfMrIn8uJF7x1nr20D5aAu6TXHi5usFxNO1SIQi
 +P+Q==
X-Gm-Message-State: AOAM530O1GcJu2ToYlh6YmC+IIgXstxHY1R5c6LZjEl/g/OmZ9twsTbC
 gYOeFD5nSpwXQB5LQ3b4owV6EjOfyTVIZ4Ry/4I=
X-Google-Smtp-Source: ABdhPJyUfo70Kg20FpXHCq4NncBMsDhBZrNLV82jU07O62oZIDTQ37gSZ6M/OALwS1ulEOQQVVEgiR8bA9bSJw8A8dg=
X-Received: by 2002:a25:6d88:: with SMTP id i130mr1917379ybc.306.1590633259303; 
 Wed, 27 May 2020 19:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590598125.git.alistair.francis@wdc.com>
 <d65e90ab8ca5ee29ab26973c86a18549853a98cd.1590598125.git.alistair.francis@wdc.com>
In-Reply-To: <d65e90ab8ca5ee29ab26973c86a18549853a98cd.1590598125.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 28 May 2020 10:34:08 +0800
Message-ID: <CAEUhbmVGZjwoW+6P2iJ23N+J-gS9y-9R=0bL1-bg=nbsOogecg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] target/riscv: Use a smaller guess size for
 no-MMU PMP
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 12:59 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/pmp.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>

