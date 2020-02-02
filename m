Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD9C35240
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 10:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8907D20679
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 10:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8907D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyCa4-00083W-MP
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 05:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iyCZT-0007WS-Ej
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 05:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iyCZS-0003Kf-34
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 05:33:43 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:36627)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iyCZR-0003KB-Py
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 05:33:42 -0500
Received: from player770.ha.ovh.net (unknown [10.110.103.133])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id A62981FBF27
 for <qemu-devel@nongnu.org>; Sun,  2 Feb 2020 11:33:39 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 86BB2EFAE7B2;
 Sun,  2 Feb 2020 10:33:32 +0000 (UTC)
Date: Sun, 2 Feb 2020 11:33:30 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PULL 00/34] ppc-for-5.0 queue 20200131
Message-ID: <20200202113330.02a3634a@bahia.lan>
In-Reply-To: <20200202084358.GF30687@umbus.fritz.box>
References: <20200131060924.147449-1-david@gibson.dropbear.id.au>
 <CAFEAcA8Uzt79o9509fyZOYgAot5m2mk2wWkQkgETW2gL0XOHWA@mail.gmail.com>
 <20200202084358.GF30687@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/33imKiHjN3.G8SR7mmU8bB4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 11926376241558428134
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrgeehgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.113
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/33imKiHjN3.G8SR7mmU8bB4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Feb 2020 19:43:58 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jan 31, 2020 at 04:42:14PM +0000, Peter Maydell wrote:
> > On Fri, 31 Jan 2020 at 06:09, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > >
> > > The following changes since commit 928173659d6e5dc368284f73f90ea1d129=
e1f57d:
> > >
> > >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm=
-20200130' into staging (2020-01-30 16:19:04 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200131
> > >
> > > for you to fetch changes up to 532fe321cf06d39d864de3642b4e1b18cc83c4=
de:
> > >
> > >   target/ppc: Use probe_write for DCBZ (2020-01-31 14:54:16 +1100)
> > >
> > > ----------------------------------------------------------------
> > > ppc patch queue 2020-01-31
> > >
> > > Here's the next batch of patches for ppc and associated machine types.
> > > Highlights includes:
> > >  * Remove the deprecated "prep" machine type and its OpenHackware
> > >    firmware
> > >  * Add TCG emulation of the msgsndp etc. supervisor privileged
> > >    doorbell instructions
> > >  * Allow "pnv" machine type to run Hostboot style firmwares
> > >  * Add a virtual TPM device for spapr machines
> > >  * Implement devices for POWER8 PHB3 and POWER9 PHB4 host bridges for
> > >    the pnv machine type
> > >  * Use faster Spectre mitigation by default for POWER9 DD2.3 machines
> > >  * Introduce Firmware Assisted NMI dump facility for spapr machines
> > >  * Fix a performance regression with load/store multiple instructions
> > >    in TCG
> > >
> > > as well as some other assorted cleanups and fixes.
> > >
> >=20
> > Hi; this pull req produces a bunch of extra warning messages in
> > my log files; is it possible to suppress them ?
> >=20
> >=20
> > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > cap-ccf-assist=3Don
> > qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> > Interrupts(FWNMI) not supported in TCG
> > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > cap-ccf-assist=3Don
> > qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> > Interrupts(FWNMI) not supported in TCG
> > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > cap-ccf-assist=3Don
> > qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> > Interrupts(FWNMI) not supported in TCG
>=20
> As you've seen, Greg has sent a fix for these.  Do you want me to
> resend the series with his patch included, or will you merge this lot
> and I'll follow up with Greg's patch?
>=20

In any case, could you please add the Reported-by: tag suggested by Philipp=
e ?

Thanks!

--Sig_/33imKiHjN3.G8SR7mmU8bB4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl42pXoACgkQcdTV5YIv
c9YmPA/7B7NSIoqeZu/edY04QZkDNb7ATn38j2MtLZ4t3Ctp8FOWGO8mTlZPEkOP
Ajy8BwOIfXPSFgWdKAQKjuTy/5YS/XVYLAV7JFJiXLVtYoVIgOS+eHeKVVcDzJEW
R/8nS2SwVUYlf/dVSHVaiqsWT+/83doloHRcs5NB3kGFYASq5yBhtEDSAFw6k5h5
kqTV7sTzUUf7zXaMzmmtGIvHgnv5xPr5FAFAKwDB1SpQzWuEvtu1lewFdr6VBCkv
S/CtWVU5BEaMmzUVbccdhXUmfPU+4GCDhO3rKaHC/vzWJi4xtCAjX6zkZwxN481E
4Hjbe8VkTjCGhXuQuN85yGKOehh+d4Mu+urJlvjZ8H5bN1v6Hxmx6tw11TwGcAAU
FBthiCWfFlDRlyWj9PFcyo4HyCtGxETUAlPp378oQZB0Jemr/ODxIg8GwTHVcTjE
zyM0e1QND9d6Q+9cjAXqPVuHg3XIN8VXv3b+lm5hPx/rtqnIgClDgxaxTHlrYndT
va+WM6mFxJm/tez7Nb96QBQgSQZ+Ej+P8xQW9N8fu3Q9BwS+iLuBjS9qhtACguqK
tN9a9g7ZC1a3jfdIjSh7hOU0gHJWr2MLxUB4vSgwu8bn1htDIhYUUMX4K6m5+zx3
h/iM5ZH+hnVhoJz04GEkgdI+kirJgd2zmmWWZgkC8sGnMEhJQG8=
=fldJ
-----END PGP SIGNATURE-----

--Sig_/33imKiHjN3.G8SR7mmU8bB4--

