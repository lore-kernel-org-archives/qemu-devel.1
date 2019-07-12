Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B64C742C2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13911208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13911208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlw2L-00085d-91
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlw2A-0007gZ-Kb
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlw28-0004dN-Pw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:56:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlw28-0004cW-JV
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:56:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so9040337wms.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jZDNHLGecYlYIjEtc4Y2lTIRmqdu0QRb6Bm7b/nuDac=;
 b=IUmAZMy6KptYh2ZXHn0qTvrVz8OE2ra+eIHm3z0rYit+7S6jdt4nKGtw0AE0EuUD/O
 JKluBB3awcIj+50XFqR/UjQqly9bz4nXTiNefVcz133bUDAAU4i07E/ZD9QGTmiW/PYm
 uC9g4ER8AYdNjJ+8Db4oR9QKO2GQDk/jyDIMCMlbKgUQCbExQTgEbxDnJ38aLBJ/oRnm
 O4WLdy50sVRQ8syjEaH4+H7vXwtEoCI4Yl9XTI1Yy5zSd4q4tvjR3ISBy0gbNXI8AEwH
 8ToFaG3goFp07Qq8CIV06psmZIHVXwcbPrLKUtL86sextyk4II/HzRiqWSl2KkE0p5MH
 gDmA==
X-Gm-Message-State: APjAAAVfxb8lUWaMkdLghTBxik+41A7LURnNUyNFowZXMzoE5PYf+q8K
 XxQllqhl+D5Q+X/pnZ0IeFL6Dw==
X-Google-Smtp-Source: APXvYqz+YBKIYeut+rV3vXEHm1w6hJYiY/8GywAbFq7y72GCLdEGnQjiwsbo71t5gAT9IV+Pa2TexQ==
X-Received: by 2002:a1c:a6d3:: with SMTP id p202mr10263131wme.26.1562939778486; 
 Fri, 12 Jul 2019 06:56:18 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o24sm13381699wmh.2.2019.07.12.06.56.17
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 06:56:17 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1562931470-3700-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1562931470-3700-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f8e07873-f5f9-218a-d542-daef5a1c1621@redhat.com>
Date: Fri, 12 Jul 2019 15:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562931470-3700-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH for 4.1 3/4] target/mips: Add missing
 'break' for certain cases of MFTR handling
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

On 7/12/19 1:37 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This was found by GCC 8.3 static analysis.
> 

Again, please amend:

Fixes: ead9360e2fb
Reported-by: Stefan Weil <sw@weilnetz.de>

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 59d4acd..b1cf5f0 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -9826,6 +9826,7 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
>                  gen_mfc0(ctx, t0, rt, sel);
>                  break;
>              }
> +            break;
>          case 12:
>              switch (sel) {
>              case 0:
> @@ -9835,6 +9836,7 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
>                  gen_mfc0(ctx, t0, rt, sel);
>                  break;
>              }
> +            break;
>          case 13:
>              switch (sel) {
>              case 0:
> 

12 years missing...

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

