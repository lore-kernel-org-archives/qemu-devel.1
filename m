Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEB0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD062065C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYfFojZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD062065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ERG-0000nM-2V
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 04:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7EQi-0000Kl-0B; Sun, 16 Aug 2020 04:54:16 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:35746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7EQg-0004g4-8P; Sun, 16 Aug 2020 04:54:15 -0400
Received: by mail-yb1-xb41.google.com with SMTP id y134so7717532yby.2;
 Sun, 16 Aug 2020 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lc9/9ec4NBry6nJd16jLQjYYfqhlQUGXwRhYp0pFGso=;
 b=IYfFojZ8W2sIr+mqV8hx8ku3ShSbs5X4QoSEU8BZT9UXJ/r/9z+GYqpGVCrs4QcCy9
 GdAadGeXjIUxODDU3ZTh4yF3yizrDu4EF0Iwn7Wdom/SICTrOogw6PKv0QsDhwsc8tQz
 dCYjWCdYoB4jhomhSNgxsWvZ4N2wAnn46dlzBJz97pF/bdYMdqomJutzsmSE2w2ktw13
 /EgMWl+fygaPwWL+QpYlagO10UnHY5G6rueLsXX/WmsX1T+UZpSHAC2i2Z8Uk6LXf5C/
 +Jdyd351xY28ms+fDQIVTmcCS2bECtcFku2In6+bGzDQUH0hUVsfrUo9898D3hjGxwz9
 rwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lc9/9ec4NBry6nJd16jLQjYYfqhlQUGXwRhYp0pFGso=;
 b=PYymeh3X/I72DZyQE2a2Qbq2efmfovILO08mPNrBOC4CCfhCbFgLpWSq4V75SDKMAj
 9hwlNadOiL2OR0gr6QBFYM0dzI6DI5BYVQdtssfkAe5peB7j2rwBVq2xOVrRDxqmeTPL
 NoUkNbjMaREvEli8NJdtMbQuhJHiO98K8Px2Z9pruKx3KZBK2UbhJpXyvIJZRU2FWcHt
 hO3yku42Ioe32I30SIq1ov2LaD+WMMkhvWS6bN+eKuDTkZMU4W4CYk1I/HkqBdtn0Ynt
 yVe3hQ6Meq5O0Z6xWloEgxxgCX7BrrDcuBi6q2NYNFNYFsEsLSfU+wpHwHsCA7PXCgOD
 0x5Q==
X-Gm-Message-State: AOAM531ITrsAw7zTrsQ7T3moB07UdPKqNQooF8WbhViX4xW+bi7/3wYn
 hqQ8uYr8R6B/kE22hH++xiozb0Tfnh8DvkwKV3k=
X-Google-Smtp-Source: ABdhPJzdoxQk3q3GoSCfvCk2WOu3JDOCoNeBEmFcC1ffg3vR1UGPqitDlY2z4aUcn+1wB8CrBBNVlZ+GYBbaKFqS7Xo=
X-Received: by 2002:a25:4251:: with SMTP id p78mr13639848yba.306.1597568052704; 
 Sun, 16 Aug 2020 01:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-9-git-send-email-bmeng.cn@gmail.com>
 <3b8ef426-77ce-d3b2-594b-045cae5ec94f@amsat.org>
In-Reply-To: <3b8ef426-77ce-d3b2-594b-045cae5ec94f@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 16 Aug 2020 16:54:01 +0800
Message-ID: <CAEUhbmXoz2YcnTNs0M3bYWPCsMRcn=96Sa_PQQnyCN9DfZeVYg@mail.gmail.com>
Subject: Re: [PATCH 08/18] hw/sd: sd: Correctly set the high capacity bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, qemu-block@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sat, Aug 15, 2020 at 4:38 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 8/14/20 6:40 PM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Per the SD spec, Standard Capacity SD Memory Card (SDSC) supports
> > capacity up to and including 2 GiB.
> >
>
> Fixes: 2d7adea4fe ("hw/sd: Support SDHC size cards")
>
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >  hw/sd/sd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index 51f5900..5e7fc3f 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -313,7 +313,7 @@ static void sd_ocr_powerup(void *opaque)
> >      /* card power-up OK */
> >      sd->ocr =3D FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
> >
> > -    if (sd->size > 1 * GiB) {
> > +    if (sd->size > 2 * GiB) {
>
> But you need to fix sd_set_csd() too, else this is incomplete.
>

Ah yes, I missed that. Will fix in v2. Thanks for the review.

Regards,
Bin

