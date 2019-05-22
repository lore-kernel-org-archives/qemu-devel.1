Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE91C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D65C20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFmDxyjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D65C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQlT-0000yt-KP
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 08:54:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTQkj-0000g7-KS
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTQki-0003Vu-GX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:53:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hTQki-0003Uk-7H
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:53:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id j187so2101330wmj.1
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=+KWkFi//FAQqid7IlvA+ZIffQE3IaSpaD+VGk0hZWOk=;
	b=AFmDxyjdv1wt3Yr/s8deSbn4K1qxWU6bJHzU8bhFeTxr112mDMkTs7uBt4EcbHLSP1
	Nt2uL7hza/aJ5c9hgwIIC3VMHixo4b0dZlkdla/zUS5+phA32dZ3TzczcQ0qAaSGakaj
	mK6dh1lUKyGrgsagJvIUIrYLbGL4VVG8jtRVhfP9rysr6GZp8vJ34t7Gqi0Xt7UhVhCt
	ABmy96fLuVihZiZ5qxvJAr61PTEz6m0wVdpgNhzkCQ+3SgyA20fY5e5gcX0bxpw9QbWF
	vOoOltN/2lzqR9s2CKv1Av1WL64R8l/7bJCIYfGXb77vblMGVOAhkQz/yBMMeWo8vRYC
	dLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=+KWkFi//FAQqid7IlvA+ZIffQE3IaSpaD+VGk0hZWOk=;
	b=HTgYokYxxJ7lmIzd+XbxeNRgAiRWwFtaDu2bOl7TSP3E4umtAdGUEeIAzQcmxLtdgZ
	LR8cyHJR2dWlXkQ5PMgbjm3xToac2DPGVmctaTIpUQZVuUqWRuubxt0GB3IwrYTIo0bN
	e+NhIUhCIF1PyRouoI2gWEnPkK5nw5fp/ttXsuS4KjxPT6V3VBbcIPIWCcW/y7yEhrPQ
	vkCyK1oC2Fnreoly5VhOeAR2wWjpPVNNqOS7qZ3dEBrTvfx+de2srNqRRf9jPYJgFLj1
	d8XilPNyH28yAul/U96R/U87KwWYDUd2FmXMHrhgZaHWvusFpzi1yX+bqteWgHUBTRGF
	hlRA==
X-Gm-Message-State: APjAAAUlJp4yxICM9HKnZsS/iF5J6wgYCIgVc/66kRg10oLHC3WKgbgk
	kNYDv7ay7lckE4UXXE1mAQA=
X-Google-Smtp-Source: APXvYqw9hHo61ZkLLiieav4hB/4E3C4NutyRaUbrPtz9DB6wadgkTsIOECo/x6lYqyfJjZT2WiOjhw==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr7735924wmk.103.1558529630931; 
	Wed, 22 May 2019 05:53:50 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id 20sm7602009wmj.36.2019.05.22.05.53.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 05:53:49 -0700 (PDT)
Date: Wed, 22 May 2019 13:53:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190522125348.GH27900@stefanha-x1.localdomain>
References: <CAFEAcA-vSebWjhbFTdfOSGHJtr8-a+DKG22JU3tS-1OoGR=VXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-vSebWjhbFTdfOSGHJtr8-a+DKG22JU3tS-1OoGR=VXQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] is anybody experimenting with the idea of rust
 code in QEMU?
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 03:39:40PM +0100, Peter Maydell wrote:
> Hi; I have on my todo list the idea of some experimentation/prototyping
> of whether being able to write some components of QEMU in Rust would
> be (a) feasible (b) beneficial (c) fun to play around with even if
> it is likely that it doesn't go anywhere :-)
>=20
> I know Paolo has had a look at how you might write some makefiles
> to integrate rust into a C program (https://github.com/bonzini/rust-and-c=
/).
> Has anybody else been doing anything in this general area ?
>=20
> (I went to two good talks locally recently about rust-vmm and Amazon's
> 'firecracker' VMM by Andreea Florescu and Diana Popa -- I
> definitely plan to look at rust-vmm as part of this.)

There are some in-development vhost-user device backends in Rust.
Sergio Lopez is working on a vhost-user-blk implementation.  David
Gilbert is working on a vhost-user-fs implementation.

I think mixing Rust and C code in the main QEMU binary itself is
probably more trouble than it's worth.  Think boilerplate, duplication,
coming up with safe Rust APIs for QEMU's unsafe APIs.

I'm more interested in using Rust for separate processes that can be
written from scratch.

Stefan

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzlRlwACgkQnKSrs4Gr
c8iXTwgAkExa1ue/PlWJLfnhq7Byy1uAsyq9r+fpPjvaAlDs74BlbzztHkWAl+1M
GfMCvZ5amXvW+QU9F/XBcM+6OLtx26O3z+RngFe03R80UyCaGlnZmAfGDiCkBEyW
fLGvMgY+TDjwGinth4iF6bjZFz7mY3uKoVSazaEiythXchRWM4ObDj7qSMOsHvhH
7aGhGjhCPjkYYDZ7N0Sv0/3f0FmWbv9cJUaFvLYeILpj0qFMkKZalkrXlZyClmyH
PLop0Mw/QrgXrYk7N9O3K8fGL+rRXAxfM4jQAPk5xd6q1JDfaP4jwpGdo8T/31gT
Hrq9YSCyA27AsM16uwFJC4bwMnfV3Q==
=eoBV
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--

