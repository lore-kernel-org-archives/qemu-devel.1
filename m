Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81139C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4986D21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvxpVh3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4986D21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP7bt-00048d-Fg
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 12:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP7b9-0003M2-Vv
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP7b8-0003sq-To
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:42:43 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP7b8-0003sB-LC
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:42:42 -0400
Received: by mail-oi1-x242.google.com with SMTP id b7so14518561oic.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5BdeQP5buwuaCPoSnZDcP6t1GFG6iOsZDMGobvDcraM=;
 b=IvxpVh3PssQTt53pZ6eR2pKhdO72MPeJTr328mcvrTn09JhX56KTI8yvpr+Lq9n6ok
 p0Ik9L1B2XiHJzm2cUDDPf9u8Pg/1ym4sW2THVs1KLDF49SMZyNd5l3hz7Z5azslFfBx
 3Cgjpes7+MUFKvVTzdzx0Q9sx+ZX968P+AnVw+076i8BBT52ofaFKpIomYD3GGBwuGm5
 dOT19YyHsZJPCrI9LLkSJlcHnDkB2R5t/ETIzo2oKp1ucmXme4XxTxFH4KH8LXfBu4Md
 mPbPWvDeKy94Gv0RNlybzddWTUkwtZey53pMasEcU3QXddj+nKK5/5PEor2sk4piUxIL
 JBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5BdeQP5buwuaCPoSnZDcP6t1GFG6iOsZDMGobvDcraM=;
 b=UVT3mnxQueyJmtLj5c3jjETCqJv0DP9IT94mt1IMH3PzqlHFm7B4YZVi0jXTmJR32U
 jPIjXNb/LEJYpkj8YMwdtcywablU0nm+mSnC+qZLl9Egnzw38ULnvZB4364glh7YfbS9
 LaJADcNKOKUXGSXCc4Jki0jbsQKSq6SO9/XoET/pTwzXpU7eQSyCfiX4EQxzoydCM2vo
 Z7y4aUcSoChyYx6yO+o6mPog3jn2xtCV+Fbb6RAJah3xl5PvhELqtjZtZMeVvCJsxH7b
 jYiYonRRwfnIw7wo7oq79sQWaUnd0O7+J9sq88GTuU1qrVxEFhTrfjhaA6MoYBvXohNI
 2NGg==
X-Gm-Message-State: AGi0Pua5VcN7ijb4MhAsBR7uBlE3aVNUDYR0ET8rL8Fq51DPi6D/ikn7
 Vkq2AteSsG87YVQSpCaF6WGK7RTzT/grNzGeVdMkEw==
X-Google-Smtp-Source: APiQypKk+6d7jpFoToCUp5oRDATwgYTd7fluSJPaGpmp9A/bx1UN8c+qKzdAsWVTre4LafAy846mVpImbJ4DzK9PN2s=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr3349854oig.48.1587055361541; 
 Thu, 16 Apr 2020 09:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200404122718.25111-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200404122718.25111-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 17:42:29 +0100
Message-ID: <CAFEAcA8JFo=-zUYE6gp3Dg2wux-cHGhHZ5hG6BhrhJvwtRyRUw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] dma/xlnx-zdma: Fix descriptor loading wrt host
 endianness
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Apr 2020 at 13:26, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Hi,
>
> This fixes the endinannes related bugs with descriptor loading
> that Peter pointed out.
>
> Cheers,
> Edgar
>
> Edgar E. Iglesias (2):
>   dma/xlnx-zdma: Fix descriptor loading (MEM) wrt endianness
>   dma/xlnx-zdma: Fix descriptor loading (REG) wrt endianness



Applied to target-arm.next for 5.1, thanks.

-- PMM

