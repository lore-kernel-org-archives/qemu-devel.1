Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCBDC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C60C20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C60C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQbZ-00058R-BZ
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:30:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hDQXV-0001o1-V8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hDQSe-0003rh-Hj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:21:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hDQSe-0003rF-3P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:21:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so7522871qkc.0
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=FhQQo+uTz/fmHzrw3+nZrbOE/gDppzRAy0wSlDnXAd0=;
	b=WnnQ75ZlG4XZb38UgsWdfp8+5twxvHfzwklWBeQC2sXvgRDI3okz8E+sqBkrwUaOOH
	wMgAQIjx8rgX9ZMCTIj+c0lb20TCJHqF44W6GIU+3L0xQVTavP3gM+7c205QWvNAeD3z
	zNr9N9YpvbqbHpsDBVdhSVGtm1uCxSL5k3PDsJjqM6EnsEhzXEzDxxD0Y3iL7DSQZJaW
	LCPO9S2Y6qukPt0R192JKmuiAZCIsXq+ndHLKgA7Xhe47RGmnl6wSHs+Yoehrs+xVjr7
	y9qMscA8uE6ZlCE7UTmYoj4Zh9EauyjlpcEaQrLqnCcSu5gJmL+pLEU+USJL3KGBbFWB
	owTw==
X-Gm-Message-State: APjAAAWoeHZV+neueMCNctSCFjBtLn+sn2LuAURneBJ4Rj/JUQ9gYgcB
	8xE6xdDxRxtJ8y6M/wrW9xVuCphMZGA0oXDRfgEHvw==
X-Google-Smtp-Source: APXvYqxjKF1ktnZ4htQWBJ1mgm2z2SRiLv75Ng55bOhKzZpJqUjQgdgaaeB5Y8B1eNzTmOHTY4yCcvfIvyxL5zmSgag=
X-Received: by 2002:a37:4bc1:: with SMTP id
	y184mr21832283qka.169.1554715263337; 
	Mon, 08 Apr 2019 02:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-4-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 8 Apr 2019 11:20:52 +0200
Message-ID:
 <CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device
 redirected to" message
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
Message-ID: <20190408092052.8QMJfMF95beA5Too5d8o_Vut2jDO__s09inOmsdp05Q@z>

Hi

On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> char_pty_open() prints a "char device redirected to PTY_NAME (label
> LABEL)" message to the current monitor or else to stderr.  No other
> ChardevClass::open() prints anything on success.  Drop the message.
>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  chardev/char-pty.c | 2 --
>  1 file changed, 2 deletions(-)
>

I guess that was printed for convenience.

Allocated pty can be read from "info chardev", so I suppose we can
make qemu more silent. Fine with me:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index b034332edd..a48d3e5d20 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -211,8 +211,6 @@ static void char_pty_open(Chardev *chr,
>      qemu_set_nonblock(master_fd);
>
>      chr->filename =3D g_strdup_printf("pty:%s", pty_name);
> -    error_printf("char device redirected to %s (label %s)\n",
> -                 pty_name, chr->label);
>
>      s =3D PTY_CHARDEV(chr);
>      s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
> --
> 2.17.2
>

