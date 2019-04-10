Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8340DC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4682420854
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTJl6GMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4682420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEF3G-0008Ek-7w
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:22:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEwS-0002LW-NG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEkl-00050g-Nf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:03:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hEEkl-000501-9Y; Wed, 10 Apr 2019 11:03:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id s15so3323989wra.12;
	Wed, 10 Apr 2019 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=4u5ikV2mcJohIqwdsvLuzluNaH++1Z1tZwJF5NL/vsc=;
	b=UTJl6GMUK24Yr4bwb2pE+wJdaSzLSH6MoaTF4mraVFvI1TZd1pnP2u3Fi0438X1MI7
	UaTdEMakAWY9KX6fltsnGNrMGZGFhFugnhuzWwJ7SoeDtlWQy/8F5K7twxz2s8LWZOK/
	1zPtlE2wswG20Ce8ag9VgikCnA2OgudMdk08X2GFSBcU8s+O83nefgpZpzEiyzbIQhTC
	JA2maSj1+HWx3lBQlpuZCDPRtF7QpPVs5BOd9nb1zErwgZiMwS9iZF4aKEeRW+rPbTCg
	icQ17ewWj62MyXAS65X2j/S6VpyTQTaN7XdSBhi7r6qa46zxZYXYPXsEXRZo1MFSd0mR
	17Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=4u5ikV2mcJohIqwdsvLuzluNaH++1Z1tZwJF5NL/vsc=;
	b=Ty/wA28ExcGlBO7TON7Na8asJUcKPGs9VVCyvTAgf55Px4QIqlEiCV6cH93Bnd1mlm
	F3ITIb0idG2XR7wPLHDAsVUREXS1e0oiQvSrRlCEIzme5go7ngG3abNNCwfWkMBO8hkz
	U9WtCvWbU58ZzOQSjFvjTeP+1wghCeELSAGG8ymzjPRNZ8d1B2EsTKfd8eEB/kqFnxM/
	ZlwdqEYv66dTdKXM3+hensNxm3ncRzXywUcdF5GcP94Xrgz7BALjQzuMYYQviPiGRNZy
	tWePPqd+a06thiiWBhdjaco3ZqF6WNdasi12eVLYMr6eNYDs9PHJWuA5zL93rpBwR5Di
	Utvg==
X-Gm-Message-State: APjAAAUIxVNRkZapvzEWhn6JkESaUewcIKt0kPvdNxouUct8sx25YioY
	dfpgEJRafW9z+OG3+5KrEeo=
X-Google-Smtp-Source: APXvYqz32zwRWqKNxwnLkGmUOv0y+/NnjMO45b5k+HvGYJQcv5TXiMcFtD25BKkrm+gIxHTRiAhniQ==
X-Received: by 2002:adf:e790:: with SMTP id n16mr16912744wrm.292.1554908586036;
	Wed, 10 Apr 2019 08:03:06 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id n1sm2018494wmc.19.2019.04.10.08.03.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 10 Apr 2019 08:03:04 -0700 (PDT)
Date: Wed, 10 Apr 2019 16:03:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190410150303.GC11035@stefanha-x1.localdomain>
References: <20190409122823.12416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20190409122823.12416-1-pbonzini@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Message-ID: <20190410150303.5vvkMuzrhQEW0WyhPXcvVUmADYCYHah9kZ5f5ckr7qg@z>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 02:28:23PM +0200, Paolo Bonzini wrote:
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

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrgWnAAoJEJykq7OBq3PIjywIAIYjMKHjVNwEQGlLNJRHLlSQ
PHejF26dHEYZxCCQkOl8VNrugqewMktEsLiyKpNMClgnWAy+mSyMGr5jFk02v2WB
Up0Ulyh8mCHNlRDWHkbJ/68Bwu5IEYJG9VsmKvMVsAsp8JfghUnaZk1EX77xEC5V
ET2koBSudiReu3UvV1HJiNrUP0eFMrpQgmaIzJS7Dyi0cL7RC7zSF+wQ04xYbTlp
iQ3AylU0CbC3cTo9s7OZbCzLaYcdG7isL1ZIcPCBhMIxydyOgmhVsZ0MiK4XvJUs
EYoBFMUcZIROqcqtGpr3L0EhE1nSV5NsCQ05ZDEYfQI9TiJs90sRNwqT9vfJuBU=
=bF7p
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--

