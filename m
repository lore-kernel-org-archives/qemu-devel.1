Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D4C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792782087F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792782087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDXEZ-0004p5-MQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:34:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hDXDJ-0004MG-1i
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hDXDI-0004lG-2Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>)
	id 1hDXDF-0004jN-RM; Mon, 08 Apr 2019 12:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41EEFC057F4F;
	Mon,  8 Apr 2019 16:25:27 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17C2C600C7;
	Mon,  8 Apr 2019 16:25:25 +0000 (UTC)
Date: Mon, 8 Apr 2019 18:25:23 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190408162523.GG4288@angien.pipo.sk>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="peRj85VDUce1fu/0"
Content-Disposition: inline
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 08 Apr 2019 16:25:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] file-posix: Add dynamic-auto-read-only
 QAPI feature
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
Cc: armbru@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408162523.Nm7IfRkBaFR8zDu0RKqbawI7OIzYYeHfWhB07xM3zNU@z>


--peRj85VDUce1fu/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 16:35:39 +0200, Kevin Wolf wrote:
> This series adds optional feature lists to struct definitions in the
> QAPI schema and makes use of them to advertise the new behaviour of
> auto-read-only=3Don in file-posix.
>=20
> Kevin Wolf (4):
>   qapi: Support features for structs
>   tests/qapi-schema: Test for good feature lists in structs
>   tests/qapi-schema: Error case tests for features in structs
>   file-posix: Add dynamic-auto-read-only QAPI feature

I was able to implement this in libvirt fairly easy. My work-in-progress
(needs some docs and polishing) patches can be found at:

https://github.com/pipo/libvirt/commits/qapi-features-introspect

--peRj85VDUce1fu/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyrde8ACgkQHGwCByjY
1GrcPQ//bfxmrb6gKlhqYqXW+mkflwSyy6t9+DhB8vw737m5pGFWUhUIGWSS3DvV
emWCZq5wLsW9D5D1NBqV54TZo8YFTxA7a1BHSU4urYi5xD9XkuzU4SB/9o6UNuB2
td0z/6n0expfCDbmiByUnIl+JLAKJkYDbnOEjMW0iQqwL+smjEAyKCln4eIqROLv
xG5UxXf5seQnuG7oPUf1KoU9zx32/Q1TxgLdkZlPcGDDOBCZEuzwFUueF0WgNG9t
ttEbi+mY/lmeOSzqzA9CaKH1W6PXUc1L/yQ2CsmSiYmmoWlcbeXsQdCHPimAfqHw
KY8qSBxElaoaabP/3Y7YzroGVk14qDBRGSP8uVVJjGHlzEhPzTyAF8AvplPuBb1t
AfncDZj3Gcmmi9YzrE/y+q/iStrtHU1cnjQHDrHzaGKJwtsx6U0MwiB16NDq0FGg
WLradObME7KwBCviiK2D0YHcIthbXtSiVlShP3i9wuXpN4QFo4qfQwPtp3CqdF4I
IbAbm9X5dxGZWf6m64rl15FHI2a0DDIM+iJrVSppg3KwCJtHwRHOAlBejc3QmrNZ
ULZNjWUSaIYyOwZ9YpXd1VIzMELQ1qa/vnVEpYgdBaG8VcX5ikWTVlGwR8BA4sbi
5LpaTiCzeGn9LKBJKZP1tn0IUmtbq4J44br02eoduQtLpqcpdLQ=
=u8tZ
-----END PGP SIGNATURE-----

--peRj85VDUce1fu/0--

