Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62216C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C032224E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/Q5vzhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C032224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka36Q-00058Y-Ov
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka35k-0004Hl-SJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:39:44 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka35j-00080p-4q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:39:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id p19so642133wmg.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=731nbpDzL46XWxcn0W5zxb1I4Xn5tiF4s3jzcSjxqYY=;
 b=O/Q5vzhCxwfxjWlcstJhNrSfjKEO+tGQjSGGVidqsuX0ht/qLWYkNUUrEEJ1L1R4zP
 Oz1GCfWWBWt4daDZVS6SO54KRxLPrnJkCwh4EC2EDM9onLi2ym83OAMSH5KwwlZhCqSv
 yYQg190C5WKL6dMq7EHOJNiolXV6hC7Zjz92VUl71px9t+w5k9fGLFYkNMXCzsTSi+n6
 DGIcNvN0qDmamNRDSZvk3lcxfNg08nWVeL4RTHb50Qt+yMcC6YFxozKgnlVz8TOMMn/m
 WoJ5rJNZmAgOSmYGd4LxQIsL3uqz1DHKcIgRerDy+T9k2Zp6Y1YVJxVta3IDJ4K/DTUw
 vtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=731nbpDzL46XWxcn0W5zxb1I4Xn5tiF4s3jzcSjxqYY=;
 b=UOle9SsivYQIuYuESs33D8j76HLGC83rqz5bDDri055K04A2ndyRZElrXMD5S/VV5s
 YhF2IGSEl8cH9BRv+KiesNohaEkQEt6/2Z8tO/MkEL6nz5r6vn+U2je/AjU60GM4TmO4
 C+IGgkEC42R92QsgDX2cazLn8UpcIdTyI8NvUZ9I2JIGzBgQPi+G3vEgoC/hgpGqvN8k
 aX0hwia2iLiXrQJacjyAAGolp53Nx5cBRmr+ZNk7LEpADHJM1MiY0DcJ4AQS/rb/+mUA
 h624Semyrp/l198U1V2gdjkvo2P3H6QKbc4Xtzhwh5kLIWSSDR+dNCn4Iy2yl8KPrjuU
 BOZQ==
X-Gm-Message-State: AOAM533wUpX6ieoIBVkp/fobwisGJHrBrww0VXH5EZwdLaQExcDpqPKF
 q0gYPi7xVIMXHJ2zdf4PrF0=
X-Google-Smtp-Source: ABdhPJwFL4rR6VqRJc2zRgAuY7s7navVQTg2tvSJYrcAa7jGpR0JXhGgHDPHtudjPpQ941pG8N4NTw==
X-Received: by 2002:a1c:5545:: with SMTP id j66mr1026355wmb.31.1604435981609; 
 Tue, 03 Nov 2020 12:39:41 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g23sm4003730wmh.21.2020.11.03.12.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:39:40 -0800 (PST)
Subject: Re: [PATCH v1 1/1] linux-user/syscall: Fix missing
 target_to_host_timespec64() check
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu
References: <cad74fae734d2562746b94acd9c34b00081c89bf.1604432881.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4a00c12b-4357-8dc0-0cb0-e3e70b2fab04@amsat.org>
Date: Tue, 3 Nov 2020 21:39:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cad74fae734d2562746b94acd9c34b00081c89bf.1604432881.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 8:48 PM, Alistair Francis wrote:
> Coverity pointed out (CID 1432339) that target_to_host_timespec64() can
> fail with -TARGET_EFAULT but we never check the return value. This patch
> checks the return value and handles the error.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 6fef8181e7..3160a9ba06 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7592,7 +7592,9 @@ static int do_futex_time64(target_ulong uaddr, int op, int val, target_ulong tim
>      case FUTEX_WAIT_BITSET:
>          if (timeout) {
>              pts = &ts;
> -            target_to_host_timespec64(pts, timeout);
> +            if (target_to_host_timespec64(pts, timeout)) {
> +                return -TARGET_EFAULT;
> +            }
>          } else {
>              pts = NULL;
>          }
> 


