Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11486C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 01:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C861C2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 01:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvjoxtgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C861C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibaIY-0005vQ-13
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 20:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibaGW-0005Cl-EC
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibaGV-0004jR-4Z
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:12:40 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibaGU-0004in-VJ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 20:12:39 -0500
Received: by mail-pf1-x442.google.com with SMTP id b19so17642045pfd.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 17:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R+0EC9L+xpy86uruArLxxQ9B2WU6gwTfHvVoWgrVo1E=;
 b=OvjoxtgBKA24PisyUiTGtnX3iIOZL91N1k/fq7PCi/Bn7zJazXWjtLsNCtI4ld/wDO
 MKM2VQyu7O+B4MbkTAJHOOmh6gmVywXJBpEfUTHtS852mZaw8YJdCJrfhN4YF5q7GPx8
 S32AQ/uR3EM4OQ0KAfURcJibJPhHBLyeEzpw40weW908cDudVkqk8hGFjZ7ZslcSlhrp
 rwGcd9szEm2/yw3XAMhWfG0Ld1uMnRx6Tgb2beQNBjdse8uG+4WENxVGuFUzpfDiD/tp
 CzZUorUufyOftiTMCvLqVnt1ggRPp4El00d05biMRZnAEIxvbdjwT3RK1Y9wtX9e6Duw
 EI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R+0EC9L+xpy86uruArLxxQ9B2WU6gwTfHvVoWgrVo1E=;
 b=PY8VjWpnzikUcOqNk8xTCw2Jc3VMHjgrGko9req1X+lSx4zusGSeOmzLsKO31rmNJ3
 GUrtW+axh4m0S27ThugziStVujvrggO+n+h9789OqaN+oOvA86uic1LFILxxjfl1Lkew
 a13DPIvmcgRCqrPJWnmuuoHNKeDPsuEu0TkroX0AgV47z4BlYyFCoAY23TqW4P7mHQdz
 zkTYMZ+lLZEqGJOZYQijC/scSx2K3Qx8aFD1edzVmzx8bbxoi/L22q8usOIGlv5A4QL8
 0NY7mOJ+RhmhR2aVGOGzhCr80qJDaqvMO5J5g703gfp4slYkdk2Zck3wyZyerr1jcnh1
 6bNg==
X-Gm-Message-State: APjAAAXTXnRPcCztp7ZLuYmL5B1wVmxaz/hxtGeFXjHo3zKd3ua1zLz3
 N5SXdW91UMzmDC9bDSGksESSK2CEedU=
X-Google-Smtp-Source: APXvYqzjAl7OoNaKigwEnnecL9BK8net54D/SH5vNnKwb1JU+RaL3cqbI06Huf8V1bu86ynoeAgU9A==
X-Received: by 2002:a62:7683:: with SMTP id
 r125mr29772914pfc.132.1575249157904; 
 Sun, 01 Dec 2019 17:12:37 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 23sm22773446pjx.29.2019.12.01.17.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 17:12:37 -0800 (PST)
Subject: Re: [PATCH v1 3/5] linux-user: add target_mmap_complete tracepoint
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191128194603.24818-1-alex.bennee@linaro.org>
 <20191128194603.24818-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04a7272d-3506-69bf-f13d-a0dfe3fd406f@linaro.org>
Date: Sun, 1 Dec 2019 17:12:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191128194603.24818-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/19 7:46 PM, Alex Bennée wrote:
> For full details we also want to see where the mmaps end up.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/mmap.c       | 2 +-
>  linux-user/trace-events | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

