Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5D3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FBD2075A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 00:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="iM3fVM/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FBD2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3q1x-0002s7-8w
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 20:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3q05-0001Es-4k; Thu, 06 Aug 2020 20:12:45 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3q02-0007Tx-H1; Thu, 06 Aug 2020 20:12:44 -0400
Received: by mail-ej1-x643.google.com with SMTP id kq25so220987ejb.3;
 Thu, 06 Aug 2020 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RdoJ616D1ZAhofYamDE/inbM3292XAH+lYqk5KBRI/k=;
 b=iM3fVM/VZpmBnrNqtY6e7cCQWjRYZ4d5NrxH5+V7vEh4aPpyXQ0AUfmadt9hVT/b+d
 njmbvDjqJasHN2r7ONKkRH6umPWPd5iZE47kCoToeAAO4XW3JItcWtDuHM/WIJ8R6pve
 gY8381F+4Hd3saOd27LdfIYqlHYW8yfgZwW8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RdoJ616D1ZAhofYamDE/inbM3292XAH+lYqk5KBRI/k=;
 b=mwuvtVZKPrRDn1jvC3lU7cQNb+SGuH/hEcdHU33JLkpd1cLt7D6xuT6Gk227O4bjj+
 wEDyR2TJwbcTkivcBovqP1QTza7TE+29iHporyS483YVMDSWj7ZsO+QNCwgi//NA1uPO
 lQraXsTVfP7os4NtnitvgA4HdiT+zDztnxVX+jB3WtPUMobO3avz19niQXL48HSXuZ+b
 NPF0ufxp6s9mquMgY4LRM6rsBML1GVXzflJG2CQutck+RahBeLgoK04c4bR0R220I5gb
 MoXdMiTPkOuanxfpHi3KhU8BGw5Vcpv/VA51iVpoFC6SVSPLL1WwekOFyEUY8WKf+6d3
 kqOg==
X-Gm-Message-State: AOAM531a/vgWRaiM07n32jap8BZUDXkWLfzrYXyVp1c3MkI+18Q+JKeC
 xDqsh5rB6NW61TkOqAyikwBVbhugZ8rw1Kq1l5k=
X-Google-Smtp-Source: ABdhPJxjO63HsExAG92kQJ8SpEJCz9aF3yYI6ogEqgwWRHWLrq7oUostLRG9mCI+rWBBIDRGfEmfmIOhSgndPAPsVbg=
X-Received: by 2002:a17:906:c187:: with SMTP id
 g7mr7122794ejz.108.1596759160503; 
 Thu, 06 Aug 2020 17:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-20-clg@kaod.org>
In-Reply-To: <20200806132106.747414-20-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 7 Aug 2020 00:12:27 +0000
Message-ID: <CACPK8Xc4uGR5OAX=TNmjDdHD7i2mzEkhJVty8tn-Z=g6spBgGw@mail.gmail.com>
Subject: Re: [PATCH for-5.2 19/19] aspeed/smc: Open AHB window of the second
 chip of the AST2600 FMC controller
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> This change works around the HW default values to be able to test the
> tacoma board with -kernel command line option.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Good fix. This was required for Tacoma when we had both flash chips
enabled in the device tree, otherwise Linux would fail to probe the
entire controller leaving it with no rootfs.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/ssi/aspeed_smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 8c79a5552f93..795784e5f364 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -230,7 +230,7 @@ static void aspeed_smc_reg_to_segment(const AspeedSMC=
State *s, uint32_t reg,
>
>  static const AspeedSegments aspeed_segments_ast2600_fmc[] =3D {
>      { 0x0, 128 * MiB }, /* start address is readonly */
> -    { 0x0, 0 }, /* disabled */
> +    { 128 * MiB, 128 * MiB }, /* default is disabled but needed for -ker=
nel */
>      { 0x0, 0 }, /* disabled */
>  };
>
> --
> 2.25.4
>

