Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDCC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351AF2071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP2UVD1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351AF2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD0s7-0003QM-6c
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 03:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kD0rb-00030m-P3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:37:55 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kD0ra-00027a-6H
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:37:55 -0400
Received: by mail-oi1-x242.google.com with SMTP id u24so338266oic.7
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=m4E94NlOSW+urNwF/7uff+jrOMj7ZxFUl4fA65SRgCI=;
 b=mP2UVD1/Y/vo/Mlmpx60p5OeE4CSUIKyevg3NJGKjjxZVvqYwh1Iw3u/GgoEjrsRn1
 3kyJfg0E+Dh/x+36oUkKL7B6ocvXVBK1gOhNYkxKCOhSvD6Nvax5HLhKvq5LPUwOT+3D
 I1Gay8W7yJ3NXWEQKL4mWbh1lZw/x241iOjQ32n1xKiRiNpOOUQn8FfY7R5haa/ldNxq
 GxMbmq3E2f0V1ZTMpTCTFzdhv7LiLwCUcOhlEepo51KTfDNxgI5dFWvhl/hRgO4Q6quo
 J7+2s8oS8KN1I2t0wAkaIDbWLw+YviKHNRIKR8ZHHNXumGP1dMcKA1Kh05H3Sfb0Asw/
 v6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=m4E94NlOSW+urNwF/7uff+jrOMj7ZxFUl4fA65SRgCI=;
 b=B51B5DlUJXhQkhUa/sdx6y5eZV+H+tOVpo/1CvIYmC1QSJz5Bz+SOX0Lqg9z8tpOVo
 d9C5kQdw9AH8U8HdHGnetVVKAJrEg9geVqvVrAZclu/iU6FOKubIrm31JjKsWfIjFYDJ
 qWy0JIdTIC+28F3ngyr8N0WjxDojuF4LDPiTTUpVYlvK3nSv+CKlEY7r83X8DivPMp10
 C//XEe6zS0u8KAotF3EO+CMpchdEff4afD45F9YtfFtKzWMJupZ9aCEWvraW9nl6V35t
 ZRGwsu91fhpp5btAduyAtE5xjVJt5YBoW9Fb4XbLr3CzNiikUZvKHmgMwmD5OT45wUrA
 Fb9A==
X-Gm-Message-State: AOAM5317zpv9Xx7hF179D5tIdhS5cmVkPY3g8tGZKQsDviAHDirmCDi5
 kT3wvGUctI7oDM9Wsdnaaw5b9+l0KzrLXJOfSvo=
X-Google-Smtp-Source: ABdhPJw3GxhTE/NYT1WnfYjN6Bi/n/jSi0HLc4IfiMCapukMMd5CRvoLhdqID2PR65KjFbFLfx9BvB25sgp2b9w4pzk=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr357715oif.56.1598945873113; 
 Tue, 01 Sep 2020 00:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200821082622.7169-1-kraxel@redhat.com>
 <CAKXe6SKZuuCnzAF2uwHO=sh=o2XdAU1+dG6OO-eLYnubX9KikA@mail.gmail.com>
 <20200831112322.rkzv6acsw7iza6w7@sirius.home.kraxel.org>
 <CAKXe6SJLxQacG_TmSBZPCkDyz24FADqNc4R+hs4z1PxzsSjexQ@mail.gmail.com>
 <20200901051530.hjdugb7c5r22n3ui@sirius.home.kraxel.org>
 <CAKXe6SLOP9WPYoPP-Rf+RvwVk26J9siNod=CgkBj8dW0rMD25Q@mail.gmail.com>
 <20200901071628.kp6xgkl7725ghyh3@sirius.home.kraxel.org>
In-Reply-To: <20200901071628.kp6xgkl7725ghyh3@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 1 Sep 2020 15:37:17 +0800
Message-ID: <CAKXe6SJgfTcFD=9AaYUoTc0_GN_L-49zUbFsQ8UNQQ8wP7D3Eg@mail.gmail.com>
Subject: Re: [PATCH] cirrus: handle wraparound in cirrus_invalidate_region
To: Gerd Hoffmann <kraxel@redhat.com>
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:16=E5=86=99=E9=81=93=EF=BC=9A
>
>   Hi,
>
> > +            /* wraparound */
> > +            memory_region_set_dirty(&s->vga.vram, off_cur,
> > s->cirrus_addr_mask - off_cur);
>
> > So the len is 's->cirrus_addr_mask->off_cur+1'.
>
> Correct.

So do you agree me the first set size should be 's->cirrus_addr_mask -
off_cur+1'?



>
> > +            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);
> >
> > For the 'off_cur_end' here, why we add 1 at the first?:
> >
> > "off_cur_end =3D ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) +=
 1;"
>                                          ^^^^
> > This addition '1' is what I think should be substracted in wrapped case=
s.
>
> The +1 balances the -1 done before ...

Then the second set size is ok.

Thanks,
Li Qiang

>
> take care,
>   Gerd
>

