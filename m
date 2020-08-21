Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ED5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6128820720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIh2z4r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6128820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Ie-0002pw-JV
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k94VE-0004jU-Ki
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:42:32 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:39718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k94VC-0004C2-OK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:42:32 -0400
Received: by mail-oo1-xc41.google.com with SMTP id x1so244313oox.6
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ltZqhKAUXZnkwbO9/e7U3hbKFlziArzkfgZic8ZWlwc=;
 b=MIh2z4r03G8wqu1pOlph85mzmOT1808VWa1ym2UNEKjSumYXn05xcjgT+MwlHExm4C
 HtcF/BJby4dWymbJv0CI7v8oVf6KrfmGD0wSjPyedYWzKBHNzAUuhc1cdUr94bW8cf8r
 N1Y/skJRWDqDAW5dLzek69+r8xv0dSI5HZV+TSTETGRlDgp0iX3lh74f/Je2+ORA/lH0
 N2ZHQN4DF/ZoeSEORQ/PSorvonaOceyK/OvM8+hP/yGZfsKkFJ3OIPWCBQoiH6LlwvG1
 nSdS8FKBXY1v2HDG3Zt0zBj0aTV5OjdpILPH4S51jPaRPGnvIjGyEmSzCYkOKuCe4Bxc
 TXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ltZqhKAUXZnkwbO9/e7U3hbKFlziArzkfgZic8ZWlwc=;
 b=SmKVFWLuHHus4KopvKIcpycozgECpikCfbwdAAClny9t+8XpFnpcstZDd3nu3w4mzW
 7ZkCxqfngsHaxE5aANsSKip3QRiSbGznR7mAk5hpypv0qJg81NZ16GnKuniiDsLvvo2l
 MXHosdMWFKip5PYlCp8eTgVx0WOnokTTFTfYN4wXpDFXdK93NNZV7L3e0SS/PHhZs0M6
 QtNmqCJ4yFq/Q2hXjE6aQAOMHqjkMam0/wFmMXl8e52tAuwRpTTq3Y2VMeKDVyWINOC/
 vqGu2qBIdE2DwV1kmY8jeL+WAGlMXimG9j8joufLAOZtXo9fIFT6QKHQLKt0gO1Zszg7
 DIIQ==
X-Gm-Message-State: AOAM532m6MXwyFMBfsuU1HXXdz3lMcpgIsWREU8u74neXRJ/fZMZyZ23
 HSAmhGB8v963pmlkpdnSN3Uptn62lTet2K8FT18=
X-Google-Smtp-Source: ABdhPJxhZKG7MGr848n5YXyH/pTE/AwiVSPWUwENXdu3Ju5LCiDo4nzQAx+SR2pllSxHEnL97uG0Rc/ara223rJndF8=
X-Received: by 2002:a4a:be0c:: with SMTP id l12mr1649168oop.22.1598006549397; 
 Fri, 21 Aug 2020 03:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200821082622.7169-1-kraxel@redhat.com>
In-Reply-To: <20200821082622.7169-1-kraxel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 21 Aug 2020 18:41:53 +0800
Message-ID: <CAKXe6SKZuuCnzAF2uwHO=sh=o2XdAU1+dG6OO-eLYnubX9KikA@mail.gmail.com>
Subject: Re: [PATCH] cirrus: handle wraparound in cirrus_invalidate_region
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc41.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Code simply asserts that there is no wraparound instead of handling
> it properly.  The assert() can be triggered by the guest (must be
> privilidged inside the guest though).  Fix it.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
> Cc: Li Qiang <liq3ea@163.com>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/cirrus_vga.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 212d6f5e6145..b91b64347473 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -640,10 +640,15 @@ static void cirrus_invalidate_region(CirrusVGAState=
 * s, int off_begin,
>      }
>
>      for (y =3D 0; y < lines; y++) {
> -        off_cur =3D off_begin;
> +        off_cur =3D off_begin & s->cirrus_addr_mask;
>          off_cur_end =3D ((off_cur + bytesperline - 1) & s->cirrus_addr_m=
ask) + 1;
> -        assert(off_cur_end >=3D off_cur);
> -        memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off=
_cur);
> +        if (off_cur_end >=3D off_cur) {
> +            memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end -=
 off_cur);
> +        } else {
> +            /* wraparound */
> +            memory_region_set_dirty(&s->vga.vram, off_cur, s->cirrus_add=
r_mask - off_cur);

Should here be 's->cirrus_addr_mask + 1 - off_cur'

> +            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);

And here be 'off_cur_end -1'

Thanks,
Li Qiang

> +        }
>          off_begin +=3D off_pitch;
>      }
>  }
> --
> 2.27.0
>
>

