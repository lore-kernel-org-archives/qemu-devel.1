Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A855CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 04:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680542067C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 04:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dqWrL9kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680542067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8cBK-0004ei-Ii
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 00:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8cAc-0003Z6-LT; Thu, 20 Aug 2020 00:27:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51801 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8cAZ-0002Gc-OO; Thu, 20 Aug 2020 00:27:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXBSf5p2Yz9sTQ; Thu, 20 Aug 2020 14:27:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597897634;
 bh=1EpChIuBXOU4rBwSnModWDpxsgEcyp0LlHp/iQnQwT0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dqWrL9kjs8pBIm7JLuXrpUmZQ6GGoZnrxqQNHCUt3L3PIdJI7PWkzhzaBh4vkGVL6
 zLIEevcWLgFaXLoETcqXILrA9tNBqRbwYHUjzCrzoIVzW9xB/IgHaxhtgpKvrlte63
 eyVKk06Jo5bV5GVZUaHRxXJodXROz/Ci8uY8BrLY=
Date: Thu, 20 Aug 2020 14:15:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
Message-ID: <20200820041504.GN271315@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
 <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Content-Disposition: inline
In-Reply-To: <20200820021128.GC642093@habkost.net>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 23:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2020 at 10:11:28PM -0400, Eduardo Habkost wrote:
> On Thu, Aug 20, 2020 at 11:17:26AM +1000, David Gibson wrote:
> > On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique Barboza wrote:
> > > The pSeries machine does not support asymmetrical NUMA
> > > configurations.
> >=20
> > This seems a bit oddly specific to have as a global machine class
> > property.
> >=20
> > Would it make more sense for machines with specific NUMA constraints
> > to just verify those during their initialization?
>=20
> This would be much simpler.  However, I like the idea of
> representing machine-specific configuration validation rules as
> data that can eventually be exported to management software.

Ah, ok, so basically the usual tradeoff between flexibility and
advertisability.

So, in that case, I guess the question is whether we envisage "no
assymmetry" as a constraint common enough that it's worth creating an
advertisable rule or not.  If we only ever have one user, then we
haven't really done any better than hard coding the constraint in the
manageent software.

Of course to complicate matters, in the longer term we're looking at
removing that constraint from pseries - but doing so will be dependent
on the guest kernel understanding a new format for the NUMA
information in the device tree.  So qemu alone won't have enough
information to tell if such a configuration is possible or not.

> (CCing John Snow, who had spent some time thinking about
> configuration validation recently.)
>=20
>=20
> > >=20
> > > CC: Eduardo Habkost <ehabkost@redhat.com>
> > > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> > > ---
> > >  hw/core/numa.c      | 7 +++++++
> > >  hw/ppc/spapr.c      | 1 +
> > >  include/hw/boards.h | 1 +
> > >  3 files changed, 9 insertions(+)
> > >=20
> > > diff --git a/hw/core/numa.c b/hw/core/numa.c
> > > index d1a94a14f8..1e81233c1d 100644
> > > --- a/hw/core/numa.c
> > > +++ b/hw/core/numa.c
> > > @@ -547,6 +547,7 @@ static int parse_numa(void *opaque, QemuOpts *opt=
s, Error **errp)
> > >   */
> > >  static void validate_numa_distance(MachineState *ms)
> > >  {
> > > +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> > >      int src, dst;
> > >      bool is_asymmetrical =3D false;
> > >      int nb_numa_nodes =3D ms->numa_state->num_nodes;
> > > @@ -575,6 +576,12 @@ static void validate_numa_distance(MachineState =
*ms)
> > >      }
> > > =20
> > >      if (is_asymmetrical) {
> > > +        if (mc->forbid_asymmetrical_numa) {
> > > +            error_report("This machine type does not support "
> > > +                         "asymmetrical numa distances.");
> > > +            exit(EXIT_FAILURE);
> > > +        }
> > > +
> > >          for (src =3D 0; src < nb_numa_nodes; src++) {
> > >              for (dst =3D 0; dst < nb_numa_nodes; dst++) {
> > >                  if (src !=3D dst && numa_info[src].distance[dst] =3D=
=3D 0) {
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index dd2fa4826b..3b16edaf4c 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -4512,6 +4512,7 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> > >       */
> > >      mc->numa_mem_align_shift =3D 28;
> > >      mc->auto_enable_numa =3D true;
> > > +    mc->forbid_asymmetrical_numa =3D true;
> > > =20
> > >      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > >      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > index bc5b82ad20..dc6cdd1c53 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -215,6 +215,7 @@ struct MachineClass {
> > >      bool nvdimm_supported;
> > >      bool numa_mem_supported;
> > >      bool auto_enable_numa;
> > > +    bool forbid_asymmetrical_numa;
> > >      const char *default_ram_id;
> > > =20
> > >      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> >=20
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl89+MYACgkQbDjKyiDZ
s5I6Qw/+IuKzQ+9g7o2EbAYkSSt1LSQOYosrbIgVAtqS65Vac1Azikxs6wvHg1yc
zjDHAwvT1OkdUy+8sED897FkmXwHHDLsEHLBQ0cCMSCl2OlCm/LeCeeYBCuSfWsu
zarbJ9dd8QA9MMVLEoQnVIoF5XiR7MJdewQFJ8SoaVf79NCtG1CNkcSsmtc4QbBG
y13iZwUnemr9Xe5Eq8/4iB7nN/YocRhdtDCzg+aUIJnJCdpFo9ltATQFnk0YGOyp
bVkWs09OG1yws0S23oyaHHfjdqqje9YAYowLD6C2E7+tgaHpPtK4YKO0lTg/Bp18
1x1SOgOuZfjF9LB0O4f0arOth1PXpWrNpKz+StPwe1WgANYF6EKMPClvzTcDDjP/
mglLpVKxUGNFEvChOi1IuNUwEqhUrXOLJBZLroI/++h3RS02PHE4FUP6tVzGIDWD
F43vh0mWQcVVFOhEYWWcTHyyECVmSx6wInSS+S4P4ipdJzWTWlGN0QihzfBML9eV
55/JzD3cdncUnyKFHR3bCOrf9OsQC+6JjAqwSwwUrJFLPTrp/SWBeCe/pQ6AsjFo
beQu9UDcwvAe1VsGpP44q3Z1zPG/n9inqdiN50pfO/tfRUIXpuIOmqAgOd6me61w
WXPtQAwwx4/6xNJlRXY7vXDHZZOzTkR3p7WQ1qPILYVPuWFcgs4=
=TV3B
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--

