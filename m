Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E76C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BA4206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8e3dSVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BA4206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWRk-0005zh-2E
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55482)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWOM-0000sl-EX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWOL-0008Fr-Ha
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:59:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxWOL-0008Cw-Ai
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:59:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id b16so10953679wrq.9
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XMyDqrGNzUMHL5j9hv2v7mYSZ75L907+avfKtjvVjic=;
 b=Z8e3dSVzp5VPnB3W93BxbfMRe5hMza6KS5nANNkVQYkLBm9agczWEWtmVC3rOtlC3U
 SfvYz/xSmSstmSNNAH0l2R64PDL1Wnmd6c6DWivXshEERsV/XA/8+KDLHFmopVIbvIJo
 YZOoD6kvOYVjCer77CHo9FNbYSOPygyTR+HLmYoee0EUR2uwHmU2Dx8wHF+LY9utFNkQ
 P0t3S0pQo8S4YQp6U8V3eLJka6UyZaJVgyuFBzLYKi4x/MXylPYtPJCgY6W++R0K57eD
 S0RjIpEFXxl5QCmHhYDuJE7G/j5BCEzBuzS189/ProyVh0HIYUwBhsgEWZ/K0oKxlUSH
 YUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XMyDqrGNzUMHL5j9hv2v7mYSZ75L907+avfKtjvVjic=;
 b=TVYKFAI/GNrrUJ5JnqMIu7vgh+L4DUogJtofSS1D7tjT+yzETrqcnmiRezxw+gAa3Z
 qAZf3XrepNXLNveQp+DxVLg9K/rBjfo3V0NEIm9crSzg4jtEVLw/bWCUHaPEJisZsfGL
 i2ndZNNLyqrn58TcStbSW80/xc3NooQPxnuduazKuYcxMaUiWrHicLDSAqmtjM4VOPYL
 ziRAqC07YG5AF1Ul6QHRKxeRf52wZ5Gif9RKnNxkQwbD6g1kGvNxZTYXZ+JvziRD8E4F
 a0EuFWptFdZlpBjnexrktz683zcI5kdxBGLxNoWFhDRzY/dsxuy551TbyiETWy9bfqYd
 SdrA==
X-Gm-Message-State: APjAAAXGi73rbbqNP32zBdAsyBO17R165mIxyomdB5nWNIBqETw96EFL
 kDzfeR6MzMprhKtP9iaq035nVg==
X-Google-Smtp-Source: APXvYqxTVehFUO/yI/PhcJvvyPPBHr0sRRw/jssL51qjD4pNaTs182aYnr23qSKL4kPq2boJsfFheQ==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr20959177wrv.237.1565701148060; 
 Tue, 13 Aug 2019 05:59:08 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id 4sm251817467wro.78.2019.08.13.05.59.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 05:59:07 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4886db3e-7869-3d69-70b6-257590a5c679@linaro.org>
Date: Tue, 13 Aug 2019 13:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 01/13] fpu: replace LIT64 usage with
 UINT64_C for specialize constants
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 1:49 PM, Alex Bennée wrote:
> We have a wrapper that does the right thing from stdint.h so lets use
> it for our constants in softfloat-specialize.h
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

