Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F66AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D8820731
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtimwTTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D8820731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvv2-0001dV-4d
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvtF-0000SG-Pa; Tue, 03 Nov 2020 07:58:21 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvtE-0004Ut-1h; Tue, 03 Nov 2020 07:58:21 -0500
Received: by mail-wm1-x341.google.com with SMTP id 205so4930827wma.4;
 Tue, 03 Nov 2020 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QGTsdyyuqveNZtckZHCjlvQRIVCWG50U/JEh6Jp/BrI=;
 b=EtimwTTNYDIRaoy9hmFxwbkf50PoKZdOVyPfN54nXi3O6kbcscbFpEeU5VJb6SI1jo
 wbdpHDpQOESYxYk/RrEnJvDjHJBw/Iv7+D6AAZKEaYZx39Tnwwcc+3/ncIe0+pl9gWNC
 C3j2BIuWJAMD8aaIYffyrSJ/Xac2ePoGw/yb0wPAAb7/SvBKtIkddFDDovyyPVYQm2F+
 bQzKGwRQAt4ZXmbTS2ETWYaE1a8THMieK7CxfkWExx6deHiLWMsr3MvQC6oQdBP1MP0W
 0fAZZXgAtH5ey7qn5K7SBZE5xCHpz2lUIP9Pix6c1dTP1V7HpUya3RFgGeaVMWolLEO1
 o99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QGTsdyyuqveNZtckZHCjlvQRIVCWG50U/JEh6Jp/BrI=;
 b=AC1ETCOTIewXexSGPZnOyS7PrZ/68iIE1WWFAXLOyyFxmG/I/WLnV2jCXpGEBFA8AZ
 OrdsdatjjmwrxHq3SRES18+ChneazxUXygXQntiBiDpsiwkuXwYumzCIR9UjTqO0zkum
 l+nGSwU3r66saHKkacIvQ9wKxafDClAV6/dmpWGwcA1JC7hJIU4q6Hezj9blEW/5f2bd
 IdJpDa3xvyOfiYy2VtlQ6RksPAbXjnW2LOhBxFliEgv9M7cZcgcpzs1W38a6eu/C0xSx
 uiPv8+QaivTDTbZ0/wMRV0d0nkq9uhYWT2V7cEtlrZHdWqVsibiOfD23AgOsRND4zjAT
 zUZw==
X-Gm-Message-State: AOAM533GjScUoU9CPSguHvPyC88Ti8EYHHKh6YWul0u+PcV7DtVH63QG
 poh7P4/sok7oZk01p6V/dHY=
X-Google-Smtp-Source: ABdhPJyN5vaKE+qtK0Eco7MDtHU8tqYTqZU9NuFnrP+bFH9jK4WTynnPOdOaNeSDKJu14OBu3/MRKw==
X-Received: by 2002:a05:600c:216:: with SMTP id
 22mr3306263wmi.149.1604408298071; 
 Tue, 03 Nov 2020 04:58:18 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g138sm2810017wme.39.2020.11.03.04.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 04:58:17 -0800 (PST)
Subject: Re: [PATCH 16/30] boston: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201014134248.14146-1-chetan4windows@gmail.com>
 <20201023122633.19466-1-chetan4windows@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <60d7ba5b-6cf4-5dd5-ca22-2878669cf673@amsat.org>
Date: Tue, 3 Nov 2020 13:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023122633.19466-1-chetan4windows@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, paulburton@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 2:26 PM, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  hw/core/loader-fit.c              | 2 +-
>  hw/mips/boston.c                  | 2 +-
>  hw/pci-host/xilinx-pcie.c         | 2 +-
>  include/hw/pci-host/xilinx-pcie.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Thanks, applied to mips-next.

