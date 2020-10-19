Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2432FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92060223FD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scCvdFb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92060223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUduR-0005Rx-Dw
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 18:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oanderso@google.com>)
 id 1kUdtE-0004zA-3o
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:44:28 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oanderso@google.com>)
 id 1kUdtC-00044i-AO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:44:27 -0400
Received: by mail-ed1-x544.google.com with SMTP id t20so932962edr.11
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=icWKdykUJr0TVGHHPAx/DBzmweZhJlz3Q58PtMqaONs=;
 b=scCvdFb9tWVBhAjVXSBUUQyW6ShC0wb/Qz6BoPmd1oRjj/wq7XZ63vWQKOG3l5bY4t
 +KlHdF4nceInsr2xA3+DGWiv4BQp8TnwsQEo1kxEf+0XZvwplTmshtiaJSE6n5JcOVtu
 E3HJfqXt3zNqrWTnvxSEe2Ddjf7PBJrVFcOWOEIrkLCA8GU6SJOO1u7c1PV4AY4mZixU
 pTwuNnI3wa0ebYETkUlPV25i3Jw+6JNFtD803wVm/SBcmXunnhY6uEbI2Cqsz+pDop98
 AQyc9g+18/6vXJ/LeYDMOMMMhbQRAjeteA9fr+eQFder8W+3dxk2HYLeFpNYaLAlk51W
 b1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=icWKdykUJr0TVGHHPAx/DBzmweZhJlz3Q58PtMqaONs=;
 b=GD9h8poH30P/T+atigh/AbBtG6xy2LpxJN1xOAjdj0eaaBhI5pbSyQFmqP10l1xFHr
 9yP8tMKbRp2rJSaq4xHR2Kt8CWHnlc2DyDhapxMm2HOHYczl0RtrTphr6aUNaA866wBv
 PDyTLMq+rRZkCd0zK8jJxZKHLCL6xdG69tZ99oL2kN8pfY9ua2WjI1oDDCisjri8YyS/
 qXAOZ3gl2jmYAFHxlH+nwtJyidf0hWXpY/lrZ25/FNHYPkkWqraRa0T/R4KXTgTL+X8v
 FGHLSQ+xTtvnE4beRCvxNAuhu0NCfSPsC+Dx1ilK9l2QwBC75ri9CzevT3N6PAxtmk5G
 PhHg==
X-Gm-Message-State: AOAM531dGTuK+FOgbJAJFg03nSSkfFOqtx1IF1BC76f96M9CncAIrJXY
 CPfyKhf2E+hDiLkwN4ZPKutDAza1h0DGo2Q5Zyv/0Q==
X-Google-Smtp-Source: ABdhPJzj0vSe4IYl6woNQsSEfnhsMHDwlvkT+tR9MnuU6q8uygxc/LWr3h8sLaU5t/BCzOYKWxsUWr+RI/M1jrenPDQ=
X-Received: by 2002:a50:be87:: with SMTP id b7mr2191010edk.185.1603147463377; 
 Mon, 19 Oct 2020 15:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKs3XfJPrMGxdAouGCje3ppnWKA6fXpNaywQ5rj9u45VkPuUXg@mail.gmail.com>
 <7c416109-6431-076e-2284-0f8406931ab9@linaro.org>
In-Reply-To: <7c416109-6431-076e-2284-0f8406931ab9@linaro.org>
From: Owen Anderson <oanderso@google.com>
Date: Mon, 19 Oct 2020 15:44:12 -0700
Message-ID: <CAKs3XfKMpTaAO6vj-V--zp_zY_Jm9HKkgkpCbCCKCQHSDT8y3g@mail.gmail.com>
Subject: Re: [RFC] Don't lookup full CPU state in the indirect branch fast
 path on AArch64 when running in user mode.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=oanderso@google.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Oct 19, 2020 at 11:22 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> (1) What qemu version are you looking at and,
> (2) Do you have --enable-tcg-debug enabled?

My use case is a large automated testing environment for large C++
binaries with heavy use of virtual dispatch.  The binaries are
generally not built at high optimization levels (-O0 or -O1), so it's
not very surprising to me that indirect branches are more dominant in
this as a workload

My use case is currently using QEMU 4.0, but we will be moving to QEMU
4.2 soon.  I do not have --enable-tcg-debug enabled.
e979972a6a1 does look promising, and like it might deliver increased
performance for our use case. It looks like the code in 4.0 is doing a
lot more work gathering the flags values from a variety of places.

--Owen

