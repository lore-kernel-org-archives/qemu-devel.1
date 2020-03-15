Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF08C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 07:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0A420637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 07:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSYj3/S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0A420637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDNgg-0006oB-Qm
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 03:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNfS-0006Gz-2W
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNfQ-0007T1-N8
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:26:37 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDNfQ-0007R9-GD
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 03:26:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id l184so7958011pfl.7
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 00:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uvdjHaW15SkeK0LOhctCdKDBlCzeaJduO/aMHtu375c=;
 b=fSYj3/S6E6afs30RJKiyh2Ud40IPAHMUrZr2ZZ+Zso5flTBFh0iT1CATiBJ4hvfCR0
 iJ7xq6UZHJcFRe9oXGehIQE2v+UI7otVCCxU+vk+9vgoULroWvGMsQ4cA0iuybXAVmMC
 NOJw6iIDrx3crf4zF3zp2uBvZMavuoWY5wmc5Ty5Zozil69OX1kbz1aOyZkb0DLW4SzY
 IAHH4uYjuGQSN4+jK4p3ra9uFA203JD2AsbDMh3o6qVCUUNqC+jgRWG3/07lO+TvgHAB
 mJhKR4hzgO5bnz5ZF19uyBguVTecXcE9YGQ13u4udVbL2Cfk7B6RFq0c2P/DnbsrkFqn
 g4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uvdjHaW15SkeK0LOhctCdKDBlCzeaJduO/aMHtu375c=;
 b=PrvWYJmfcsqKUAVtpp80QLYBcbr4QsnAlCOJLt+6YtgpUJn9Vwwti+D4JIihTQdPg4
 yTVq0RjCE7UnqRCAH/hTA6BWoIejQRa2RauOXnKVFad4ibGwAmFFlz0k119ogNKVCaM6
 yS2KTJpPKlqQYTEsnh8mnN76Nsa3YloZ1mdjGn6fuixMSxJWA+FJDtqT0frGJrKZX4a9
 5HOrgubWBpCBW8U5ayak6utMIvQeBgAFTGaikBEYJpKeRiZsdukBg7wsM+b7QcNQryzI
 FV/wfDsYzFxbhVyv4EdNR7LDFOEmNYoTbb9QWVfYBe47jy20LusYaotMRqNcw2GtzrVR
 fltw==
X-Gm-Message-State: ANhLgQ2jIyG1HwDhL1EjxPxnXMZa1G+RCesp/pPlIKpRY740658lOux/
 kUTvtshlG7UIPo5PjneYZsaL9A==
X-Google-Smtp-Source: ADFU+vvTgbBvFvjpdELOzKroLhdYmr8Yg1nYRFYtC7TB+kviCYZMRcerjY3J//mbq6jRR5t0c+EPSg==
X-Received: by 2002:a65:460a:: with SMTP id v10mr21210307pgq.370.1584257195141; 
 Sun, 15 Mar 2020 00:26:35 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g18sm63588008pfi.80.2020.03.15.00.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 00:26:34 -0700 (PDT)
Subject: Re: [PATCH v5 51/60] target/riscv: set-X-first mask bit
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9684ea94-452c-973d-5996-6cd3ea1d65de@linaro.org>
Date: Sun, 15 Mar 2020 00:26:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[ Patch didn't make it to the list, so reviewing

https://github.com/romanheros/qemu/commit/60668e86d94ffa48adb2f9c346753cf77f582686
]

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

It should be possible to rewrite the helpers in units of uint64_t.  The
unmasked path is easy; the masked path is more complicated.


r~

