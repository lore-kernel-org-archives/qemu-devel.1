Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0B42071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/Dn6Ksh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0B42071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzm7-0002eb-Ut
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kCzl5-0001sj-BY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:27:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kCzl3-0001fQ-PF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:27:07 -0400
Received: by mail-oi1-x241.google.com with SMTP id d189so187380oig.12
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5dV/+2xJJw3Y27euk5TX1X1H7daCpl6Na/5MIj+EuTc=;
 b=Y/Dn6KshoTWzp8qttynK3q5nQF+uKjzvOaz3mpSFPWryR6nurnsLtJUGNX3jxqqw7m
 Di4dSsi/GD3L2QL7tiANY+Ewfq3YoaeTWN6KrSJc4FFUmAkj/5JT1M7Yo6HogKUyGUVs
 aQLGepEsNu/tXG918BGYbHBUK6yqSUu/k0QskOIGQT+PYlDvEpv9ejsQF0lL5sEkKdwx
 Ce6IzRtEhigoNewhFv25wtGxfUcVhEk57xfa2Tiq3+IFNhKvgXcaYKQ1JxTvI/ZgTeHu
 9SHY6kizPa6OcWiAduWI2GWTYIA09HwaIinaDV8F7Gh+tetNKxRFQBd7q0p6m3V7SoNS
 GQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5dV/+2xJJw3Y27euk5TX1X1H7daCpl6Na/5MIj+EuTc=;
 b=Z9lAhy/iNv98Ap8/MqozKsQ8roOUTrND27IctX8jEbIflqwpNhzfKKZI/bRTvXpzq8
 Zq7XKLIwtdi3m8Y1tWATPLoYJpuCbI5hEeYAehVcyZw3yN59s0CJNW0rDmJc4k7jF56e
 9fwZ+cIT3QeiXuXRZXuuECtIjnNe0urIzp/+rdwAP8QuzVMHZu1977efWenYCh6KwF4f
 ibnzc8n0/wRAJraSCbxGb2jSQQKIzQNb50+z6dD8VAEWDi2NgnNMV043rxm397QLJzfb
 YNe3TvD+SLKdo7RopQXTX10aokXH9hT1CC8JwT91ZpdIkb0sCqAL0XO4TcYj+Hk7Lart
 L4+A==
X-Gm-Message-State: AOAM532VIGg41MrIwH1B4HP6py1CUUDuV+UjQX/cS3f/1GWhcysdbFva
 BOJYYvKHoVaKnk7YjaAdfZNLRezKjXYecRucXU8=
X-Google-Smtp-Source: ABdhPJwSpVtWQNzpAeMouqfHNnmG041gWMTeJiYwNxPAFEsDIvH2dxGhqbsjzTeClin7wW7sRNt9TwzQkapM4CirKRc=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr230565oif.56.1598941624389; 
 Mon, 31 Aug 2020 23:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200821082622.7169-1-kraxel@redhat.com>
 <CAKXe6SKZuuCnzAF2uwHO=sh=o2XdAU1+dG6OO-eLYnubX9KikA@mail.gmail.com>
 <20200831112322.rkzv6acsw7iza6w7@sirius.home.kraxel.org>
 <CAKXe6SJLxQacG_TmSBZPCkDyz24FADqNc4R+hs4z1PxzsSjexQ@mail.gmail.com>
 <20200901051530.hjdugb7c5r22n3ui@sirius.home.kraxel.org>
In-Reply-To: <20200901051530.hjdugb7c5r22n3ui@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 1 Sep 2020 14:26:25 +0800
Message-ID: <CAKXe6SLOP9WPYoPP-Rf+RvwVk26J9siNod=CgkBj8dW0rMD25Q@mail.gmail.com>
Subject: Re: [PATCH] cirrus: handle wraparound in cirrus_invalidate_region
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:15=E5=86=99=E9=81=93=EF=BC=9A
>
>   Hi,
>
> > > > >          off_cur_end =3D ((off_cur + bytesperline - 1) & s->cirru=
s_addr_mask) + 1;
> [ ... ]
> > > > > +            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end=
);
> > > >
> > > > And here be 'off_cur_end -1'
> > >
> > > --verbose please.  I think this one is correct.
> >
> > Here the 'off_cur_end' is size.
>
> Exactly.  And memory_region_set_dirty wants the size.  So everything is
> fine, right?



+        if (off_cur_end >=3D off_cur) {
+            memory_region_set_dirty(&s->vga.vram, off_cur,
off_cur_end - off_cur);
+        } else {
+            /* wraparound */
+            memory_region_set_dirty(&s->vga.vram, off_cur,
s->cirrus_addr_mask - off_cur);

The s->cirrus_addr_mask can be reached. I mean we can do following:
s->vga.vram[s->cirrus_addr_mask].

If I understand correctly, the 'off_cur' and 's->cirrus_addr_mask' is both =
index
[off_cur, s->cirrus_addr_mask].

So the len is 's->cirrus_addr_mask->off_cur+1'.


+            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);


For the 'off_cur_end' here, why we add 1 at the first?:

"off_cur_end =3D ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) + 1;"
This addition '1' is what I think should be substracted in wrapped cases.

Thanks,
Li Qiang

+        }
         off_begin +=3D off_pitch;
     }
 }



>
> take care,
>   Gerd
>

