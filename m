Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56355206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWwYafP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56355206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsrsT-0003Yx-Mg
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsrrS-0002hr-G0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:58:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsrrQ-0008Qc-Uv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:58:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so28593wmg.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AZyqiLiiDT3MlQeNGzoZ9Xu4tO0w5COYPj5N5l0ZejA=;
 b=fWwYafP8ZHxGDMunz98CbLESx6uMeF2d9E7xfzKPR7dXNMnSkh5FD4uB9OIl18yD8j
 vwNHP1yESlqdgMbQA/ep+m1kG9rQXC16lbKMhiVRtGoA2r77+uk/eqgmT5A8MJyJtXCN
 +PtlvWuyN6AbC9dKwXPaFBEydJOm+DNtdUQ9UDShJVQx5rLgUK7XvzQ2xxqGdB3cGJwq
 ktLAEgye1tKPrd8cOUE1eDGttXQQ+DiohWF8bvjp00XR64IFta5PKqgyrAUrfFZnb5YA
 pbpmI9FM6x3hP1m+DoRKOjX0V7bBVCtXzRgrGqe1P8MrqtB798RYJp/SoVdv3t9MIUIA
 sWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AZyqiLiiDT3MlQeNGzoZ9Xu4tO0w5COYPj5N5l0ZejA=;
 b=TMhtEB3iCXGRaLwzgomvdmU6Y9cQRy9Bqa5qTjPN97tRtS1ZsaS1F4ACjI9zY5YEBp
 Mmrgi/1jVPV1ENfDKsJ5jak6TZbdwKKbukGOX05gsheXiGNGSXLIlKMm5Xnwff/gsJQE
 ai6vb4w0eCqC4DyoehMtEa73sDPnFR5D4HR49va15w1PKVs5yi7Z7iMioJ7mHTe8sVFy
 1Nt0o0yAKvTqXoRVGsF0EgY3TiLD3EjE40owh3bzgqYGlylJwT29COm4FB5OimhQLFmI
 eAXkFMkxwJAyqO7YK099E8v3NHLwM/zf7QtrvpfDPZyuO7EpFc2h0b9tTBSZpJDixIkS
 SV+w==
X-Gm-Message-State: AOAM530mhi0YJdb+NM4mr5fsURiTqSAlGuIzPyMqmMut+l/1e2GdUDvg
 kxp7EAtzNHwkG5SBdXAcr8g=
X-Google-Smtp-Source: ABdhPJzPE7FlvzNRjBMzaR1RRoNemUcJvepIWk8V657pSclYEGh54t1RBPHwFWdBvjrfQuMEsiGhcg==
X-Received: by 2002:a1c:2257:: with SMTP id i84mr5266091wmi.158.1594144707213; 
 Tue, 07 Jul 2020 10:58:27 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d18sm2179097wrj.8.2020.07.07.10.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 10:58:26 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] target/avr: Few fixes
To: qemu-devel@nongnu.org
References: <20200707070021.10031-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b3f6f844-8ab2-a925-7cd8-d216e0d7de67@amsat.org>
Date: Tue, 7 Jul 2020 19:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707070021.10031-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Michael Rolnik <mrolnik@gmail.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 9:00 AM, Philippe Mathieu-Daudé wrote:
> Since v1:
> - added missing 'Fix store instructions display order'
> 
> Few fixes on top of the AVR merger series Thomas sent yesterday:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720089.html
> Based-on: <20200705140315.260514-1-huth@tuxfamily.org>
> 
> Philippe Mathieu-Daudé (4):
>   target/avr/cpu: Drop tlb_flush() in avr_cpu_reset()
>   target/avr/cpu: Fix $PC displayed address
>   target/avr/disas: Fix store instructions display order
>   target/avr/translate: Fix SBRC/SBRS instructions

Thanks for the reviews, I am queuing the patches 1-3 and will send
a pull request for the AVR port shortly.

Regards,

Phil.

