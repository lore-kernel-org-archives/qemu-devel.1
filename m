Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7052CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B47020674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ37PIR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B47020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jagAv-0007Eo-Fg
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jagAI-0006pN-QD
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:50:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jagAH-0007Pt-P6
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589809844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHIq4Rh+KzB1kdqyC+00aTW9baDYRs/oblOPlt+8JH8=;
 b=CJ37PIR2cVBlKMz1+hPD2+0dBpjc6nptu+dXak+rRSxnMhCPRgDFyv6x8gqUc2P3b5qGoZ
 qlj4rtV1pOhmdnQNhsAA2ThH5/68TzeY3rh4pSogb1rnzc6n7zU6mm6kCsxBAW49cuaikR
 iUtOxAVtefHO9vr8LE1cRJugCZC2HDY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-a-MUph5XPUK1HuCbmxWaCA-1; Mon, 18 May 2020 09:50:43 -0400
X-MC-Unique: a-MUph5XPUK1HuCbmxWaCA-1
Received: by mail-wm1-f71.google.com with SMTP id t62so5465560wmt.7
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 06:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yHIq4Rh+KzB1kdqyC+00aTW9baDYRs/oblOPlt+8JH8=;
 b=n2ZfykifLijhaoy37tg5pJIit2DzcUjnGH4djEfpkYMEsgqgnAn6uXNGvcxzhFXnwo
 WZXLohiLeF/G26/lYkOfqiIxgenqL/f5F6SZs2Np0eXIpzRztlcVBnmXCqfpD9i0hkW0
 3WbmO8woQhVdQ4wsvrqLqBvqM9Bw6qO7Y15BQyVeYNpFgJDj1o2jYGm5e+bZwacYXUOi
 YsWp1rsD7Cvvsq7768N70xhfUdgrnMn7jMxeW7dkaoR4+SCB8p5QXLwYLu44P2j8d3Hy
 wgQyuDQLbxL1vjDU/UwMaJDs1cj4yq9s/F7+bUH9a7ai55zrwc+FNdMXaZw7nT9nam64
 2SdA==
X-Gm-Message-State: AOAM530Lkli9iQARvFD4h6N2gQez7mBp/7VjZb2+aLWxWqB3fP6SGbG8
 nFgpPOcjcWXehne97nGHiWiABiKXPkONT3ZCmgK7XjfbIDTEnc3gOlkrWnPh4xE6+DnMZgRld4U
 5S6wisJjf3I6XdF8=
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr19642575wrw.78.1589809841918; 
 Mon, 18 May 2020 06:50:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVOyRuHO6XN+ZJl2pqJ4xevyKOu4HcJRvX/Z3wB/84AkPmeNV6xi5inxNeBjSry/gXqvtTGg==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr19642562wrw.78.1589809841722; 
 Mon, 18 May 2020 06:50:41 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id j16sm16372292wru.13.2020.05.18.06.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 06:50:40 -0700 (PDT)
Subject: Re: [PATCH] semihosting: remove the pthread include which seems unused
To: konrad@adacore.com, alex.bennee@linaro.org
References: <1589806958-23511-1-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5ab6f370-6725-1cdb-1b82-24a58cb7642e@redhat.com>
Date: Mon, 18 May 2020 15:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1589806958-23511-1-git-send-email-frederic.konrad@adacore.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: frederic.konrad@adacore.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 3:02 PM, konrad@adacore.com wrote:
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> This have been introduced by:
>    8de702cb677c8381fb702cae252d6b69aa4c653b
> 
> It doesn't seem to be used so remove it.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>   hw/semihosting/console.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
> index 6346bd7..22e7827 100644
> --- a/hw/semihosting/console.c
> +++ b/hw/semihosting/console.c
> @@ -23,7 +23,6 @@
>   #include "exec/exec-all.h"
>   #include "qemu/log.h"
>   #include "chardev/char.h"
> -#include <pthread.h>
>   #include "chardev/char-fe.h"
>   #include "sysemu/sysemu.h"
>   #include "qemu/main-loop.h"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


