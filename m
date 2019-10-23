Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BCECA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E8F21906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E8F21906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNOM1-0004d0-6l
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 17:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iNM6s-0006Qw-S6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iNM6r-0001Go-QP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:15:54 -0400
Received: from home.keithp.com ([63.227.221.253]:51588 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>)
 id 1iNM6p-0001Ek-CW; Wed, 23 Oct 2019 15:15:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id B1FE03F23ED3;
 Wed, 23 Oct 2019 12:15:47 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id VKIcKvzv9SZ9; Wed, 23 Oct 2019 12:15:47 -0700 (PDT)
Received: from keithp.com (keithp-172.keithp.com [10.0.0.172])
 by elaine.keithp.com (Postfix) with ESMTPSA id 7655C3F23EB1;
 Wed, 23 Oct 2019 12:15:47 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id CD50E1582118; Wed, 23 Oct 2019 12:15:46 -0700 (PDT)
From: "Keith Packard" <keithp@keithp.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Semihost SYS_READC implementation
In-Reply-To: <5e8913f8-558d-6a2e-c7d0-787ec533e4a9@redhat.com>
References: <20191022031335.9880-1-keithp@keithp.com>
 <d7470bfa-ba4e-3287-326f-ee63c5d76407@redhat.com> <87sgnk3b0k.fsf@keithp.com>
 <5e8913f8-558d-6a2e-c7d0-787ec533e4a9@redhat.com>
Date: Wed, 23 Oct 2019 12:15:46 -0700
Message-ID: <87eez31del.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.227.221.253
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini <pbonzini@redhat.com> writes:

> Please take a look at include/qemu/fifo8.h instead of rolling your own
> ring buffer.  Note that it is not thread-safe so you'll have to keep
> that part.

Sorry for not looking around sooner, and thanks for the pointer.
I've also cleaned up the other issues.

> Kudos for the unlock/lock_iothread; I am not really familiar with the
> semihosting code and I would have naively assumed that it runs without
> that lock taken.

I discovered by testing that the semihosting functions were entered with
the lock taken :-)

I'll post an updated version of this patch to the list shortly. Thanks
again for your review; I really appreciate the time you've taken to look
at my patch.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl2wpuIACgkQ2yIaaQAA
ABHAOQ//V73ZQhAgWfci8AUC0QDOrOsGQ/ysuGomZ6O56MKNsYUmXrVYzD+eXxRc
Uh8bYM68rPn4JCeDwVJiBKKkGrhN138cieEb2if/cZ0hn71xZc9wiGn0bu33pU9e
d7rY3SWqBwUI3Km24o3qwNBD36mAmeiZHm1Htmv8hg8dBsH+kkBvVUGr/SkxcXhL
/yEKaqsqYIG3+sCetyXlv4iOmdxZjc0ljELhhPfrrM+7z7Czb+jK+syBj7u2SdqY
R04VyvmMjWEfm7xD5ON4A+sWT7GIXKzwSe88zJ8AO3w/0LFTR+m5ZinKeSOIgsdA
MBIKXT3sJkRy8F4kPI3kzsET6pwU5GhrUF2hMJ9Zlt6LWYl3gm77etw53Q6fZrsc
ZsLLckRHoQ7Ocot7pulXyFQMfDmY+NkolngPR7rPUkN/RsM1v0lHeAAvJBAxWR5k
lrr59wbn8dfE0/SoQHihhISu3oSTOTOHi3jP5LK3ekg83Pa/V2U20wNYW514qs2b
JcQYiW+l047MIGOO8qKRnmrApSD8xnq6ZWk6cA6rVsh3BmTjW9u5RMk4tQH9ouCc
OBUb3tVeUD2C4I4CU+a8CMSv1fIbisUg0batn3nnCpZG3jeIGX/ctIdqhnZZNd/a
ZbbiSSiWa5u6QJnUGOInZWRfPJVUcQ2Z+FyOEUWhkU8rgnYOjIw=
=Gk4J
-----END PGP SIGNATURE-----
--=-=-=--

