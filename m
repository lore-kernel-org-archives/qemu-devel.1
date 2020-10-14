Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81102222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCIWyvGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81102222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmQX-000602-Ea
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSmOD-00032x-9Z; Wed, 14 Oct 2020 15:24:45 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSmOB-0002AA-Aj; Wed, 14 Oct 2020 15:24:44 -0400
Received: by mail-io1-xd41.google.com with SMTP id u19so506917ion.3;
 Wed, 14 Oct 2020 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/huUIpXmrpJ/eA8kfnT88Q/NcUfZRZKSu/X4oQZ4dns=;
 b=FCIWyvGdOBMGNtz6IGK/B7ZDy8reE+nrZq87Z9BLyqcGc/o6NJZ0Rs/NE+4d2GYFWp
 qC6WR+NkErfPYvyHH4OvbPeqeFFGVi8cxH6X33bpKkpSAL13J4QocC5arLzMXNMmaQm9
 1QuqQweN8sYk2Hn117i4sia01RsR6qTH6dUzNV15okvhEcDNxHLY+Pd7jOLkwRURthIe
 BVnca5TQcATgF07i6Q8dCmOLXLmsaKhtNJvPfxV74anvGCIPSINuh7JgfmZ0s3fWRs1V
 7U6bYoPgsBw2OwJs4+v3PLTJef2eJC6D2BuMAFmenCxllGAk7qoKCP+CsOuTgxTAoFVY
 lMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/huUIpXmrpJ/eA8kfnT88Q/NcUfZRZKSu/X4oQZ4dns=;
 b=fKSSvq4D8TYJFQT/xlyixoKSYl+ZQAbV8X94FS6yDce/GMlTYr5CwdXzrSnMbIkSLb
 x6EhOypIsduJqSWZs+frA6rgfcK1JbFzIsEbUCEUKCRQt1JI9UNDI0pubrt7FAccsBXg
 9NlOiPn/BzeiKdpErWWNi9WkX+pZyPMzxsOcgnCsomSpEsZ0K7G9Ad4gru7tddsFyr9X
 u+Uo2oUeO1j0z9VvG37SmWmS+bXV344WqRLUEw5TYDbWkYaQ6NOXqgu9FDOgX56azZO8
 CjDcrlR8zvzPVu95J00opcI6sBbMbiy9o+Xh2hKPaVyWq2HFAuutl+wbI10qhLBm3ikb
 yCcA==
X-Gm-Message-State: AOAM531PzMXCKpiEFomURotNg3kFFN284rO7LkgGxRRQcPD3zQlalznD
 LoRWuZbS6uxeD18jFKGxXWZEXmZatir9Qgr0JRw=
X-Google-Smtp-Source: ABdhPJyFWLBbbFuMF2sREiVbTIj32xe4KJ73QJAQcNJNRUK+xx25ui9NVRKrqAUfKT+ByWMsvuMWTyD1tNC+o3wBr9I=
X-Received: by 2002:a5e:9b11:: with SMTP id j17mr739802iok.176.1602703481512; 
 Wed, 14 Oct 2020 12:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <1602577811-67343-1-git-send-email-bin.meng@windriver.com>
In-Reply-To: <1602577811-67343-1-git-send-email-bin.meng@windriver.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 14 Oct 2020 12:13:03 -0700
Message-ID: <CAKmqyKMTSSUwk5DPzkfaOZUqm8vtcqqZj4J_EsxuK3=UEfF5Tg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/intc: Move sifive_plic.h to the include directory
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 1:31 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Since sifive_plic.h is used by hw/intc/sifive_plic.c,
> it has to be in the public include directory. Move it.
>
> Fixes: 84fcf3c15111 ("hw/riscv: Move sifive_plic model to hw/intc")
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v2:
> - reword the commit message as Philippe suggested
>
>  {hw =3D> include/hw}/intc/sifive_plic.h | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename {hw =3D> include/hw}/intc/sifive_plic.h (100%)
>
> diff --git a/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
> similarity index 100%
> rename from hw/intc/sifive_plic.h
> rename to include/hw/intc/sifive_plic.h
> --
> 2.7.4
>
>

