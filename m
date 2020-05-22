Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23669C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D761B207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utn3yIUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D761B207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxxo-0003BO-3N
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxwJ-0001GA-6T
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:01:39 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxwI-0002tA-BD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:01:38 -0400
Received: by mail-pj1-x1042.google.com with SMTP id n15so4366835pjt.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7jg+6ng0lQ2weQOBmMds6QSOC4i/EupgASW2YZ6ch+0=;
 b=utn3yIUxsO4BnVfqX0jXEMC86XUBs56Xj5ZBQfGJfG3MedGxYkRRJ2sJK+2FCaBVU2
 eLg5z3bSKV54i4ukDTUXIhZ7EPp8BDy5x8YMXJ7PwypD0olm/0ncqpc631Ok649m9Gw8
 W/5iwhhEqDrnA/7zDPqHHOLdirvu0H08XskgqhIPiBHLVAomA3yq6OzrtBC7JnbT7DL8
 LC8gcWv4Ueiq13sMLoE0iCH5X2cL35SLm86gWdi0PqgTDG0DiFYD8c46Iigr4mfhtG/P
 srQkhHOAr6z/YKp/PSccD6fWkYnmCZe312JBC3XNNOOw/O4DmuTeyCp08JWvz430ukB+
 lNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7jg+6ng0lQ2weQOBmMds6QSOC4i/EupgASW2YZ6ch+0=;
 b=DgQ+QuJeGeOFoJIfQxONlr7ATtwUE/zIS5DfQP59ztpYDJNnQchQuCq71b7x3sx7aK
 ydRGUXzNggrLSsnm10cQ/ncMjR5eScweNdjuxGU1EY79xruon5z86nxz4xRjh6/9kVVI
 AVXzo+zDNK5KvMNYlLI1B4+TC8cEjuMWgEWtiMbBCGSlFfPQ00WcWx7ZcrXm/3ZICbiO
 eu4uT/W00RyHhS53YKf5XcTW18e8WxH2jQ13UhZ+9zCnfqhiHzhH+JPnNE43TyV+rSos
 Qf8wPZNIRmmZhMg3JmetAGqKwbfb9n2xyAoZce0p55Q+eu4p1puR0wXqMcYps+LhjecH
 utHw==
X-Gm-Message-State: AOAM532L4PTylvNeLrVfGp6TbIv7SDzhIttX2RIXWXRJ/sM9xkKwtpfu
 N7P4yfcyFjjNYLDSMPbUxeRHNcAr1LQ=
X-Google-Smtp-Source: ABdhPJx+bz2YoAC4FZKWT0QD0tnDeNG8Kj42rNuQ+yESXbkghLXn++94mvQHO9Sy2kUc7jftRYY2VA==
X-Received: by 2002:a17:902:aa4b:: with SMTP id
 c11mr12784930plr.211.1590116497109; 
 Thu, 21 May 2020 20:01:37 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 10sm5407624pfx.138.2020.05.21.20.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:01:36 -0700 (PDT)
Subject: Re: [PATCH v1 09/15] tests/docker: add debian11 base image
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200520140541.30256-1-alex.bennee@linaro.org>
 <20200520140541.30256-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d7aad11-0133-7cdf-0cd3-764b9a5fd0bb@linaro.org>
Date: Thu, 21 May 2020 20:01:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520140541.30256-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:05 AM, Alex Bennée wrote:
> We won't use this for building QEMU but we do need newer GCC's and
> binutils for building some of our test cases.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include            |  2 +-
>  tests/docker/dockerfiles/debian11.docker | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 tests/docker/dockerfiles/debian11.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


