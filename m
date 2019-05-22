Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A7C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DFF20879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uiff/gna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DFF20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46585 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTax-0002cf-DN
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:55:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTTRg-00040Z-Ek
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTTRf-0005NA-H5
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:46:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hTTRf-0005I7-9j; Wed, 22 May 2019 11:46:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so2849513wro.8;
	Wed, 22 May 2019 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=V4OTrUDnUFdhkPJIZbmDI/lgnifrNG7tjecGshAcfU0=;
	b=Uiff/gnaoZ+C6JABOPwEAoKQfME3jB6JEweWwmJb8gW+fpYX6M+D0C4WTdaU1YIrir
	xDy8pkcR25MWWBozEgvNjtKKXiWHWoXbhs9SR/InPWA3boh2p9UIcnD30gJ3S25ZMGJ5
	DnPEY/R7MXX4yGCCR6vB/zcpUnSWAqbe1ZPEJprwrhCHyI4Kj+eFH50/1x4GsNhHWpkO
	0w8251XOV4N8MP1e5VeUMnT68kyINaWgBtwnDGJu3YZTBICwVTBIgb0cz9SZ1nIuPS4N
	/MjITH79oBqrLltHmkUju04xfd51jeoxnUAaN/CZgg6M7pDH7h5mSmMpJfCZENTPfnrh
	Zzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=V4OTrUDnUFdhkPJIZbmDI/lgnifrNG7tjecGshAcfU0=;
	b=p94wyXrsSyhZtDvdNcnEtQzw1xG7x28y9E97DQ3Ipri1+i1VKMgAeH5Dsp5U4A2WgR
	K6aUQkAVPBWNq+6rGY7M9za2W+vFjvrejYPnXQ1GU1jK/BxtB2cz9+ApPRDE8nTiqrij
	DXyzWOoU+Lg/FtKmdAI5CfREjIdO+egUuz3VIkHSaBVaAbYdTUVRMDh/RwGLHsT38oOT
	6PyXeTyxMZuAIHAGGnSE9QZjsGEEWkld5l/ULohjnmrCqYslI6OTsF7e5PTl81bAOeuj
	T51og0mUBeRl7plEGkO67phFAWyLoJR/XXCiPsWAvmQ7b6PtX002+GIF0D4fl1xJvhhm
	jA1g==
X-Gm-Message-State: APjAAAXQeY8KFJ5Jo32aC8518KNTclE6HlseCpoxUMVrKJ2B6qBq2fHp
	o/dOjcPzmKKUvyHsJaiUa2o=
X-Google-Smtp-Source: APXvYqwWCkYwKvJyqK3dkXpnZKlJDLJbnwweUok7Ivs78rLg/2F3e8F7AEJu6GLhH7KuXRJ2kVRGMQ==
X-Received: by 2002:a05:6000:10c4:: with SMTP id
	b4mr30109691wrx.145.1558539982310; 
	Wed, 22 May 2019 08:46:22 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	p17sm8433242wrq.95.2019.05.22.08.46.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 08:46:21 -0700 (PDT)
Date: Wed, 22 May 2019 16:46:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190522154620.GO27900@stefanha-x1.localdomain>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oSMU0HVueUMCAvn0"
Content-Disposition: inline
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] Add support for io_uring
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


--oSMU0HVueUMCAvn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 05:22:06AM +0530, Aarushi Mehta wrote:
> This patch series adds supports for the newly developed io_uring Linux AI=
O interface. Testing it requires a host kernel with it and the liburing lib=
rary. Use the option -drive aio=3Dio_uring to enable it.
>=20
> Aarushi Mehta (9):
>   qapi/block-core: add option for io_uring
>   block/block: add BDRV flag for io_uring
>   include/block: declare interfaces for io_uring
>   stubs: add aio interface stubs for io_uring
>   util/asyn: add aio interfaces for io_uring
>   block/io_uring: implements interfaces for io_uring
>   blockdev: accept io_uring as option
>   block/file-posix: extends to use with io_uring
>   configure: permits use of io_uring with probe
>=20
>  block/Makefile.objs     |   2 +
>  block/file-posix.c      |  63 ++++++-
>  block/io_uring.c        | 385 ++++++++++++++++++++++++++++++++++++++++
>  blockdev.c              |   4 +-
>  configure               |  27 +++
>  include/block/aio.h     |  16 +-
>  include/block/block.h   |   1 +
>  include/block/raw-aio.h |  15 ++
>  qapi/block-core.json    |   3 +-
>  stubs/Makefile.objs     |   1 +
>  stubs/io_uring.c        |  32 ++++
>  util/async.c            |  32 ++++
>  12 files changed, 573 insertions(+), 8 deletions(-)
>  create mode 100644 block/io_uring.c
>  create mode 100644 stubs/io_uring.c

Thanks, I've posted my review feedback!  Looking forward to the next
revision.

--oSMU0HVueUMCAvn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzlbswACgkQnKSrs4Gr
c8g2cQf7BSSJ3RgZ299IaRLhqa4fvgEFnjC80uUQoqgMu5y/Jb7WOc7Os/GAg0mJ
KQkl5mtKm+ah9vDXnYFfZYGehHsFiHZ0kuxzCETYBEXJPrXIzU6R7rZKazuDjZrV
HxuT6JQc8iaXNh/AkMyyNhrZSVYwugJQPYh/gHHX1AVk7dI6QLGonSQINRrbd1dl
QDE+8df4Un+pmlsEBjM1skPLfWzV/6YLD6MAdL2IXXUkNDKqjgzxNVPnqhNtJIOK
PAu+chcgwcvm7RChxFcW9Z3WrcL8t2F+4X6AsVB9s7T7l3KL2UuwSnFMWQvvk59F
JrmT1EzsEriI0XdUgsnDqVgwMpVgXg==
=8EoX
-----END PGP SIGNATURE-----

--oSMU0HVueUMCAvn0--

