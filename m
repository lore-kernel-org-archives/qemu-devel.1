Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F515C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBEF208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/bQG/o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBEF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSGX-0007Fk-CK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxSFz-0006jD-Hk
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:38:47 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxSFw-0004Fn-S0
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:38:47 -0400
Received: by mail-ot1-x342.google.com with SMTP id g37so11634680otb.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=3ZKCJK17LggfFsY25YbupU2IJSnrJviKGCGX4ioJjK8=;
 b=p/bQG/o28XcazZ4AA8C7f7DqLWz1hhPu7nu6OUgEAuuDrzjFs6mID16GdCFJed4K+P
 QR18KOcNoinfXnGRtL4eyecouwKhvSI9kAqzkjPEOCT7KA1BgnDZCRRO6z3mMD2FkZnS
 88y8R/NKqc6RIK2hySfd2KOXSOI9fyt63s1lkGAjWGqAn3wssRBFB8gv/nCwDYJCnFXZ
 YIY//UHCfCzm9SnczjjlgboZjb01A7LFazImbnNI0yJTqexZLGqC5c3WI5XmCzOL5gKB
 zob5m4od1xGEYU7qDY5D3TLa/AKZKAkY5l20Eb76gReaSlur0tguEuqURadcx3uA/1/c
 aR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=3ZKCJK17LggfFsY25YbupU2IJSnrJviKGCGX4ioJjK8=;
 b=CkyBFfykr4q0e5s4g7zU2Af8Xow+n5+WkL2y1VdjNginOOh9FQQk9O87m9POx1+UuK
 lbOp9e7TcLVjweyo2vw6HqObJVZrKBWAS54rbKxMZKcq2vccQx/wNZaVi3MOymPOlFym
 dM+75xS8HIMbW23F9U41u3+UHSXQoEG4ZsgASi/6+C7gn4p07j0x6d+seihhVMVFsi6A
 lrYwjhdJS5OHR8xNmUhiILqNgAHdpv/ggbhMepkDiqR8/JRtBT1VyhxeBjY+VIIiUcos
 C4WrkKjIQUZ8prFVzlERp88NSmG52XqVH8sUxzhgbGpsUlPdTX5AKcVXRLFxOmMMZhY6
 RLUw==
X-Gm-Message-State: AOAM530lISIXuDS2hIjfLBAvf5mr3upByKfApetcLqfphpLHkeGolMuA
 2VQ88VLLMZ/DOMNctO/5hqMCfECFeNclrQlj2yiFIv1g
X-Google-Smtp-Source: ABdhPJzpgKkgRwmhiRMcjRG79rFExO/Hk/k9erzoSxPvQ3xQ3NIvfNaQSuQWu2ZR+T9Kpbt2KXAio6qN7DhYZnHfq0Q=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr18960533ota.91.1595237923481; 
 Mon, 20 Jul 2020 02:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200713175746.5936-1-peter.maydell@linaro.org>
In-Reply-To: <20200713175746.5936-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 10:38:32 +0100
Message-ID: <CAFEAcA-BKB0ar4EJAF=dLtSx5jeHxWQToqMvj1P2mXf2TJtm-g@mail.gmail.com>
Subject: Re: [PATCH for-5.1 0/4] Document virt and a few other Arm boards
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 18:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This series adds some documentation to the system manual for
> previously undocumented Arm board types.

Applied to target-arm.next for 5.1 with the minor wording
tweaks/additions suggested by various reviewers -- thanks!

-- PMM

