Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6668DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB96205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8SyS4cL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB96205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEKo-0006Q3-EH
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEJs-00054L-7e; Thu, 14 May 2020 09:54:40 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEJq-0008Cn-OL; Thu, 14 May 2020 09:54:39 -0400
Received: by mail-lj1-x243.google.com with SMTP id f18so3568323lja.13;
 Thu, 14 May 2020 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iO3sxqa6uRbK6tbM9gvYcV5wCzXYGAcL3OcFmKTeXU8=;
 b=L8SyS4cLvHZ32MAPdS91cLeNrTFXVTVEeGLdkGX+yFPuuVqbLsSq/n+bVw66x/m//v
 +lUDWWsT6hFoHEGmraMtnnZI9tDSKX3aSHxJdvTeRfKTUB1qkW/GHUnMW3KGMuuoMI5v
 7/pl0DLIs9YB0lKXMcyK4HtJZ5EzqLCoKGndirAVw4fDWWEU3u51+3loilhTI7s16zy/
 XsA5+87uKhfs66cQGjqNUFTKx/ehte3x1tiSLVL00N2Q/jh0ZVOIMPxBTi3Hpjd5maBX
 25pRyTRcBfp5Q2/DU1/krj0K576UUMcPy11QGp6fhwwhVBhdq1GkzB+pCDZ/BhlIJaq/
 cBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iO3sxqa6uRbK6tbM9gvYcV5wCzXYGAcL3OcFmKTeXU8=;
 b=jQIqYU0VagXp5nQHmD3rT8rjRn7rDenzEldKM4VPyrgLuK3Ysp5DcOtJOrbUFSUmwh
 bBBS7DvwNPqt6jox17oT7gBC8LOTnHTPKlFMWzAjkd5F7h2Znk/9omuscAvozgl3aJXh
 u/aHynPh2c1EHYfZISFn15ctvFcYPzX/9FmUjuSXgU/A2zvK/tqeMhzETdoRJJ5DEHzj
 sUVjbARAvczZcmV/LXZzOCJNqJvEpc70jos4F7dRb/54wh1cAthIHPIV1VQ6sF97gCM8
 XrTFaaMkZbiGQEs1cZO7CB2sNn3bM1TJHTH4s3mFT8jKTSTWLpnGND6HfNIdDvlxSNY/
 JHww==
X-Gm-Message-State: AOAM530ph48nuKE7J2PeoXNZutYkCyrbQ4u8gJ2znqrYpMAWdIFyNZ3l
 R3TJKt8snrXRsdYNJubCe50=
X-Google-Smtp-Source: ABdhPJxoDJa79M7EzM6PpUhWgH6/VWV5hdQTK0WSFsj+FKLKF+Cs9aB2oXOSHUkH4N8UGEGxdZ+RlA==
X-Received: by 2002:a2e:8590:: with SMTP id b16mr2994989lji.45.1589464476110; 
 Thu, 14 May 2020 06:54:36 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id i11sm1941877ljg.9.2020.05.14.06.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 06:54:35 -0700 (PDT)
Date: Thu, 14 May 2020 15:54:18 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/5] docs/system: Add 'Arm' to the Integrator/CP document
 title
Message-ID: <20200514135418.GW5519@toto>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507151819.28444-2-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 07, 2020 at 04:18:15PM +0100, Peter Maydell wrote:
> Add 'Arm' to the Integrator/CP document title, for consistency with
> the titling of the other documentation of Arm devboard models
> (versatile, realview).

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/integratorcp.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/arm/integratorcp.rst b/docs/system/arm/integratorcp.rst
> index e6f050f602b..594438008e4 100644
> --- a/docs/system/arm/integratorcp.rst
> +++ b/docs/system/arm/integratorcp.rst
> @@ -1,5 +1,5 @@
> -Integrator/CP (``integratorcp``)
> -================================
> +Arm Integrator/CP (``integratorcp``)
> +====================================
>  
>  The Arm Integrator/CP board is emulated with the following devices:
>  
> -- 
> 2.20.1
> 
> 

