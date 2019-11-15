Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFCC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32612073C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z81XabWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32612073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVkuX-0004Rb-Uv
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 18:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iVktW-0003wA-M8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iVktV-0004OE-CR
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:20:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59045 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iVktU-0004L9-Ex; Fri, 15 Nov 2019 18:20:49 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47FDqK0bZGz9sPT; Sat, 16 Nov 2019 10:20:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573860045;
 bh=5hEGpdzDR1tyHvUdl6EjoLd8sVZJpV6/4Wf4uPH5sCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z81XabWojnHwTkraeT9EvqZVCSno1efaheoFcLdv6c4Cl1WXlVOZ77zHtGHtTOch1
 V3W/xIiN9lTfXtmRUTRT9Yf9WsTTGBvFHrLxDyiLhDwkDOgGpmy/fKHSF1t3ndK4ui
 DQhik8qODLlEqyxxzQHvOnXCkneJbWRX3l1Mqbfw=
Date: Sat, 16 Nov 2019 09:45:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PULL 0/6] ppc-for-4.2 queue 2019-11-15
Message-ID: <20191115224512.GQ2134@umbus.fritz.box>
References: <20191115223312.204979-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="25rOlkxR6a4U87uN"
Content-Disposition: inline
In-Reply-To: <20191115223312.204979-1-lvivier@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--25rOlkxR6a4U87uN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 11:33:06PM +0100, Laurent Vivier wrote:
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a54=
08:
>=20
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2=
-sf1' into staging (2019-11-02 17:59:03 +0000)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/vivier/qemu.git tags/ppc-for-4.2-pull-request
>=20
> for you to fetch changes up to 140fce75367a2bd8ef50681896a15f34952d9b85:
>=20
>   mos6522: fix T1 and T2 timers (2019-11-03 20:09:59 +0100)
>=20
> ----------------------------------------------------------------
> ppc patch queue 2019-11-15
>=20
> Several fixes for 4.2.0-rc2:
>=20
> fix mos6522 performance issue,
> xive/xics issues,
> fix /chosen device-tree on reset
> and KVM default cpu-model for all machine classes
>=20
> ----------------------------------------------------------------

I'm still on holiday, so Laurent is sending this one with my blessing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--25rOlkxR6a4U87uN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3PKnUACgkQbDjKyiDZ
s5LidhAA5paf1b5/F9O1lBRMFFUd4TXBcomFPZsHJ35vdtSogN+OMJ6Ln0GsODsx
eh2079Tzt2Dl4r5XF3lOPCuiM0DD7/dcSsnBcDjA8hfoViEeSZX03v+oTkjwXsvY
7pD3u23FtOo4gIc9BZNzN6tsxPn8bKYD5/GtGKKoFg9TUVfJEh8NlYMbzv2Nm+3/
X+NcecKdYQ8M8p85cbI6lLT6Yo4TffaywWqOX1oOzFGjcQycaNLAtELJ4XhS+RFd
r+pHZAOfOXP6nTMU2eyP9c1ZQw1jdk/hTnYD7EpbwmcsDy3omt6rZIAXyxSK0JEz
8VZi50066KyIv5eZO0c4V/7s8KAhVranRto0NuOAyRvVt5w9mMuL7B13lFcxnGrd
8P1ZSs4YAslR3qCBrnN+HnTWzF+kM2MCSEKkrbAfVbOH/k98WgbRfYlRvNFrVwP4
JCJOYEmxrx/G6U4PYhZW+rQjg2Jp05kqj/ce+Y2YdWtEtw+O6V2JTpTvXAbWZpBs
Mb0oTbo7Yu14aioFGz1+qmo9/eNSxwj0b3EsJYts5DQ8EDP0PAyrqCthD6HJLOeL
SzhDkppjjVBrKBiOeSlwKNigm48F2MDrDaOM11eDIgmeJOYo+nvXfsXVKGY+898J
rflfF+2U6XgW+3lyH+GfOk7lzcTC2GWi9KKhokQkPpLY8uVPuzw=
=c3HK
-----END PGP SIGNATURE-----

--25rOlkxR6a4U87uN--

