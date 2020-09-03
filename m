Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A531C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A422072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CCHF2c2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A422072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDeVc-0001mu-8N
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 21:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUm-00005w-1c; Wed, 02 Sep 2020 21:57:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55997 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUj-0005bt-1H; Wed, 02 Sep 2020 21:56:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BhkSd2bYBz9sTp; Thu,  3 Sep 2020 11:56:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599098209;
 bh=rBlWEZQ01ggjZW9f7CpBFT7ZjV9RlvLxalPbKl1Tou0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CCHF2c2CEf2AHBcRGq+3FCCxgrvAKtu6NkbBP/yeH/Dox8VBbJGnt+3rp3p4IUI+7
 BRytnDnQYXvvRqy2DSYMQMVBcj5Ld5sfa2B49JCbTZXoPrcklxRFZBefnHs/xs/MOW
 RWiOqIxbxiJ/lZCrJmrgsoLKQZp0DoEhbfWC7Ems=
Date: Thu, 3 Sep 2020 11:49:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 0/7] pseries NUMA distance rework
Message-ID: <20200903014904.GJ1897@yekko.fritz.box>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200903013539.GH1897@yekko.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="apbmkPN6Hu/1dI3g"
Content-Disposition: inline
In-Reply-To: <20200903013539.GH1897@yekko.fritz.box>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 20:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--apbmkPN6Hu/1dI3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 11:35:39AM +1000, David Gibson wrote:
> On Tue, Sep 01, 2020 at 09:56:38AM -0300, Daniel Henrique Barboza wrote:
> > Hi,
> >=20
> > Following the reviews of the first version [1], specially this
> > reply from David [2], I decided to take a step back and refactor
> > all the code in hw/ppc/spapr* that operates with ibm,associativity,
> > ibm,associativity-reference-points and ibm,max-associativity-domains.
> >=20
> > A new file named 'spapr_numa.c' was created to gather all the
> > associativity related code into helpers that write NUMA/associativity
> > related info to the FDT. These helpers are then used in other
> > spapr_* files. This allows us to change NUMA related code in a
> > single location, instead of searching every file to see where is
> > associativity being written and how, and all the soon to get
> > more complex logic can be contained in spapr_numa.c. I consider
> > the end result to be better than what I ended up doing in v1.
> >=20
> > Unlike v1, there is no NUMA distance change being done in this series.
> > Later on, the hub of the new NUMA distance calculation will be
> > spapr_numa_associativity_init(), where we'll take into consideration
> > user input from numa_states, handle sizes to what the PAPR kernel
> > understands and establish assoaciativity domains between the NUMA
> > nodes.
>=20
> Patches 1..4 applied to ppc-for-5.2.  Patch 5 has some nits I've
> commented on.

Ah, sorry, I realised I missed something.  Patches 1..2 are still
applied, but patch 3 has a nit large enough to call for a respin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--apbmkPN6Hu/1dI3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9QS5AACgkQbDjKyiDZ
s5JbJhAA5b5EzsKJATY2U4pXrDkPcYPCvcRq9aALF4uG0OGyuCnSb29EZBMC4MSX
w0Mpx7dkf7LQIb5G1qoSVw54ZcKRXKjKQC6vHXwe+Ax3RAn4R7ABTedP6KhR8rXE
MxmK9ND9BYMp6n7mo0oewyYGCy8mc+cSBOJ4dzV5SrmaSlqmFyEGuecxPnujA8fh
r+0CqsSxlTomopZKP+H4XAFlahqIndbLnTZ2cd5nt2Z2CS8iv4aBQz6D/Kom+iAo
04LigwbRe5YhOym/DPQlWyiQtVIqZ4tm4qLHdR++zHnSe/po/VmDDVFkkLzYrrtB
eHHtzrZwfi4Fxqs5E1YxK76X5xULK3fFlb3oi9+nvecvZUuk6vR7Qyuv27fQV5KW
Ol0zWc2hOZgqDon7OqRYeHS8lOvcn052JO0lvTbgsNwBZBdmFtxhHNK2Xj6ld3Uz
3CnkOafP7nGdmwKb9OmqUQ1MvsWBvQw/Bg3r77+eeR9qTWFuRgEBqIfDjonQGxcw
DSH5P41UwhqIsV0x+55YFmHHTorNCx/YzGBvNU8m9KqPcB4M0i+zoHNgoJ3fKgo3
Yts4W+rY4U3fJiehntcRWhBsPH/b8yPmZznIpKfHwlK+Zo5sUptXO9vQOOqwKt2l
a2F9z3OCow7uxvZBbbnWNlxfMsB/RXuwO7v6SJza69uMBFx1fi0=
=SIY3
-----END PGP SIGNATURE-----

--apbmkPN6Hu/1dI3g--

