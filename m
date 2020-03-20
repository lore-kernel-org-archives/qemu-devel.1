Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED89C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F6920739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STj4vS2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F6920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFHrZ-0003l2-0f
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 09:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFHqv-0003HO-Ks
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFHqu-0003gx-0F
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:38:21 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFHqt-0003gQ-Ne
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:38:19 -0400
Received: by mail-oi1-x243.google.com with SMTP id 13so6463855oiy.9
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z7ygtvweL5WEtEK6CAkGQWD05ToYeFfW+Ycw1W6PnwQ=;
 b=STj4vS2pQ02x5+5Y+DgXYRcy/ZotzrNQkrNgMBHfP1YGxcLNmPwBV2Q8ihqxTTgfIy
 0GE3AuOLUGokg8upfykwNuxrGw9oBXN+UQWmnDQYeFxxtOwPmVQO0+sJc8kCOpGXRIxU
 K5++L8vP3Sv6V8ijIgrq+89AAeVpoQUnk0L1ehD+PGBxDZSUl+gBn2DI9ML2wKKO6MpO
 qOg+SmnzpkhnZhDxPTgXwf1D50c9g3hzVIOFW8wocKr8wtpsrxZeS339KneuhL+gDBFu
 OWgZbB+Y1F0AHZkElySlmW1droHaN/Bg7pHpn4yLW1DiuBHF65FGOfm1/hNOY5xl12nQ
 Rccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z7ygtvweL5WEtEK6CAkGQWD05ToYeFfW+Ycw1W6PnwQ=;
 b=R9TdX+jFRmqHRnmxH3eat+f07SMXwqY+VyDTj+kF2z7Qb4UMxqgoyutc0DPsG60BWq
 5t8XacAZ1dy3lT9kFFw58h0jJdjU3TWPjYfNJRMpYNnDMeZoz/p6zDSFgnDvDFu+8VMn
 W1lqeKpgm4q6HbWovduCH1SzxF05wsXYEIJ5eQzuJJjkZbsHqruiUSh4UVEP3wMCeI5n
 WuTqyt07uw+Brf4sN1643eDfKjgS6jJhIZ77gfGCdJ7ZUWuBqNgLkYpHjNVBKN/spg26
 +rQb/vtVVp5bQ9L1jkwEezogFhqVARSCv4JDJLP2jJKis6M7OW5Y0HKgkrCQqQT+Jurw
 7EXA==
X-Gm-Message-State: ANhLgQ2KzNxo9zYufPgwRh3yRcwxg2UPe3KMVL5dxH2zUkkfD+ObCPkA
 e7pkNHlXNrXXnj+KYI9DGr0PuqJOPjr9jWC4Ju9UGg==
X-Google-Smtp-Source: ADFU+vsliWcGzjVVskW6IQVv+dBCm4SJ/uRkJ+MWiTPq9BuPvVAxksTA4EdP5WoH8TLQiK955t3hvFbTXZXLlRkW6Vw=
X-Received: by 2002:aca:c608:: with SMTP id w8mr6518467oif.163.1584711498686; 
 Fri, 20 Mar 2020 06:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200123164630.91498-1-dgilbert@redhat.com>
 <20200123164630.91498-38-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-38-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 13:38:07 +0000
Message-ID: <CAFEAcA9+uFmPSfkjBHgcsQprMZwOh_Fe-5BAyH7brg4e-mb8hg@mail.gmail.com>
Subject: Re: [PULL 037/108] virtiofsd: passthrough_ll: add dirp_map to hide
 lo_dirp pointers
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 19:41, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Do not expose lo_dirp pointers to clients.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 103 +++++++++++++++++++++++--------
>  1 file changed, 76 insertions(+), 27 deletions(-)

Hi; Coverity reports (CID 1421933) an issue introduced
by this patch:

> @@ -873,6 +881,7 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino=
,
>      struct lo_data *lo =3D lo_data(req);
>      struct lo_dirp *d;
>      int fd;
> +    ssize_t fh;
>
>      d =3D calloc(1, sizeof(struct lo_dirp));
>      if (d =3D=3D NULL) {
> @@ -892,7 +901,14 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t in=
o,
>      d->offset =3D 0;
>      d->entry =3D NULL;
>
> -    fi->fh =3D (uintptr_t)d;
> +    pthread_mutex_lock(&lo->mutex);
> +    fh =3D lo_add_dirp_mapping(req, d);
> +    pthread_mutex_unlock(&lo->mutex);
> +    if (fh =3D=3D -1) {
> +        goto out_err;
> +    }

This change introduces a new code path which
leads to out_err that can be taken after the
call to fdopendir(fd) succeeds...

> +
> +    fi->fh =3D fh;
>      if (lo->cache =3D=3D CACHE_ALWAYS) {
>          fi->keep_cache =3D 1;
>      }
> @@ -903,6 +919,9 @@ out_errno:
>      error =3D errno;
>  out_err:
>      if (d) {
> +        if (d->dp) {
> +            closedir(d->dp);
> +        }
>          if (fd !=3D -1) {
>              close(fd);
>          }

...but here we close(fd), which is an error if
fdopendir() succeeded, because that function takes
over ownership of the fd it is passed and we should
make no more calls on it.

An easy fix would be to add 'fd =3D -1;' after the call
to fdopendir() has succeeded (but that would probably
deserve a comment explaining why it's being done); or
you might prefer to separate out the error flows so
we only call close() for error paths before the fdopendir()
succeeds and only call closedir() afterwards. Or
you could make the error path

   if (d->dp) {
       closedir(d->dp);
   } else if (fd !=3D -1) {
       close(fd);
   }

thanks
-- PMM

