Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B56C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91E6214DE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfnFwqjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91E6214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tpg-0002A7-LQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i9t09-0006tY-Qb
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i9t08-0003M9-OR
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:33:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i9t08-0003Lb-I7
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:33:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id p7so252918wmp.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=D6YGUbR9BdCGcEa9DD/zNGfvBUbgKnJJMLtswwo8nZ8=;
 b=rfnFwqjAuipgKas6Jq1zxfx2dObIUf1JMcVpb5YGCNkn73QHBVw2B333B2ebfXaA4f
 c4n+4S31WmmRjsEO0J51QugqgKfqut2VHxkdeaqIIxF4X7u+54/2Bn24EtUMf/UBVDXw
 X6RXSYK5zus1TKAnhm8ZMp/EYSMKUfyKxOfps+oANdEDi6YRWT07Y/EIyu8JqjTjX0bt
 BvfhzVvAWpFjFgChn8LCXfglIJEdTEhyJslcnPW+UHLkdtfivU2XM86kO1x8g8sCbA++
 5bnsy+bZLlRHh5PFmkq/NbFgfCplwZ9I//tUAa2RwWJceSeecK4NkFjy875+9AF81D7Q
 ZV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D6YGUbR9BdCGcEa9DD/zNGfvBUbgKnJJMLtswwo8nZ8=;
 b=jPtMRS/vcbK34GPP8gyau79mj8XyJxGmKJgGhsc+wXfD/7DyQVt8QXivZfTqrkKNM6
 suA29DYfMm7qJOzJdGIkiH6XKTU8NpXI9sp2s02KYKD7dLuuZaFIH5hCEj0ZrR/1Whuv
 ubbpe4Ba3N31RP5igxtg2ULbQ2DZYd5MXuqTKioUFGycHXXYKUA0AocAvOM1W2IGoi5A
 Gt1BL/SZqQGw04Ep2LsQFVd4QABm+39aVRezFyflu753NwZO5q87I3OhM9pZBTEbuTrt
 VElLg9XERLeE06QH1m68vDCQAmfgXk1+EJxWBEr96kkk6eG/7RL/1etaCjbv7D5rERaZ
 +SBA==
X-Gm-Message-State: APjAAAXEUUwpGnUnw+tnusVurVzLzX5BGcVrhfUdeDPO3B1sfHJsIQls
 4iDV+WRxkkJrC0xYEFyXLp0=
X-Google-Smtp-Source: APXvYqwf93/FtMnaBos6f0NymSYGaihZNrGsupvZW7o3ovoVMBTVAGku1who481w9mNGWDUMGORfyA==
X-Received: by 2002:a1c:e709:: with SMTP id e9mr111668wmh.65.1568647994953;
 Mon, 16 Sep 2019 08:33:14 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o3sm190952wmh.38.2019.09.16.08.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 08:33:13 -0700 (PDT)
Date: Mon, 16 Sep 2019 16:33:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190916153312.GD25552@stefanha-x1.localdomain>
References: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: Re: [Qemu-devel] test-aio-multithread assertion
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 12:50:21PM +0100, Peter Maydell wrote:
> Hi; I've been seeing intermittently on the BSDs this assertion
> running test-aio-multithread as part of 'make check':
>=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-aio-multithread -m=3Dquick -k --tap < /dev/null |
> ./scripts/tap-drive
> r.pl --test-name=3D"test-aio-multithread"
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> PASS 2 test-aio-multithread /aio/multi/schedule
> ERROR - too few tests run (expected 5, got 2)
> Assertion failed: (!qemu_lockcnt_count(&ctx->list_lock)), function
> aio_ctx_finalize, file /home/qemu/qemu-test.kaRA0o/src/util/async.c,
> line 283.
> Abort trap (core dumped)
> gmake: *** [/home/qemu/qemu-test.kaRA0o/src/tests/Makefile.include:905:
> check-unit] Error 1
>=20
> Anybody got any ideas?
>=20
> (this is with the tests/vm setups; I've seen this on FreeBSD
> and NetBSD.)

Last week I triaged a ppc64le test-aio-multithread test_multi_fair_mutex
failure (race condition but reproduces after a few minutes) and sent it
on to Paolo.

I don't have time to investigate additional failures right now but
please keep reminding us if you encounter failures.

Stefan

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1/qzgACgkQnKSrs4Gr
c8hmjQf/Q2lVIIysAFb5mCwbCqMHd4m07mf5XaXZiCfSDY5Sy1NR3HjG5yJP6V4y
FLZ55mKrheIwiutcPrWtpsDDTIvqupmuEyaA/6ksNdeqgYQQCQ4DahnTcdhlejmo
7u9/KbCQUF5IuzpTRnctI95H9xIJCtBF6hbGBqir5g6KPX7a7WBZc2yvdVsRmkMC
pjgTbQBzt0MAvhWFDfMe4piMx/Z20o6emfLJ9dRkgE8NWdoPuXNhtjgdEzPkNe7A
c3EyKCx0oztzeSv8WZUj7qK7JVi7cJveNsOF5leoS6+4Qe0Vh/9bJAPR0FOmWfGM
J9qreMKL9qOJZVVkjyUhG7zc+RAsiw==
=wJSC
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--

