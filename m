Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5829C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 22:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF14420663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 22:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4fTANCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF14420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv6WC-0002bK-1L
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 18:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv6VZ-0002A9-LK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 18:01:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv6VX-0000Tl-OY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 18:01:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id q17so6637615pfu.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sYhkhYArnucgNXIGnUTO1AoXPeTA2vKBLZaKFNKORIs=;
 b=F4fTANCYVFKfD8T44JBQfwMSzaYzl95M5P3xigvcU4li8yFul5+DbXkhlufkTFU1lx
 N7q9uljE92zvEhy0MEnSp834bBabJA7SSkt4z4F3mRaiMJKXBLWcpm/Otv6IBQT14YK3
 t1N2skY7tG48PzXh3vosiG1el1CiTb55Bj1715/APytMSNmNo1CzO4VfdNlU1U7NTFqq
 rCd2PxSeZWqJ1GNjSWU9fYXdzB/+aCBVgiViYxNbl/A46xCuHaltQ2dV+10Sl3MBBkWt
 3I84baeuIhsqdlPg25zL4qMfaDgKKg0NIL4byshVv+tw3azVKbpK/U+8mHn9/hQQJpxg
 qm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sYhkhYArnucgNXIGnUTO1AoXPeTA2vKBLZaKFNKORIs=;
 b=DwU0Lta0fSu4HXmZ6zCN1L1ip9uaWH5jNSbzSPCqtwfgaj0f6wgF68ukWjtfkslA7S
 7x5bgrUo4BDdLY/iO/k4nHiHwDjg+uJXCK/k9I+MbIuyRSRogB4escdDbwq7Lerg13jU
 AX56BONTIlgl/Orf7Fv4zOu6311e/V6lemczYp+vzuWgj0ik2q4rDomyAKyjPTjft62+
 rS0rUuca/hrEAJ9GuYMhTNsPJFiwI/H1MbFBrBs+bnM3e40y3cQvHvqRNHIwVSKhiRzh
 R4QWM0TZnim3CGT934vUbbEDXmqMq2TaD5ELiERNPRuXb47IWXuoTlhmOd1rpDgzefYJ
 LtPA==
X-Gm-Message-State: AOAM530lp/gNy1y22y8m6nwRmVxkEDyzU+8H4cSXwejh64ZphBF9Pqa4
 CVSWOYcpNb4brvZURBsLX87smQ==
X-Google-Smtp-Source: ABdhPJzDkgku0ut2EJiP3lNIbKRG7McPfn6BKocj7dlKBoWDCBu6SoedNe70s2nKTUvYT78Ce3PZRQ==
X-Received: by 2002:a65:6710:: with SMTP id u16mr959324pgf.45.1594677666053;
 Mon, 13 Jul 2020 15:01:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x66sm14238671pgb.12.2020.07.13.15.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 15:01:05 -0700 (PDT)
Subject: Re: [PATCH v2 08/11] docs/devel: fix grammar in multi-thread-tcg
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200713200415.26214-1-alex.bennee@linaro.org>
 <20200713200415.26214-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <758d397c-4226-72c1-dfbc-af59619053ea@linaro.org>
Date: Mon, 13 Jul 2020 15:01:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713200415.26214-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 f4bug@amsat.org, robhenry@microsoft.com, aaron@os.amperecomputing.com,
 cota@braap.org, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 1:04 PM, Alex Bennée wrote:
> Review comment came just too late ;-)
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  docs/devel/multi-thread-tcg.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


