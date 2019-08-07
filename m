Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B0C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4912221BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs29uTNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4912221BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvKAB-0008F6-HA
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 07:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55075)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hvK9g-0007qU-Pd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hvK9f-0000f7-JP
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:30:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hvK9f-0000eB-EE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:30:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id q20so102724349otl.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZdBahCsCMrB2xSdqsxnpGdxMVojkChJhGruyZvC/Qg0=;
 b=Bs29uTNIxeD+77C4VfOdt5icJPksAyiyhi2AX6IzdEfbWqVwkW2Ke4AjKLiIi4NoqB
 GwNf31qqHTPteZ/7xtLz4DpWe8mSMR6slrvaNplc3FLgnA8o+tRRIlJyqPPQOzJxckSe
 YEPYvHsH+gOGt8G9pXjv4E6b95SAXW/Uf1A/a1S17DdqpPSSsrtnG0tRvE6pDSUZilb4
 mkQ3dHBE31YwKSIGugZSffz1WIu1jimfUFYlKr+NbNr/OFiTwMveA0I9sBO9z11FbVv4
 9MlMSGpyACAD+P9VAz6D5CcbGLrt6F3WZMMYT9VnHd/rap5eBrsREmnVC0AZGoDEXkJ5
 Oc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZdBahCsCMrB2xSdqsxnpGdxMVojkChJhGruyZvC/Qg0=;
 b=hS5zXlphMenqL2SRK4DT7J33qmBbpB2zZk6Lc20pCFNoa4TgPKW0iEJ/tFJXo4Z4RJ
 SZV57tmo5GhD/taj9nGMjmWeFIoqeCpzDI4jCnHvk2QZ/RyeHcbkcGeppbp9Qgo94jjP
 0hJDI0FSMnmNgVdcDC6Dt6JaixJ+vDufPn1itQUEGhR4vds2Sfs6VfDlaYWH/+JwHado
 KKbVedpa968bTAWmBmEuoVI3jzwTQK12xZ38xKZ9B+IYaf3V6ryVaRmHYJGkXuxSDmX0
 7hwJHysKKAeI5ho4Rrh4itfKjeBK5DpkJwnhrl2vc62yjgy2ukMRhPomyJsWEvG9cY/1
 Nwvg==
X-Gm-Message-State: APjAAAXFs70Jq6Puz6ZIqBl8vvUls2WUVbwtTQZ2DuHfjYpqhpBimd7g
 Ed+4r29DbVfXLmbjKLoc0NO4iE6x0gjPBGFMDGE=
X-Google-Smtp-Source: APXvYqzzOCchqhjZc1ZdV6uFrP5bVpeRoFX/wqmpNNRKmuS7h5sYk9JQDiaORc0+bhoGfScSSs2Tm6WuceQkvD5Wwj0=
X-Received: by 2002:aca:3602:: with SMTP id d2mr5175585oia.150.1565177453807; 
 Wed, 07 Aug 2019 04:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190807084048.4258-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190807084048.4258-1-marcandre.lureau@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 7 Aug 2019 19:30:41 +0800
Message-ID: <CAKXe6SLbRVSuApk_BBFaff0QWZNxY=-zAcqo=7AFun1W7hQLXw@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] usbredir: fix buffer-overflow on vmload
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
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=E4=BA=8E2019=E5=B9=B48=
=E6=9C=887=E6=97=A5 =E5=91=A8=E4=B8=89=E4=B8=8B=E5=8D=884:41=E5=86=99=E9=81=
=93=EF=BC=9A

> If interface_count is NO_INTERFACE_INFO, let's not access the arrays
> out-of-bounds.
>
> =3D=3D994=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address
> 0x625000243930 at pc 0x5642068086a8 bp 0x7f0b6f9ffa50 sp 0x7f0b6f9ffa40
> READ of size 1 at 0x625000243930 thread T0
>     #0 0x5642068086a7 in usbredir_check_bulk_receiving
> /home/elmarco/src/qemu/hw/usb/redirect.c:1503
>     #1 0x56420681301c in usbredir_post_load
> /home/elmarco/src/qemu/hw/usb/redirect.c:2154
>     #2 0x5642068a56c2 in vmstate_load_state
> /home/elmarco/src/qemu/migration/vmstate.c:168
>     #3 0x56420688e2ac in vmstate_load
> /home/elmarco/src/qemu/migration/savevm.c:829
>     #4 0x5642068980cb in qemu_loadvm_section_start_full
> /home/elmarco/src/qemu/migration/savevm.c:2211
>     #5 0x564206899645 in qemu_loadvm_state_main
> /home/elmarco/src/qemu/migration/savevm.c:2395
>     #6 0x5642068998cf in qemu_loadvm_state
> /home/elmarco/src/qemu/migration/savevm.c:2467
>     #7 0x56420685f3e9 in process_incoming_migration_co
> /home/elmarco/src/qemu/migration/migration.c:449
>     #8 0x564207106c47 in coroutine_trampoline
> /home/elmarco/src/qemu/util/coroutine-ucontext.c:115
>     #9 0x7f0c0604e37f  (/lib64/libc.so.6+0x4d37f)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/usb/redirect.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 998fc6e4b0..9764a57987 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1495,6 +1495,11 @@ static void
> usbredir_check_bulk_receiving(USBRedirDevice *dev)
>      for (i =3D EP2I(USB_DIR_IN); i < MAX_ENDPOINTS; i++) {
>          dev->endpoint[i].bulk_receiving_enabled =3D 0;
>      }
> +
> +    if (dev->interface_info.interface_count =3D=3D NO_INTERFACE_INFO) {
> +        return;
> +    }
> +
>      for (i =3D 0; i < dev->interface_info.interface_count; i++) {
>          quirks =3D usb_get_quirks(dev->device_info.vendor_id,
>                                  dev->device_info.product_id,
> --
> 2.23.0.rc1
>
>
>
