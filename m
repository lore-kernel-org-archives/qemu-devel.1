Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F5B20774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wovw4ei+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F5B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Gzs-00024Y-EU
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6GzB-0001aX-EP
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:25:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6Gz9-0007vV-6H
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:25:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id d19so3141089pgl.10
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Wyg7l71x35BFZNv5hbIJgLUzGTHNVWCfUhp/BWXJAe8=;
 b=Wovw4ei+zMRi0L1m884v4e5R6xxJBUVOkj3x+RWwZUawTHt7s1EVpm+1ikqDPcb7S5
 I9WwWjrBShzpmBYfBDXcpFk7LUDKHGF1SfnmSRft2KLywMGmCI6FmTRMzXBaYtMJDr9q
 5gjet0UYO+hMxh9SgBJeovynOr2t7Y4WYXpI5dD5+MTgaa3Y1aFYcErDFHF85eqfYZvO
 TdoPZANoyVRxzEHldClFkZj+kxAwMZAqlHqf0nbKLTRFc9Y+T/k9pDNAnvAtSxfTwlvO
 6YI2DNaF6P3DuLudPqLj8FLPn9pmnufQolXkCVYWWYY4NF4foKyilRuaP0j1WcQY1KAA
 C9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wyg7l71x35BFZNv5hbIJgLUzGTHNVWCfUhp/BWXJAe8=;
 b=HKBfzHpWiHm7RaNFgn6wMIqg1IvxS47tbDH4ItN3F+GnfqqN4dDcpQ5XpG73uuF101
 QxgGyGBJ/eAXPVIhWE1Mi6mRkYDtgfh5/XI/xOOdMwjKV3SmP0GkAw8BXzMk1OWF2wqH
 ulGkBWaAtR/DUqp+6HXYwjETVluJB0xka0lDxcY64Cdzd6h3faFbJzp4x/RaWYRR8hnt
 1NqjEB+lPlJnsPtJboULKs7mk6P8ztz2I8NEWYxqIfudxBOznKDnAbaGxqm1nRCtOcHr
 hMow02i3TOXGLCpGku2cgEa9YKvSYHtzYx72fUgvQEYvpTY+8ib2ZEUVrX3eDbe+SKG5
 gdQw==
X-Gm-Message-State: AOAM533Rns13ffEmCy47ruO5KR15uFzkcbP3pCAQ5j5i3pjGbXg3j0Ed
 0Mi/V9VxC3vh1LIDzfBQw46pnQ==
X-Google-Smtp-Source: ABdhPJxVjzevL+X3jD7+S7azjbqd7EBpuF+q+bLRL7IZMa5dFRZrtVqIyskXNPamztilEWwWlaf2Fg==
X-Received: by 2002:aa7:9551:: with SMTP id w17mr5512160pfq.167.1597339549433; 
 Thu, 13 Aug 2020 10:25:49 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e13sm5783242pgs.13.2020.08.13.10.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 10:25:48 -0700 (PDT)
Subject: Re: [PATCH 3/3] softfloat: add fp16 and uint8/int8 interconvert
 functions
To: Chih-Min Chao <chihmin.chao@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com>
 <1596102747-20226-4-git-send-email-chihmin.chao@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <979fce4d-75d6-2160-209c-46f4f9209a86@linaro.org>
Date: Thu, 13 Aug 2020 10:25:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596102747-20226-4-git-send-email-chihmin.chao@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 2:52 AM, Chih-Min Chao wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Queued to softfloat-next.


r~

