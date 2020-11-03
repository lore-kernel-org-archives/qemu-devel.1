Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41BC2064C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vigW2mrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41BC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzPc-0007Mn-V8
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzOb-000668-MZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:42:58 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzOa-0001Jh-6O
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:42:57 -0500
Received: by mail-pl1-x644.google.com with SMTP id w11so8807156pll.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GtDxz4VHdqCjjsRzEBN7Ul/zlklUL2LXi+mieqcgLV4=;
 b=vigW2mrFcCtUCEeSw4d2V25mkdcIWEqs00hnixz9X0tiINgYBDfYQGdczV/GTcmg6o
 WvHgdhfMZYEZtrj/AnsAbl2qV+gNtUlhD8iYnxlHdYfvJuI3/F1MDnKaiLiarS2n3pzs
 lYADkWhDcPl6iezTRM8K7o/g0E6G+sVsZ/4uNy2ljOmnbaZRa5f1fxWj6KrJoj5DmiPO
 k/wQ/fAOOQqxLWuS2zNcrBjjixhgis9zpxapBeqDwATnjQaWWDgja4XfY4W7FlLDXrxB
 VvlmJ0Nb80qizG6/KlROFFzo39Q9GxnF6dyGCU3DP3rtVZmB2yJJr9uC8d8gKuwjuj90
 Js8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GtDxz4VHdqCjjsRzEBN7Ul/zlklUL2LXi+mieqcgLV4=;
 b=cUvCUVTZcTzhjK+JGKs52infvTuqJeHM0VbDHAq8f7p25Wl6T0y4HxRjrPPujXCeIN
 x6EEukCUgJLQL+GTAQ/VLsVnp/e2Pl9+PWWQkXkNDtutZq3V9KL48UTqAHUC+s5raUgZ
 D2IIMO1QHOIlUTxvam0ih6jGl7ON5RCwAd/GVrX6eOov8OFxV6AWQbRP8VBw8HfRM0lZ
 IMgT1vGeaK7Z+3COrJoWFO6IZjkLEJ+aBRunhDgcFFk2iZJOgW68rd0AvQ6bE840KPt5
 jZw9oM5ey8ocjeVpDr1AQf6XAVDgSeAeDWsfj0K4g18BEI7MW56g1Hwyxh85Vpe0x61y
 QjcQ==
X-Gm-Message-State: AOAM5335LIKtw01jqIX/97a5Rw3nOvrCLCmpmCJixM45z5pOlYQtxE3S
 EPVngSq/K2/u6ZMh1TRDf7t/+K+Q/xEbTw==
X-Google-Smtp-Source: ABdhPJx1R0E0gvd3gP8feX+FFL86ji2qpGgXMAfGelX5IgX7NSlNdygphiKkunPo68V1xcXLfLq4LQ==
X-Received: by 2002:a17:902:820e:b029:d6:e802:75aa with SMTP id
 x14-20020a170902820eb02900d6e80275aamr1165414pln.51.1604421772979; 
 Tue, 03 Nov 2020 08:42:52 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id 136sm17764209pfa.132.2020.11.03.08.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 08:42:51 -0800 (PST)
Subject: Re: [PATCH 01/14] target/arm: add arm_is_el2_enabled() helper
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-1-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c0bbd0b-f7b3-d93e-b0c7-d99822e19553@linaro.org>
Date: Tue, 3 Nov 2020 08:42:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-1-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This checks if EL2 is enabled (meaning EL2 registers take effects) in
> the current security context.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

