Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF09C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C102075B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chI3Kda2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C102075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEk3-0004Gf-8p
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBEjM-0003oi-NS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:02:04 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBEjK-0008IL-Tm
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:02:04 -0400
Received: by mail-pj1-x1042.google.com with SMTP id z18so2361912pjr.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VEew9N4D0Tz+Wb6QYHfqZiA26fXiWZ5JEuXRtN7TOuM=;
 b=chI3Kda2ecbFAWYIsNk6Ot81hxat3BYKNFsPKsHJ/0XLeoKxt0P4kwQ8r8jtPYC2RQ
 4YZ5LXCsOU0ASZDdSmO2JqrZkrTIGN7phR/8ojmA5uo5LWH2J2roLtjmJt5AEDcmoZfl
 9zk11mbvN6bWgSH2N9TYBgsiH2UqWUvjrdz9A6aH8CxTVTGuOuJIcXY6J4zIuWCeWJ2L
 agNPeyPLvLg92mvOxIO3SM2ZZ7fwHYugAuMO0JZycIDYR8dEFPitlyiFyJ/Wmzmsb3kq
 dJ/i52411rg8Q6p0DvBSb6BGLnm/QCMllU6QNYlAsbuGbub1LYCqR3uFX4u8MFnYgvH6
 HBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VEew9N4D0Tz+Wb6QYHfqZiA26fXiWZ5JEuXRtN7TOuM=;
 b=WkpFNFdS4Mf4SL5wwU1DludzLQ/ZKeQoKtSxjV0ziHfaxIuolxzivPA7oLimybPRzm
 6RBcTASJ38MQovtuxfiK2elOQ5w//RrFbacK4L4BQAoxf6uLeSgjCecBENjoS9ZMUjId
 JGjgjtbINUx/OUUaxiC8DsllkyNHaKaw3ElEfmw0NEjqelPoKxAD1DgJRjK0XtQm19PB
 kNQfUqZUTK/rO0GPwZo51W7oBxIDqyfbx0RW0OVU+3pgp3aZ07WbtNKNC0bEDHLYF//i
 QSIs+0TR6Ihy4v7LyHg4a8jn9ZPs/gKcg8rCUEopExb3Hl0FI+781w1jH6tdjvSdk9/b
 BpYA==
X-Gm-Message-State: AOAM530Dy92KgKBVWCOQMdBLn311syt2UX7FeqzFKb2Q68NpnsUruKQz
 iFZEHsiaJk5S5ZlbzfmLG1YZomqnjLX9iw==
X-Google-Smtp-Source: ABdhPJxlZfPYhhFKb071aOl+BID1P5Bbt0GFvE7K5YezhA1bvPtHBf/x9lSs5nvbeTs5InEyyalcNw==
X-Received: by 2002:a17:90a:1117:: with SMTP id
 d23mr9939625pja.33.1598522520832; 
 Thu, 27 Aug 2020 03:02:00 -0700 (PDT)
Received: from [192.168.101.174] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id a12sm2172323pfr.217.2020.08.27.03.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 03:01:59 -0700 (PDT)
Subject: Re: [PATCH 00/77] target/microblaze improvements
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200827091128.GK2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1628c0ac-db22-ef9d-22e2-6a167ceaaf55@linaro.org>
Date: Thu, 27 Aug 2020 03:01:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827091128.GK2954729@toto>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:11 AM, Edgar E. Iglesias wrote:
> So a first general regression is that opcode 0 no longer
> traps as an illegal instruction (seems to be treated as an
> add with all r0).

Oops, will fix.


r~

