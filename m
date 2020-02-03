Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9FEC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4692F20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKKJoAwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4692F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZPA-0006wr-FD
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZOY-0006PY-GJ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZOX-0004Sc-2N
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:55:58 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:41488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZOW-0004RV-T5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:55:57 -0500
Received: by mail-ot1-x32a.google.com with SMTP id r27so13170778otc.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PyBI2DBErOycQqYQiTbHQsaYOYZLDqNJ6bKfKvFdY5Y=;
 b=tKKJoAwj5kLDiuMq+lsmVn3DBLJkvvzupZB0TqoGOLYg8td1OKR4yILDkv2pOnSuh2
 jjB9bqy2e7cU858RUnp9lT3HS5hFPVbf8DZe+YyT5Wb+PUsCM9zUoa6Hg9shv0W4Hfxv
 tgj7UgE4iCjj/aewJ0dDREjrZrjvt56lHo9RQmwvHJVxWdSGVghEj4AicfGI3uEpGDJ+
 QDtrCplZfHjqkb1tg7ElY5Fvwv9ynbgVIVp4ntqyQNv9Qt2yxM1H3KvjTR6exaA6o4Od
 mwr3Kv5ncG6UWznOQAKQJdHUh26KXrXkAazlAQUmqdNQloPj/I9Bl+fhb7K4lXZ1ZJhv
 SOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PyBI2DBErOycQqYQiTbHQsaYOYZLDqNJ6bKfKvFdY5Y=;
 b=HAnUky+Mamtt+W+uIBApMCUHROHaYxgAg5DAqFsCRNnp5gzLZetl2ntzMgnfepv3aF
 +mjHewHex5j8fo/RabOgbLD7I1s0JdRtsvR5sxgqjF/1uCPgGmPNwLbXGleiC14euddi
 50Sxh3eGe/JAzeBtYxyRZkDl7BQ2EZZm6a5CeZ+ZNWQ5lhOrJLUvCEwCreCNbtK6tB51
 9l4OyjyZ+UBs47u3WuZuL1yyKTsNlMTWBULMdCM+fpG4l2W4al/Tyw2wsLKXi0UYbwCB
 Ohy4EIq69Rpl3HdoFtBmuYp4uvIqlXgFdpVdxsJSA7V4jwP90S7TXoNQIn64dUr3PPyZ
 45vA==
X-Gm-Message-State: APjAAAVX6QeDC8R66JJWskoWEef+grHOV4Pdjp3azHNB+uvy8EhuSDWU
 wDz0UfyFgKGgSC2w4s+jh78pkDgYiv6SWrMnFaHqJg==
X-Google-Smtp-Source: APXvYqx8OvJxPf8G4QRbhuZSi7+ln42a9K/cVQCXx48Z15KBwKd2oSYAIc9bgTaah7rrvrBCPkaxLr2N2slRXpmzjlA=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr17417981otq.135.1580727355716; 
 Mon, 03 Feb 2020 02:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20200130213114.325157-1-stefanha@redhat.com>
 <20200130213114.325157-16-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-16-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 10:55:45 +0000
Message-ID: <CAFEAcA8J-nFZFawn49uDzDtQVMYM4qhXnT7Pb41gS-n_GjofiA@mail.gmail.com>
Subject: Re: [PULL 15/18] qemu-img: adds option to use aio engine for
 benchmarking
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Qemu-block <qemu-block@nongnu.org>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 at 21:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Aarushi Mehta <mehta.aaru20@gmail.com>
>
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 20200120141858.587874-13-stefanha@redhat.com
> Message-Id: <20200120141858.587874-13-stefanha@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -20,9 +20,9 @@ STEXI
>  ETEXI
>
>  DEF("bench", img_bench,
> -    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_inte=
rval] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buffer_s=
ize] [-S step_size] [-t cache] [-w] [-U] filename")
> +    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_inte=
rval] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buffer_s=
ize] [-S step_size] [-t cache] [-i aio] [-w] [-U] filename")
>  STEXI
> -@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-in=
terval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--patte=
rn=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @v=
ar{cache}] [-w] [-U] @var{filename}
> +@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-in=
terval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--patte=
rn=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @v=
ar{cache}] [-i @var{aio}] [-w] [-U] @var{filename}
>  ETEXI

> diff --git a/qemu-img.texi b/qemu-img.texi
> index b5156d6316..20136fcb94 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -206,7 +206,7 @@ Command description:
>  Amends the image format specific @var{options} for the image file
>  @var{filename}. Not all file formats support this operation.
>
> -@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-in=
terval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--patte=
rn=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @v=
ar{cache}] [-w] [-U] @var{filename}
> +@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-in=
terval=3D@var{flush_interval}] [-n] [-i @var{aio}] [--no-drain] [-o @var{of=
fset}] [--pattern=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{ste=
p_size}] [-t @var{cache}] [-w] [-U] @var{filename}

Is there a reason why the new '-i aio' option is added to the synopsis
line after '-t cache' in the DEF() line and the STEXI/ETEXI fragment,
but after '-n' in the line in the qemu-img.texi file ?

All the other options here are in alphabetical order, so logically
'-i aio' should go in neither of those two places but after
'--flush-interval'...

(This change is a conflict with the in-flight qemu-img conversion
to rST; to fix that up I'm going to just change the rST conversion
to exactly follow the texi here; we can fix the option ordering
as a followup patch.)

thanks
-- PMM

