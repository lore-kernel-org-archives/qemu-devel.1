Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508B4C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A1120644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaVt2ng8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A1120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWIX-0001FK-92
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:12:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2K-0004C1-ON
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVza-0000NH-TF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:31 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVza-0000Mh-O5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id z28so2045698pfk.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ugeqNBSjhloZiIaY5MfyAspW63xn/blmZgulKqzx3hc=;
	b=IaVt2ng88UL75PiUs2Kfi7CUojrTzp56oQ+Qy5jjTcjeQaVqVZE9itTvki09G73Gv0
	Uk2/4e7I7vZZVJKmyiBgJ3XC05l+AsgdMDRNYHgVxGfSAmhRzqElpqV5SlYD8fZqVumg
	IYQrklFtyD4nmaEj2H5BG1q2QeDq7XqM0uyj8/vHO54sze9YNgMCiWezDvNODKA4nKn2
	tNg3aEiaLCo4WNLmvTmiWXs6z/G8FgWiOdgX+7X0iBYvO5Ul2CAQrSdd2DcwfhXJdMLV
	0Zy31HfMJavmfkI/deg+hMa+4KEnpBalyTcSA/vBUhcapBO0kv140qIuwrhwyAvMmHhU
	bHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ugeqNBSjhloZiIaY5MfyAspW63xn/blmZgulKqzx3hc=;
	b=gssV3+uB/Vit09xDcDfudG9Ki8hQX/jc55VvB9R16zDg1ujaNbekeb0hROqcD2feVM
	MqsMrMvTus8yG1lMpgHVQHNcGmJAdfrXP22dWbvCLccOgtK40uPk5jFBUyZOU/MDdKwI
	rpu9wvG+oXacvGWLrTAmjzudIcJND9UeVUmyt4tsbCcuiD6HKxufVtDRmBaPTP9s8/IC
	kR1zNfFQ5uds9XYTkScGSGVxpsIYtVBhpgi02ZpwLoYsUAyHWSwOQUXxsnrwwhIyraXE
	KExV3eoVpqJiHVJk6X4le7eAYzP4pCi9yUMSL+Bni0qEM5X1W5MnK7ID1u2FkMc7bXwc
	CE1A==
X-Gm-Message-State: APjAAAVCRg66CSkeWdanivjg7M2rZgauEEZrLJ6QBgOBmYkJIr9umdJw
	zGSClqWn/lHWW9L0U8d6iZPzHQ==
X-Google-Smtp-Source: APXvYqwaxD8H1Xl3TEQcP2gLMd1TYClzMjClEncnZjV+gXVqArus+3neJmKRgzNDVry4Q/wM2uFH8Q==
X-Received: by 2002:a63:6fcd:: with SMTP id
	k196mr66970625pgc.238.1556643149644; 
	Tue, 30 Apr 2019 09:52:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	a4sm2681766pfj.36.2019.04.30.09.52.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:52:28 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-11-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <45ae496e-eb58-9bd8-a96a-e1620a792d9e@linaro.org>
Date: Tue, 30 Apr 2019 09:52:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 10/14] target/ppc: introduce
 GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165217.PoWSRuOcsLZMqUweCQn5eeFEl9qsGDwfsPHABtagmf8@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> Rather than perform the VSR register decoding within the helper itself,
> introduce a new GEN_VSX_HELPER_R2_AB macro which performs the decode based
> upon rA and rB at translation time.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 10 ++++------
>  target/ppc/helper.h                 |  6 +++---
>  target/ppc/translate/vsx-impl.inc.c | 24 +++++++++++++++++++++---
>  3 files changed, 28 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


