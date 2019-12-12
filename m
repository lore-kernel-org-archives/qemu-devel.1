Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D750C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1A92077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xcbnq6dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1A92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifDY7-0002K6-JB
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 20:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifDXE-0001me-VU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifDXD-0000qf-Q7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:44:56 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifDXD-0000pB-JF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:44:55 -0500
Received: by mail-pg1-x541.google.com with SMTP id x7so266091pgl.11
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 17:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TCHmnrkRlOqZCr2wFwT0K+hY8xftWllzo35pAoSr184=;
 b=Xcbnq6dWxVNKQ9PHm+s6raRNrO1JBPbKqqRx4WGaITmPvYb+AxldCCl9Yuj0dHo2Ik
 CzTo0qy0OkDf2H6GyMMp1l8UQ7Gu/MHR1K7RpeOthBjOj/ylMDLY/gaipWpVXcU4oSAT
 Nz5f775eP52sw//qPqipDo2OYR5w8wvKHKiUuHd1ARudTR+3M5VuKEe2jr+hxOSoyrqO
 TdNv2NF2t6rcQmn2kLI5qVqGvqV/4oU3skOj0wN+FEAdxDLw8YkOhmUOnO92vZMBoNAZ
 +1fBbs1zrXDXTG/3pda+qqnySVAg7WaD0bZbdSNVtRsD/UKWbWTkUe0NJMsjadrEcWDe
 Xssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TCHmnrkRlOqZCr2wFwT0K+hY8xftWllzo35pAoSr184=;
 b=CmKYhvfHxFbIEbRpvAOzqWIrBIdE9dwW9jmxGG1oI15m79ZmAO81RFeR9Z41Cylz5E
 n1z++CYIwmPVEoEEmtlFW+9WE1pMxWJfGwNYqK3HaQ7GIArDvuXgyqKZZ7As6fH3seiX
 lHsoi3tQ6SjpnidbgxZNnnIp4tW3WKE/HNrn4Rd2mPFQEZvvitofAmzhAtEUWLjaDAeA
 l049UmhxP1WnVoWAFcmfAwnkaD3nGWIfbXQHL4qGnQJsttXWU5543Js5lkvyVTrPi9Ss
 EyJMfh2GSmtyGldPPGFlJ9Ygs7fetZj6GAW1/N1k4r7RMSUm7JiXWoEFS26+yl6S3Cbo
 fH+A==
X-Gm-Message-State: APjAAAXPO1duCnAuoBmIsUtQdezodFdFZsOSrno9kQ9bkf/8E6wbc2SW
 vi5BSNQCD6k0eVq4l1qNo0NHPQ==
X-Google-Smtp-Source: APXvYqzzDU4q6Fi1ak3VWWokenhkt0/WbG/wlVPpo/4QyoriQTx6IHM/BgiB+WNzauHF0HJi7MMbVg==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr7030799pfi.260.1576115094279; 
 Wed, 11 Dec 2019 17:44:54 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w200sm4451871pfc.93.2019.12.11.17.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 17:44:53 -0800 (PST)
Subject: Re: [PATCH v3 06/20] target/arm: use gdb_get_reg helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63022f19-cc59-0b08-c3d8-3a002381789d@linaro.org>
Date: Wed, 11 Dec 2019 17:44:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211170520.7747-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 alan.hayward@arm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 9:05 AM, Alex Bennée wrote:
> This is cleaner than poking memory directly and will make later
> clean-ups easier.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> ---
> v2
>   - make sure we pass hi/lo correctly as quads are stored in LE order
> ---
>  target/arm/helper.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


