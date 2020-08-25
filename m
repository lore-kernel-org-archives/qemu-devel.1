Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC00AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A5220738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nzlpWOmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A5220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZIv-00049F-Ss
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAZI9-0003h7-QZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:47:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAZI6-0007k1-6I
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:47:13 -0400
Received: by mail-pf1-x442.google.com with SMTP id y206so7385488pfb.10
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8MgPMiVs43Ru9ZjHnrp90fz7N4U+Myk9wcpddjZBqpE=;
 b=nzlpWOmrOUg6E+gGJStQwG8k2k8ccW+YSr7L3fsEiht9sMBBrJ5Q0QcLfbyWoUhlzn
 eL/V3nidzs+MiT1NTvZ1CDYVKEw9of/u5nNUI+TCsuWhvBp2BHT2bdvGdzB9UZVVSrmN
 y6592tE/CYXIyH+DpQWK7QQs5Zwd7GJAKQRw06SqrkVCTBYO0BrmlvScNAt5fsXSC4eo
 gXR1KQ8Et+ukJqQYWek8LXeWBhkjQ4PRzvqtqLr4uwR0iUqrMYfHeTWZ9AdUUBHv52zj
 2D3rlbWzNwMO9kPVt8CxaCRjnnunQtTrRE0ku160vEo5/tkBvrrZntGyboAKD7rx+tlZ
 3lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8MgPMiVs43Ru9ZjHnrp90fz7N4U+Myk9wcpddjZBqpE=;
 b=GCJvaf+oOc8cXmVv7jz8En56+wrBVlvAo1RTnxmjDYG4GF5oDkQEnxZwaDNFyJqR+F
 /eo6fXv8Gh46LPXjpw8/UrdpiREEekKYf8A7zglNXbYTcmcpqzIuWT3zNEuAP4FL3MmY
 y/4oHBb5vQ4iZBrVgzq/lxak7o4la6abDaMvMv48h+biR2UTIDkEfAx1UEEd8s7276jU
 v/VOabVY3dThV1HWD4qwgTJQouYGrg09yjy/wyd7AFnYVWbBHpi+YMB1tHCzgMNIcq1r
 mEJmAMTSujm/rH8JwhBzs0gjiiwpTRpnbHd/59w5jiEXZwmraYNurJ0Pvr4okY5f3iMD
 ha9g==
X-Gm-Message-State: AOAM532piKiJgCiepIeNNHALIEj1nwM3THTNwniARuwjwcgoDt9IH5Yw
 LbUd1rjoMtGo32Be4Nmj4N1vdOMSrK0ZtQ==
X-Google-Smtp-Source: ABdhPJzdGDvcvH81kLqo3rQe6iqwTA7k/Hpb01i7biAV/w3lVVd1wSQlZwcZxglY1YVg1gCG37SyLg==
X-Received: by 2002:a17:902:900b:: with SMTP id
 a11mr7811120plp.199.1598363228386; 
 Tue, 25 Aug 2020 06:47:08 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id j81sm7726471pfd.213.2020.08.25.06.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 06:47:07 -0700 (PDT)
Subject: Re: [PATCH 04/20] target/arm: Rearrange {sve,fp}_check_access assert
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-5-richard.henderson@linaro.org>
 <CAFEAcA9a1m1w6=Ohdv1x0YpFioWLxV+AKSsi4BpHAv196c3raA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57c537ff-a008-29ca-bf7f-94d932be85cf@linaro.org>
Date: Tue, 25 Aug 2020 06:47:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9a1m1w6=Ohdv1x0YpFioWLxV+AKSsi4BpHAv196c3raA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 9:59 AM, Peter Maydell wrote:
>> +    bool sve_access_checked;
> 
> Is there anywhere it's worthwhile to put in an equivalent
> of assert_fp_access_checked() for sve_access_checked, or is
> there no point that's both (a) common to SVE accesses and
> (b) not common to generic FP accesses ? One could put it
> in pred_full_reg_offset() I suppose but I dunno if that
> really gains us much. The existing fp_access_checked will
> catch "forgot the check entirely" which seems more likely
> as a bug than "put in the FP check when we wanted SVE".

While adding one to pred_full_ref_offset() might be useful, there are plenty of
sve instructions that don't touch predicate registers.

I suppose I could make vec_full_reg_offset() be different between
translate-a64.c and translate-sve.c, rather than sharing it via translate-a64.h.


r~

