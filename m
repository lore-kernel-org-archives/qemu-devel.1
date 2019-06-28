Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E635CC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45BC20645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOT42Qvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45BC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguLC-0004Oy-Q6
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgttG-0001fj-E1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgttF-0006dp-GX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:38:22 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgttF-0006ch-8I; Fri, 28 Jun 2019 12:38:21 -0400
Received: by mail-lf1-x142.google.com with SMTP id b11so4395474lfa.5;
 Fri, 28 Jun 2019 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+PC5nl+ig+mRBNdUabM7Gb+PFZU7gEoP5wibD+xDhCI=;
 b=bOT42QvneO7Q2nnb4emKDrlJlXJBNa0rhv6IwqaNxRBPKnp9adUddDUM7YrkxzhCNL
 IYqqm7ccfyakqK7x9dBSEoarKgtFZvvjcr5Natjeaz9eIwY5mE6kXMBvygQLw8XHYLKy
 XRPOkWDOjBODQho32P4ef83le7kLDu/lepUDGd0fNRo+ItxX2QCMT6RTp+NPkMPgFDR4
 HSHC4eqnULU8J96UbRogVR6qqhlO6mQhxAic5QtrFRG5GXc6B3RE31Pw6QE6g2Sa/FGv
 eqaHWguAZNGyXZAyhEWEY6XbtZS+WzUUaaNg/6Sdh3KqwfzkKRUYTVXEu+ebDr4UTUHO
 bzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+PC5nl+ig+mRBNdUabM7Gb+PFZU7gEoP5wibD+xDhCI=;
 b=F8KMzaBWq/GOL28L5By1B897NNoUlghbW8w25gvme/1R/us2ArSw4JeKYA1pySf43z
 w+ifebiJMUIqw9N6qIJDHT7S6E8hg9u+2sR9b6IA0c9bsmPldpCuYfBZXjRvZns9N+k7
 hS4OjG/EqvpXnkuPWqFXMXL63IkarOaAB7jSuf64TII1moA2a1NvhLDxdUdMhrfu3SAj
 RcFqNh/ambypbU3XocJ6nJGvJsfzRyHNv6vghoGFgibmLDz/d5y/CX6csKHfv0t4mPMo
 HHe4PqiZsoiuz+DJoMEgYjgWzi0Iik0dxgz9hWSNziq7XXvMVDKdQLRMs1K1is+ybC5k
 gTVQ==
X-Gm-Message-State: APjAAAULPML2Pg2f9Gveq+sFe0YBZ92rsOJz4XZAcdVM8b/+OkUD5UfO
 l9PfFbAXQnlJLqn0POCSWYRIWLNlGE8670yEY7o=
X-Google-Smtp-Source: APXvYqwQFBRfxw1s+Vq9rh/0wzk+8k72xa+8HW6dYkz9KghDNd+18P6/4DllfvgZzvlWtGYDDrMlNUHlLX/ijXs6SyI=
X-Received: by 2002:ac2:4990:: with SMTP id f16mr5309931lfl.93.1561739898726; 
 Fri, 28 Jun 2019 09:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-18-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-18-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:35:18 -0700
Message-ID: <CAKmqyKPDmO-G8APN1Ce9ZSxt6AxXwmjEfMYi4+v6fEQWWJT6Rg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v5 17/28] hw/block/pflash_cfi02: Document
 'Page Mode' operations are not supported
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:57 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The 'page mode' feature entry was implicitly set as zero
> (not supported). Document it exists, so we won't discard
> it if we squeeze the CFI table.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-6-stephen.checkoway@oberlin.edu>
> [PMD: Extracted from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 23d05a6308..01d9c5d75a 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -637,7 +637,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
>      pfl->cfi_table[0x0a + pri_ofs] =3D 0x00;
>      /* Burst mode not supported. */
>      pfl->cfi_table[0x0b + pri_ofs] =3D 0x00;
> -    assert(0x0b + pri_ofs < ARRAY_SIZE(pfl->cfi_table));
> +    /* Page mode not supported. */
> +    pfl->cfi_table[0x0c + pri_ofs] =3D 0x00;
> +    assert(0x0c + pri_ofs < ARRAY_SIZE(pfl->cfi_table));
>  }
>
>  static Property pflash_cfi02_properties[] =3D {
> --
> 2.20.1
>
>

