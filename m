Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FBAC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111CC2085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 06:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111CC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg17J-0000xb-Cb
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 02:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hg162-000063-52
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hg161-0002l8-7Y
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hg161-0002kH-0i
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 02:07:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so668600pgc.6
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 23:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=n6HUBcG1LsiatuoEvj91e7+QlXshNMsVznzz62ounWw=;
 b=QIF3SqvLW1Y/LxiGGeUZeUMFCAQxXLVfsMtlcb6rnGx2iW4icX659fpKTjOW3rDFCa
 DG/HVK7CkIq8bBXy6N0ZKpWHYpipHo6bmYiNz3YM0crZ/qfl4KGbwtTzelz3LGU25i6w
 KAXdkI0vZoK+AMeRYe0kDGGejz9Jod4N7NKX2YDS0aHNT+mC/owLbt5ZwMZma1EOi270
 3+RUgN8rg5VIJDI5EtF3J+2011u0d4MMfjzm3Qg0Hxsb6Sw0yjdE5yLIWDhfQLtkCpKy
 PKfRRz/ImdoW9yBqI4M7EyBjU0aa8UHuciZveq3oqSaboLOLWnyuzpIj1F1vVQlORLvB
 37kA==
X-Gm-Message-State: APjAAAVKFKSL9Lh6D2XPhTlRTh0TWdeq8eBQ1YR7gxUFUtn2abXtCGeG
 Hata2p3gSKHF/xrqvBJd5OyCJw==
X-Google-Smtp-Source: APXvYqyqNZf6mSoFYSsvDFaFcd2f2q/Cie5stp3wYTJlviVDnOBsRzc7GtLvbv7v+oX/3ZkPLkWArg==
X-Received: by 2002:a63:1459:: with SMTP id 25mr1175001pgu.201.1561529271698; 
 Tue, 25 Jun 2019 23:07:51 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id q1sm13278390pfg.84.2019.06.25.23.07.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 23:07:51 -0700 (PDT)
Date: Tue, 25 Jun 2019 23:07:51 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 22:36:07 PDT (-0700)
In-Reply-To: <2dec03cb-22af-4d0d-f182-3bee9db83d6f@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-3b5978c4-bfb8-4757-ae5b-0731f2851d30@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 joel@sing.id.au, Alistair Francis <Alistair.Francis@wdc.com>, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019 08:36:28 PDT (-0700), richard.henderson@linaro.org wrote:
> On 6/24/19 8:08 PM, Joel Sing wrote:
>> Regarding the alignment for reservations, the
>> specification does require this, although I do not recall seeing any enforcement
>> of this by qemu itself.
>
> Ah, I see it now.  Enforcement begins here:
>
> static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
> {
>     REQUIRE_EXT(ctx, RVA);
>     return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
>                            ^^^^^^^^
>
> This will force softmmu (but notably not linux-user; a design limitation) to
> generate an alignment fault for an unaligned address.

That was probably correct at the time the code went in, as the ISA used to
allow these to succeed but not be atomic.  No implementations did this, so as
part of the ratification process we just mandated that unaligned atomics always
trap.

Is there a better way to fix this than just doing the alignment check
explicitly?

