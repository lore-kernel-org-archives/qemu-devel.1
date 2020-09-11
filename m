Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99363221F0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obMOWbMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99363221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGsCj-0005Ph-KA
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 19:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGsBv-0004rP-R6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:10:51 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGsBt-0003Nv-T9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:10:51 -0400
Received: by mail-pg1-x544.google.com with SMTP id y1so1283703pgk.8
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0ydLp4meF9o2JhNP0kAqRQyliGYUsh+mHHbI+dJCN9c=;
 b=obMOWbMSHReO+/dB/VDTGnk30//PcBR/wxLA1s/kVcxod20bHi05ng0wZBJvLapdo6
 3sy17/pAzVyKxvMw/QnSlgyjcB2WlzHpU0Jmn7KIHCIB/Kze3AvbF35GVZ8D3s8GrQDe
 LU8576YtjJU7vEiDjVqDjPwOZACYwWv+iD+Zu1CAmHAiHZt46iyV+Iu0fpSLzoIHZf7v
 oSFpZ5O6xehzfVBB3BwPQhJhxfpml+658YcBC2PsjIk+YY/8NnjH11oqdCJIHeIohayE
 p9NnHPHAFZpgT05FRMIVzvzP/0xJoFb2/Cs9EpxrAgdq/dNXjODaBT46U+ox5HWjybi5
 qm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0ydLp4meF9o2JhNP0kAqRQyliGYUsh+mHHbI+dJCN9c=;
 b=i8Rk7cFgFWu/DkKtGbVFD1yZlbLghWkp76l1rG83qw2wq2iJWSB37ZLhqt49rKwDKv
 GsTosCXb0vCqNvSYVDfuTsv+O3WZZfiuklY0g4aSNlV52UU77imklOZwWhDjsAIx9cls
 7ve3/ibmaY21elQMvByeNtWQAeEpyS0szL7tSW7LNQN903vm3fmUSA8mOXtDMu2a48Jx
 W93O3hVM88XzyD29ThoNK0CD1++scptZ9kvBjAm3NFvz80R4wKSapTmXUdbdhxdrzaJH
 rTQ03aInwVA5N+mj4IRizRsR2sRDWSavcqDnR/6LnaOOweF5RlO4kEy/gf7w1YtnPAk4
 cELg==
X-Gm-Message-State: AOAM533mmszL7ejAbf5lqayiSLS/LCyc2X7ticgPpyXV5eF6PbE3dqg+
 k/2UMk/JJ7FT65aSz5JA99VLTQ==
X-Google-Smtp-Source: ABdhPJxQ9IzbgepDdIJubmYjyBHqaZs6gTt5tBtnnJuGUBEiPbLl61dGxqSWkVqDH5Pbl/OPfXlsDQ==
X-Received: by 2002:a63:c66:: with SMTP id 38mr3144108pgm.379.1599865847637;
 Fri, 11 Sep 2020 16:10:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm2751775pjl.45.2020.09.11.16.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 16:10:46 -0700 (PDT)
Subject: Re: [PATCH 5/7] hw/char/serial: Make 'wakeup' property boolean
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200907015535.827885-1-f4bug@amsat.org>
 <20200907015535.827885-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3287e2ce-966f-50f0-cb66-e166ca37046b@linaro.org>
Date: Fri, 11 Sep 2020 16:10:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907015535.827885-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/20 6:55 PM, Philippe Mathieu-Daudé wrote:
> Make the "wakeup" property introduced in commit 9826fd597df
> ("suspend: make serial ports wakeup the guest") a boolean.
> 
> As we want to reuse the generic serial properties in the
> ISA model (next commit), expose this property.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/char/serial.h | 2 +-
>  hw/char/serial-isa.c     | 2 +-
>  hw/char/serial.c         | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


