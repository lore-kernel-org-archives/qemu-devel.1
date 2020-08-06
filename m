Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2657C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47AD204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZytDxuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47AD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3djQ-0001MF-D4
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1k3dRN-0001tG-MG
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:05 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:40047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1k3dRM-0007lK-0y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:05 -0400
Received: by mail-lf1-x141.google.com with SMTP id m15so25197963lfp.7
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+F2bvw4279AFpRAqqHr9VWj7UEazWN4PYw+oY2vMYa8=;
 b=FZytDxuwtIQKZP3iyMnkL/T5/O6IjGWF8fDMueWvMixfJVT0mifTHd743Bj5ndEbvF
 Ry3pSxktKyczlATkt3Yt3ovkS/7xygecOfGuZjdmwzIF1ipy2NB6pzZh7ao+//ZmTBdi
 CNueY6UNDJK95eeClCokRBbkY+gs/dvS4CmGuViCqjkLaaAk6CHbcDPe2G0ACzGAQgJk
 e2j0KobbMTFzhGr0tX49nsTraHwHmcfyZkGr3JFEYz5IDfkFrtxpTM5/yJ2kbliylX1/
 6CdNnBknNmq8X/aEHsaa3VyymRzrCUR2fqPcatDBEnKFlg1Ox34Pspo9XJ0SqdLbbNBm
 6rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+F2bvw4279AFpRAqqHr9VWj7UEazWN4PYw+oY2vMYa8=;
 b=j+euW9mFYnriG7u49eOfDotofmMvo5G08D66Aw5UTr86pj9qyjRvTsDMHHvInB/7Ua
 MeoWupRIL6xLRTqYZw58GR5E3WZjSkS4PKG1Cv/opANwNts4ufL09+SyZhugN//prmVv
 PAs6ZxjfRku4P14sG2PbGcFX9wISTH3hejAXrN0fDF0xwPiZoAY61Qg1L99YCKc1ZnAW
 FWfg6JVEFEz94CmFlSig4hijmTOPW38rXvnOW9goIsACkOjv9KZj2RE2/nLdmlQDrFWK
 jtYaBSKv+utzQmMpNuoBqUDi8JpoV26+9pnLSLNMMXHXAQMcGDuqyEAwX3oPYYSTCbky
 DorQ==
X-Gm-Message-State: AOAM532nxDbPglfR7TfE5958HPkQ1v4yISPpYhaBAEWeJnjWp1ojU7+/
 rkY4NILpCxD2gUKOAfjsdhkYERwPRp+BrfiGCcxTtg==
X-Google-Smtp-Source: ABdhPJw3YRS5JPfc1W80PkQQEw6/Xj8PLvezRr9eMiA5H0m5fq09Fro360+A1GEpHIZKK8g2u9ca4vq/md8Y6ToCaw0=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr3576663lfg.194.1596710881135; 
 Thu, 06 Aug 2020 03:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200529072017.2906-1-linus.walleij@linaro.org>
 <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
 <CACRpkdZk-Pv49PyhtrW7ZQo+iebOapVb7L2T_cxh0SpYtcv5Xw@mail.gmail.com>
 <CACRpkdbOiL7=KUNa0==P+H-3SynhMt1=JweCY8ihbEZLK=b78w@mail.gmail.com>
In-Reply-To: <CACRpkdbOiL7=KUNa0==P+H-3SynhMt1=JweCY8ihbEZLK=b78w@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Aug 2020 12:47:49 +0200
Message-ID: <CACRpkdY-w7TD89eRMJQSvhrPC7gxSPYPmMhPO2FUOxtzYRcRsg@mail.gmail.com>
Subject: Re: [PATCH v2] fcntl: Add 32bit filesystem mode
To: "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=linus.walleij@linaro.org; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Linux API <linux-api@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Florian Weimer <fw@deneb.enyo.de>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 19, 2020 at 2:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 6, 2020 at 10:54 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > Ted, can you merge this patch?
> >
> > It seems QEMU is happy and AFICT it uses the approach you want :)
>
> Gentle ping!

Special merge-window ping.

Shall I resend the patch?

Yours,
Linus Walleij

