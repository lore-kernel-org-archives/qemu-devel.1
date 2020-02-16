Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A4C76199
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B731420857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCKedMZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B731420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3GHu-000696-Rk
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 04:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GH9-0004zl-4X
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GH8-00075W-Af
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:31:43 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3GH8-00075M-51
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:31:42 -0500
Received: by mail-pj1-x1043.google.com with SMTP id j17so5907912pjz.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 01:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=N/2QfcxffSOIHpsgi4MCX3FuMnglO7aG2xXNeYCGFoM=;
 b=tCKedMZOpD3SaCHQksc+CcShm/IegEn+Cj3uktcea0B/ChXoxiZ/CCQ7GV1YfSTZ0x
 pPXjOnyecMUbFuaaEy/0T3EisqieE/zqFE9cDEhXtMBzCokg3qMvVYyK023JTZMrMvOi
 jdxc7xO8nNnL8NegUvP52pftO+pPoZkKVAQjC/n3d6s33ZYqIghkuTu5Mj+czC8GKzyz
 g5IRhAbai6inrvZHfFLHz0KGgtFSY3n8nAIUj/4Uqdlxh6R7WEHfesLLM3Bmtkr75UeF
 /JndRhtkLywT0fp/lgPQV+hOhb07VXkMaHOEfCBg8Ppz43RURrlGi5WANm7SNPeaXSqy
 L6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N/2QfcxffSOIHpsgi4MCX3FuMnglO7aG2xXNeYCGFoM=;
 b=UbtXQblC+QAfCa9JTaqDO/k8eZI78gbScZJErL3YCrj0hyy1sVyTwmj0ryx+tq+LNA
 lArCfCAqiTCLq3SyeVtChOBf5mXHzud+ijKSdTxWdCIiUhd2YoTeicK3vZsKYMV1kq9f
 xYRXtD/KLtlREBuqcvmR+bb7xTQgwGJcC3xPF0QsODck5u+4tKtfJ0u6Cap1IKnATL/z
 nbVihhNnasT55ldkYsP+4CSJO2XBxDRwmVnFlhKo3y72VvgLnoin2qiN0MXFRToijgla
 Ybbw7k3tmOXKrR+8+QF9Q6/d2JR1jpmxpnFQ3ebqFxsNx8igov6XcM9ogNeo+ixhyQOG
 FnoQ==
X-Gm-Message-State: APjAAAU6HZzElQ1GsYRw1XBZ1UHywblQM7m29J7hR68JG7fxpCGfWBR0
 aOVFsb1AumkOIiJ/B2+N2jKg8A==
X-Google-Smtp-Source: APXvYqwBtJxV5nM2j0Bgbk0zS5qH5KqwFwaJmzsF5Q8T32vjWRFFFgnCNvYR4xDdsaAY9hJbFXuc1w==
X-Received: by 2002:a17:90a:e509:: with SMTP id
 t9mr13062264pjy.110.1581845501259; 
 Sun, 16 Feb 2020 01:31:41 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f1sm12202949pjq.31.2020.02.16.01.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 01:31:40 -0800 (PST)
Subject: Re: [PATCH 2/2] cmd646: remove unused pci_cmd646_ide_init() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 rth@twiddle.net, jsnow@redhat.com
References: <20200214084607.20471-1-mark.cave-ayland@ilande.co.uk>
 <20200214084607.20471-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3cc12a16-fd0d-923e-700f-6d234dab4ed9@linaro.org>
Date: Sun, 16 Feb 2020 01:31:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214084607.20471-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

On 2/14/20 12:46 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/ide/cmd646.c  | 12 ------------
>  include/hw/ide.h |  2 --
>  2 files changed, 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

