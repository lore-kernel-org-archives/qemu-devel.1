Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D88C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839432051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLGkaVA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839432051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRih-0008EQ-L8
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRfq-0005tr-7E
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRfo-0008WS-5u
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGRfn-0008WA-WD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:40 -0400
Received: by mail-pg1-x544.google.com with SMTP id j29so724965pgl.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QIsGpO/C6XkhBsEjdZXlh6u93jnlAWM962BEGpA6+Oc=;
 b=YLGkaVA5Kdh3qdzc/D25RO2xV27PfIXCGdccoGu65/uNU2Q0gYHjZC+F1MHzXx9arQ
 hkRbI2glxolD1qG0q8isG5Dq81KUtwT81sgRsd//FdUpFY/QU3HxZ7O1PmmZVkjRUAfb
 87OS3awBTAnMaBQ75b0FTU0/PTvqHC1byMCfdk5Fzmm70u7/jpdLlrN7ZExPTK/1z1gL
 qrfdv9RQBzvcS7ipuf+7NqmvH5n/msA6J4HF0YtJ+9fksHr9ysiCTjadW1BCGQqryyyO
 3SLi5hBZzMSxn2kh7OM1gmfcrBrJWtrfWjjP+Ud/3qdg9F7KW16YFUe+pJ0YFkzHIp9Z
 3eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QIsGpO/C6XkhBsEjdZXlh6u93jnlAWM962BEGpA6+Oc=;
 b=RKpzn9yCyKQ82shcm01mz9eTb2EpHYbECuVzJe2NAbOFjqxRXaBVX4HZNMxGrzL037
 BVYpnq/OMMwUbu6Dt0LlEr/2TGJGTHw4E8jd7wTilswf/5GwASBdNnBUsfSReeuCYiZM
 TCZrQ/iIPSGOwiJ7XgpKkpNq3rvfnGYUO8GoTDwtMASBUYwB0Tv/Nn8aWJhDamKIKMrX
 QtnO3VMHYFdvk5yrMVwvaUWl+i34ac9PqEbKU+gYf8NUDNhdt8lTli4ZDeHd9wlqsd07
 q2bmlt70daLjIQCFBhMUuTJjrnqCYoD+x9eavk2dqllqM/tQwZ6vQw328kW+DquSvWDt
 sK+g==
X-Gm-Message-State: ANhLgQ1BN0TA/qxTdxDA5/0EWCD1L+StZmY+6jhlsvMropta4oyLA63x
 mDFu3weEhV+6juexN7SoJ150KQ==
X-Google-Smtp-Source: ADFU+vv1jRBWH+ViL5LCGFY2SGowq9f6vniOl7DoVy/0BZHx/wWGc5n4qVLJPLMInAhiNvIPuEKbPQ==
X-Received: by 2002:a63:2fc1:: with SMTP id v184mr22239797pgv.97.1584987579075; 
 Mon, 23 Mar 2020 11:19:39 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o33sm252211pje.19.2020.03.23.11.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 11:19:38 -0700 (PDT)
Subject: Re: [PATCH v1 08/11] tests/docker: Install gcrypt devel package in
 Debian image
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf7777ac-ffef-c410-be8d-ae1eaa71d6ac@linaro.org>
Date: Mon, 23 Mar 2020 11:19:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 9:15 AM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> In commit 6f8bbb374be we enabled building with the gcrypt library
> on the the Debian 'x86 host', which was based on Debian Stretch.
> Later in commit 698a71edbed we upgraded the Debian base image to
> Buster.
> 
> Apparently Debian Stretch was listing gcrypt as a QEMU dependency,
> but this is not the case anymore in Buster, so we need to install
> it manually (it it not listed by 'apt-get -s build-dep qemu' in
> the common debian10.docker anymore). This fixes:
> 
>  $ ../configure $QEMU_CONFIGURE_OPTS
> 
>   ERROR: User requested feature gcrypt
>          configure was not able to find it.
>          Install gcrypt devel >= 1.5.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200322120104.21267-3-philmd@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


