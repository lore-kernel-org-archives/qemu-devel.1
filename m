Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C38C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F4B2083D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn2O/2n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F4B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmwgr-0003Sp-IX
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 04:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42131)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hmwgg-00034J-CZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hmwgf-0006ha-9y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:50:22 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hmwgf-0006gy-54
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:50:21 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so16169848otq.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yU3uj3LhiJlvRJtlYJDGUpRD71DW5B9pwYJl9r3+QwM=;
 b=tn2O/2n6/XJ0JIkfL2iaGj38/ibJniq1ewiM/EZlTdqMb/XRKiOZH4ARpaOI4qIW5X
 ZAYfDPGORXtI/+xpObwFlDiMBtrn5xD4J6fOM0cY+9biBdje6VrIzc98XDOPKh90i7/X
 +IU0SMMCMC/wz7nEj4HScNj0RTo+PiXhW2sFKKk+/5Tz+k5maBo03xpC3rM5LY6qV4ob
 vsc0eo/mBJh8UlBGDVhGGbyfWGV6cC5sCfgpZuxBs7G88zzxQ4xUFvaFP/g2Unq4DDcQ
 66GHaVnmidmGUoWPKv3xtnupC9O0SRQYzMjqVBsuVoo4NpdA8aTd+zynwr6VDeAo0Q9v
 AQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yU3uj3LhiJlvRJtlYJDGUpRD71DW5B9pwYJl9r3+QwM=;
 b=qluxUXYFCRXOwgtaFroonmfTiaKrLB912Ix/WEDYT5dfe9sBFpcKF6O9jXxo+xLDtN
 TXwfXW0ok9KkhNHiotyqzq92OYOLaMZwjtszaqgpuefy/TqvPh/bY3tn/6ansHuNqdfz
 mIy+O5KUaQwXofR7YVugXHCzJauGsC9tK6p8gm5n8+NM51DQejTiJMNRPd9zF78ez0qL
 J7p4NXmONG9roqDYhqhfH+q7zgXljwOOfe3IaEMvqFVsl/S/OT9fxV7HubVqHpkBVMQT
 PmMbUQ2xueZIckBTVGer7Ojhbaz8VY3DlKFGSnhYQfVrE2y0PeH6T8LhYhGPBdhhqdpb
 vI8Q==
X-Gm-Message-State: APjAAAXeNKILTR31tO/qeG6XmPPtkDfHLxkaR1g1uahHBmLQIQ0i4uyL
 MxMT1OA1S9elh8mdQGvv6LogAzSYAlzM7zsp+WuFH/PNObk=
X-Google-Smtp-Source: APXvYqweMSiCtTRo+yTBqlcOnjBfwLqlp6YwlAMNHvh0uWmO6wV+9OKZwlptUgjiCZFI8G19d6rVNaRJnTk7XdF8aTU=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr17950106otj.97.1563180619956; 
 Mon, 15 Jul 2019 01:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190715055736.15214-1-armbru@redhat.com>
 <20190715055736.15214-3-armbru@redhat.com>
In-Reply-To: <20190715055736.15214-3-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 09:50:09 +0100
Message-ID: <CAFEAcA-_rUtYj=z6fqBZgcQXUVOKR4ihWCAehyE8LCq4MQouVQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] qemu-tech: Fix dangling @menu
 entries
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 06:57, Markus Armbruster <armbru@redhat.com> wrote:
>
> Recent commit 2f2c4e4731 "Convert "translator internals" docs to RST,
> move to devel manual" and commit 282d36b5e2 "qemu-tech.texi: Remove
> "QEMU compared to other emulators" section" removed @node, but left
> their @menu entries behind.  This broke building qemu-doc.info (but
> not qemu-doc.{html,pdf,txt}; how odd).  Bury the dead @menu entries.
>
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Fixes: 2f2c4e4731449449a2b1aafcd73e4f9ae107d78b
> Fixes: 282d36b5e27ba86d42d0638430e439c2c257367b
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-tech.texi | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/qemu-tech.texi b/qemu-tech.texi
> index 3451cfaa5b..0380de77b6 100644
> --- a/qemu-tech.texi
> +++ b/qemu-tech.texi
> @@ -3,10 +3,7 @@
>
>  @menu
>  * CPU emulation::
> -* Translator Internals::
> -* QEMU compared to other emulators::
>  * Managed start up options::
> -* Bibliography::
>  @end menu

Whoops...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

