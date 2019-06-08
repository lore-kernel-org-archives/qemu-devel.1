Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7FC468BC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD0D2168B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsvY6f2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD0D2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhD2-0008SA-G8
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh10-0006Jh-If
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh0y-0006wJ-LB
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh0y-0006vW-Dm
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id 203so3685752oid.13
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d/LML2CpWzrbkhyg8j4ROCDBN6DxwDlM9TuSJqOhLBY=;
 b=WsvY6f2Ua9it1EHTVHG+V4GiYpGW/GG9HEtuIpGZlGiRv7HrLjL/IXhkwI9uBqTCt6
 lwGB1pjElGgWtGaempVuttzCSFE/syQ8302B4hnEDvleGpkmlTFcu3IpDwkSq+HlKB1R
 wp9YeYtMGzDchXT0iNij8FPTMQMIVNN6N6jbU1Twf8GKWvVlEhwACARhVvPcjZmStXOM
 w5rSOgpnqiKgx4GXks0knrtbf31DCtLEHMBvBKalAr9SA0x0/7tT9r8NcJDuV5aPfP0z
 JuKRj2Y922+1vlc41vsIRDtvcu5hLWjgrLCcYzJCL3fZcblfvePA8t41iYI5/LpoETL8
 Beeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d/LML2CpWzrbkhyg8j4ROCDBN6DxwDlM9TuSJqOhLBY=;
 b=t9GhGJF9ClXvWkUg/DhzVbgiJPJEXci+z05oP8Rjb1uG8KBDZF4PcnHwUTH6PhpTf+
 OrOPKrPnZFu7fQx5uwuvB2qGG5oL5FC5BonZVyjLn+zf3DeT8QdBqP6kCZ3A1H2X9xu2
 U+/rinNc9TS2G/X2ue/91V4Elsu4XPpmLt8rEMmsC+J0jsTN/3sIm9K2H9VL7k1l2W18
 8bbGK5ACBBW4iQ6cW/TOATa/b7cvM3TrHgb6bfp6HOwlaeVUnnnlhK/1c+m/8P95V1F4
 x2bKXNZJmGp1XTETarlNWESECaMOIDTUVALYX61udkHVLgORaniEU9ajnpPEMK7i8Njf
 ax0A==
X-Gm-Message-State: APjAAAVHx49AIPfyhMl/oFeRT0vt8MWQiifKLW47Kv57lE1upRCyqs3c
 AfOsiJNOKMyDRlQKnsTAuZQlE3MmoUXSXQ==
X-Google-Smtp-Source: APXvYqyEVRbLXr5eSaat2BC5bmupXKdPzn9/drnUwT1zetN49xlgOvc+b2URnYATY6KEZM93vVq+QA==
X-Received: by 2002:aca:a896:: with SMTP id r144mr7355410oie.105.1560022111255; 
 Sat, 08 Jun 2019 12:28:31 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id 37sm2562161oti.45.2019.06.08.12.28.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:28:30 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-26-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cad1bb4e-0143-1f88-bdc7-9d06929900f6@linaro.org>
Date: Sat, 8 Jun 2019 13:30:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 25/42] target/arm: Convert VSUB to
 decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VSUB instruction to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 10 ++++++++++
>  target/arm/translate.c         |  6 +-----
>  target/arm/vfp.decode          |  5 +++++
>  3 files changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



