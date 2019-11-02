Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F10CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 16:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FACD2080F
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 16:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FACD2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQwkY-0003U0-Ew
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 12:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iQwjD-0002px-FP
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iQwjA-0000Gf-Af
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:58:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iQwjA-0008Nr-52
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 12:58:16 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 535C485536
 for <qemu-devel@nongnu.org>; Sat,  2 Nov 2019 16:58:11 +0000 (UTC)
Received: by mail-oi1-f198.google.com with SMTP id v130so7901938oib.5
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 09:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2jSpwmZaDSMA0WmkwmiZE/EaDVe/p6WyRu3qsrw0Ep8=;
 b=aikJfdeKkdehJSjfnJlmolEJRK5XyTUtS+Mc8Db/VkmwizNtpjOKOYq1JZVHhqLRTh
 5pyySyc8jmXWOor2nL77OZ8t8oWFn3GekmOClalA4Qbs8AyddXVKuwduwJsVzUVh27r/
 lPMIVLCkYahRrCTLDKXUlmYRyAluppUzmguHn4wmoYnC4i3LAK91t3Fg/oN3T+qWgMxw
 ktijtZ5r6c+cUUXL6fIH7OvQkoPyYRRB/kT17S/Lf50d/g4TkjkeY6YXjHvMunI3P68J
 pGdRYDWcbevEfT9HQKLCceeMu86bl96qD6GeRNcQs8mD6iB2en1pYcDT5ApGhYAZG4/w
 OcFA==
X-Gm-Message-State: APjAAAWcZRttzudmsY/htmQ1EJOzPvFzykdUdkpaD8Rd5uvYn//TDPqH
 9zInxDA3DkRJPB5f71+UyHK8Q7U17SorUixoxuARwT11NsDi9wjxABIOIB48a6LK2z2shVAm3Vo
 yF23kwQyZovtr/adPxxQ0tjwHTCxLFjE=
X-Received: by 2002:aca:c7c1:: with SMTP id x184mr8281672oif.158.1572713890778; 
 Sat, 02 Nov 2019 09:58:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTto/GKdgwzddtNyMFaYuvELq/XtAZLhCv0cFVUERODd6QVrdHXA2c8FQM1y4sE6ypOLT5OQLAIKfcLO+bda8=
X-Received: by 2002:aca:c7c1:: with SMTP id x184mr8281652oif.158.1572713890401; 
 Sat, 02 Nov 2019 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191102114346.6445-1-philmd@redhat.com>
In-Reply-To: <20191102114346.6445-1-philmd@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Sat, 2 Nov 2019 17:57:59 +0100
Message-ID: <CAGxU2F6TKSwwCBMESc1GoikzwhHbtZwxpUHKAqpSAE=Sk1yyUw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: install bios-microvm like other binary blobs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Bruce Rogers <brogers@suse.com>,
 qemu devel list <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 2, 2019 at 12:43 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> From: Bruce Rogers <brogers@suse.com>
>
> Commit 0d5fae3e52e introduced bios-microvm.bin but forgot to add
> it to the list of blobs being installed.
> Add it to the list of BLOBS that get installed.
>
> Fixes: 0d5fae3e52e "roms: add microvm-bios (qboot) as binary"
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> [PMD: Reworded description]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
> diff --git a/Makefile b/Makefile
> index bd6376d295..755aa6c5f5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -770,7 +770,7 @@ de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr=
 \
>  bepo    cz
>
>  ifdef INSTALL_BLOBS
> -BLOBS=3Dbios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bi=
n \
> +BLOBS=3Dbios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin =
vgabios-cirrus.bin \
>  vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin=
 \
>  vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
>  ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin =
QEMU,cgthree.bin \
> --
> 2.21.0
>

