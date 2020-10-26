Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57402C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA97E20878
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDv0DaXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA97E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXB4s-0003nQ-II
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAwL-00062f-WE; Mon, 26 Oct 2020 18:26:10 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAwK-000058-50; Mon, 26 Oct 2020 18:26:09 -0400
Received: by mail-ej1-x643.google.com with SMTP id ce10so16169429ejc.5;
 Mon, 26 Oct 2020 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uiasqVfucua531Ai9drGAEvhhayzBZ4sO3Uq2/OVqDA=;
 b=qDv0DaXKCol5r+4WqryBOIx1Ynow8NDAqypmO4ziYYALlqjU/qfsufHRTPOWrlpDsu
 iRpurxrFPF4sKGNisbGMD4a8GQhE6Us+YDkV4dvEeKDvKBvR9k9+Ziki3rMbXKCoO5rN
 BPVWe2wkCsDWmXf7fMfuGTS86j1GaJgDV06VOdEl1MB8SHfvJl3jmGk8yeF/mMWF9x/T
 TUdsR32C1xAD5d/2WYo2LTBX+dbgU+63I7sq4NGJFgE6DIWEUwEHVh9bLzUiGo77Fb96
 IN11tZFjNqeuQKvcRoe5VP8ahMS19E2U8TLIgnehBareihe92jVI4hxpZ4bN9gEwDgJa
 4tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uiasqVfucua531Ai9drGAEvhhayzBZ4sO3Uq2/OVqDA=;
 b=A4FTRJr2I0vTtJ4QmJZoVe4OMzc9Es7YcYxhE0zmnDTPFfeZACyrf8Xe0TD5n4OFMp
 7hrcJkh2IcRdUBrqJZ6qBZFJ65oqh+q2gwkxUorouGGOtr3oW7HcMvv7mnuIToBBBbb8
 dMAqO2hy3Fls5FZqNqzYc6FcdhQXkPWC0xf442IWmH5RXhffo57mCzNX1LcP+Buj7RV0
 TSwc0TiXxri2arnhPVwROZFCYg8/Fbuni3jxsBFRxcCe9+sTP2N3GgfCHZ0vHyfRd4Wm
 Pjt/3e9UM+FkccJ47dIwHgUTtLXc9/gZBDziPQ2mqXcCNaff91cuzmrfWmI4+xDOiwtW
 BcOg==
X-Gm-Message-State: AOAM531nDR3yX7B3ilWrU9qcqpCLUWz8+vU3VEgv/qfd2PgsaVE1QMsq
 7CEdK0bB+b6kQIiEZPaaRY8=
X-Google-Smtp-Source: ABdhPJykhFtIu6T62ZDVfqhCvEtnghWIgsGeGKl1rQEN3QMbQQ7EnkSOkO47uJE4sHAz7LYU64VXOQ==
X-Received: by 2002:a17:906:4a14:: with SMTP id
 w20mr17349921eju.513.1603751166029; 
 Mon, 26 Oct 2020 15:26:06 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id l20sm5556800edr.56.2020.10.26.15.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 15:26:05 -0700 (PDT)
Subject: Re: [PATCH 26/30] renesas rx cpus: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201014134248.14146-1-chetan4windows@gmail.com>
 <20201023123840.19988-1-chetan4windows@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <23e08867-c7de-06ff-5c5e-7b5e1339fa63@amsat.org>
Date: Mon, 26 Oct 2020 23:26:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023123840.19988-1-chetan4windows@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 2:38 PM, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>   target/rx/insns.decode | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/rx/insns.decode b/target/rx/insns.decode
> index 232a61f..ca9334b 100644
> --- a/target/rx/insns.decode
> +++ b/target/rx/insns.decode
> @@ -7,7 +7,7 @@
>   # This library is free software; you can redistribute it and/or
>   # modify it under the terms of the GNU Lesser General Public
>   # License as published by the Free Software Foundation; either
> -# version 2 of the License, or (at your option) any later version.
> +# version 2.1 of the License, or (at your option) any later version.
>   #
>   # This library is distributed in the hope that it will be useful,
>   # but WITHOUT ANY WARRANTY; without even the implied warranty of
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

And applied to renesas-next, thanks.

