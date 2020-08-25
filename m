Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE59C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A403207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbmQWQOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A403207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAbye-0002uX-KZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAbxt-0002N5-Kb
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAbxr-0001ez-Hw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598373506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XdxT7gYSqABMrY4bTBgS804sXw9OEAgp3DC6LCiJgBw=;
 b=BbmQWQOWRBWlpFZjrrT5g7fIU9371jbVRdVicNOyryBDMVW2D+BgddRo7LLE8PENSXm112
 619NB01GSZ94hJfWji+O+2qbGht4k/GX7S08mgfswGnChk+0RpL8gP+pzNRhuHMHcSRCa6
 3R8qvbj3aYF5zn9rZLot3kzcUMs5RtI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-PFcgGSvINy-hwSYz8NAQBA-1; Tue, 25 Aug 2020 12:38:24 -0400
X-MC-Unique: PFcgGSvINy-hwSYz8NAQBA-1
Received: by mail-ej1-f69.google.com with SMTP id e22so5606128ejx.18
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XdxT7gYSqABMrY4bTBgS804sXw9OEAgp3DC6LCiJgBw=;
 b=DInVhWifO3jiodODKUAQbTMvol8g6pu+p07oETO+AQs5bxwhKxMkE2Tg3IoS00wDk6
 pk0/qOETH8F3sWbGEGqrjWQPfISoEMPA4vb5bj/iVbFiQwl7R3U+Y1REIh0OTaeleV/E
 SuYIaWQjSHsVjrvvkKZG6KVDke8+Tnlps+WryPSxM5Z3UrjryGDoKRXyLCagjBT+zXYR
 Wdt6FcQe6ao0DFI1xejrkLrIvAV1xKK+Xm+KY+x+Mcc8VKAGsWucswnLIW7l2smCt6sW
 hFP5JgUTnmYIF2REpJHtAZeoRgyTNYpbGbueBcJapWRF+dqDt9QRrVtpOsiOILN8PPla
 MAzA==
X-Gm-Message-State: AOAM5335WAY6M9r5HJBEVkfj0s5ier6o7eCWiUU7Ga9+BPOua4gCJavf
 TvN7s30RH1ndMfLoqBYoA+z3dF73lM0aAMna3M89/NJ8aJ7yxYlGNX9vha1srmrcBksJKzOsCsv
 gs+mlJtCYCma+xKM0G3Y+6W+iSMSwJDo=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr10510603edr.243.1598373502978; 
 Tue, 25 Aug 2020 09:38:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDhloinUyxd4STLjce8p5QasdxVQKnKSnrvtyYll15WgJtlpr0W1zoPBpl+KDpeq/4lpp5CMFpVKHktIHGq+U=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr10510586edr.243.1598373502787; 
 Tue, 25 Aug 2020 09:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200825150409.346957-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200825150409.346957-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 18:38:10 +0200
Message-ID: <CABgObfbW5NMu4-NxiTNYF1NxiXt9pgyueJwv+vqdyQ5gySd+bQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] meson: mingw installation fixes & nsis conversion
To: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000da395305adb654b9"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: sw <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000da395305adb654b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Whenever we fix these bugs I would rather avoid adding duplicates between
options and config-host.mak, so that we can sooner or later get rid of
config-host.mak.

For the same reason, I think all options should have a sensible default so
that in the end it will be possible to do "meson setup". Do you think it's
possible to extend the series in this direction?

Paolo

Il mar 25 ago 2020, 17:04 <marcandre.lureau@redhat.com> ha scritto:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> The following patches fix installation path when cross-compiling Windows
> version, and move the NSIS build rule to meson.
>
> Marc-Andr=C3=A9 Lureau (5):
>   meson: pass confsuffix option
>   meson: use meson datadir instead of qemu_datadir
>   meson: add docdir option and pass pre-prefix qemu_docdir
>   meson: use meson mandir instead of qemu_mandir
>   meson: add NSIS building
>
>  Makefile                           | 56 -----------------------------
>  configure                          |  2 ++
>  contrib/vhost-user-gpu/meson.build |  2 +-
>  docs/meson.build                   |  4 +--
>  meson.build                        | 32 +++++++++++++++--
>  meson_options.txt                  |  2 ++
>  pc-bios/descriptors/meson.build    |  2 +-
>  pc-bios/keymaps/meson.build        |  6 ++--
>  pc-bios/meson.build                |  2 +-
>  scripts/nsis.sh                    | 58 ++++++++++++++++++++++++++++++
>  tools/virtiofsd/meson.build        |  2 +-
>  trace/meson.build                  |  2 +-
>  12 files changed, 101 insertions(+), 69 deletions(-)
>  create mode 100755 scripts/nsis.sh
>
> --
> 2.26.2
>
>
>

--000000000000da395305adb654b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Whenever we fix these bugs I would rather avoid adding du=
plicates between options and config-host.mak, so that we can sooner or late=
r get rid of config-host.mak.<div dir=3D"auto"><br></div><div dir=3D"auto">=
For the same reason, I think all options should have a sensible default so =
that in the end it will be possible to do &quot;meson setup&quot;. Do you t=
hink it&#39;s possible to extend the series in this direction?</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 25 ago 2020, 17:04=
  &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt; ha scritto:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_=
blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Hi,<br>
<br>
The following patches fix installation path when cross-compiling Windows<br=
>
version, and move the NSIS build rule to meson.<br>
<br>
Marc-Andr=C3=A9 Lureau (5):<br>
=C2=A0 meson: pass confsuffix option<br>
=C2=A0 meson: use meson datadir instead of qemu_datadir<br>
=C2=A0 meson: add docdir option and pass pre-prefix qemu_docdir<br>
=C2=A0 meson: use meson mandir instead of qemu_mandir<br>
=C2=A0 meson: add NSIS building<br>
<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 56 -----------------------------<br=
>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0contrib/vhost-user-gpu/meson.build |=C2=A0 2 +-<br>
=C2=A0docs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 4 +--<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 32 +++++++++++++++--<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0pc-bios/descriptors/meson.build=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0pc-bios/keymaps/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++--=
<br>
=C2=A0pc-bios/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
=C2=A0scripts/nsis.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 58 ++++++++++++++++++++++++++++++<br>
=C2=A0tools/virtiofsd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<b=
r>
=C2=A0trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A012 files changed, 101 insertions(+), 69 deletions(-)<br>
=C2=A0create mode 100755 scripts/nsis.sh<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div>

--000000000000da395305adb654b9--


