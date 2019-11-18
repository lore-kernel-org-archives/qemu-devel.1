Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1E8C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4636920656
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWbx59MV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4636920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWhmI-0006fq-Fr
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhlH-0005oK-7o
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhlF-0003Qq-Ul
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:12:14 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWhlF-0003QF-Oh
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:12:13 -0500
Received: by mail-oi1-x241.google.com with SMTP id a14so15411598oid.5
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fFnzt3koHgk6JHVK5bSTYoxjzZXzNfc38goaFNH8Ixw=;
 b=gWbx59MV6L7XF0X60iSsm6cTkvN3n67rqJjg3p4gg2dy/k6mXg3NOXjnqYtjgHDdDr
 Um9iP7E6iconcfhlypjaFU6cdbo+axwJ2KBc0DEpStly5hiqAqtJ6+lZGpxKyYK81LJG
 7sOr1UU56M09prWpbD0ny60jz8d3zwoS9s26TydKwmvML9x/0NmUbttlr2deT4arbd+L
 rn2PseM8+U9ETbPK0mexN261AcH8SENtHPqILQgzWUnDY0lQ+vZhR4xHXNQNYKw2P892
 UhAR2RpFHMw3V9tWFu7qmAeiip6W4/IUzy1kvlLQ215Rb6478YnjFWS8Ani/2nMmyH4B
 P0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fFnzt3koHgk6JHVK5bSTYoxjzZXzNfc38goaFNH8Ixw=;
 b=qUmBAHR9a/5ITS75Wf0JWddbpIKrA/v4c3b0nlCix5Zi1UwNXf8iaJnhATSSxj5gNo
 SDTfZJMzCzmKCiUF9wH8ml00FeRSJsQyS/Po+drzv9D11KBb9pzHVnmW94DXUOm87TGD
 t6D3XmsZEfCNst7LnnM8Y2FonF9Z+CPXqIRk/xW44AJI/ofvw6ggwHA4Mypwvdbf+r+n
 ILJFWAt8HYnsPZqXj0dFAnmAfhwZ12msV6wbDcLDk+GV+utHWraqA0vL3U0u9h28YElf
 4fFQOUrtLr0Hq1ijaVPyaYjRzVjpWmqAdZ+29tq75NjoT2NMBlkgIn9Z1n2Ji+hZsfkA
 Jukw==
X-Gm-Message-State: APjAAAXkrWKL7gXG58WXZLUCs092KYuCKrqbyjMdNOdiDT/ZrY0XS/Fq
 tMbeX+ldLmOwXTS2+7lqMrYSwi1h4SYgoSdjU6be8w==
X-Google-Smtp-Source: APXvYqyu4WyASPrbFtKwqbF1pxNmOvi6obOMQonBB2yBEqS9E4qeG68cJ0PgGgjgs9YkE2Ac/YV3jiDqVxUzYDTZewQ=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr20588689oij.163.1574086332722; 
 Mon, 18 Nov 2019 06:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-5-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-5-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 14:12:00 +0000
Message-ID: <CAFEAcA9oV-fHLmh3uJTwJrQW60=HFQmRb_brkRpB5BYYVDqF+g@mail.gmail.com>
Subject: Re: [PATCH v3 04/33] chardev: generate an internal id when none given
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 18:33, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Internally, qemu may create chardev without ID. Those will not be
> looked up with qemu_chr_find(), which prevents using qdev_prop_set_chr().
>
> Use id_generate(), to generate an internal name (prefixed with #), so
> no conflict exist with user-named chardev.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> -Chardev *qemu_chardev_new(const char *id, const char *typename,
> -                          ChardevBackend *backend,
> -                          GMainContext *gcontext,
> -                          Error **errp)
> +static Chardev *chardev_new(const char *id, const char *typename,
> +                            ChardevBackend *backend,
> +                            GMainContext *gcontext,
> +                            Error **errp)
>  {
>      Object *obj;
>      Chardev *chr =3D NULL;
> @@ -991,6 +992,21 @@ end:
>      return chr;
>  }
>
> +Chardev *qemu_chardev_new(const char *id, const char *typename,
> +                          ChardevBackend *backend,
> +                          GMainContext *gcontext,
> +                          Error **errp)
> +{
> +    g_autofree char *genid =3D NULL;
> +
> +    if (!id) {
> +        genid =3D id_generate(ID_CHR);
> +        id =3D genid;
> +    }
> +
> +    return chardev_new(id, typename, backend, gcontext, errp);
> +}

So presumably the idea is that chardev_new() now must be
called with a non-NULL id (should it assert() that?),
and qemu_chardev_new() can be called with a NULL id, in
which case it will create one ?

> +
>  ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
>                                 Error **errp)
>  {
> @@ -1003,8 +1019,8 @@ ChardevReturn *qmp_chardev_add(const char *id, Char=
devBackend *backend,
>          return NULL;
>      }
>
> -    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc))=
,
> -                           backend, NULL, errp);
> +    chr =3D chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
> +                      backend, NULL, errp);
>      if (!chr) {
>          return NULL;
>      }
> @@ -1061,8 +1077,8 @@ ChardevReturn *qmp_chardev_change(const char *id, C=
hardevBackend *backend,
>          return NULL;
>      }
>
> -    chr_new =3D qemu_chardev_new(NULL, object_class_get_name(OBJECT_CLAS=
S(cc)),
> -                               backend, chr->gcontext, errp);
> +    chr_new =3D chardev_new(NULL, object_class_get_name(OBJECT_CLASS(cc)=
),
> +                          backend, chr->gcontext, errp);

...but if that's so, why are we calling chardev_new() here
and passing a NULL pointer ?

How many callsites actually pass NULL, anyway? My grep
seems to show:
 * this qmp_chardev_change() call
 * gdbstub.c
 * hw/bt/hci-csr.c
 * tests/test-char.c

Maybe we should just make them all pass in ID strings instead ?

thanks
-- PMM

