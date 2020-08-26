Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54228C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1968E20738
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmvFdHRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAx53-00077P-CH
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAx4T-0006eP-Kq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:10:41 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAx4R-0003UI-OO
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:10:41 -0400
Received: by mail-pj1-x1042.google.com with SMTP id q1so1002751pjd.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JlZ144ZjalNWl8Zs/ogMcBXsdvdyu5qZ5EVRlkCIwEQ=;
 b=cmvFdHRVTfkLb9m9JQw4w46zcMMk/zJ1e2FSjpl7vSI68uS0vRawrgze4l1cw+6Jyo
 HvcyEBWtiN3Ah4UgaPJ6NC6SLypAvka8hfZpXkI111yNRPPZMZIJEtL5kdE4dIQD/5lA
 MerfkLugjQ05TPYuhBFzffiN74CkKk4Be62Jwr2zcbzP2GONIYg3WAHGiUOaT3vVFMqq
 v3FJg1cBW0aiu7FJixqiNtz5Ks3cG2bTGTIje0vYQFy0WttOFfyp2ZFaThwJEQoBuy1k
 p9UxlpqzgE7k/TlOUU62IzDg8PDTBvLy/jSEDyCsLH/P/WtrDroQvkTTrIKJxxeD53MT
 42uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JlZ144ZjalNWl8Zs/ogMcBXsdvdyu5qZ5EVRlkCIwEQ=;
 b=i0wGUxOf/YhHKoON/Qd4tiI5YrhsXYV/6V7pu4SAyJsTNcVxhT/QhpLWxPVVrPNL3B
 xayjfRu1kIfpRIgE5AxA0LvTPH8owV2x8L0utBykN5vIprdRsK6EGawYOj1a5xDRfG69
 IpD6uZyz/txIRqJhqV8Asvcq9EuU97gqdz/NojMrRHU4TEZ2jFY6DXfX6VreuTYhyV6k
 nD2jvs/PvX+bJTrmkia1oMVelqBowStCAwuyPKNdP/i3HjnvGQcWXEU+fVlcJ7rFWf6/
 atb2SyUPsO0686LyTYOB9gzKBGAGoLNW61Po8cFIdZxzIpmAxG/9hZUMCFK1PArcPqEv
 lgVw==
X-Gm-Message-State: AOAM532G1UpGAYxdsw8xhXkEsnUbB2eTRrfflSGOg1TIRQsXkaqhvLW3
 SZJOZbHWkzuHorfnlQ6hyaJLmA==
X-Google-Smtp-Source: ABdhPJwgJp2PgBTnbzFA98v+q4qXDnfKz97DwrMSuWhfYF6qnq6LLzlOVVbFrU4c2YG/9HGHpfTH8g==
X-Received: by 2002:a17:90a:6b07:: with SMTP id
 v7mr6785781pjj.138.1598454638162; 
 Wed, 26 Aug 2020 08:10:38 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id u16sm3305782pfn.134.2020.08.26.08.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 08:10:37 -0700 (PDT)
Subject: Re: [RFC PATCH v3 16/34] Hexagon (target/hexagon) utility functions
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-17-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f188d8d-811b-76da-a6d6-d2eab3dc5da5@linaro.org>
Date: Wed, 26 Aug 2020 08:10:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-17-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +extern size16s_t cast8s_to_16s(size8s_t a);
> +extern size8s_t cast16s_to_8s(size16s_t a);
> +extern size16s_t add128(size16s_t a, size16s_t b);
> +extern size16s_t sub128(size16s_t a, size16s_t b);
> +extern size16s_t shiftr128(size16s_t a, size4u_t n);
> +extern size16s_t shiftl128(size16s_t a, size4u_t n);
> +extern size16s_t and128(size16s_t a, size16s_t b);

Did you really need to reinvent qemu/int128.h?


r~

