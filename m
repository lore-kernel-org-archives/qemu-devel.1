Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F4C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE20B2083D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMv42YKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE20B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn6MK-00017U-Ka
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 15:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hn6M7-0000No-MT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hn6M5-00024P-N4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:09:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hn6M5-00022a-HF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:09:45 -0400
Received: by mail-wm1-x342.google.com with SMTP id g67so12168859wme.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RWBp2IE1vwSKoCESzMaColafJOklblLLXQ5f+pIP/MI=;
 b=SMv42YKUEeY6kzn8xDQKIZ3LlphkFSvuD3c34k2wOfebt6zOQdKXXyB4izBlUDQbxV
 FMDeHCpWGqXmyQGnc/ExeUQ+ZPTtk/sf7OoHW4GMm7uJ3G9ws5SbiRn7dfdbL6c9aoVQ
 230HrxK5/u4s7SRjOqL54Wg0uWo2hytyloFrMMkaciRlRI69nBEOLk7uHIWywnabaMWA
 FqQdvn2H4PeiRbHM4xBb3MFLXtdcqh79DB8qXwLz2b8/vE1NC9EVHnDVdrXAhDVdkhkT
 8u8PjehqvlChthK/xodrd8uTbNbll1yf2QFX4kbQR8DcHVj2yJEro9YF9tfiChAT45eB
 cYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RWBp2IE1vwSKoCESzMaColafJOklblLLXQ5f+pIP/MI=;
 b=EhqHbWjElqw38LrrlHZaLPjgP+bQyv1Be3Ua+GdDK/SXOwV5r9MEKmmjRqFRmWFr++
 usMUULgQhBSVtYou0N95XGPqdoxrN77tohze2rdc2URIj8RL7J8dSc3AQXX9Sl0/qs/9
 8gJod2xtuOjT3Cr7M7bZrvYXtRUhczrFjcEYYCS1PoYnRGkUi2maSP6LGbFiUUUGjfZQ
 /1SGdQAkwYjra6YOieVPppaanHgDjQ5AU3yxcMTFoRBZTL8cqJcvjZR6F9mSMpHLIWbu
 n81AlECSXDrVGoKyd3B/kaO/14SND+B+Q6aDHGSnFC8aWtuvBawcNG0121saRUqSMJE5
 VVzQ==
X-Gm-Message-State: APjAAAV40RFQ+qLp2FvQbQ6P9QxoVkbnRyUghpXY5QYqKBCqi0t7e86W
 n0ygwkY3C1VD6xqy75/kDYQ9GDwPBgqWcRRVd8Q=
X-Google-Smtp-Source: APXvYqzYB4cMcCJJ6FLVZ0iKbVGN+bBRF9c3VDTD1v3tkrILaFuNm8obU21npaERdoPg4CAZTFEdB2aSe4WDM10SVZU=
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr26043586wmk.5.1563217783212; 
 Mon, 15 Jul 2019 12:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
 <20190409161009.6322-18-marcandre.lureau@redhat.com>
 <20190410084830.hiesbi6aumiwsdfk@sirius.home.kraxel.org>
In-Reply-To: <20190410084830.hiesbi6aumiwsdfk@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 15 Jul 2019 23:09:31 +0400
Message-ID: <CAJ+F1CL8jD9-Pu_G60uRr77QnLR5KhTJ4PfbN__A9pyYBCUpTQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v4 17/20] console: make screendump
 asynchronous
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 10, 2019 at 12:49 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > +static void qmp_screendump_finish(QemuConsole *con, struct qmp_screend=
ump *dump)
> > +{
> > +    Error *err =3D NULL;
> > +    DisplaySurface *surface;
> > +    Monitor *prev_mon =3D cur_mon;
>
> Why this is needed?
>

ppm_save() calls qemu_open() which may lookup fd associated to the
monitor: monitor_fdset_get_fd().

Interestingly, it seems fdset are not coupled with the current
monitor, so it's probably unnecessary to update the monitor to the one
associated with the command invocation.

> > +        /*
> > +         * FIXME: async save with coroutine? it would have to copy or
> > +         * lock the surface.
> > +         */
> > +        ppm_save(dump->filename, surface, &err);
>
> DisplaySurface is just a thin layer above pixman images these days.
> Pixman images are reference counted, so you can
> pixman_image_ref(surface->image) to make sure it doesn't disappear
> underneath you, then pass the pixman image to ppm_save.

ppm_save() is still synchronous. I suppose you suggested that for a
future async version. (note that in this case, ref the surface is
probably not sufficient, as it could be mutated while it is being
saved)

--=20
Marc-Andr=C3=A9 Lureau

