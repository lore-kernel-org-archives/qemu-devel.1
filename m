Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF611C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 19:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B879025231
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 19:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCyFF1Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B879025231
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn5NC-000417-2m
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 15:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn5Le-0002d5-5e
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 15:09:46 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn5La-0005ps-SQ
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 15:09:45 -0400
Received: by mail-pf1-x444.google.com with SMTP id 64so7293453pfv.11
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CGILvny0GIXQuYHQTGBIJ5r9ecKvkxWNMFZqwEPiK8U=;
 b=YCyFF1OvBgwQl4VU6tFDBzYHzAoHi4qUMChs2S3WmugoLsG6Oa1nzLYpM40CvIkG9d
 AW7BE2RRn3sEwYN8um5/9fi3BVKYdkUHtzEqU77ghlT47CoQaUvoeebV67AkJNJTzqS7
 +3hvGRdFb9EK1kPHAg2pCZbgexbuvRwFUlsGVRKlHZ2jkPcuXiYqh9dHdDJOxUbzCmGV
 LBARWQPINkLy/M7cemiNw8odvGM9a/nb3dj7/46x9rVEgOTA2w8U1fRA5OwkA5ejNXeI
 zgtQOYkKU3g1Hdzk2rijDykfqFfT2mXX3jiKbkjIDLxx8vdPUpzuiQB27tJnuxFqtKsj
 6GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CGILvny0GIXQuYHQTGBIJ5r9ecKvkxWNMFZqwEPiK8U=;
 b=p/pHu9/ZTktrmcf9ejnKwWKwYTQqixAq5np87ilvDn9ioezKl9A+r7qPmpIhh7GN58
 FIYpWJ3Tl5clgv1+JUM0VGmVZvizSNS1cAvp+TToL9Z2qC+NcdMM+Vm+a0P0EH71Dcmn
 Zwn5JOaSIlMxywjovQOwq6bVZ8K87+nSFwYOUUE5/uFgoxY/4iexPIm5MssO9BBB4JQh
 cL0bG738aPMkXkwpXHSdjjZlpVIxeFbjdJvcMd01th80qF3bvydycPju+EVXxNVyJ1p7
 7v2jOa4umgGQ72V2lJvu1wd3hGLKQNOIuLgnWi+B1nzPR/AyE3ouoFui/Cl/7+IslNVf
 1Jlg==
X-Gm-Message-State: AOAM530BJFxi5fSdvry2dlM+3QkPlYv19KC9oU/dNFfOaLHGkbaiKZw3
 fh82IXiZR20bZqrz+Et63h8GRQ==
X-Google-Smtp-Source: ABdhPJyLrl+ZddBt/Q95HKM5ANiZ3pg+cqkaUqaou6RnSIvQqA33pNqipvi5tm1gOWUItZ685hizhA==
X-Received: by 2002:aa7:96ac:: with SMTP id g12mr17073788pfk.193.1592766581402; 
 Sun, 21 Jun 2020 12:09:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l83sm11717579pfd.150.2020.06.21.12.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 12:09:40 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] hw/misc/led: Add helper to connect LED to GPIO
 output
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0fb2c123-72a7-52ff-a9d8-e3d74f6a9ebe@linaro.org>
Date: Sun, 21 Jun 2020 12:09:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620230719.32139-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/20 4:07 PM, Philippe Mathieu-Daudé wrote:
> Some devices expose GPIO lines. Add the create_led_by_gpio_id()
> helper to connect a LED to such GPIO.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Adding support for named GPIO is trivial. We don't need it yet.
> ---
>  include/hw/misc/led.h | 20 ++++++++++++++++++++
>  hw/misc/led.c         | 25 +++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)

Modulo my question re colors, looks good.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

