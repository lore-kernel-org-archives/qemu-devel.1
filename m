Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA7AC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB5427C92
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLDddfab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB5427C92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXhBm-0003Q8-Qj
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:15:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hXhAq-00038g-72
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hXhAn-0005Rp-O3
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:14:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hXhAn-0005Px-Gw
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:14:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id e16so2533701wrn.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=vfBc/nNMUN4P1/DVqWOdYYzRnmuwmKZSYfuSfT0Fuu4=;
	b=dLDddfabY0N5I+wcYJttEkoNDgRSTxjjYgoKWnlr4NiVcjXnJpjAj8kGMYfPtyyxmr
	q2Yvz/pWRPA3q+YRQ5LlS+7DY4Tjxtphy/1pjax7TdQjJq0wdnUdBOzhByZqV1Jxet4B
	LqDt2xlrXB2lAYhN5idnZTIIw4V/RMvZ4SRIqzflpk1stHYRY6r2h3fg/hWtBUqfvhip
	5uB+7/77bg1GdIOpgs7MKjzaoafYHVROTRj3bEaIRTRFf/8hVIm4yi0BCbhzmQKFX6ZS
	Ks1cxJz3S7AqoC84TmONm/Ug7r52+WmA+8ynW7GQ5iSV/LYV/hwfG2E9AMVl/YgBVw14
	GriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=vfBc/nNMUN4P1/DVqWOdYYzRnmuwmKZSYfuSfT0Fuu4=;
	b=QFRkeySGoiYTJDl5m8KjlIHoac+H2g6v9+aS1OTYTE61yhcS14GlbwVJGva5WXwLPY
	OQ6+jVtlEg3BcpvtKzUJWywCnsn38Gygx9qkfmyGBus8LMJdpYZbphHGkG2JmaHI7/gU
	isFkx/KOWBPXrqusitFQODINxCPs0V0ArW8U2Y5Qoed2Rpa7JSxojhDxteiB2itKpGrd
	ruavybOr9RMVUbWX24MiuLRHaey7MsRmGLbZqKKk+sTo2grWOPwjFZbw/XeUthUNhEHt
	wwCGllVoY5GqFHeVeW5EnIdZMomxmwS+Ae220eBYp2gqngdRpZ9Dakun/4YG2wK+F5Pw
	rJSQ==
X-Gm-Message-State: APjAAAUXz8ccM23Vl6modEw4MO9ejp5muogy/HjEYOz3mr6F6cZ4CrXk
	gMKNwcWay9IVVmYYwSaQs4E=
X-Google-Smtp-Source: APXvYqyLAuFMouMQTv4REZrhd66HYVYHUZ3XxeJyIyZYxYZetj56szm1yZUhFgFFmSvwHppTsuov9g==
X-Received: by 2002:a5d:4992:: with SMTP id r18mr1341075wrq.107.1559546063805; 
	Mon, 03 Jun 2019 00:14:23 -0700 (PDT)
Received: from localhost (77.119.131.150.wireless.dyn.drei.com.
	[77.119.131.150]) by smtp.gmail.com with ESMTPSA id
	l15sm8139368wrb.42.2019.06.03.00.14.22
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 00:14:22 -0700 (PDT)
Date: Mon, 3 Jun 2019 09:14:21 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Julia Suvorova <jusual@mail.ru>
Message-ID: <20190603071421.GA6338@stefanha-x1.localdomain>
References: <20190602201709.11901-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20190602201709.11901-1-jusual@mail.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] block/linux-aio: Drop unused BlockAIOCB
 submission method
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2019 at 11:17:09PM +0300, Julia Suvorova via Qemu-devel wro=
te:
> Callback-based laio_submit() and laio_cancel() were left after
> rewriting Linux AIO backend to coroutines in hope that they would be
> used in other code that could bypass coroutines. They can be safely
> removed because they have not been used since that time.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  block/linux-aio.c       | 72 ++++++-----------------------------------
>  include/block/raw-aio.h |  3 --
>  2 files changed, 10 insertions(+), 65 deletions(-)

Thank you!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz0yM0ACgkQnKSrs4Gr
c8gdoQf+L0uX8dgFgERclA8pTQFAbb+zhAVDQ1ioCGCLWlyNYUN+cRBNe1uClxDi
tPhW64kD/A4kdjIJtUq7w2D2HR0cXiDCiIQxVC2bXNH4kMBOkzSlKuSEDpSZ3a2y
MiDw6QTjKeyBYtD+EjDQ/zdMOKAVKrNxggNFXgFAuQylO9GDOjCi7TWKOrnwsqBw
lhDHT6J+1J9zCmwBioEVOjERwU18Oc7XsyvmkhCHy7XTyfrKOOFkdQBLwZv4JzX7
X8bZ0Y9DIzOmrfQ+keBo4xQ/tljcI5ldYEWQuGmMxxjSzldQOMNCb4TQ8MeO8WTx
0X/gQhRWGdvdcT7dedTOzGQZEwHhUA==
=H2K6
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

