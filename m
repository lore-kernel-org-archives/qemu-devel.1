Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE7C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662FF208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662FF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvyG-0002vo-AD
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60816)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlvy5-0002Sn-Jb
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlvy3-0000tR-Jg
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:52:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlvy1-0000nM-Ke
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:52:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so9059614wmg.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gxFnmVrBb75/JlwW3I9edRJQYOFniIvY92lbGjsZ9b8=;
 b=TVrRhWr5NSybtTv66CrduH4zHBSL6CqkjBCqPSYYTJH6H3AWJoxoHZ4/oaNGD/4nsp
 nr7R7iGgfKGPAlTqTgydszQT2tIi49/2mUfjNw9tn5y6WGUQEJ5R3J1knQ7SxSBi/IEE
 2MbqLX/W8uTI7sijx3vxkhCas8URCERvfQdMbRKmSb8DjGL/AsTSnKgepfxyn0yhg/L1
 SGzbpi4k9b2y33kQxbB96gwYQZpXZURFyGgVOxXnWdB9IBRI6g8ZzlHNd02P9iZj+wY7
 MKQjcsPcqTUz7m04JsvtJ0qxuSKGx7mzLDTpYhbsZr+L+FLjkT5awmCpblYQBc3QJsHE
 7DRg==
X-Gm-Message-State: APjAAAUMR4uertLsQe+E3jDP6AT/1HgQOluYZgADqCMWarikAkWnRZO1
 9zMSw0CETFgqIJO2yJwnMtVIqw==
X-Google-Smtp-Source: APXvYqwvAggGVtIYEu3WifXBz1Z36C4k1K97I97GAs03/uTliLPhm9EpmLgNPldRuw59/K7Udy2vCg==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr9605374wmj.71.1562939523414; 
 Fri, 12 Jul 2019 06:52:03 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id x16sm6140940wmj.4.2019.07.12.06.52.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 06:52:02 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1562931470-3700-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1562931470-3700-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <59eb9c50-2452-922b-3154-fb71ddee2edc@redhat.com>
Date: Fri, 12 Jul 2019 15:52:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562931470-3700-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for 4.1 2/4] target/mips: Add missing
 'break' for a case of MTHC0 handling
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
Cc: arikalo@wavecomp.com, sw@weilnetz.de, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 7/12/19 1:37 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This was found by GCC 8.3 static analysis.
> 

I think you can amend:

Fixes: 5fb2dcd1792
Reported-by: Stefan Weil <sw@weilnetz.de>

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 2be5e2d..59d4acd 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -6745,6 +6745,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          default:
>              goto cp0_unimplemented;
>          }
> +        break;
>      case CP0_REGISTER_17:
>          switch (sel) {
>          case 0:
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.

