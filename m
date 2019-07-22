Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAB2C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8B0218DA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2ykFDRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8B0218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpX5k-0005hy-Ip
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 08:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpX5Z-0005HQ-7r
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpX5Y-0003g8-7L
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:06:45 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpX5Y-0003dD-0T
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:06:44 -0400
Received: by mail-oi1-x243.google.com with SMTP id 65so29347159oid.13
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=K1X1yXAbotw8Asih028UQ+9mbBQKJXZru9lYiZgqWg4=;
 b=e2ykFDRMJJEI39kOOjHRDdu50mfkl1HMx9fWDZxhPKO3mYCqgdJ6RVDlw2i4KbeMJm
 mjcxrVO6yRfFEJK4ixKeUP1JdWLgjYSuzTVBvErb4wt9LQNIUbZ4rBUxrswHnPkU7B85
 NaE4YHIlGpWML8yqZjQBMmdvNG0CiT+2HcyeiJtwcSZGemBvDYNI0i5AHIxpHo59Disa
 bt0hwc1Uc1TJUh3PJ8iwKLd8s+h/tYgRM14E7UXziJmYrjc0ySfQF1N3WUXaLA7Nj+CY
 8stS+6tkZ/KZuQ+FNEmlWcxBBxGgxrozCicYPCIXV0UddaVIiKYMeDVHWIaOeqZkQ7RQ
 ejsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K1X1yXAbotw8Asih028UQ+9mbBQKJXZru9lYiZgqWg4=;
 b=jl3eg63YYIJ8X3n4L33/MVCFJsagIbbaqS9Mv6nuM1SRTFY1FB2JavIDEgXFda5hIF
 B3OFQ5IH2/d/1+gIxrOyOvTFXHtetVx5gDGnsyrQ9GvSuoIjIgzrjCPiDcvaPNrZMIzt
 +hTFU35hOVutUCHLW4/+UGkmh5eHys7K7FZHYpCcxh6rxC3FkF8I5sU84P3GCt5QQKV6
 u6L5dS9Uew45uVVsfztTY2D6r70smBqHAHIO1Y9QziWfe5aou7vWZI5VmhLs5l/lG2Qp
 H6lXA/3nv4BPmqBhO74BeV0wFwIEpgYtITWY7XScAI0IPCbna1wn+AHyQuKcuFAeQumo
 zFzA==
X-Gm-Message-State: APjAAAXxRJWXRsUdL1BOG7w/Pmg1a9LMrlzpOOELO7cmT3KKV6UASfNq
 OmB8Ye5OFk2dsKAF6VyanLUuOfVnB+ELfTsG3YkmIQ==
X-Google-Smtp-Source: APXvYqzEgQ5hruz+VjVezZHWO1N41XX6ZtcaPz8CLUrF6GLeVIJfAqN7chhf78ezLJq17h7ccFwT6NRrQhJCDSg+6+0=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr30982543oib.146.1563797202635; 
 Mon, 22 Jul 2019 05:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190719100955.17180-1-peter.maydell@linaro.org>
 <CAJ+F1CJU5iUDa_W2Vj0WMBEht3eVJ9xsUWt4nCE4-eC14ei4hA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJU5iUDa_W2Vj0WMBEht3eVJ9xsUWt4nCE4-eC14ei4hA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 13:06:31 +0100
Message-ID: <CAFEAcA8LtjAEp8BKPatdFEjcjzjsrThguUxCXB3D5j3VyakFUQ@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-4.1] contrib/elf2dmp: Build download.o
 with CURL_CFLAGS
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
Cc: QEMU <qemu-devel@nongnu.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 11:18, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Fri, Jul 19, 2019 at 2:10 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > contrib/elf2dmp has a source file which uses curl/curl.h;
> > although we link the final executable with CURL_LIBS, we
> > forgot to build this source file with CURL_CFLAGS, so if
> > the curl header is in a place that's not already on the
> > system include path then it will fail to build.
> >
> > Add a line specifying the cflags needed for download.o;
> > while we are here, bring the specification of the libs
> > into line with this, since using a per-object variable
> > setting is preferred over adding them to the final
> > executable link line.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks. Since we don't have an obvious route for elf2dmp patches
to go into master I'll just put this in via the arm pullreq
I'm putting together for rc2.

-- PMM

