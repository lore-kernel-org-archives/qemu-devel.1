Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FAFC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309D82089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE3eVgc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309D82089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRIc-0002oz-Bv
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:28:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTRH0-0001N1-Nx
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTR71-0006ib-Bp
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:16:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hTR71-0006g1-5C; Wed, 22 May 2019 09:16:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id y3so2217598wmm.2;
	Wed, 22 May 2019 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=h95/ojYiJJWsLYlCDAz4/5udM42ib4fEZVf0a+qphrw=;
	b=JE3eVgc94DZj1+ZHlAus/bkp4hpMaVpBb5YLl6vsEhe8iHtlwwqWCeswrZUAY1vjGf
	U3MDb/LN0JJa20frKL3zvB9tW8eDTU6NKIkSSEkMmXPx5vz3WNf22532s4FsYp3bXFmw
	+KiHanOiuzPmq1Lbccz6dJ2FJGofVDL7CZu44cFw9tNYo/ABmiTqISWOMN1vOpXRhxz/
	HNSDJRqnatznAVwytcMGnW41OPGkH7Kicdny/PdZljamBQYrPbWnwkntFzuZF7QqfPvz
	GaTEVa5TujNO68lORfLfePMbidd/af+DDfz2XkW4ZHqutB4TIdIG4yMudmosgWzxY10+
	JzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=h95/ojYiJJWsLYlCDAz4/5udM42ib4fEZVf0a+qphrw=;
	b=sEt7mRvNC3cH7fth3xR4mpKUTXaoUWgLEL3VtR+ZAaCKe8kDwy7N18cCZwnUcG8umf
	ousxTpFQVRcCVhEIn+l7AiWlR9cF/OC/ln2c2A2Z+8dEc9cVW2PHNOT9LBwm7A8htyo2
	8ju2KbzZtZyvDGSpbxCFucOHNp43bcH7p1wJt1PJEZhzvfjeDZaP58mQUAacHkAHpvim
	pDJG/8exlqsIDe0jv8DyfIUAhx1kiewpBRJDg5s6E/1xj31gx5AADwm8Fw5Z2ZqV1vWP
	X+tjZJznRr6rDqbDkCd6a5hyoy1oSU40WQu1EvBuu3f33GRPWBX+ID0/vFfBOtLfmEmt
	snig==
X-Gm-Message-State: APjAAAWlH8ldfs4HHZM/AAYZWlYBiNs5wXQPcV4+00RrLQ3ruRX5uP0f
	fPq26b1bhXnEtfFFWyTzidg=
X-Google-Smtp-Source: APXvYqy5wOjtpyacg3MtWIld5P1vVLuyfFYGdfq0w/poDsfZbT2Aa5gYRwMuxbLfDjJU3SgCPmzXww==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr7140643wmg.30.1558531012891;
	Wed, 22 May 2019 06:16:52 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id y1sm6399325wma.14.2019.05.22.06.16.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 06:16:51 -0700 (PDT)
Date: Wed, 22 May 2019 14:16:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190522131651.GL27900@stefanha-x1.localdomain>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-6-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline
In-Reply-To: <20190521235215.31341-6-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH 5/9] util/asyn: add aio interfaces for
 io_uring
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
Cc: saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 05:22:11AM +0530, Aarushi Mehta wrote:

s/asyn/async/ in the Subject line.

> @@ -341,6 +349,25 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
>  }
>  #endif
>=20
> +#ifdef CONFIG_LINUX_IO_URING
> +LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp)
> +{
> +    if (!ctx->linux_io_uring) {
> +        ctx->linux_io_uring =3D luring_init(errp);
> +        if (ctx->linux_io_uring) {
> +            luring_attach_aio_context(ctx->linux_io_uring, ctx);
> +        }
> +    }
> +    return ctx->linux_io_uring;
> +}

Personally I find functions that are written to have a single return
statement hard to understand due to the nesting and multiple code paths.
I prefer a straight-line approach that returns as soon as there is an
error.

This is a style thing.  You can do it either way.  Here is the same
without nesting:

  if (ctx->linux_io_uring) {
      return ctx->linux_io_uring;
  }

  ctx->linux_io_uring =3D luring_init(errp);
  if (!ctx->linux_io_uring) {
      return NULL;
  }

  luring_attach_aio_context(ctx->linux_io_uring, ctx);
  return ctx->linux_io_uring;

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzlS8IACgkQnKSrs4Gr
c8gWMgf/WN/jjYPA2jD1jZuoyZRcmd+fKm1i6AICHOguAvXXOVvcbSdJhiceE71h
Gfbdl2XgxMdr+UPlTxJsdjazxgRx97YLhh+i/DYhqncGozeMmNRdqJYcxsRhKe4K
63QFyXiUt5dREZ/MC/TacCYOegr1/1kpepWzG97ZYfFVuTTJ2xxPnhG0RSJHoAVA
hCxufg1tHkj6eGBwvEwGDrDHfqr/5P9/2KwcLRlSBuPRlMifb15X12BeCWIOzKMt
09+QlmeoSJYYomC3UBfxOYBOPH9mk2XQB582+cl/YLggl+hqG2pzo8MvREgFV98f
pyBOI6oHdJlo25oy3aHLja+4IirJjw==
=87ck
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--

