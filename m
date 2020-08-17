Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FABC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556552075B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KzGl3oNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556552075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hMr-000299-Fz
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7h7l-0004No-L2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:32:37 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7h7k-0005rI-1N
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:32:37 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mw10so7853909pjb.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0t5vUMkdNBrHjsJYG3aZF0PJl8ZMZ0nuWbOmx34ihNY=;
 b=KzGl3oNoZeeJKXc/S9rSXhVVWvESyDlMDzl7796o2UZyJWXjGsS2vdY6Y6G4SqH350
 Am4QY1UO+HTxf3zbJ9YIa7iDTRU4D7K/JaDkUGjjecUKkle6d0TeImi3JbnMAFOkZ5Vu
 A5yNFGOgXbGiSeEbevW5Ncs2bgrf9gYV5IahaFQT84k4dv2QTvNpMPrDJpx4YpMi7IuX
 KwchiXKSlXBcuE/tqG71ykxUutIco1g2YhHU//laohQiv23S0jVZs/aRpE1LM8SpNSgF
 obDyjS9TZlIf1X0U/low/QqmnbHt/lsrXpUbTGcAfG8Lz2CL2Qx6f69gJsNfYuYq+Giv
 TmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0t5vUMkdNBrHjsJYG3aZF0PJl8ZMZ0nuWbOmx34ihNY=;
 b=NbipZbaUg+zAdBeUjvnaYcgZ6msNhEAKLEa2bh9R7BnppibqQl6CiRsSwpKfyEtfUv
 gfSusuE/4kB5nF8cKIkNaiEbaj1or96/yJTOQruaIObwsIEihYgBviEzVdCv0sU0P0J0
 /rjzPVKL6yd3RZk2jfSSQjtxK40oePC3mpafY7Xhl6PMOZNRArf5ymYrYiTWumExIjSq
 UON74SA6pc3ODTqgg++9JxCt9553c+Fp6DOUfcUk9n5eHR/i6+w5xwtoy3JfQtx/lUyQ
 ovyTe+oYlEkQ+/Nd2MHceRMlhG5C+VnEBpI7Lb0d9IRtFQFiOxiRBK9RJ+yGZig8t9Su
 hYiQ==
X-Gm-Message-State: AOAM532Jnnl73QuGYciOF9mdIaQWdoaN+MlQxZXxcjXmUY9THIF6V4WN
 Jn2QtWP4pRfMGRojBdLhP8luGw==
X-Google-Smtp-Source: ABdhPJxexc7C7cDmjpFJDppj7xBpoxawwEjDWne7UjHVohBF5AxkXXX/Ac/lEqJiFb7au3eVsq7J9Q==
X-Received: by 2002:a17:902:744c:: with SMTP id
 e12mr12035055plt.38.1597678354435; 
 Mon, 17 Aug 2020 08:32:34 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d22sm20554099pfd.42.2020.08.17.08.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 08:32:33 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] target/microblaze: mbar: Move LOG_DIS to before
 sleep
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
 <20200817140144.373403-3-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6740c852-3772-09c8-15fa-967d31aacd86@linaro.org>
Date: Mon, 17 Aug 2020 08:32:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817140144.373403-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 7:01 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Move LOG_DIS log to before sleeping handling so that it logs
> for sleep instructions aswell.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


