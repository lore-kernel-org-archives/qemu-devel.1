Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D654C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28156206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chhlb3Yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28156206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsMnV-0008KE-GV
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 03:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44368)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hsMn7-0007ov-D0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hsMn6-0000pL-Jq
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:43:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hsMn6-0000ol-Dl; Tue, 30 Jul 2019 03:43:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id p13so64557248wru.10;
 Tue, 30 Jul 2019 00:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4+vY0/fc4hOqHsfxkymmfBwT3mHd9oZtfA/cVdSMdUA=;
 b=Chhlb3YoEdmkv56xKJEIMoyx6Lbz0U6hP/iKg7LswN5EhOYHqyX6pDo7NUPudWgRa4
 4mBzpZofmoHFidt90o+OCaJ/3REW8Cf1/jJS+F+635LenfSZ6hVpY+LPE1MRMOI5E4Nf
 kEcGmNx6qCadh5Gw3FloSK13z6S+riOJjN3YHjfs6HS/QQLJEbPJrZmPHzrBQs1amLMW
 m3Y6SGf+A+bxLf7j9dAk550Dh2fo4N5/R8WKjoQsz4xkxdFXhDqDp3UjZCif+br33PW9
 GZt/+EYGcAUNK0UtWMe8rjzMh58iZFlDR4Akl/CBy9qFPANY8suLCgayu3LsAUi06FMM
 JK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4+vY0/fc4hOqHsfxkymmfBwT3mHd9oZtfA/cVdSMdUA=;
 b=DxhCl/eQdo6CC63DQm/VJkLGgKfD4oCW2DZECKw9xchoGf83VXyQkaGrY3PrwxvESF
 777kstMgSmJC/mKe1Kl3zN9PJx/RN+wYv+WV4HUty2Y7TB32Q/Is2DEsAsExfpwWWeog
 YTCWrTKdYuTC/Ciw7s7GCvmePQK7lqWf/5VnAhov0LJBUa9G3NNRUrGM7AxfRC9lt+6d
 90mXxXLiKzPBhB2Vr0n71RP7ycXcxzlOKcibGtOXKSQU9Dgg+/0Tvkdz4FAYUEzpDcFr
 YlIB3rfBXE5Amtk6qcgyKZLOrmXt95jNklWxi5J8F6dmIhqWQ+CRDmmsQqRM7+G/eSuK
 h0Fg==
X-Gm-Message-State: APjAAAV4pn67BEylUk5VePXL3qGWwPXwgyou8hEDULe5EviRWgKacDvZ
 8To2AorDQVFQy4j/4yI5gnQ=
X-Google-Smtp-Source: APXvYqyppwmw0zVL6CCHh8KrTT8LVImIlR2iOnljmaemfL4YbHJRld9AhdExNYHe+oelvVr8bpaZeg==
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr36610488wrp.203.1564472603268; 
 Tue, 30 Jul 2019 00:43:23 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id j9sm74441149wrn.81.2019.07.30.00.43.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 00:43:22 -0700 (PDT)
Date: Tue, 30 Jul 2019 08:43:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190730074321.GG30213@stefanha-x1.localdomain>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
 <20190729151651.21306-16-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <20190729151651.21306-16-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 15/15] tests/qemu-iotests:
 use AIOMODE with various tests
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 08:46:51PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  tests/qemu-iotests/028 |  3 ++-
>  tests/qemu-iotests/058 |  2 +-
>  tests/qemu-iotests/089 |  4 ++--
>  tests/qemu-iotests/091 |  7 ++++---
>  tests/qemu-iotests/109 |  3 ++-
>  tests/qemu-iotests/147 |  5 +++--
>  tests/qemu-iotests/181 | 10 +++++-----
>  tests/qemu-iotests/183 |  7 ++++---
>  tests/qemu-iotests/185 | 17 ++++++++++++-----
>  tests/qemu-iotests/200 |  3 ++-
>  tests/qemu-iotests/201 | 10 +++++-----
>  11 files changed, 42 insertions(+), 29 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/9RkACgkQnKSrs4Gr
c8jZAAf8CYIze2HIlLSiW5jmIziyjs4Yv926Y1rSvVuoD1Mqm2y0wypkAPcgPWEm
P+H3/ps5ypogkrGTV5jp9Yl5MhL1NaSAMQQ22+Gw5Xq0cuPSrIgQRliAZqZKUl92
WJE+PD/JRqRf2FXY3czo5zzyBfTRz9KfKOapTYuJvBHh+Sq1rBfSaAjQCifQ5NwU
eToKwhnyEYCkt4XgG1QZdAqNZF8aIQXalhGaY8POr4mG77Vg6ZiBKP0phsjFpBSG
0EWpCpNyk8la002cgki69X5MgrEPlQu/avIQZ0y2uBJ5iUrKUgNrEgHkd17ZzloG
8yyq59CMonjkJWcmRmr/AsT86iCSaw==
=3f8O
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--

