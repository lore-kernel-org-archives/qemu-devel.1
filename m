Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 00:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A773B207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 00:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D48zpJdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A773B207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm4kC-0000pq-VP
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 20:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm4jV-00081M-01; Thu, 18 Jun 2020 20:18:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm4jR-0000Nx-8a; Thu, 18 Jun 2020 20:18:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49nzsZ3khXz9sRN; Fri, 19 Jun 2020 10:17:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592525874;
 bh=jZdgPaGGkD9cQaDs6WzCOTGJiJOUnLhanFqgPsKGbps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D48zpJdwakBf/Ku4zcPEeUwbOBTsaGcm55Q5gAejoV3ZUKV8rl+hKiZbLmV1id403
 ViHsPCaQ/ExZrA1cblGmEQ658zcMpXJOllkVTy536IaXV+SnjNNU/7McBCA1TmNfOu
 H+0xky8HxyXyO9USFdWwYsTHvaSVVaovHgM2Oea0=
Date: Fri, 19 Jun 2020 09:59:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 4/4] spapr: Forbid nested KVM-HV in pre-power9 compat
 mode
Message-ID: <20200618235912.GD17085@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188283391.70166.16995399489383620172.stgit@bahia.lan>
 <20200613071804.GE5861@umbus.fritz.box>
 <20200615112031.679512c3@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <20200615112031.679512c3@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 11:20:31AM +0200, Greg Kurz wrote:
> On Sat, 13 Jun 2020 17:18:04 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jun 11, 2020 at 03:40:33PM +0200, Greg Kurz wrote:
> > > Nested KVM-HV only works on POWER9.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> >=20
> > Hrm.  I have mixed feelings about this.  It does bring forward an
> > error that we'd otherwise only discover when we try to load the kvm
> > module in the guest.
> >=20
> > On the other hand, it's kind of a layering violation - really it's
> > KVM's business to report what it can and can't do, rather than having
> > qemu anticipate it.
> >=20
>=20
> Agreed and it seems that we can probably get KVM to report that
> already. I'll have closer look.
>=20
> > Allowing POWER8 compat for an L2 is something we hope to have in the
> > fairly near future.
>=20
> Ok but I guess we don't want to start an L2 in compat POWER8 mode
> with cap-nested-hv=3Don, do we ?

Sorry, "L2" was misleading, I really mean L<max>.  Setting
cap-nested-hv kind of implies there's a L<at least one more> which
contradicts that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7r/9AACgkQbDjKyiDZ
s5Lk8Q//YkL0Vk+BAnv0JgDFjtqJAdkGBX8A5fjAToEh3pE97xq7lluy5EElzhOX
4gg3C5iUTeim1hWwCmql7S79kXy77xOjFThr2pdgq/vVw2iureipbxMs4yFn0DIa
90oXl4w/d84JSDcP9u2wA7Xw1SNghD9CELEK5LGwNDwtWZv1BGu5UxEl07XVDyE9
l1Gnl/8UVZ1kzb5Mtaq3ALSS5xF+JWklbREPP/1OInH/JavUfJzX+Hc7irq+ESfp
r/e1gX5p1nc2+zKVSBwT9+uFexZySI/12ibOs0mKX+/DGT8/UURr+FXtWRonZIZ5
xsROasC+05WBP7sbN4HubkRFrCMFhVLLEFLGnLfLEd92JKKKzg0cLoqKIROrDupN
l2r1Mh4Ue2uJo8w0xiYWJT4WKFnWF5V+zxSBt/XpR+lyz1XdwHie31bNgZeX88s4
8ExA9qnYcSXXakoyZBMSQbBsDAoJrNcap2P+9W9keMT+TLzoWV7jwiyvY7ZalhW0
V+yr2HSVsFxncnwbPYf6PzlPPUyAV6AAWc4KP8EAUbqfpnF53vmeMXNcTN4xwrWc
jQ0XyGnx+oVuPKnIN7mNTwaXW9d+so5N0b7/o+n1cCALT6GIpPLRXH7qPBDcPFbr
32km8GC5/V2UrzOYyc8gS6XNEVn6v7IQNRXDgcpy452EgeApdSQ=
=3jTe
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--

