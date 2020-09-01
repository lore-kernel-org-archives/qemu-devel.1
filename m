Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB646C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A13C2071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzbwqDGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A13C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3e0-0001uk-H9
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kD3dS-0001MC-Fa; Tue, 01 Sep 2020 06:35:30 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kD3dQ-00018U-QX; Tue, 01 Sep 2020 06:35:30 -0400
Received: by mail-oi1-x242.google.com with SMTP id x14so698296oic.9;
 Tue, 01 Sep 2020 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fLeiC+kPycHsrk+GI43WqCwlCZLc+UNBu9ek2UxoDKE=;
 b=JzbwqDGoFiT+YRhLCYUbhsDwblWfzpxES2R8s+WC6wLtT62xYLWyx+gcSJnjV+qKi9
 iEhvQATE5GUNL/dHiSy+ZDTGlJdPBNYaODt2VdL4ytpufVyp5nEgDtKHQWtbvLtum6IB
 6AeXR4PmXVXGGoSFFWAEbX34+ZU5ulePyca8b0jwPT7zwpKtr9BcAth7Y0Mw7KxfnbYw
 oQs0TWyNevMhWW+glsID6E0eHqArfvihp4rvUIN0NJp0saw58JtE4UOB7qUVnn+S9s4j
 qJBrr3idEGaGMR/RAxYvaAUlrO5J0aq7sQBdfFpgND7H0WBPXzS4cyHCB5TSmafzn/bs
 wbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fLeiC+kPycHsrk+GI43WqCwlCZLc+UNBu9ek2UxoDKE=;
 b=B/j5EO2+HwMLW1MTVkxNYowXChMtWRMHaEJE0R5WSNCPT/8LkhiupYw9PSEunTaIce
 mYbNT9UiMSZTWCM6wSbCwoS7cCZFXSc60d8TdV5CBOznD/RVf4f5NPG/Y2FhX8DOtBtF
 2FLVmEQ2MqtVgvNRW+P/NJB7DdNe+tZpzHTffHgUZwypbRzfK+fCMcc/LWptdI/uZLOU
 iQRNUyWPG9cUXTsgmyg3HTqxx9YwN8HKENIrvLXLLC3lEA7nJPfemJpLJI4niMkGLBhg
 ilvS5EQ1H5JdADCgx2EjWAZygMsU9EDbCLZv26DfTZ67t8fIpogP0olAtLt0VpGo5zTr
 iAdw==
X-Gm-Message-State: AOAM5331AfwywNQg90x+1dV4XVUY4WjOgaho5m2fLsfniVbp9pSMEX2w
 5+wzAl0pRtDx16UZn/6OOsQLQLSm+6ZKDUKxHq0=
X-Google-Smtp-Source: ABdhPJxBjJr8/g0N4yyymldxlgOSLy6CBzq48+J4MGsSLS4jQ6qJmiBvj6n+gEMyMiFZG1pVvvF7NrJRutH+IQMU+wY=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr729468oif.56.1598956527270; 
 Tue, 01 Sep 2020 03:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200815072052.73228-1-liq3ea@163.com>
In-Reply-To: <20200815072052.73228-1-liq3ea@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 1 Sep 2020 18:34:51 +0800
Message-ID: <CAKXe6SJkqaeDBpDC__N6-RYgOMdTRO8NcJ0jkaFvAheEkfqbbw@mail.gmail.com>
Subject: Re: [PATCH] hw: ide: check the pointer before do dma memory unmap
To: Li Qiang <liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8815=E6=97=A5=E5=91=
=A8=E5=85=AD =E4=B8=8B=E5=8D=883:21=E5=86=99=E9=81=93=EF=BC=9A
>
> In 'map_page' we need to check the return value of
> 'dma_memory_map' to ensure the we actully maped something.
> Otherwise, we will hit an assert in 'address_space_unmap'.
> This is because we can't find the MR with the NULL buffer.
> This is the LP#1884693:
>
> -->https://bugs.launchpad.net/qemu/+bug/1884693
>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/ide/ahci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 009120f88b..63e9fccdbe 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -250,6 +250,11 @@ static void map_page(AddressSpace *as, uint8_t **ptr=
, uint64_t addr,
>      }
>
>      *ptr =3D dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
> +
> +    if (!*ptr) {
> +        return;
> +    }
> +
>      if (len < wanted) {
>          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
>          *ptr =3D NULL;
> --
> 2.17.1
>

