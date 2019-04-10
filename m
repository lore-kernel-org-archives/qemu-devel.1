Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368ECC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D142820693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL3Zx4TT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D142820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32795 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEEgG-0006mR-1N
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 10:58:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEfL-0006R2-Hf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEfI-0001ON-2l
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:57:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hEEfH-0001DX-Ib; Wed, 10 Apr 2019 10:57:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so3382483wrq.1;
	Wed, 10 Apr 2019 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Ud3SIgCyBmMKx2t8jyT+fH998eaYUPk3F/Rgxkjzu94=;
	b=RL3Zx4TTkk37vIL3IIk4oRIaBJqSM+dOU86r5eNCIzD0lRcpVjsLdi6bQ+95p9S6um
	3Lq0+hVGrhprRL/eskjZs8UJOus8n7Y7JhImods0r2h4y9BSQttkD3Xx8X6n8Fpm6cDD
	pybDIJUF7kou3M0PtrRQjzixZ9HEZtVr3u12CS6xENSqWxFGJav195xAfrhH0VH530kg
	ASnTqEpypOavAIi6l6EOfR0aZTUJP7O7oWCUb0W9DPgBP3mAcFc7lfylpqs9A5Z8xd/4
	aslWZgBC6X9ZXEzPWvb0GuNNRBKLh8EDJUzUOk9CkVsq9ZTMHG9fZJQpRtu6PGbRBado
	9g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Ud3SIgCyBmMKx2t8jyT+fH998eaYUPk3F/Rgxkjzu94=;
	b=EZDgVrhTGUtYOrDOvrBn5QL3/qZl/Gd0oeP/1NTaoq7VaP5O+59Y38hbGQ3Nat7y39
	kMgjMV2+vDae5aeFdBcjwrxCrq2uXp5/fvSjf74swPDaebumaILyPXth+YT78sU1iRKP
	ibnI6cdHbxROmENjBBesE/9s77S8F7jf0I0r4ut0rtUpRDw4v2Yt9bfBBVGkRskUgD57
	12QB+Z1sHmdcWQ7IxBi1r+pUoB6DJZ+z1BgY7suc7Ej5GX616Y3vZhEv/t+4z0YWk3wI
	4PGg5Kzl4hAUG3+cPvFE7H/7PYaupWpGn4sQlx5J++3IJt543j9ULBJfFb/AMgiUQ927
	y8wQ==
X-Gm-Message-State: APjAAAVPglRSaDqeK7ZyRG/hO2c6CPFvkOC3XC2u/rCwar3YAvb/t+lS
	KslvY3q0fPCr1RI0ssnBbml1+10064c=
X-Google-Smtp-Source: APXvYqxqnSdafVLo7ZEzN5hyaD2XIpyy2oNp/PW2NRephXM5vNsOeliJTlH5Q/CuxakyMVBbB54QcQ==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr17140132wrl.214.1554908234980; 
	Wed, 10 Apr 2019 07:57:14 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id t74sm8125041wmt.3.2019.04.10.07.57.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 10 Apr 2019 07:57:14 -0700 (PDT)
Date: Wed, 10 Apr 2019 15:57:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190410145713.GB11035@stefanha-x1.localdomain>
References: <20190409122823.12416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20190409122823.12416-1-pbonzini@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0?] aio-posix: ensure poll mode is
 left when aio_notify is called
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410145713.rJoYl7L8T0srEy6RhO924p4nMlVUvguBq2B_nGRZsJg@z>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 02:28:23PM +0200, Paolo Bonzini wrote:

Why is this 4.0 material?  It's not a 4.0 regression and tweaking the
event loop is risky.  I suggest waiting for 4.1.

> With aio=3Dthread, adaptive polling makes latency worse rather than
> better, because it delays the execution of the ThreadPool's
> completion bottom half.
>=20
> event_notifier_poll() does run while polling, detecting that
> a bottom half was scheduled by a worker thread, but because
> ctx->notifier is explicitly ignored in run_poll_handlers_once(),
> scheduling the BH does not count as making progress and
> run_poll_handlers() keeps running.  Fix this by recomputing
> the deadline after *timeout could have changed.
>=20
> With this change, ThreadPool still cannot participate in polling
> but at least it does not suffer from extra latency.
>=20
> Reported-by: Sergio Lopez <slp@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1553692145-86728-1-git-send-email-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: use qemu_soonest_timeout to handle timeout =3D=3D -1
>  util/aio-posix.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrgRJAAoJEJykq7OBq3PIm+MIAML0auOsbBS21Irwntsw81N5
tVlao39CV3V24vxR+959LSWlPrT6ez39VG2cmSyv9KYEOgB6EIOzxaig99UfB0uK
c7ebePFhHdgslTeR4j+eBvgn6FWjQO9Q4QuB7orWiZaBTT125DFTlhaz8GZwxorm
dOIcGfCsCwO9fBP+gn29lgUHxudhP+PRuEaNpqtxjbEUpX8QrSWhpMvyUaza9pSN
c6fM8bWsFCZeafkSLs50dZiOWzPAgQHtIlorx/0lA1nvsnAdO9dUUfPM8t8qk8QH
Tga35fwcjyD/QnwLCMpIbZtZgXR8unl9rF2QImrgSCIjEgner2UNQPTQ9+QaPMc=
=y/1/
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

