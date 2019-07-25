Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F678C76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C5221734
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C5221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqf6b-0000st-Fs
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40236)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hqf6Q-0000Sz-LW
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hqf6P-0006Pd-F7
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:52:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hqf6P-0006NB-7j
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:52:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so45269427wms.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=yl3RtR0b0vJdwQ5gCLi8TimWLtRYqJy+3RrGtmZ3AnQ=;
 b=Svl3lJanlGEisismb6SXLOB09yhNhWjHQuUvAvgPRhUS+v+mJtvPcCC04AmeNUgIUK
 vHBsa96rlOYyxNx3R1vrJoIbRC8XEwCUtmBRNO76ki35+SJJ4q2QJloIN68pDz3It+AY
 z2gzE3/2hv4W/qIFfT83py6LCNp9crxoiKRS9OGkyvcyf3D/3p6oHFYhV/6lp7SRVjcL
 goPWe3MZgkmeeeBjXnbSIacfMrTckMqV+ndryBiQXZ3paB5olD6YDhkho3S3P+rTBdRG
 pc0YRRAF0zk4l5+Tmft3YbgLO15IY6ObORLb0UoTLFN4ZH1tgt3Xsv+F2yRhM8NhXl2v
 TtRQ==
X-Gm-Message-State: APjAAAVadyxJlXbWluIYJ4/fsiZuQ9eJQjSf2c+WpgfxIfA0so63M3Uz
 RkZ3PbCaqmX/KRXy6YJ123OCoOUjgXQ=
X-Google-Smtp-Source: APXvYqwo/Ol/G/p2YPyO0bk1yIBWwt7mcJwH5r55ctuMzwlZr7So/ssJZoZX2k4y0vzFCFKdyYSggw==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr7566549wmi.79.1564066334047; 
 Thu, 25 Jul 2019 07:52:14 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id a67sm53208498wmh.40.2019.07.25.07.52.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 07:52:13 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <20190725060858-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
In-reply-to: <20190725060858-mutt-send-email-mst@kernel.org>
Date: Thu, 25 Jul 2019 16:52:11 +0200
Message-ID: <87lfwmmajo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, maran.wilson@oracle.com,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Michael S. Tsirkin <mst@redhat.com> writes:

> On Thu, Jul 25, 2019 at 11:05:05AM +0100, Peter Maydell wrote:
>> On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > OK so please start with adding virtio 1 support. Guest bits
>> > have been ready for years now.
>>=20
>> I'd still rather we just used pci virtio. If pci isn't
>> fast enough at startup, do something to make it faster...
>>=20
>> thanks
>> -- PMM
>
> Oh that's putting microvm aside - if we have a maintainer for
> virtio mmio that's great because it does need a maintainer,
> and virtio 1 would be the thing to fix before adding features ;)

There seems to be a general consensus that virtio-mmio needs some care,
and looking at the specs, implementing virtio-mmio v2/virtio v1
shouldn't be too time consuming, so I'm going to give it a try.

Cheers,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl05whsACgkQ9GknjS8M
AjWeBA//YekOQs5c97CA8PAjz+WVBsvoLW7zh1YSVRGZAgXWuR619x/5ha6pgRXL
F8io/rFwlV7As0gxRJBrUq3j/D07uBD12fOm/zxGhizJ9hp9JCui0GwAvY7ZlfdP
aTHKhJIs94E/0HHvWL1ImkYMtDVdLahSupBSNZxnpDXkihiTL767CphmDs8lJFRb
kgzojpCixiMLGK4+MyBmJHb5pXgdBL1T8A4j323G2nFnUMSuCJEnxxF5tg+sDFQH
syDtoDOIJIdjfpDbt4XENGqd+AH0C1gX8Ja35SXdEGCgX7hX0pKd8igVztRGsySO
tqjDZyZcur7pCVCuj2ax8BvJ37hcAab5Mx2aRMoB9zcfIAdhAYnH2bV6rgYK3Fg0
imfKCzFQclc/l/L4iDNRNY1n22irSf1r//oTOngO/AyufaQMp+H5UHE/LsPTZmoT
gSNAWdbyDBjf60sSvB5lnoatZl98Y6f0yAPKiGP6KYj1ougr4ylGQdjURhSmXcOE
60cgLpjlYxOQbChrd8fGZ0Aw2a0KN9/xQFUdd/ARW8hMsvsTfmQ1vLNXFoTKjEoY
tJU1VGsFEGBvn1Phnoh3I70vF1YEzY1JGq0Zg2oIUj8BMashhfLUTgxQpYUu8796
9ulktW+NqEGCKZCliWhJNnGHxnKiMsJs3EK3oRmOki/DjkmsM/g=
=j9LQ
-----END PGP SIGNATURE-----
--=-=-=--

