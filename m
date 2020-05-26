Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19F7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB3F2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv0b/2o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB3F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUEq-0003Wh-Hz
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUE3-0002aQ-P9
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:42:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUE3-0008AO-41
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:42:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id j198so4429488wmj.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cwC1UOjS4ENWExUN2SZCKDvXLvnmL+UfNuMTkYmQgKg=;
 b=iv0b/2o88KVcIXPV+1hL09ZkZrHjN9FzYV1t24th25aG+SgcddcGaI+Gxk+c14U4O3
 N92xMISXwwoazHtDuxT+UK+ct49zKH9WKn+asrJiLUFNcLerL+xbfgPrxN6AynwZOrNQ
 47Uq23ECP2XIolkUKKnDDACLTgK4MvTw9JveanW16hxXqJdjF0urPgnbIS/el+VoUTVp
 5pzEVQKa/lIYMHXftVXq69ULrL7dNVz2me0WpQGH9Fs/JVK93DJfCXX0FYZR15Rq+lxI
 xbGz5RbN9PpZzaQWIBGxS2SQHo1JXiDTti+BG4YHo6Dm5mpwHMEgJkAoV2bR2kY6zH+1
 IHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cwC1UOjS4ENWExUN2SZCKDvXLvnmL+UfNuMTkYmQgKg=;
 b=I/fdJU/fPB5JKnhy5QqNoQlux3NA2YXeeQgmU1PZBXbbXrxjjEDBeZfZwBo9JCibon
 il6MI0csBSCW3tscqMfK4nDQyE1CMh/njWaT+PqX7juj69oa07+1tWTxNSgbdrTEt4OT
 f5GYUXBB98Pjpjb17PVeolrLQZX+iFF7QJ+98pyr71acjkdINAFtYZIwK9iERg5/ojyA
 2N4B3Ckxceiy684/r4dxdPWJx5wRkktazjEJ/Wov0SMzcnU4o6bdrwlnNOXzn14vYbt/
 OQtzqEzoV6PQd+c/3LMaOaWLyeWOpxmrViT918GfXJMMJvbNKXDngSL+wxuk3fi9ry7Y
 YdJA==
X-Gm-Message-State: AOAM530nQqiPCmEQeyjrnBAhDR/o/DZjCY8BDhkH9sF9D2xTB3m0RVrl
 h/a+yQt+KP6VRp+gxmVWakQ=
X-Google-Smtp-Source: ABdhPJxX8zGRNVZKfBijr+gdmu/5hxI+0cL4KcJBakq6VefKCSPshGOHHD+31Jqrt6p7dIO/dh70gg==
X-Received: by 2002:a1c:2013:: with SMTP id g19mr88830wmg.143.1590478933362;
 Tue, 26 May 2020 00:42:13 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id x17sm20570423wrp.71.2020.05.26.00.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:42:12 -0700 (PDT)
Subject: Re: [PATCH v6 20/21] hw/mips: Add some logging for bad register
 offset cases
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
 <20200518200920.17344-21-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dba8f844-e28a-bd13-9655-75f8004ad21f@amsat.org>
Date: Tue, 26 May 2020 09:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518200920.17344-21-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: aleksandar.rikalo@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 10:09 PM, Aleksandar Markovic wrote:
> Log the cases where a guest attempts read or write using bad
> register offset.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Not well tested apparently, because it doesn't build with GCC 5.4.0
(Ubuntu):

hw/mips/malta.c: In function ‘malta_fpga_read’:
hw/mips/malta.c:430:85: error: format ‘%x’ expects argument of type
‘unsigned int’, but argument 2 has type ‘hwaddr {aka long unsigned int}’
[-Werror=format=]
hw/mips/malta.c: In function ‘malta_fpga_write’:
hw/mips/malta.c:517:85: error: format ‘%x’ expects argument of type
‘unsigned int’, but argument 2 has type ‘hwaddr {aka long unsigned int}’
[-Werror=format=]
cc1: all warnings being treated as errors

I amended this snippet ...:

-- >8 --
@@ -428,8 +428,8 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr
addr,

     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "malta_fpga_read: Bad register offset 0x"
-                      TARGET_FMT_lx "\n", addr);
+                      "malta_fpga_read: Bad register addr
0x%"HWADDR_PRIX"\n",
+                      addr);
         break;
     }
     return val;
@@ -515,8 +515,8 @@ static void malta_fpga_write(void *opaque, hwaddr addr,

     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "malta_fpga_write: Bad register offset 0x"
-                      TARGET_FMT_lx "\n", addr);
+                      "malta_fpga_write: Bad register addr
0x%"HWADDR_PRIX"\n",
+                      addr);
         break;
     }
 }
---

... and queued to mips-next,

Thanks,

Phil.

> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  hw/mips/mips_malta.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index e4c4de1b4e..88869b828e 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
>          break;
>  
>      default:
> -#if 0
> -        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
> -               addr);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "malta_fpga_read: Bad register offset 0x"
> +                      TARGET_FMT_lx "\n", addr);
>          break;
>      }
>      return val;
> @@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
>          break;
>  
>      default:
> -#if 0
> -        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
> -               addr);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "malta_fpga_write: Bad register offset 0x"
> +                      TARGET_FMT_lx "\n", addr);
>          break;
>      }
>  }
> 

