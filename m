Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61BAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F8F2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWbY7ykC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F8F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizNO-0008Np-Um
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jizJl-0002eh-NG; Wed, 10 Jun 2020 07:54:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36807)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jizJk-0001uo-Od; Wed, 10 Jun 2020 07:54:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id d128so1565901wmc.1;
 Wed, 10 Jun 2020 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VAo7lOQcnoD1c9i2OtR9EY/ZBmtoYESYiQio2kxfj5U=;
 b=XWbY7ykCtJjH+dJe425i6AaYSoQWix2O+ra4fAm3MSJHBYvDqFU0ushmonEiX2UduW
 ckVqa3wvuirqFMCQibNWzg+EZW5+O13N2RudsNyZcFNeAuHz8gTbS4dQS4mQN2beP/Gr
 ZIzDykASUBtA7zOeFOjzQNfG5Dh2XxyXwgfQlVEHPAvGtCPGeAlzvzenxxaap+5w1R8k
 OJpVKUOMXXLUmsK0wJHDVZBXxOrFap3S8+WVGlcmns68raSE7Yf+BmBPplaxTlrPT/om
 aWaTdB1jtlANxyHdT/miFsqDpxO+R6Vy4lC3qNKqMH8HOyB0fcKsTAIAE8MWISqhc0pq
 7A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VAo7lOQcnoD1c9i2OtR9EY/ZBmtoYESYiQio2kxfj5U=;
 b=M5J/NPIxFVSpKDr+SBk0isGwH2cuj83WG86iYj+r1TKUVYvIxkNgkOc3qLFyiKrFpZ
 gn1f5ZuI6RY/1ByzGuXOUmNQrlM+zvn3kwC/lZmApYWbXUqpt/K3UDhom+P9vXxLbmlj
 jjqn5EjkEeZ9nt5DvVKSJi7PJKDJLNJ+7l3jqQhpolKlxl/YrabjjTmAkaniqLwdFj5k
 vhDKNvz/S+EHVbSNVfIv4VCP2p0PcPe71P+5TVTBGNeKVCxRdCecCyMuKtakyoFKTSxM
 4AmSuAfAIKb4v5WNJwCSudZf5Y1sTN9sTCESuLYaIUO/28ln4XTm3lnSwrdtxSRWQvjE
 ttFA==
X-Gm-Message-State: AOAM531r/pO2VOZTUK+QLsSD5So7dmKjEuVGKEySqlhZSGLt53Lcoqvk
 lJWiXO85wcpOhEbCplYajvsWKQTPBcwgBz9SR+g=
X-Google-Smtp-Source: ABdhPJwofCQlJ8ibOgq7e4YB7Cq1+Ie/y6GitKTg2FKl/8TELspsgRbVJwdUN4M8gLo8RBDqLzm8xQTp8KO+MyF//rI=
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr2738986wmf.129.1591790090548; 
 Wed, 10 Jun 2020 04:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-3-f4bug@amsat.org>
In-Reply-To: <20200608090142.6793-3-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 10 Jun 2020 13:54:38 +0200
Message-ID: <CAHiYmc4ucHtgwfEs5aXLC5MAiLs01c32W0eBFFQK4zeZRGqnwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] MAINTAINERS: Mark SH4 based R2D & Shix machines
 orphan
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 8. =D1=98=D1=83=D0=BD 2020. =D1=83 11:03 Philippe Mathi=
eu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Last commit from Magnus Damm is fc8e320ef583, which date is
> Fri Nov 13 2009.  As nobody else seems to care about the patches
> posted [*] related to the R2D and Shix machines, mark them orphan.
>
> Many thanks to Magnus for his substantial contributions to QEMU,
> and for introducing these SH4 based machine!
>
> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08519.html
>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

I think, regarding both patches 1 and 2 of this series, we just got
overly complicated.

I suggest simple replacement of Aurelien's and Magnus' name with
Yoshimori's, with possible exception of addition of the line:

+F: include/hw/sh4/sh_intc.h

And that's it!

And let's finish this unpleasant episode!

Regards,
Aleksandar

P.S. I now expect that Thomas will complain about my usage of the
words "unpleasant" and "overly".

>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49d90c70de..a012d9b74e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1250,14 +1250,15 @@ SH4 Machines
>  ------------
>  R2D
>  M: Magnus Damm <magnus.damm@gmail.com>
> -S: Maintained
> +S: Orphan
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
>  F: hw/timer/sh_timer.c
> +F: include/hw/sh4/sh_intc.h
>
>  Shix
>  M: Magnus Damm <magnus.damm@gmail.com>
> -S: Odd Fixes
> +S: Orphan
>  F: hw/sh4/shix.c
>
>  SPARC Machines
> --
> 2.21.3
>
>

