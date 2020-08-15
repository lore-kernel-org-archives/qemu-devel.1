Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19149C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C9E23102
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCzJqenv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C9E23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6z6E-0007AE-0t
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6z4o-0006Jv-FW; Sat, 15 Aug 2020 12:30:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6z4n-0005QG-0Y; Sat, 15 Aug 2020 12:30:38 -0400
Received: by mail-oi1-x243.google.com with SMTP id z22so11001101oid.1;
 Sat, 15 Aug 2020 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=So1m/CQpgJE8oIUdFCwbc+hiP/OZYh6ibudoP8u5D9I=;
 b=UCzJqenvC+PgihmW1jn6ZoUS+ogucGCeKLg+x81tH0jL0qC6EqA8ivq9uziN2udh0b
 5XxC/dzAMEZJoxjig06BqDGHkkXpZVJGGz1fsp5w6jovVIULRNZjCXx2AjdebqQF/Wcy
 pHaPzUmxC2FuK1ORzbxaok12YPLUxEV/LZ3c4dR7pvfbF9KtArBNEyU6LxCbFv9sfQ+f
 6KObcQSsfSQclDzN4TRbFIpfsIBlBYlBUUu98SCXWW2PuerLX6uRa/VN6DGEAl6p6tKd
 J/gU0f9rrOQz5mJbjZe23Xoi8TMEDkwdi6M0DlRAqguDrRYK6//QbOe8K6SeFNZdgvI5
 plAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=So1m/CQpgJE8oIUdFCwbc+hiP/OZYh6ibudoP8u5D9I=;
 b=ndoW8PWM2oO+AkFystAoWYe2ffp0jBelTOd+Zuxu8A1mvka52Njf3AMYp5awz7s0zp
 RfhPwylIO6NhI+Qp6fPbkGrZHDamPwTXB6hDuyqZhwgHubZbmoa3T6qwsCr0LsQeMl1T
 0p7z2axAzU0pVtBsSb0OCukpLPMklXOa+3mIgCe3HRxmD4YbcZsSZ3zz2Iu81CsR3uLq
 kMXDbsjeH2Yllx6i2WRAqDu9jf+GMjFPigvnpuYPrYZpHmgxvb+IXhD/UsrTEHk1qvhY
 BnyNQMhq0Z7C+tqzo/AjsiyVeROwCnmkICKG5+a6nAWVmln0Wx53lTW6+Qle/BhKjMqc
 Le8A==
X-Gm-Message-State: AOAM532LPpq1yaRVleJPIHjypS8eymZ/leDgUuM6jsxKPaGrHAoz3qH+
 Z7wZUbrC5enS+camFeXPmtKx4t7/+aPtT7Ou5R59gaf/Z2I=
X-Google-Smtp-Source: ABdhPJw3AL7SLiktmxetz4Dbdwi/r9N1u9uNuROjELQO+raN1Bas6l4dEgbeDsbqXuHBwaWeUJhlYp5OEOFjp37lt54=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr3589966oif.56.1597461748500; 
 Fri, 14 Aug 2020 20:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-5-f4bug@amsat.org>
In-Reply-To: <20200814082841.27000-5-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 15 Aug 2020 11:21:52 +0800
Message-ID: <CAKXe6SKa0H7umV+=2p_Sq_6m1HOAQsHO9hNxKgUOKa--LZt9RQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] hw/ide/ahci: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B48=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:31=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Use self-explicit definitions instead of magic '512' value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/ide/ahci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 009120f88b..b696c6291a 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1151,7 +1151,7 @@ static void process_ncq_command(AHCIState *s, int p=
ort, uint8_t *cmd_fis,
>      if (!ncq_tfs->sector_count) {
>          ncq_tfs->sector_count =3D 0x10000;
>      }
> -    size =3D ncq_tfs->sector_count * 512;
> +    size =3D ncq_tfs->sector_count * BDRV_SECTOR_SIZE;
>      ahci_populate_sglist(ad, &ncq_tfs->sglist, ncq_tfs->cmdh, size, 0);
>
>      if (ncq_tfs->sglist.size < size) {
> @@ -1703,7 +1703,8 @@ static int ahci_state_post_load(void *opaque, int v=
ersion_id)
>                  return -1;
>              }
>              ahci_populate_sglist(ncq_tfs->drive, &ncq_tfs->sglist,
> -                                 ncq_tfs->cmdh, ncq_tfs->sector_count * =
512,
> +                                 ncq_tfs->cmdh,
> +                                 ncq_tfs->sector_count * BDRV_SECTOR_SIZ=
E,
>                                   0);
>              if (ncq_tfs->sector_count !=3D ncq_tfs->sglist.size >> 9) {
>                  return -1;
> --
> 2.21.3
>
>

