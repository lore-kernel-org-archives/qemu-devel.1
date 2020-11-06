Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E0DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B972087E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3HuHFnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B972087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6VQ-0000lK-A5
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb6UO-0008L8-2t
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:29:32 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb6UM-0005Qy-Hq
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:29:31 -0500
Received: by mail-wm1-x342.google.com with SMTP id c16so2211377wmd.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1yJVRUpkJCkFCXxPJWdMlfqsn6ACQjjqqj85gHXl4n4=;
 b=K3HuHFnbdBNph8RO4GPDZeI9mbZnu/2tqe8D8Q3JSRLlLI3hMR4uliDfN6YWqo0d7f
 tkCPhWM2yM7zPo4plelTzsFbeiHC5kKiQT4TEnvGDR380dvYDe1s7nfozlvYPVlFRfmE
 yGGoN0OAuugVNXstIGRNT71QSGypxNp4uSwm+7RT4z60Zp0h2DDbIKPfSy8xuYZMMmLK
 P2nxCQYhaVfhuxyDE1Ch6H54LvljUw0cs/4QG7CPyjGXqCqJy+rwr1wXMAafAlfODEIQ
 e1u2d3ft6asSw0W9Is4lRZqS3hLVyCg2NGB7BRWtxCyYfQfWnH1sUGI3QFV4AjF6b4NA
 l2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1yJVRUpkJCkFCXxPJWdMlfqsn6ACQjjqqj85gHXl4n4=;
 b=mxukIuTLl3YKed51POFRcCXHb/aHpFjabBl1dIVm0kRo0hKoNB4HPPp05l8BDuAiuU
 s5N96bnNlFwaRgUktXWq94IRW+C24UJD0s4HRROvZYLFAdolLbEHHFvyv34gOUlkqZJl
 m39qo3m07W05wqWQt12X42JODfXNcG0xKnrTb0+Cn7TkRrqw0ykfg3TYeDNOG3uv9abd
 VBlDlGuEcoYvRD2S7j1tYp/pLJ+XWHaHYe8p6GztgciMx03pALVPDOoqAx3E1p503qVe
 G32OlHeNA5bprzNIGtYxWyk4h5zgeIExbzbfU15eudCBtPxSMOfPkixdQgNxFVNlun4I
 eMcw==
X-Gm-Message-State: AOAM533jWSvlkbnejiT0DlMOu7TnwEhnNpr7YPDsPxxxj4UVYLTF4F8y
 SiSS7rXr+AEx3TCOb/wwxlg=
X-Google-Smtp-Source: ABdhPJxmp7wdqVg1cz6+Xvjqi9CKa6lk+cK/EejyC3hla/xCDnfkWANM0+EiGNX9PvAsi26aD165rA==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr928099wmx.168.1604687368921; 
 Fri, 06 Nov 2020 10:29:28 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g131sm3558927wma.35.2020.11.06.10.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 10:29:28 -0800 (PST)
Subject: Re: [PATCH for-5.2 3/4] hw/net/can/ctucan_core: Handle big-endian
 hosts
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <51da5abd-bb51-2ee0-d1e8-dd3f0c93e2fa@amsat.org>
Date: Fri, 6 Nov 2020 19:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106171153.32673-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 6:11 PM, Peter Maydell wrote:
> The ctucan driver defines types for its registers which are a union
> of a uint32_t with a struct with bitfields for the individual
> fields within that register. This is a bad idea, because bitfields
> aren't portable. The ctu_can_fd_regs.h header works around the
> most glaring of the portability issues by defining the
> fields in two different orders depending on the setting of the
> __LITTLE_ENDIAN_BITFIELD define. However, in ctucan_core.h this
> is unconditionally set to 1, which is wrong for big-endian hosts.
> 
> Set it only if HOST_WORDS_BIGENDIAN is not set. There is no need
> for a "have we defined it already" guard, because the only place
> that should set it is ctucan_core.h, which has the usual
> double-inclusion guard.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Ideally all that bitfield-using code would be rewritten to use
> extract32 and deposit32 instead, IMHO.
> ---
>  hw/net/can/ctucan_core.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/net/can/ctucan_core.h b/hw/net/can/ctucan_core.h
> index f21cb1c5ec3..bbc09ae0678 100644
> --- a/hw/net/can/ctucan_core.h
> +++ b/hw/net/can/ctucan_core.h
> @@ -31,8 +31,7 @@
>  #include "exec/hwaddr.h"
>  #include "net/can_emu.h"
>  
> -
> -#ifndef __LITTLE_ENDIAN_BITFIELD
> +#ifndef HOST_WORDS_BIGENDIAN
>  #define __LITTLE_ENDIAN_BITFIELD 1
>  #endif

Alternatively s/#ifdef __LITTLE_ENDIAN_BITFIELD/#ifndef
HOST_WORDS_BIGENDIAN/ the codebase and remove this here...

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

