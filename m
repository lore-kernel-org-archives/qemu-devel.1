Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCF0C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 00:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720582087C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 00:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0dDKT2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720582087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEMX7-0005YZ-8q
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 20:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kEMWY-0004z7-6O; Fri, 04 Sep 2020 20:57:46 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kEMWW-00077L-PX; Fri, 04 Sep 2020 20:57:45 -0400
Received: by mail-oi1-x244.google.com with SMTP id y6so8209871oie.5;
 Fri, 04 Sep 2020 17:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pq3IydyVl7elgApy6N8WV2urw9Pb7iv2Q/GZzZ4Wprk=;
 b=m0dDKT2y0i1v1ap8gzg9Nr/irji2zScGYs+dIuOa9f0f6sxBmPiQ3epjAjKRs78A2o
 cL5i1DYsFhFjXZMffZgTo0n6tH9gxXg38BwxiLCUrGO53mX9Qi7n0AeHLvjsTB9dwwwA
 IkOhqp6wBV2zJ9lFWtJg0FkLB6y6WHlzGWeVoHlzGhtpGQVe+C/hgfu9UnzsogGjz32B
 RQaZpY9rx3byMofwZEFSiWRZaj0wGNdR8ZXvnM2fKsIxsgNESPWDCjSaw4OTJw9055zB
 jGBKu9LUBXGsiAIz/r3jRzgQXl7Ixy4mm6yeX2e+K8LkzBhOI0Et9KkU+nXl98A2ZSmx
 asyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pq3IydyVl7elgApy6N8WV2urw9Pb7iv2Q/GZzZ4Wprk=;
 b=CvKRdi76MlZgjwjkaYTlwp1NPQaEveXwSfA2RVZ994cKcEeQj6anRbMyf9nOfTYbCs
 T3bHdb2ekb63bA0rsa6YD5rChXz1FBi2rvZPwCG6bt91LjFB+cQwqSKQshD6dWF0tYNK
 RHQ4Z4IE0LMrWWXo6UMBfHXyEk9lIl1LwBy+/pL4dDgwy8WtR06Ipz73a9K8Rhl3JYlm
 bMFjqJbr5Yqke2T6X5KU5iNg/eFO7Ejw+mGL6BJfO6qKwy8lnIIvCu3zJoWRC4Tqbgkg
 XXJz3e4Kirlif9sueHb2RZMzVthkHnGiKjekGAcZmIoWJDXuLc5xt2PN/HjldClSCvCB
 IHgA==
X-Gm-Message-State: AOAM530FFXt8QDM7ivfwRSGo1yptPx+5K1ZOXNV6hGJ/bl5koBJuCyml
 2vUS4kUlibukDopNNmQmhNPHbXgi+EKv9Qtv7Us=
X-Google-Smtp-Source: ABdhPJzH+I3FcaveCU4mH3MC9K+bkvxPmST6AkIUZlGFJ/MbPkqA5b0ql53hKEfpSZihfijgimoXt8b80L9kKg5IM/I=
X-Received: by 2002:aca:1117:: with SMTP id 23mr6980636oir.97.1599267463252;
 Fri, 04 Sep 2020 17:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200904131402.590055-1-f4bug@amsat.org>
 <20200904131402.590055-2-f4bug@amsat.org>
In-Reply-To: <20200904131402.590055-2-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 5 Sep 2020 08:57:07 +0800
Message-ID: <CAKXe6SKbRVsgi8DRd-NzuAnPbFFF130-mcN=+zxRqaZgDB2zJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/e1000e: Remove overwritten read handler for
 STATUS register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:14=E5=86=99=E9=81=93=EF=
=BC=9A
>
> The STATUS register readop handler is initialized first with
> the generic e1000e_mac_readreg() handler:
>
>   2861 #define e1000e_getreg(x)    [x] =3D e1000e_mac_readreg
>   2862 typedef uint32_t (*readops)(E1000ECore *, int);
>   2863 static const readops e1000e_macreg_readops[] =3D {
>   ....
>   2919     e1000e_getreg(STATUS),
>
> Then overwritten with the specific e1000e_get_status handler:
>
>   3018     [STATUS]  =3D e1000e_get_status,
>
> To avoid confusion, remove the overwritten initialization.
>
> 6f3fbe4ed0 ("net: Introduce e1000e device emulation")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/net/e1000e_core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index bcd186cac52..5170e6a4563 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2916,7 +2916,6 @@ static const readops e1000e_macreg_readops[] =3D {
>      e1000e_getreg(TSYNCRXCTL),
>      e1000e_getreg(TDH),
>      e1000e_getreg(LEDCTL),
> -    e1000e_getreg(STATUS),
>      e1000e_getreg(TCTL),
>      e1000e_getreg(TDBAL),
>      e1000e_getreg(TDLEN),
> --
> 2.26.2
>
>

