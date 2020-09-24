Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F0C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABD620B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABD620B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYXe-0003nA-8y
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLYTA-0001GQ-4H; Thu, 24 Sep 2020 17:08:00 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLYT7-00025N-VZ; Thu, 24 Sep 2020 17:07:59 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id C5DD158049A;
 Thu, 24 Sep 2020 17:07:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 17:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=/GLl5N9ZXFy+GjT7ACdgXbtL440
 A3Ecm8GuvlXJ5Q34=; b=XwvaDGgEMnnU7JuQ6znCY/UOzYJOaHDbW3rtW6WzAF4
 o/gBqY4aUhV4kZapI4A3j6ZYRrKN2X1vr7TbR6HKSeaqBFWBuE1IHSWJcknP1mtn
 6X9KIIvjnMNkjo0ll/GkWx/nLQrfVF3WRUz1P743kxbYizy1uYUUPpzQHNKGz5JH
 FsMiSOdyLkJx0cr+HQVw1EAZdvyfLRlaV1Gydg7iTpaxjghpNQkJDurFpK/syzYI
 qqp3EQSbR/OMhgs4suHXAOFeSbNzqpZ8WZp3Jj+gXl8xcN2HaUgu/h0MLks68Mno
 X82EiokJmuNsGlLe1vaMXUFHM2IZQJtZcLn5SnzxD+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/GLl5N
 9ZXFy+GjT7ACdgXbtL440A3Ecm8GuvlXJ5Q34=; b=GgZfZ9Pk9yMWQSWkQqigYF
 reGdVBjSNQtH5zagmtZ4Ok/HodlnOL2GZmzxecnc8P8ra5BviKbqrz0oJWHtCaHh
 gTekaf2BXIMQ6SEUdP/adGk4JbkkRQz5+Gn3HijTXWNlDTyoyfFlwICgJjZDQ85S
 BRyhy2wy53Obp7lf0ifmvjKqt75+6HcP/eD7tm/bOiVzW0XE86tlnXzN/C55vPqQ
 fW8aku++psbipRyEm5CWHGpLUlOdFqtI6o5KMKdHZxl5IKPzNlfcMKP4JPpRttvf
 aSsGX+PKtdfRSZuUOs5lRJMywqpT8en0iMFARaYYFACNOpku3JtGLvmYOoPrdnWQ
 ==
X-ME-Sender: <xms:qwptXz704txH1hjuvpwKqrolN6sdzwQqVHTUD47PpuSYdId-RfYXyQ>
 <xme:qwptX47OLynu04g1HpoqkLXEOGGNP4wFvbD9Gu-dJXOgttbpdhaMNte6pC9hXZ6Fo
 FfSZLiP-RJPUHiy0Hk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:qwptX6feNgPbPlGRhUS6mlo3jppx-49jOUYqcM9SkeHySZp-MJENZQ>
 <xmx:qwptX0JDPgNwFkRMrvSwnuCdYeGNDE-HtWEE1udOFLELj7Y4g3Oq8A>
 <xmx:qwptX3KzC8sYBYFycoIjaAu6dDKKtmdBtw7_gMQrP11hZJsuybsNsQ>
 <xmx:rAptX5wx9OBh7JKMt2QZDFh7BhpksHreVzWt9Q4kTwiHuDPOxyoV9Ae5eSI>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id AE0E63064610;
 Thu, 24 Sep 2020 17:07:53 -0400 (EDT)
Date: Thu, 24 Sep 2020 23:07:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Message-ID: <20200924210751.GD1738917@apples.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:55:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 24 03:20, Dmitry Fomichev wrote:
> v3 -> v4
>=20
>  - Fix bugs introduced in v2/v3 for QD > 1 operation. Now, all writes
>    to a zone happen at the new write pointer variable, zone->w_ptr,
>    that is advanced right after submitting the backend i/o. The existing
>    zone->d.wp variable is updated upon the successful write completion
>    and it is used for zone reporting. Some code has been split from
>    nvme_finalize_zoned_write() function to a new function,
>    nvme_advance_zone_wp().
>=20

Same approach that I've used, +1.

>  - Make the code compile under mingw. Switch to using QEMU API for
>    mmap/msync, i.e. memory_region...(). Since mmap is not available in
>    mingw (even though there is mman-win32 library available on Github),
>    conditional compilation is added around these calls to avoid
>    undefined symbols under mingw. A better fix would be to add stub
>    functions to softmmu/memory.c for the case when CONFIG_POSIX is not
>    defined, but such change is beyond the scope of this patchset and it
>    can be made in a separate patch.
>=20

Ewwww.

This feels like a hack or at the very least an abuse of the physical
memory management API.

If it really needs to be memory mapped, then I think a hostmem-based
approach similar to what Andrzej did for PMR is needed (I think that
will get rid of the CONFIG_POSIX ifdef at least, but still leave it
slightly tricky to get it to work on all platforms AFAIK). But really,
since we do not require memory semantics for this, then I think the
abstraction is fundamentally wrong.

I am, of course, blowing my own horn, since my implementation uses a
portable blockdev for this.

Another issue is the complete lack of endian conversions. Does it
matter? It depends. Will anyone ever use this on a big endian host and
move the meta data backing file to a little endian host? Probably not.
So does it really matter? Probably not, but it is cutting corners.

>  - Make the list of review comments addressed in v2 of the series
>    (see below).
>=20

Very detailed! Thanks!

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9tCqYACgkQTeGvMW1P
Den9Ywf9F2Lj9NLWESmAG+VWsNngZjDwNsTZWuvfFHlbTPbELV4CfiefE4XM35CV
WYzGM9d1dnomtUAviTT43DCkGoLTHXvRgCBTHq7iVJUbGApyieHi350754Qw46x3
p6KgGCBxPTmAuK5QjaoEUwHomYiWvd7i5YwfFetY30zbe00XjCQ/9g8ZQI9+dRWa
BxA76QZA8IC9H9UfAL65FPdRcnih+PUsAQz+JrWPJC7fEqrQFqpJa9MBFEKr5sg0
Ec9JuvQvN0ahEotNp1XiUw2cKVXLM7qVBNZcqwCwmt2nk44aszx8Bj41cymMPmpn
hWjhdaKnx8DEq+I6KXRgJoEb4FKLjg==
=zc1d
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--

