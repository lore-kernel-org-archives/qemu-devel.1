Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05646C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD91D20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD91D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQZo-0003VT-1R
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:28:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hDQXz-0002BR-R1
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hDQJ5-000790-9b
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:11:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hDQJ3-00078G-6Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:11:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so14450795qtv.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=BoP0sVkCWEBazHu8UdHDNHhUMbQnujILYKxIWd/bSa0=;
	b=h5b9BKVSN255K2F/oa2vp8mg5DWZCF2clriNLREWsajuxZcGQUE3AXVL9cI1UXD3in
	sPGlA8DHhMBn92idgulXruKHv3JQjqtVSms/w1E0PNQitys0jt9Gk1OSwtvqo2PbOSo/
	LbbY2PcdDoJ7u4LArMv9+PCKA2bip472QB0J1qZ5zU5xYRF2cIzvbAVKm+YlwV/Pg1La
	ltHyvvJDqfnX5CrJ4OSj/eYWvGsLw6HxHBsoIW3TdGp/eONtQxRqfkLo3S66k8pBALmx
	2JgIWTv7IpTB/tabD69ZrG03sUtYn7ZimD4UycNylE43/5zy6Rx2etc0Ey42vS5Caoth
	QnZA==
X-Gm-Message-State: APjAAAUJKE0hBYfs3O0tjKi/rPzRx/cI4JHdgLHl3JBb6TzWiyv9T7Rv
	1dGRCscy/c1IdPXCbQKPeGUfOjgcSpWyMeHoFl4hAA==
X-Google-Smtp-Source: APXvYqzaYSi703Y6xKPX0PjO3h/zln0WKCMbh1DF0TJz3us8hKu4z9+HG2Mkusp6z8lGIeDecpkJDFNmmwYSK0Bxxxg=
X-Received: by 2002:aed:35f7:: with SMTP id d52mr22590606qte.335.1554714666537;
	Mon, 08 Apr 2019 02:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-15-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-15-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 8 Apr 2019 11:10:55 +0200
Message-ID:
 <CAMxuvaz9R37C1c=vY1xtqMYBW7j1t0pTKW=_ViSq_0yx4DHWuQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH 14/15] char: Make -chardev help print to
 stdout
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408091055.vtxFq9hw7szBNV0LRN9ofidF1ChbJ_L5CAuo2nFWqBw@z>

On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Command line help explicitly requested by the user should be printed
> to stdout, not stderr.  We do elsewhere.  Adjust -chardev to match:
> use qemu_printf() instead of error_printf().  Plain printf() would be
> wrong because we need to print to the current monitor for chardev-add
> help".
>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 514cd6b0c3..54724a56b1 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> +#include "qemu/qemu-print.h"
>  #include "chardev/char.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-char.h"
> @@ -651,7 +652,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMain=
Context *context,
>
>          chardev_name_foreach(help_string_append, str);
>
> -        error_printf("Available chardev backend types: %s\n", str->str);
> +        qemu_printf("Available chardev backend types: %s\n", str->str);
>          g_string_free(str, true);
>          return NULL;
>      }
> --
> 2.17.2
>

