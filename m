Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C9C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F4E2475A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwV7fLX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F4E2475A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrFJ-0007t4-E2
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXrDk-0006ir-Ok
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:34:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXrDi-0001pd-Q1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:34:56 -0400
Received: by mail-pf1-x443.google.com with SMTP id o129so295831pfb.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=0lsfgTTZDn8KwJgod1DnAX82pyeZ0k1S64kkEpHNFeo=;
 b=UwV7fLX87rXseihsHi/k1q6h8+LGkotmyxXDGoavGDGQeJ9+203ufgIdy22omUozB2
 l4h1p66uM/W4O3lHDuwUTv9KxQgJ4SREbX+rePuSFutZgKAEMB3GybYjQV9OHdCLjZhH
 Rjcp5NLpcWTbpM1PvBuLHHugXcorikmSoCJ0zWSDktV6BUO8GCcjWYHoJz8X2KucL8ub
 Xc4f7kADW4z6vNd+g2Bb2DH+fERer73X/CxBazKn+dEBfxL+mELcRgAOep0XIWEJwwXC
 /HRMNzV09SEw7zwETD5T83zFeDLSVg1Qyyj6kaOhEyWEsWbXWqKXNhuP/n62sfEwCtL2
 Js8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0lsfgTTZDn8KwJgod1DnAX82pyeZ0k1S64kkEpHNFeo=;
 b=FNwIublpzobZN5LCMVz6bq8W2vk5mhMBoEFfLajWlynMZeZMM3apNcl4FlBvbPe8eE
 dXOwNBL6LT+TCjU5dxNdKAh8t2TTnudI+7mX/4RkGTiKyDtR86uNcUiwnIMir/kESuz5
 f4myohlvF8EmOKQII2d70WEnqZgSCd95GzM2JDYRlrb73Qiy363b+9UnsH4ZK89TPq2/
 HII9Fr2lPn6dkT9uCjv7/cXB//nK30pLtfNTvqpQPkD1O2LoJNT1xZk9ehHD6ftntWit
 qnCMRbvVBWi1UxyqamlpkXhwdAUOv1g0ihIA96Oe7BT7zG8wmLTSLno+ldmNvnCyS6S/
 7muA==
X-Gm-Message-State: AOAM533npI8Ewxo97FDU2kgy5boPHwT8bwoJdjprxfVEZK5LJezO+L5l
 nrZt0TiyVFgi4xBm2vmAKa/u2AXmbXJvpg==
X-Google-Smtp-Source: ABdhPJw6uZkiV8+HgrdOXUFtORzADnjdZ+1Ya+NpTJNhpx9iGMgYsPoDNbzT7S1BL7E3+5Q3+hQJMQ==
X-Received: by 2002:a63:134d:: with SMTP id 13mr854569pgt.370.1603913691228;
 Wed, 28 Oct 2020 12:34:51 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o65sm167836pga.42.2020.10.28.12.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 12:34:50 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix some Neon insns on big-endian hosts
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201028191712.4910-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bd6afe2c-8151-623a-b576-22742680541a@linaro.org>
Date: Wed, 28 Oct 2020 12:34:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028191712.4910-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 12:17 PM, Peter Maydell wrote:
> Peter Maydell (2):
>   target/arm: Fix float16 pairwise Neon ops on big-endian hosts
>   target/arm: Fix VUDOT/VSDOT (scalar) on big-endian hosts

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

