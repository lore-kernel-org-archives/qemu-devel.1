Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E2FCA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 06:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEA121655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 06:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEA121655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNWde-0003wP-E0
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 02:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNWcW-0001Rp-Pv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 02:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNWcV-0008Gu-Fd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 02:29:16 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:49683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNWcV-0008Cu-81
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 02:29:15 -0400
Received: from player773.ha.ovh.net (unknown [10.109.143.24])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id B1FC8146966
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 08:29:12 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 44993B562A1D;
 Thu, 24 Oct 2019 06:28:55 +0000 (UTC)
Date: Thu, 24 Oct 2019 08:28:54 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Don't request to unplug the same core twice
Message-ID: <20191024082854.1ea22701@bahia.lan>
In-Reply-To: <20191023223817.GL6439@umbus.fritz.box>
References: <157185826035.3073024.1664101000438499392.stgit@bahia.lan>
 <20191023223817.GL6439@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fy+zS_12A=8GD=EI7MPEu3s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 4951707793292171750
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledtgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.62.179
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

--Sig_/fy+zS_12A=8GD=EI7MPEu3s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2019 09:38:17 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Oct 23, 2019 at 09:17:40PM +0200, Greg Kurz wrote:
> > We must not call spapr_drc_detach() on a detached DRC otherwise bad thi=
ngs
> > can happen, ie. QEMU hangs or crashes. This is easily demonstrated with
> > a CPU hotplug/unplug loop using QMP.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Ouch, good catch.  Applied.
>=20
> I wonder if we have the same problem with other DRC types.
>=20

We don't have it with PHB and PCI types, through the same use of
spapr_drc_unplug_requested().

LMBs see to avoid it by failing device_del early if an unplug
request is already in progress:

    /*
     * An existing pending dimm state for this DIMM means that there is an
     * unplug operation in progress, waiting for the spapr_lmb_release
     * callback to complete the job (BQL can't cover that far). In this cas=
e,
     * bail out to avoid detaching DRCs that were already released.
     */
    if (spapr_pending_dimm_unplugs_find(spapr, dimm)) {
        error_setg(&local_err,
                   "Memory unplug already in progress for device %s",
                   dev->id);
        goto out;
    }

Not sure why we error out in this case instead of ignoring the unplug=20
request.

> > ---
> >  hw/ppc/spapr.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index f9410d390a07..94f9d27096af 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3741,9 +3741,10 @@ void spapr_core_unplug_request(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> >                            spapr_vcpu_id(spapr, cc->core_id));
> >      g_assert(drc);
> > =20
> > -    spapr_drc_detach(drc);
> > -
> > -    spapr_hotplug_req_remove_by_index(drc);
> > +    if (!spapr_drc_unplug_requested(drc)) {
> > +        spapr_drc_detach(drc);
> > +        spapr_hotplug_req_remove_by_index(drc);
> > +    }
> >  }
> > =20
> >  int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
> >=20
>=20


--Sig_/fy+zS_12A=8GD=EI7MPEu3s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2xRKYACgkQcdTV5YIv
c9bQXQ//R4/7qfR1kct+Yc1kGFpXy6pRWB6BK1Td9WIEK5U2acofVujNHSYXTZne
5X78GElghk0D3bXycKuzS1vH8QLopNJ4YggBHBrkbpj0TCflGPHNvpBRnaEVm5Ng
m/BWZI+UsPW9W2uz+vwMwqo4xY7qC8BpQtNvXEqt4dSOlLbwTQz/HOH5b11nYO54
cgxdTJlqREUptFPNAJOJn143/ICP8QAHQwYSe6SylY5/Ws+wnh/WeBmPRiwt047l
M0zP2zqgW18yk/S0GH/5cNV9Idv8nyiTzeKhJ29ySVZuETOafnwwv3JrpSrysA0R
dbjx+Oge78KW+4eq8Cqle94270Ep49tOVYOavye9wItt+fdjTQYwXIU3sE6BuXku
P0ObEfegCJFrTCwhv0B4SovUD9XBMVuqmbP6d/JyxfntO805K3W74bzU4m5v8Y4U
fFAQEj71V5Zni5TH24ci5lpvZMgY9wkVEGONnceTH3/BH9TTswsmAX3iT97kGwJn
olJet0DdSHmCeVH0Y63RJ8TpDsnWC2i3uVLdzpqxJ8oK0t9jWNPS2TrpudOuJWP4
DygsTtlS5QliDU8SwFMVfxs29Ow0rGFfBXqmGhj4l04zDkzFJonil/mE7T1HQBGf
bEmMryhzQH74tpjtpiPPnDKn8CZoW87Ty1BsBpXGHi7EgZ39p58=
=RbIr
-----END PGP SIGNATURE-----

--Sig_/fy+zS_12A=8GD=EI7MPEu3s--

