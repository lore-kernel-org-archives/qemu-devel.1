Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CDCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6904212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLYzvQ2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6904212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jld3N-0005wy-Sg
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jld2C-0003s5-53
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:43:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jld2A-0000Zs-9l
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:43:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id y20so3116895wmi.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZO9CXk8QOIOp/ULaqFKuKm4Yc/BI/X/L2xNDfa3rZdA=;
 b=lLYzvQ2xnwIHYFwEc441BK2f8SHPWwcZW1lkRCT8AI6rFc3H6e0l3EKzjVFURLs0Fm
 U2kFiHq+4dUrH14bFV8hKSLLdg7jxrxk0TxVeMDM+4veBOUmURt7T02UqXVZ7hc/QS2C
 KfAIHvoBwZcAEUjrUVwZTqBqSzE5p5sEsGWmKhZDyQJXDjRKdkPIduptD4S16s71bXUf
 Mc5S/F8iCaCoTQUa+yf6DEo3rpKjybBzDZ+A3a8drdIH+3tDfwHUWTyVmbGgKW3YELzd
 rYa2CJXfIx+2byotulkzXXmSg8P0xYWMW3ldAvY8aGuONNvmJj61D2yJzy3e51tbMiQb
 3M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZO9CXk8QOIOp/ULaqFKuKm4Yc/BI/X/L2xNDfa3rZdA=;
 b=NnSisjYv1QeZnsoaAma6lCrg/ndH1xPJXuZfLgAIJ+pMwsOsYPRhekzp0/n62+Y3Q8
 L3qz1gLksMKqRdnFRrJZybWklc5m69FuOhcij7PyMaq17NT4oE+UVvmJxEec+TwNbkaj
 0OV9KXteheiRe4mLhyqSVT6XYFBi3hYVqPJtEHMPmeToXvpc2cJMMd+Ym0jI6I1MAGSM
 nFmgPWwfRgnQs4vnhiItm8lDW0KRl87Ft4P4OfMwxTKKdPl8z7V3J1jnXHWHUYrIeKT8
 sOR846EeNj2OnrqgXrOLesMx4Hi19x8a97C46eMMDrR1Ox+ivJwrR7sy1A1LfdXoymVA
 GKbA==
X-Gm-Message-State: AOAM530Gd4JQdPEXLihso483qe2Z2G+qf8Gd8StWGsbqilNuH61/6GVH
 RaMMmkf/F5zVB43bwx1/4Xc=
X-Google-Smtp-Source: ABdhPJxeaOjhnuRL6UQavnHItEkrMVmMOimGAXvxyoW/Jjp41BAkKzAOq7ExfQT1afRcq7Fk0JFTfw==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr146612wmi.22.1592419416459;
 Wed, 17 Jun 2020 11:43:36 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h15sm471895wrt.73.2020.06.17.11.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 11:43:35 -0700 (PDT)
Date: Wed, 17 Jun 2020 19:43:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/4] Add support for SafeStack
Message-ID: <20200617184333.GO1728005@stefanha-x1.localdomain>
References: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FrxVhwK/bNRjN48l"
Content-Disposition: inline
In-Reply-To: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FrxVhwK/bNRjN48l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 04:51:18PM -0400, Daniele Buono wrote:
> LLVM supports SafeStack instrumentation to protect against stack buffer
> overflows, since version 3.7
>=20
> From https://clang.llvm.org/docs/SafeStack.html:
> "It works by separating the program stack into two distinct regions: the
> safe stack and the unsafe stack. The safe stack stores return addresses,
> register spills, and local variables that are always accessed in a safe
> way, while the unsafe stack stores everything else. This separation
> ensures that buffer overflows on the unsafe stack cannot be used to
> overwrite anything on the safe stack."
>=20
> Unfortunately, the use of two stack regions does not cope well with
> QEMU's coroutines. The second stack region is not properly set up with
> both ucontext and sigaltstack, so multiple coroutines end up sharing the
> same memory area for the unsafe stack, causing undefined behaviors at
> runtime (and most iochecks to fail).
>=20
> This patch series fixes the implementation of the ucontext backend and
> make sure that sigaltstack is never used if the compiler is applying
> the SafeStack instrumentation. It also adds a configure flag to enable
> SafeStack, and enables iotests when SafeStack is used.
>=20
> Changes since v1:
>  - CONFIG_SAFESTACK is now set up in configure, and not in the code
>  - Added option for a --disable-safe-stack in configure
>  - Configure checks if SafeStack is enabled by default in the compiler,
>    and set the CONFIG_SAFESTACK accordingly
>  - Updated some comments in the code and the commit log
>=20
> NOTE: I kept configure as Patch #3.=20
> The reason is that the code changes will not be enabled without the
> configure, making the code fully functional if only Patches #1 or #2 are
> applied.
> On the other hand, the configure patch will produce incorrect code if we
> request SafeStack and the other patches are not applied.
>=20
> Daniele Buono (4):
>   coroutine: support SafeStack in ucontext backend
>   coroutine: add check for SafeStack in sigaltstack
>   configure: add flags to support SafeStack
>   check-block: enable iotests with SafeStack
>=20
>  configure                    | 73 ++++++++++++++++++++++++++++++++++++
>  include/qemu/coroutine_int.h |  5 +++
>  tests/check-block.sh         | 12 +++++-
>  util/coroutine-sigaltstack.c |  4 ++
>  util/coroutine-ucontext.c    | 26 +++++++++++++
>  5 files changed, 119 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.26.2
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--FrxVhwK/bNRjN48l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qZFUACgkQnKSrs4Gr
c8iSSAf+PVmM1lkcVoyTkspWnqQaE4LO7zLRXn5OQc3DMrX4kw4YezrDgahYL8cD
mzB+UfMOKnh29EOytgNc/kxcXi5BKYeHlh4KgBVjWB+MLvrEjNXj3YtlKIbZO9wp
MBUI+mUJTIihnGOXjYhLBjjtP30A8HEmsSNFGjTCKO+t90bTuhmeD1z1d3I+7dGX
Elfr5p0mBZxqe8AUUgnI9iCGw36OsG5J8avfOgQdPev+SH+OyThxyCsDzK6vLvJA
dbPY+OxlAzJLokMVRgZYHINzCKNhjDf5NsVu8tsKaBQTVkF1b76Ve6+tirDF5H1z
HphpsDIJ+/Lb16tT17ZJGWK5eYh5LQ==
=2jDn
-----END PGP SIGNATURE-----

--FrxVhwK/bNRjN48l--

