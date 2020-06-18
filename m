Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14EEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6336020FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOBT9ejr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6336020FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlks3-0002CG-MR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 23:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlkrS-0001ZK-25
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 23:05:06 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlkrQ-00062U-Hg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 23:05:05 -0400
Received: by mail-pj1-x1043.google.com with SMTP id h95so1998602pje.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XCVqd1ufSw2SUGilKve+IqRASg+Co0CGH9ys0/r8bJE=;
 b=oOBT9ejrZhHU5MI2B73atvx0ZLHQcxNtV7ND5Z+4KQtkQKqF2kYCJV8+JJ+/TvY7aj
 Zyg7IVHfqYbwiHh0f31svLcIX9s42AAUO8FsVPJbCGkEt8K4yVaclsl9Cj+MGS6OYN3X
 tfYpjTeSPhKHw3GtvwQVo7Nppka0k0MWXNJQVKdoq/2GiDHqWIYlxOtdnQGRvYHkwxv6
 vH4p/FWZCBXSkI/16EtFVCZMU76EuvOU18N4/u74Q9kYCshSf5eD63NMK8YXBgYDwbil
 uY+MkV1lhp0WEOYJH1A6qfpRPLVfPgisH0j49/6JexaEi0sgLDHqgF4EN/wFsHXFGYFT
 WYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XCVqd1ufSw2SUGilKve+IqRASg+Co0CGH9ys0/r8bJE=;
 b=jFgZSv9Jcn9XoqQFaWc2cp11vkm1VfEaODb32b28/e5b4/+7Uzy/sj3DfLebm3YEsL
 WZZUffm4z8Qpqb0F/WVBOztlbUdoYWhUHUHaZukmtr8FwVfQVLaA7UX6F9Bzbp8iXoMi
 cosLcTzhSdd8E4TKcDXveDbnBhl1wyeHiXaV++nD9PoMIyU61rYnvNpTXqyPkR1Bhvsr
 +OH9pcDKjn7x7lcY7gwuuRb25kSql4pz0BNLIBU/ZpeO3+FrvvtoL0+g4Un3fC5ojLf+
 J9NnipduWme7gxMViJY+qJICD+wMXgkgdQdYAWZfxN3gLo4mEyy3vfNwQOvtcYPbrDa2
 gXig==
X-Gm-Message-State: AOAM532DlgMclsLTpO4UdmXkdshiVSkoTeZn9wGjk9QKFy1xtgw4ss23
 FJajAfI/+/oqlGB7myJ1tjZYxg==
X-Google-Smtp-Source: ABdhPJwgZBxwn9WPRlts+1d1P12xWeyCJeGqEP7gXfIKGoXhlYEZbAQ1lw7o1GAvQl3kFa2Ok/n7Vg==
X-Received: by 2002:a17:90a:e506:: with SMTP id
 t6mr2183686pjy.35.1592449502735; 
 Wed, 17 Jun 2020 20:05:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d25sm1016891pgn.2.2020.06.17.20.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 20:05:01 -0700 (PDT)
Subject: Re: [PATCH RFC v2] target/arm: Implement SVE2 bitwise shift immediate
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200430194159.24064-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42119585-96b2-9dfe-01cf-05b85d76434d@linaro.org>
Date: Wed, 17 Jun 2020 20:04:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200430194159.24064-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:41 PM, Stephen Long wrote:
> Implements SQSHL/UQSHL, SRSHR/URSHR, and SQSHLU
> 
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> ---

Thanks, queued.


r~

