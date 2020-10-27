Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0802071A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0802071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJTY-0006BA-VI
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kXJSk-0005i5-JZ; Tue, 27 Oct 2020 03:32:10 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:40277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kXJSi-0005zx-3S; Tue, 27 Oct 2020 03:32:10 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.186])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id B0F7468B367F;
 Tue, 27 Oct 2020 08:32:04 +0100 (CET)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 27 Oct
 2020 08:32:03 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002497e4762-6cb7-406c-a72f-78dce7e094c3,
 8E5A4880AAF567D55136F4F8027E0847E2FD1EE8) smtp.auth=groug@kaod.org
Date: Tue, 27 Oct 2020 08:32:02 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/4] spapr: qemu_memalign() doesn't return NULL
Message-ID: <20201027083202.57a1e487@bahia.lan>
In-Reply-To: <20201027015640.GB4671@yekko.fritz.box>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371603337.305923.17158585537944509438.stgit@bahia.lan>
 <7b6abe52-c17e-09b8-9239-e0e38d4d0a1f@redhat.com>
 <20201026154647.4a421bc5@bahia.lan>
 <20201027015640.GB4671@yekko.fritz.box>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CUkvGCImWmFviCfENWzt5Qt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 390bccb6-3608-42cc-81dd-ad203f844e27
X-Ovh-Tracer-Id: 14768429078897072608
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeekgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtihesghdtreerredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephfffgfejleefgefggfetheeftdevhfehtdeggeehffduteduudeugfdvleelueetnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 03:32:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/CUkvGCImWmFviCfENWzt5Qt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2020 12:56:40 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Oct 26, 2020 at 03:46:47PM +0100, Greg Kurz wrote:
> > On Mon, 26 Oct 2020 14:43:08 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >=20
> > > On 10/26/20 1:40 PM, Greg Kurz wrote:
> > > > qemu_memalign() aborts if OOM. Drop some dead code.
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >   hw/ppc/spapr.c       |    6 ------
> > > >   hw/ppc/spapr_hcall.c |    8 ++------
> > > >   2 files changed, 2 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 0cc19b5863a4..f098d0ee6d98 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1521,12 +1521,6 @@ void spapr_reallocate_hpt(SpaprMachineState =
*spapr, int shift,
> > > >           int i;
> > > >  =20
> > > >           spapr->htab =3D qemu_memalign(size, size);
> > > > -        if (!spapr->htab) {
> > > > -            error_setg_errno(errp, errno,
> > > > -                             "Could not allocate HPT of order %d",=
 shift);
> > > > -            return;
> > >=20
> > > Wasn't the idea to use qemu_try_memalign() here?
> > >=20
> >=20
> > Well... I have mixed feeling around this. The HTAB was first
> > introduced by commit:
> >=20
> > commit f43e35255cffb6ac6230dd09d308f7909f823f96
> > Author: David Gibson <david@gibson.dropbear.id.au>
> > Date:   Fri Apr 1 15:15:22 2011 +1100
> >=20
> >     Virtual hash page table handling on pSeries machine
> >=20
> > using qemu_mallocz(), which was aborting on OOM. It then got
> > replaced by g_malloc0() when qemu_mallocz() got deprecated
> > and eventually by qemu_memalign() when KVM support was added.
> >=20
> > Surviving OOM when allocating the HTAB never seemed to be an
> > option until this commit that introduced the check:
> >=20
> > commit c5f54f3e31bf693f70a98d4d73ea5dbe05689857
> > Author: David Gibson <david@gibson.dropbear.id.au>
> > Date:   Tue Feb 9 10:21:56 2016 +1000
> >=20
> >     pseries: Move hash page table allocation to reset time
> >=20
> > I don't really see in the patch and in the changelog an obvious
> > desire to try to handle OOM.
>=20
>=20
> This one is probably ok.  AFAICT all failures returned here would be
> more or less fatal in the caller, one way or another (&error_fatal in
> two cases, and failure to load an incoming migration stream in the
> other).
>=20
> > > > -        }
> > > > -
> > > >           memset(spapr->htab, 0, size);
> > > >           spapr->htab_shift =3D shift;
> > > >  =20
> > > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > > index 607740150fa2..34e146f628fb 100644
> > > > --- a/hw/ppc/spapr_hcall.c
> > > > +++ b/hw/ppc/spapr_hcall.c
> > > > @@ -361,12 +361,8 @@ static void *hpt_prepare_thread(void *opaque)
> > > >       size_t size =3D 1ULL << pending->shift;
> > > >  =20
> > > >       pending->hpt =3D qemu_memalign(size, size);
> > > > -    if (pending->hpt) {
> > > > -        memset(pending->hpt, 0, size);
> > > > -        pending->ret =3D H_SUCCESS;
> > > > -    } else {
> > > > -        pending->ret =3D H_NO_MEM;
> > >=20
> > > Ditto.
> > >=20
> >=20
> > This one was introduced by commit:
> >=20
> > commit 0b0b831016ae93bc14698a5d7202eb77feafea75
> > Author: David Gibson <david@gibson.dropbear.id.au>
> > Date:   Fri May 12 15:46:49 2017 +1000
> >=20
> >     pseries: Implement HPT resizing
> >=20
> > I agree that maybe the intent here could have been to use qemu_try_mema=
lign(),
> > but again I don't quite see any strong justification to handle OOM in t=
he
> > changelog.
> >=20
> > David,
> >=20
> > Any insight to share ?
>=20
> Aborting on an HPT resize failure is definitely not ok, though.  This
> one needs to be a qemu_try_memalign().
>=20

Ok, I'll fix that.

--Sig_/CUkvGCImWmFviCfENWzt5Qt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl+XzPIACgkQcdTV5YIv
c9b4rw//ViaMmQChus9EfQf2BnXOCyXpv3+NecyL8m4nBbPicuGqpdh+OESLMRDl
s5kbdSBB4Z1b3t9aFkuxjRuYYUzfjnhT1fpoatfbAvbYXX9MPU+iNx07xjLSPR3N
MObljwAYVY1pCkKtvG7RcIHEGCLzytle262rwWLOBmZYj6Qj0cufGcKRLUmTiYPC
pZp1gEAABfIra0Sa0t1m5blaYikFELyJPIUZKyKsFE13K8gpbQTUzH7EfE44Uef1
trbZalDWVA6M3yZ4UV9o4p6vogMC1Zvn1b3wUHJ/VVJ8VBUtRyOj5XQuDr7AyIzj
gCaREIcYjLnjh7hhMoHenBoNMSgEMYXniCEoJ20RvL1VcF1v6pm5rq8alXyTTPjh
FYIFgF83TSo+mTJZhCmwksXjjjvMtOQ2cphS4+lC9AE2v5xbWBz7cj9ayJvJK9CG
74T+f+mEHjuNlHbG9eB3nB674/uJhnNigGFR3sbzAOpV7EWbTm5d7DU7DirSqSgT
fbEHcSu3/yVeU2qzd3Euz1ZOuQtcp3hWEx3Bd+M6DQLdYwkgCNFj1RDj14j06k3o
JhUrqvZkLvsxUVMP6FFENmEGRwEcm/Z5vAEG55x8lz9B7UxeCU1lTTO4VTgkrHF2
tFKmwXOoB3mwIxjv/YbJFZHZhkuutSdWfjDafeKTUaD4sxrGF7o=
=lDG9
-----END PGP SIGNATURE-----

--Sig_/CUkvGCImWmFviCfENWzt5Qt--

