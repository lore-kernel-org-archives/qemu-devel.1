Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060EBC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE872076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLhDQD5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE872076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8SF-0007FH-Uc
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY8RE-0006Zy-Sr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:58:00 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:34577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY8RC-000211-R2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:58:00 -0400
Received: by mail-ej1-x631.google.com with SMTP id o9so1881712ejg.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ymZSTgXFvKt2lqGgdidP/R3BTEM2V+IE5SCwng5x8fg=;
 b=zLhDQD5PSDPp4C9MrJ91HaVD6Li5WWrfWDLJQl0/5O73Yh4cWtQN5/y13l3GGWicTG
 EsW5LWKxlz+S6LLWvWLu7rwzX0ZYVMeA2IhbTf0+nFydWyQi0JQU0oU3Xcikf6OrH4q7
 63PtkyKY6CocvHVK3nczuq6ED9L4SHoscq5GS2mrlPq8Vx/PFaU7pVxER0tOC8wDKAgz
 lMl/Jy/vr2Wn0YLV1rBSexa99GAWXhlCpuh3cm+1j8/2AjGYCvuZHIfcKuxTjkfBbe6k
 /35exdDIVumrnRt0RMEEThkMd9cOGq3tRNjL9dNESFz367Oz5oey2V1idbdPma89GKgt
 iPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ymZSTgXFvKt2lqGgdidP/R3BTEM2V+IE5SCwng5x8fg=;
 b=gCUHkwgFMBiBVwHyu2rxMqgz16KT9TLtpwrOnw8Ti/nmCa7/gQ8Gb6LWOV97xZNZRU
 DupSJemjxvs1X2xwxIUOayKOQ5GAv6urQiA9tVuwgRa1z3eVYrVOaBP4Mbq7j9MRqSkP
 KuIWBr1MRn4rFs6N+RV1H0ti8wN+GGUlgYZydNRkTKlbr8yU1aayl+ZN1SY1wrfDkuYf
 7km6PbsNDH9p5O93rA6xssUBAeawNTpIqssZY1SEvCgYa/1BFibpBnOs7d61F1W0C1/T
 ka4aV/RSmlpVN/lWMTvviUbwu98UFq8oIF4w/27uOf+Kd4QNsMFRzgxnZLiUTMTbje3v
 FFAw==
X-Gm-Message-State: AOAM532Nw3ay5qzn+g7yT4sICXATqbHlnUEeOE3XhYMtItxnbKVxtLwo
 rcpT8/Mm4uFS3Y1GaKSLqPFy5cyaumG3dCCwgrLCfg==
X-Google-Smtp-Source: ABdhPJxOW+DZmjN3vEt2VWXW9DLY8BoFrIfZrXRtb79JL4qFqgxhvF0Ue1H1sC5RPkjW6xjfYF4FYvutIwe00rAcJHg=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr4222438ejd.250.1603979877177; 
 Thu, 29 Oct 2020 06:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <2016477.jJ6Bm08OSA@silver>
 <CAFEAcA_qsZ1ZT-hk5wJc1Mz97vzo3N+UisK7XBagG5S1GtjqoA@mail.gmail.com>
 <3097828.JvSkC2jeLF@silver>
In-Reply-To: <3097828.JvSkC2jeLF@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 13:57:45 +0000
Message-ID: <CAFEAcA-q0AVF-GMu1VLKPKmPAURV9j+YoC3g-C15F2Jy5nTUVQ@mail.gmail.com>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 13:48, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
> So I'll append the architecture to the test dir location. To nail it this
> time, anyting else that would come to your mind regarding test dirs?

I think most tests that need a temp directory set one
up using mkdtemp().

thanks
-- PMM

