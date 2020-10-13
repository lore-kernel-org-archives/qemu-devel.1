Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A874C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6FE208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGBNX7oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6FE208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQCi-0000Xe-Tx
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQBp-0008UY-8P; Tue, 13 Oct 2020 15:42:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQBn-0002bz-Q6; Tue, 13 Oct 2020 15:42:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so980115wma.4;
 Tue, 13 Oct 2020 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zsXmAvnfkQETc8sVboNjaVziLCDUeIESwvOimu3F67Q=;
 b=rGBNX7oQnJMsGnwgubOA6lCWIdXeayBxw0qS3lVS0xeOeMOdFv21TX17Bd3uX8skPN
 IcF4785AYtUURcvNUytus/D7RSxuhykV9k5NEjKndKggcf5LQxebZidOpvam51eKfV8p
 jRQlH6ikdpupjjOb2ngWHuGA8S6S+iItgINfu6T4M+/d/zaLxX0y+crkpvT64o6W3TKx
 +WFOXUsJqZ16fyJ2alLSNgYLJOvd70bF1G1+VY7Jvd/8tZirwjjeJbI8I+EeYF1TEUA4
 CJhS7jqzdb/nF2YQm0ADdrQHFIpHHs6sAXXF0NIx5ayxrN1J9+ArEU/QDXH9tNVI9ShZ
 /Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zsXmAvnfkQETc8sVboNjaVziLCDUeIESwvOimu3F67Q=;
 b=TuqTC82UR9zg3wrK9UktENZOzZqWcYYD0yw3ZL0d03pmdgSzyJCgZt218QcGzxLjr9
 SV8hedBbJ2A1ll0qbftqGnSdBauq7+uvyMSONcGbzLanN2n+ZoyRhiTBxjqnvVTy2R3h
 ZrXDPzZct3GnhXUo52HCMoOsN38kEm/TRgfqLjDPzYZ94fhCBNhiBDtyDa3Edzrnk7ws
 eEmEdiY3dE6WpsU+dO0nv0A93SKIUo1OsX8pz+LarCjwTYpMJRISM56ixVNNnu52XkBl
 SGwWH2vIFBrf5ZMZD7VPfumf8ZFxJWwOSjTqd0VlX1cCTY8gopcMG0QxBMX4/N3GcnHt
 4HbA==
X-Gm-Message-State: AOAM533A8dKrO+0yunA9Oy+zl2tEhQu/WShUBDBBgVgDftXZNRWdbZZe
 3KtwYG5uLMlByRSb5FkEz5deOoDB7/s=
X-Google-Smtp-Source: ABdhPJyg92VCCOgi1aoXffqAJxLDW22lXZd/vM1RgR//XV4BAosQLJv5R9pMm6L77cgSTJs2QhH0Yw==
X-Received: by 2002:a1c:e1d7:: with SMTP id y206mr1381687wmg.48.1602618145287; 
 Tue, 13 Oct 2020 12:42:25 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h16sm856555wre.87.2020.10.13.12.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 12:42:24 -0700 (PDT)
Subject: Re: [PATCH] target/riscv: Fix implementation of HLVX.WU instruction
To: Georg Kotheimer <georg.kotheimer@kernkonzept.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
References: <20201013172223.443645-1-georg.kotheimer@kernkonzept.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ab7cb33b-e650-2ce8-8b04-f984accb9eb3@amsat.org>
Date: Tue, 13 Oct 2020 21:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013172223.443645-1-georg.kotheimer@kernkonzept.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 7:22 PM, Georg Kotheimer wrote:
> The HLVX.WU instruction is supposed to read a machine word,
> but prior to this change it read a byte instead.
> 

Fixes: 8c5362acb57 ("target/riscv: Allow generating hlv/hlvx/hsv 
instructions")
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
> ---
>   target/riscv/op_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 9b9ada45a9..3b7bd6ee88 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -334,12 +334,12 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
>           riscv_cpu_set_two_stage_lookup(env, true);
>   
>           switch (memop) {
> -        case MO_TEUL:
> -            pte = cpu_ldub_data_ra(env, address, GETPC());
> -            break;
>           case MO_TEUW:
>               pte = cpu_lduw_data_ra(env, address, GETPC());
>               break;
> +        case MO_TEUL:
> +            pte = cpu_ldl_data_ra(env, address, GETPC());
> +            break;
>           default:
>               g_assert_not_reached();
>           }
> 


