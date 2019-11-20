Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0E2C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FA320872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FA320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKm5-0004hY-0c
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXKka-0003bS-Jy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXKkZ-0005J4-8t
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:50:08 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:43184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXKkZ-0005GV-0w
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:50:07 -0500
Received: from player692.ha.ovh.net (unknown [10.108.57.150])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0478C232317
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:50:04 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 908E5C308551;
 Wed, 20 Nov 2019 07:49:56 +0000 (UTC)
Date: Wed, 20 Nov 2019 08:49:55 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
Message-ID: <20191120084955.160aa793@bahia.lan>
In-Reply-To: <20191120043653.GG5582@umbus.fritz.box>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan>
 <20191119010012.GI5582@umbus.fritz.box>
 <caa35299-c928-a968-83b5-842d000f0242@redhat.com>
 <20191119164526.0e980a37@bahia.lan>
 <20191120043653.GG5582@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sy4ApcBtHuvRpnLeZOkDCbA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 17306207472055982566
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.178.58
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
 =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/sy4ApcBtHuvRpnLeZOkDCbA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Nov 2019 15:36:53 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Nov 19, 2019 at 04:45:26PM +0100, Greg Kurz wrote:
> > On Tue, 19 Nov 2019 15:06:51 +0100
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >=20
> > > On 19/11/2019 02:00, David Gibson wrote:
> > > > On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
> > > >> On Fri,  8 Nov 2019 16:40:35 +0100
> > > >> Laurent Vivier <lvivier@redhat.com> wrote:
> > > >>
> > > >>> Commit 29cb4187497d sets by default the VSMT to smp_threads,
> > > >>> but older kernels (< 4.13) don't support that.
> > > >>>
> > > >>> We can reasonably restore previous behavior with this kernel
> > > >>> to allow to run QEMU as before.
> > > >>>
> > > >>> If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
> > > >>> as it is done for previous machine types (< pseries-4.2)
> > > >>>
> > > >>
> > > >> It is usually _bad_ to base the machine behavior on host capabilit=
ies.
> > > >> What happens if we migrate between an older kernel and a recent on=
e ?
> > > >=20
> > > > Right.  We're really trying to remove instaces of such behaviour.  =
I'd
> > > > prefer to completely revert Greg's original patch than to re-introd=
uce
> > > > host configuration dependency into the guest configuration..
> > > >=20
> > > >> I understand this is to fix tests/migration-test on older kernels.
> > > >> Couldn't this be achieved with migration-test doing some introspec=
tion
> > > >> and maybe pass vsmt=3D8 on the QEMU command line ?
> > > >=20
> > > > ..adjusting the test case like this might be a better idea, though.
> > > >=20
> > > > What's the test setup where we're using the old kernel?  I really o=
nly
> > > > applied the original patch on the guess that we didn't really care
> > > > about kernels that old.  The fact you've hit this in practice makes=
 me
> > > > doubt that assumption.
> > > >=20
> > >=20
> > > The way to fix the tests is to add "-smp threads=3D8" on the command =
line
> > > (for all tests, so basically in qtest_init_without_qmp_handshake(), a=
nd
> > > it will impact all the machine types), and we have to check if it is
> >=20
> > Ohhh... it isn't possible to initialize Qtest with machine specific
> > properties ? That's a bit unfortunate :-\
>=20
> Uhh... I don't see why we can't.  Couldn't we just put either -machine
> vsmt=3D8 or -smp 8 into the cmd_src / cmd_dst printfs() in the
> strcmp(arch, "ppc64") case?
>=20

Yes you seem to be right for migration-test... so I'm not sure what Laurent=
 is
implying with qtest_init_without_qmp_handshake().

> > > ppc64/pseries to do that, and there it becomes a little bit complicat=
ed
> > > for a so small piece of code.
> > >=20
> > > So I think the best to do is to revert Greg's patch.
> > >=20
> >=20
> > I'm okay with that since this patch doesn't bring much for the moment.
> >=20
> > But soon, ie. linux-5.5 hopefully, KVM will allow to configure the numb=
er
> > of presenters in the XIVE and XICS-on-XIVE devices on POWER9. Combined
> > with this patch, it will allow to drastically reduce the consumption of
> > resources in the XIVE HW, which currently limits the number of VMs that
> > can run concurrently with an in-kernel irqchip. So I hope the 'make che=
ck'
> > you're willing to fix is worth it :-), and BTW you didn't answer David's
> > question about the test setup.
> >=20
>=20


--Sig_/sy4ApcBtHuvRpnLeZOkDCbA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl3U8CMACgkQcdTV5YIv
c9blYQ//WwiK9sacNfoBe2raQC8IOmaeqTxvIz2lBjClUzUSo+QSflYqsFFEVswU
PNxypm62AYgkkRpKzpt4et+tEEWavtRSZlYiWyjqXbgnSg//Z030NojaJmOJ6q1Y
pfq7b1/r0A+ZfH7frjAcMSIaFESpBh/UqUbDVsyk+7ExKkmTRzWysbq1IAAIomPY
C2lISJGUQWtRYxBoH13FJHRZVYFiN/LsjKh1o5lkWhBZA3Rci2Zrc0qXobf7CtCj
+CIUSXw969li7PT8WSwYPn4U1roQqA7ao1VJPd0ZdzsHndymmbZZPNi8myB/CKM/
T8xBD45FOaRmo8MxZ9frR31qUsbEMcH1kuY10fV+UjjuM77pJ7Xt+OzrstbDUQsy
K5fq2/7FmiuvbmuoUGK+56NKJmpYAvoKepru30P1VKwezzJsDjmFkeUx8KcDLQvI
7vWyHSLO/3e9PvemhXDLY1/IjfZNI4zs1+U5IKqjX54mCPGyuPbvaU+WIEnDuY2F
VpyHjIuatGKJHNk99n4Rm3IJgL+atILz0eMZFvPqE43TTujPBQVcRVkYeQSicf5K
d4bUEIOhPKZZ6Io7wEyv0X/u7aVIlRs24XGvjnZdhcKzc4t6eBAsPjFNWosnBRab
/a0wL4tPoqzGt6+Jkptvia3snJ82f4PMNno6Sutr9BazKaofhF0=
=LrNb
-----END PGP SIGNATURE-----

--Sig_/sy4ApcBtHuvRpnLeZOkDCbA--

