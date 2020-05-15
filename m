Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6011BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E75206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E75206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUJI-00075o-8h
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jZUIg-0006b3-MT
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:58:30 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:58985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jZUIf-0002C0-8U
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:58:30 -0400
Received: from player773.ha.ovh.net (unknown [10.108.42.145])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id C845B24D4BD
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 08:58:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id B55EC1276C42C;
 Fri, 15 May 2020 06:58:08 +0000 (UTC)
Date: Fri, 15 May 2020 08:58:07 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 0/6] target/ppc: Various clean-up and fixes for radix64
Message-ID: <20200515085807.7315539a@bahia.lan>
In-Reply-To: <20200514065249.GC2183@umbus.fritz.box>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
 <20200514065249.GC2183@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//rL9VxfSndOgxF.EtPHUHs6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 4434356785439283686
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleejgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeggfekuddvuddtgfekkeejleegjeffheduuefhledtteeftdfhffdtgfegiefhvdenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.172.249; envelope-from=groug@kaod.org;
 helo=8.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 02:58:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_//rL9VxfSndOgxF.EtPHUHs6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2020 16:52:49 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 14, 2020 at 12:56:42AM +0200, Greg Kurz wrote:
> > First three patches of this series are simple cleanups. The other
> > ones fix some regressions introduced by Cedric's recent addition
> > of partition-scoped translation.
>=20
> Applied to ppc-for-5.1, thanks.
>=20

Could you please refresh your ppc-for-5.1 branch on github ?

> >=20
> > Changes since v1:
> > - fix build break in patch 3
> > - introduce guest_visible argument in patch 6
> >=20
>=20


--Sig_//rL9VxfSndOgxF.EtPHUHs6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl6+PX8ACgkQcdTV5YIv
c9ZeyRAAjC2muFkBpn13QVplvaLhXee7G1pxN/0UZo8kd6Vh1KlOuFSJUNAnCB7S
4ePRo2llIVV1MiAENtB3dGyMpQxQmePiOCLprWBehBpGTxlswu4Z1sRG33X0NZpS
2mYn517pJ9enhrFTP7xiSju5oCO500MSU4oE51PDPygl+CdD+IPTfRsf/e4QoIJM
8cAhgN/oLXQPiPgCin8ht6g/bKMv5CWPo0UVVVTlMeXaXagFO3sGPHCBO/nF4fBc
v/CajRg5valTayDxpk6qWb+1VJoK8dnPlNRrOzBinpwX/7zheQA826Qb878FvunW
yKs7qWsUR8hf2u1N9tukY/yXh2PW7lIF+g7F+Lgjfs+EddWBIV2wn2qbBE9VFtQd
VknryAs66jvBwjgi8q8ylDfpiDoe9BSvd8cCuu4wowudBt6XFs2rx5kJdoJxFbFn
BNb8kPPBmcgVeDccJId6nhKuA6S/ckBhqewIkqOMrDhhDIo9N3EZ7y8FbygURt9Q
wCzwwUN5H2jlFVbUQMe1lC+se0pLCxyWVmrwvZ+ePkXLCoFZZB4zcDEVfaUnUbgh
zPOPEqI8Oj7zd1ql3gh9wAFrj2WWEZ4zEAEa4XDgxQANH1t4iVrP0EPlpeF1AMUn
I9AWX6Qa+TtcVxwU4P/ZpQW23JuWQhC8XA4Oak1pZEa2zsm+Cbw=
=8AGK
-----END PGP SIGNATURE-----

--Sig_//rL9VxfSndOgxF.EtPHUHs6--

