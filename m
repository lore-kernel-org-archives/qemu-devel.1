Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1443BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E0721479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvTFzYs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E0721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOj8g-0006rA-3s
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:31:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOj79-0005lj-Mt
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOj78-0005F8-RF
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:29:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hOj78-0005Ek-Ed; Thu, 09 May 2019 09:29:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id r7so2439003wrr.13;
	Thu, 09 May 2019 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=nO05n2b4bwpw+2Hj0vzxgDLt5R1AGAuoaXeAmu2XMF0=;
	b=fvTFzYs1lRPv4CrioYrK3g8ALkn5o24hmW/ZZ6M+tj30ioyMqnEn4+gRrrfrh2wV+r
	eWF3g2cEXZXR+57eQ23+eNW9OIzTQRIvIaVgFnrHSI+diWnR/oGElqyTma4FmrJ/gomc
	AZIs3Diud0FlH0vjgAJ95hLc9Hqhx/LaWyN21MRA5UPCPfxGkMMao+XixPT6ivWngBI/
	33FjGv+idHdEb2nOvtQry0kjtkBSv1XakhwDoIg3f5ojx5ujXduRdtqHkPgRIvR9F9k+
	uj5vgqxwVBogapy175gcoIH+jhTMW8nVdlf2rauhmWRTMrTlZ9z2FZBCIiLIl++B5oAa
	UNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=nO05n2b4bwpw+2Hj0vzxgDLt5R1AGAuoaXeAmu2XMF0=;
	b=O65RUk63yhBR4OqpDiKfIivP3b/7fH999c71LNy7xch8K83zD8TB7diVpnvCvUw1xf
	q4nB8eFciBv6zfTC0QtDKmleP8TLrlQKPx59tQ3hYCoKLBOWKRjzsRg/Ago3QhaMR3MF
	SFwQ05WSZHYsN+gA64WEioguRwQh+T/znC/n7bzh7u3iANQY/MmIZ18ePzAmvptyHD03
	5t8/hnEHs5kuLaYTa2P2a41JJqZiQuOKLSW3kCHPCpnM2naAJdPUmTN2E1siOctqXRrj
	/mLxeh0Yo+Fy/mhkPjqaaQ9lQlVkJFj8DYW7RMnae5QiAm765aWHy8XaqcLrYD4BHQW6
	B0ng==
X-Gm-Message-State: APjAAAU9rAoY/YhSMAL291Fx360SaVgOosr8n9kMbQqIgUzV7lJwLNH5
	10C/uYZNqiOV12Vhzu2qSyg=
X-Google-Smtp-Source: APXvYqxcfh9E/nf0cNd6IUDR0fORdOG00LYkotJM+q/kMfTK47WXKCUuCTY3dlg7Q3l6fpjUSIrrWA==
X-Received: by 2002:adf:8567:: with SMTP id 94mr3312323wrh.286.1557408573167; 
	Thu, 09 May 2019 06:29:33 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	i127sm6971825wmg.21.2019.05.09.06.29.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 06:29:32 -0700 (PDT)
Date: Thu, 9 May 2019 14:29:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190509132931.GC17133@stefanha-x1.localdomain>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 0/9] Assembly coroutine backend and x86 CET
 support
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2019 at 06:05:18AM -0600, Paolo Bonzini wrote:
> *** BLURB HERE ***
>=20
> Paolo Bonzini (10):
>   qemugdb: allow adding support for other coroutine backends
>   qemugdb: allow adding support for other architectures
>   coroutine: add host specific coroutine backend for 64-bit x86
>   coroutine: add host specific coroutine backend for 64-bit ARM
>   coroutine: add host specific coroutine backend for 64-bit s390
>   configure: add control-flow protection support
>   tcg: add tcg_out_start
>   tcg/i386: add support for IBT
>   linux-user: add IBT support to x86 safe-syscall.S
>   coroutine-asm: add x86 CET shadow stack support
>=20
>  Makefile.target                           |   5 +
>  configure                                 |  62 ++++
>  include/qemu/cpuid.h                      |   5 +
>  linux-user/host/i386/safe-syscall.inc.S   |  19 ++
>  linux-user/host/x86_64/safe-syscall.inc.S |  19 ++
>  scripts/qemugdb/coroutine.py              | 107 ++----
>  scripts/qemugdb/coroutine_asm.py          |  24 ++
>  scripts/qemugdb/coroutine_ucontext.py     |  69 ++++
>  tcg/aarch64/tcg-target.inc.c              |   4 +
>  tcg/arm/tcg-target.inc.c                  |   4 +
>  tcg/i386/tcg-target.inc.c                 |  23 ++
>  tcg/mips/tcg-target.inc.c                 |   4 +
>  tcg/ppc/tcg-target.inc.c                  |   4 +
>  tcg/riscv/tcg-target.inc.c                |   4 +
>  tcg/s390/tcg-target.inc.c                 |   4 +
>  tcg/sparc/tcg-target.inc.c                |   4 +
>  tcg/tcg.c                                 |   2 +
>  tcg/tci/tcg-target.inc.c                  |   4 +
>  util/Makefile.objs                        |  10 +
>  util/coroutine-asm.c                      | 387 ++++++++++++++++++++++
>  20 files changed, 689 insertions(+), 75 deletions(-)
>  create mode 100644 scripts/qemugdb/coroutine_asm.py
>  create mode 100644 scripts/qemugdb/coroutine_ucontext.py
>  create mode 100644 util/coroutine-asm.c
>=20
> --=20
> 2.21.0
>=20
>=20

Aside from the comments I posted:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzUKzsACgkQnKSrs4Gr
c8hFmAf8DjtS9h9LvH3yDIB8opdbLHiCUf8goBuL+kGQiLc8Npea6bu1QuBLk0zD
virHPHIbwbL4z22Cs5AruCFZVVOnZbqU+wnTJqgXtQNSmFCGipPds/a79Dt4baVl
NeHyo6s8gmzdl/fraSpghEVgaOSEUdA5Yz653MW7T7mgi7nnzP0Lseqzmdp902MZ
gc8ZMjj+4nOtxVUKlnZe/8bmzQtQA8SofeEWUY44Hr60JvRkr5r0tJGZzn9TyT+o
MdtnUN8Xvs+vsGBkAKbqBDUCNVYdtLtJCIgT+xSTIjRtUfrqblfbt/ca+DfJ/cn6
K085yg9qnjOKhb/VZ2u3Pqxz7bLxPg==
=5+uW
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--

