Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCED2C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D9721882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8FwQ54D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D9721882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSigG-0006dK-6Y
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSidb-00056t-Sg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSidF-000802-QY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:19:51 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSidF-0007yC-J4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:19:29 -0500
Received: by mail-wr1-x442.google.com with SMTP id i10so3210747wrs.7
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L2AX6rOA6Deu/BUv+P6FJ06EFiLcPyHKUC/DSSMAG7w=;
 b=F8FwQ54D3L+T14ydI0T9CI8mlSI9320A3XlrMx0wL4E374XTy/gLjWaDuQhrydE+AM
 e9yIAOn759Sz39mLMp5c5jBapq6aUOTBKS1BZNH0/9xI3Et5lpg5JjGyq2S/eWXoSGLl
 cQ8MDkhUpzwu5ra/3DY1zwNqfdy1yk4SY093vzh6gjAuPmLCNzw1uVfqKGnFPkxIycoF
 cKsPi/TCUnvr6hww3Od+jz7nlJlfWYDZ9A13TCwi8kzM8PsPflVqyUmlmin5koepPUnZ
 XtEX5KnTECGLakEhuh4n7+ybI+c0Kc7+Llxroayhveh8+6/wpPgstBP2rkpGgJr3q/+R
 JugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L2AX6rOA6Deu/BUv+P6FJ06EFiLcPyHKUC/DSSMAG7w=;
 b=fx/M2sffpS14IjdVKFdfUBvpFX7ZDgIjDNnRE0LqiBs/u+jqtX2GbYtA2O3W6+2WZU
 qB5jNLFmMzXtwY7kHzMFIrO35mYggUWycbpGDB4NN7L+D4qaLLXPqMAgPj5rq7xQiu4z
 qaibTYixEa91beSBWmWI1VEYIzNLJmq1jIGoAAixRqECWVbeceDoPJefzwUHUYLNhrd1
 dgKJ8ftySM/ANAUtX2SvKtLvbseehJMy8cthzHzq922P96b5OmFXOLyX0had4IwzWief
 65Iw6jmacbgBgNZP01eAj6MhSneiPE6VFQyetzqeHvx3dsAHmYB/GIrNh5hGz9owB0HW
 Wfqg==
X-Gm-Message-State: APjAAAVxFpdmG8AMhgwyZmphsnQK7nm02Y4Cv9x14UAwBHyFNk8q/Sjn
 PiSPawmDariM0gMoADuSLh0i9Q==
X-Google-Smtp-Source: APXvYqy728D3vY+s9q/bjvTQgyQNWXCo9D8lzuWmyG1UjPhUn/RkkPSjUNBg6zTEu8MsRI0h6NfyPQ==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr3075881wre.11.1573136364472;
 Thu, 07 Nov 2019 06:19:24 -0800 (PST)
Received: from [192.168.8.102] (141.red-79-149-50.dynamicip.rima-tde.net.
 [79.149.50.141])
 by smtp.gmail.com with ESMTPSA id h8sm3370341wrc.73.2019.11.07.06.19.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2019 06:19:23 -0800 (PST)
Subject: Re: [PATCH v1 1/3] target/microblaze: Plug temp leaks for loads/stores
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-2-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3ee495ba-a88c-c81a-92e9-d5ad5d88022e@linaro.org>
Date: Thu, 7 Nov 2019 15:19:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 3:14 PM, Edgar E. Iglesias wrote:
> @@ -967,12 +967,14 @@ static void dec_load(DisasContext *dc)
>                     10 -> 10
>                     11 -> 00 */
>                  TCGv low = tcg_temp_new();
> +                TCGv t3 = tcg_const_tl(3);
>  
>                  tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_sub_tl(low, t3, low);
>                  tcg_gen_andi_tl(addr, addr, ~3);
>                  tcg_gen_or_tl(addr, addr, low);
>                  tcg_temp_free(low);
> +                tcg_temp_free(t3);
>                  break;

While Luc correctly notes that tcg_gen_subfi_tl() may be used here, I will note
(1) there's a typo in the comment (not 2->2, but 2->1), and (2) that this whole
section can be done with

	tcg_gen_xori_tl(addr, addr, 3);

Similarly in dec_store.

The other changes in this patch around gen_helper_memalign are ok.


r~

