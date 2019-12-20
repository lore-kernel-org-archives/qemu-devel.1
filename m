Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1097DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7B2218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h31smFCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7B2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJWV-0004Vu-01
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iiJOl-00034I-4u
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iiJOj-0008QS-Ok
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:36:58 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iiJOj-0008Lg-Cp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:36:57 -0500
Received: by mail-wm1-x344.google.com with SMTP id u2so9458146wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wr2r5OgRhxoULpPsZrkpCfPL8AlmhSNEbif8D8BFFuU=;
 b=h31smFCmVFx1mZyb0iFFapFsmA9idJbQ47uopd8nUtT4NauhKEHEU/EWZugJ2K/SAT
 AZlzdVavoUMNACz5O7G+d9YpSkscKDS+G/J7f9GPxX2PCFdcRrN7H+pFQQ2eWCgSn6g2
 u4coamS/01fGHdIlzTGZaNEhtygTiomMDCk+GumWfGYrsBoPeDQINimV5atzTuKDokQp
 ZgZ/gOpvQEqC3KlkPJrZeQbd1NfLjgZBFwtj/Yv7L24knTZx0s4XeQysXycTuPKuZTfr
 JgcPfwpBKK/GgCbVgSVnpnenqbzMiI2DLZgHTK4UYj2Qxo2xdFGAhXfM78PLxQCZJ+y6
 GnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wr2r5OgRhxoULpPsZrkpCfPL8AlmhSNEbif8D8BFFuU=;
 b=iZ2MnlpHnsjI9YxgXISLIELlLGzwnY6TaaN0Np0BaS6Xz1LWEuTWyWi+vyti5FsJ5r
 N3ftpUjh/ubFYHkjRS9PCU6FhJlPeslvSQjdL0AU9zIHo6t61nQDvmVJOe/cCN79Wqmj
 E/KkZEM4EtPcJyHBVGePgQHvvN73Fb7dQGY9TE3ivzJxPXOuuodC6QRPz72IVfvhJDVB
 qNyRwZbztleNwLgkRdnFQq1TyqM9zIG4EM72iVR1GdEA6zL2KUkORvGQYXOpu2CweyC+
 kCxCzporvbUs8vXTmoeDKdg5FoW8j7YR1lUxNwbf5UNPsjWWbVKwknPeC/w8e+m7hUd6
 vQ2g==
X-Gm-Message-State: APjAAAVaqTNsE+ApQLN8eM84sC2R4t0B2PP6OzDlCRCAlhnYtDhG0Duh
 ce9JKe+soCJ+AIpnOyqqCRjuDu6b2TjmB6LYZew6Pzj2
X-Google-Smtp-Source: APXvYqwHIgKGXnDvpuERyYH+QjY/N8+jryCHKB5N/rWE676AcozO8Ni9WRh6KDNWgbYEouUPQGjSWdu71ZurAFPHgyY=
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr17362641wmf.56.1576852615171; 
 Fri, 20 Dec 2019 06:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20191127115202.375107-1-marcandre.lureau@redhat.com>
In-Reply-To: <20191127115202.375107-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 20 Dec 2019 18:36:41 +0400
Message-ID: <CAJ+F1CKVV4bWEKWrioOgf6RRQvwGx2c-j6XmLNSBen_F4j7uwg@mail.gmail.com>
Subject: Re: [PATCH 0/7] console: screendump improvements
To: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On Wed, Nov 27, 2019 at 3:52 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> The following patches have been extracted from the "[PATCH v6 00/25]
> monitor: add asynchronous command type", as they are
> reviewable/mergeable independantly.
>
> They introduce some internal API changes, and fix
> qemu_open()/qemu_close()/unlink() misusages which should be quite
> harmless.
>
> Marc-Andr=C3=A9 Lureau (7):
>   console: add graphic_hw_update_done()
>   ppm-save: pass opened fd
>   ui: add pixman image g_autoptr support
>   object: add g_autoptr support
>   screendump: replace FILE with QIOChannel and fix close()/qemu_close()
>   osdep: add qemu_unlink()
>   screendump: use qemu_unlink()

The series has been reviewed by Daniel. Can I send a PR or do you plan
to take a look and make the PR yourself?

thanks

>
>  hw/display/qxl-render.c  |  9 +++--
>  hw/display/qxl.c         |  1 +
>  include/qemu/osdep.h     |  1 +
>  include/qom/object.h     |  3 ++
>  include/ui/console.h     |  2 ++
>  include/ui/qemu-pixman.h |  2 ++
>  ui/console.c             | 74 +++++++++++++++++++++-------------------
>  ui/trace-events          |  2 +-
>  util/osdep.c             | 15 ++++++++
>  9 files changed, 71 insertions(+), 38 deletions(-)
>
> --
> 2.24.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

