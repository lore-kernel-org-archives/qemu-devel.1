Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21395C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 04:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8146208CA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 04:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2LrCjDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8146208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCyLW-0002qS-1T
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 00:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kCyL0-0002QB-2T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 00:56:06 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kCyKy-0000Do-Ea
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 00:56:05 -0400
Received: by mail-oi1-x243.google.com with SMTP id 2so42265ois.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=//jsZuuljFADNkB5AJjOqrAfOUPGkV6SV1BV5Fc/ae8=;
 b=d2LrCjDUgB1AxyayQ9oDt2DPlkI/iKL4xdRIHCBYpIQbnrrk1SDsUUnNB6rY50CIuy
 8UelXECVGz7HWcNgtN6flpUvIkivOvlUYosQNwQFo6hR+s1vux1txG9mG5tHWzfXUMXA
 9VwkQLA4Bw6xmfyfcGVMMGGe1xOO+ZNF1FvPF68LT04V5U1zNP13HJYxM8BUCPIQKVuw
 5H/ZIPgDkAm5tWI6G6vUYuR0FSuFWt5RKT5SA0yqkPQYwLxiRz5UJr/LYR6S9P+/inBc
 vvXGskAVzqqFdluKp/untTymxFdzaJ5om+i8/RuNX4ZwiVTHHznUneNuHp+JHs8IXYXn
 FWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=//jsZuuljFADNkB5AJjOqrAfOUPGkV6SV1BV5Fc/ae8=;
 b=thqvQRZpDz+gzQZmbWepAIkEbu5BInzTLV8egAGXramVfASJX5GJpfWLH0yXBFRW8r
 VwNsF7Wt9H8hwT6frGCiK0w83YIMsCviNPWdRJPxbMEQet5n6Yc2QK+o/AXlHvQYaptH
 bYd5WeaGwqkzYcNz82o2b6fbzCTIlXBNj4vHbKAcre3qt3/ksG77MGf55h8Kt6CACQ0q
 +/R0ROLlaTXjahnc3Kj4W/XA/yx6XUwceZq4Wv9T7+j0+FMcz+Z4InsWFgyPfRAEU3da
 QieCST5ftIQI8yCmOyDc9vD9JUfyJz8RisLa5pjLeBCU1KG2R9pkDtGGg4q1CrCtkU9E
 wclA==
X-Gm-Message-State: AOAM530VgmTM5bNSc+0JNB++ErvsoxIwYiQK/v5ad3WuLSVOLEMjroaH
 jPBv1OkBUkyhiJAt67FR8L4sfWM/2evEqQ7YDt0=
X-Google-Smtp-Source: ABdhPJw55+03XAtI9NY7nRiVR9HfLiImPahoNPjdKr7ZxI+ceCOCfcHGgB1zOzuvu3PE5gUElDIfJfMrFBlK26GD2Hw=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr78736oif.56.1598936162616;
 Mon, 31 Aug 2020 21:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200821082622.7169-1-kraxel@redhat.com>
 <CAKXe6SKZuuCnzAF2uwHO=sh=o2XdAU1+dG6OO-eLYnubX9KikA@mail.gmail.com>
 <20200831112322.rkzv6acsw7iza6w7@sirius.home.kraxel.org>
In-Reply-To: <20200831112322.rkzv6acsw7iza6w7@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 1 Sep 2020 12:55:26 +0800
Message-ID: <CAKXe6SJLxQacG_TmSBZPCkDyz24FADqNc4R+hs4z1PxzsSjexQ@mail.gmail.com>
Subject: Re: [PATCH] cirrus: handle wraparound in cirrus_invalidate_region
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:23=E5=86=99=E9=81=93=EF=BC=9A
>
> > >      for (y =3D 0; y < lines; y++) {
> > > -        off_cur =3D off_begin;
> > > +        off_cur =3D off_begin & s->cirrus_addr_mask;
> > >          off_cur_end =3D ((off_cur + bytesperline - 1) & s->cirrus_ad=
dr_mask) + 1;
> > > -        assert(off_cur_end >=3D off_cur);
> > > -        memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end -=
 off_cur);
> > > +        if (off_cur_end >=3D off_cur) {
> > > +            memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_e=
nd - off_cur);
> > > +        } else {
> > > +            /* wraparound */
> > > +            memory_region_set_dirty(&s->vga.vram, off_cur, s->cirrus=
_addr_mask - off_cur);
> >
> > Should here be 's->cirrus_addr_mask + 1 - off_cur'
>
> Yes (mask !=3D size).


Say if we have a range 0~0x2000 then the mask is '0x1fff' and the
off_cur is 0x1000.

0.    0x1000.  0x2000
        off_cur

Then the wrap occurs.

In the first set.
We just sets 0x1fff-0x1000=3D 0xfff bytes.
In fact we need to set 0x1000 bytes.




>
> > > +            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);
> >
> > And here be 'off_cur_end -1'
>
> --verbose please.  I think this one is correct.

Here the 'off_cur_end' is size.
In this second set we actually sets 'off_cur_end+1' size bytes.

In a word, I think the first lost a byte and the second added a more byte .

Thank,s
Li Qiang

>
> take care,
>   Gerd
>

