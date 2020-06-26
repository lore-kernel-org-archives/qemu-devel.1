Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACC020885
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="l6Gchirp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACC020885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowsT-0004lZ-56
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jowPY-0006up-0n
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 18:01:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jowPW-0006Pq-6Z
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 18:01:27 -0400
Received: by mail-wr1-x429.google.com with SMTP id g18so10890488wrm.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jrtc27.com; s=gmail.jrtc27.user;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=EzAK0n4lFLbG8Hhr/FajhMXYeVPNN5eCNuDlmt0qm/k=;
 b=l6GchirpxG4REXFbmYKuotlA/CY55m9YFybeO/e1xQqUkA+KhuDALXrg3v9Q9YRu5p
 Vvq3x7VWpKrYNiBFi015AFed/UjiF7Vizg6eUpgUPnRHlr7f16JUJQAZ567LkiewIIEi
 qsmaGJc5ZDdEK5pZRh5TZYDgW8YhUTcH3fmovq7EbX+U5jEkuoZiuITn+S8I2+YDeEeu
 1MtdutSGbdAVIMbf7WpiAHO9NofpCEjzpTJA7OiUQyep3sY4OX1ZoE4VDATdt96dTTig
 73N+VEr7khqR9b/YoiND449qa8jniFacsj8VMgrd+y+khZBMKgbYcpHnqeVj203qZL+h
 epQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=EzAK0n4lFLbG8Hhr/FajhMXYeVPNN5eCNuDlmt0qm/k=;
 b=DIC05XBhuAffuKng197WodMqENGw6ttz4uCapzRWiQgDkIKGB1UQJSOGCsOwCYd9nv
 9YH34xFuwIVCxzneIy+ghXRB/0d53o0I6PorGJtuVAGqvmla7wSkNvjZRm0EztfUXLaT
 JjhbwyTmQmUa5oiBh8R5AfApwTz9ygV2RlN5ZUr+GdKuNtRcp733aGBLX8a2xU31WtTH
 t8JH0BYQFWLMbIM9hRmS7D/daYfI0u1LcU/oCt5EdVlLL+fJqDz7W1f8FcxbgjuEWQeB
 8V9ifMWXQ66JBxRJuKOU0eStPlT//JDRkWG9JSxYiHdc9NrCj/02pvWWnjG4TSW238Y/
 ymSg==
X-Gm-Message-State: AOAM532NmDFq1F4Mk/ML7OrPCFLBlCWlzacxJey2nui/r+kBKz2pUE93
 MjUar3eK4GNf+m6L5S93p9Bq9w==
X-Google-Smtp-Source: ABdhPJyb4uH/YeaipnEpAhvHbX2HWYPSuAkPLejzW70qQQOAQi3roOkzTp7NGLN2sENXEkKstJlpIQ==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr5670707wrq.401.1593208882067; 
 Fri, 26 Jun 2020 15:01:22 -0700 (PDT)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk.
 [131.111.193.104])
 by smtp.gmail.com with ESMTPSA id 125sm19956745wmc.23.2020.06.26.15.01.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jun 2020 15:01:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PULL 02/63] riscv: plic: Add a couple of mising
 sifive_plic_update calls
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20200626214410.3613258-3-alistair.francis@wdc.com>
Date: Fri, 26 Jun 2020 23:01:20 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <76226AC1-ADD7-4A58-A44E-B69050DF4932@jrtc27.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
 <20200626214410.3613258-3-alistair.francis@wdc.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=jrtc27@jrtc27.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26 Jun 2020, at 22:43, Alistair Francis <alistair.francis@wdc.com> wrote:
> 
> From: Jessica Clarke <jrtc27@jrtc27.com>
> 
> Claiming an interrupt and changing the source priority both potentially
> affect whether an interrupt is pending, thus we must re-compute xEIP.
> Note that we don't put the sifive_plic_update inside sifive_plic_claim
> so that the logging of a claim (and the resulting IRQ) happens before
> the state update, making the causal effect clear, and that we drop the
> explicit call to sifive_plic_print_state when claiming since
> sifive_plic_update already does that automatically at the end for us.
> 
> This can result in both spurious interrupt storms if you fail to
> complete an IRQ before enabling interrupts (and no other actions occur
> that result in a call to sifive_plic_update), but also more importantly
> lost interrupts if a disabled interrupt is pending and then becomes
> enabled.
> 
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-id: 20200618210649.22451-1-jrtc27@jrtc27.com
> Message-Id: <20200618210649.22451-1-jrtc27@jrtc27.com>

Something went a bit weird here.

Jess


