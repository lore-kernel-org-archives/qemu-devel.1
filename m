Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C01AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 01:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A278820708
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 01:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m/dGoFvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A278820708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIiYV-00010a-O5
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 21:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kIiXe-0008SS-Ei; Wed, 16 Sep 2020 21:16:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kIiXb-0002Rr-Qj; Wed, 16 Sep 2020 21:16:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BsJvx45SDz9sTW; Thu, 17 Sep 2020 11:16:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1600305405;
 bh=wEzmaPSW3K5cxCNNFB/mq+KFspyBXl4ZaOZdk9xXVLo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m/dGoFvdOsSLkFk5yB43KQhJHGQ4lh8/eUQuUyM8CH4+sNGtw2hnrgIwALNKwPKqg
 Qz5H2js2ype7Li+ZGhL7M8cv19xWSNYRQUQnyzZFqBA1yjKZ8vY6ux+BbqTRT4OHVO
 uwYqMkLiOfVADmMywB9kSvmVLDQ91OcUZdu8v9/0=
Date: Thu, 17 Sep 2020 11:06:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 10/15] spapr: Add a return value to spapr_set_vcpu_id()
Message-ID: <20200917010622.GG5258@yekko.fritz.box>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-11-groug@kaod.org>
 <740605ab-5310-d2fe-eb20-138b8def0b48@redhat.com>
 <20200915155352.605b0e47@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <20200915155352.605b0e47@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 03:53:52PM +0200, Greg Kurz wrote:
> On Tue, 15 Sep 2020 15:08:05 +0200
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
>=20
> > On 9/14/20 2:35 PM, Greg Kurz wrote:
> > > As recommended in "qapi/error.h", return true on success and false on
> > > failure. This allows to reduce error propagation overhead in the call=
ers.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  include/hw/ppc/spapr.h  | 2 +-
> > >  hw/ppc/spapr.c          | 5 +++--
> > >  hw/ppc/spapr_cpu_core.c | 5 +----
> > >  3 files changed, 5 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index c8cd63bc0667..11682f00e8cc 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -909,7 +909,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, r=
un_on_cpu_data arg);
> > >  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> > > =20
> > >  int spapr_get_vcpu_id(PowerPCCPU *cpu);
> > > -void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
> > > +bool spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
> >=20
> > If you have to respin, please add some doc, at least this would
> > be an improvement:
> >=20
> > /* Returns: %true on success, %false on error. */
> >=20
>=20
> Yeah, most, not to say all, APIs in the spapr code don't have
> doc in the header files... which uselessly forces everyone to
> check what the function actually does. Not sure how to best
> address that though.
>=20
> Adding headers everywhere (ie. lot of churn) ? Only in selected places
> where it isn't obvious ? Also for functions that return integers or
> pointers ?
>=20
> I'll cowardly let David decide ;-)

And I'll lazily reply that I'm happy to take patches adding
documentation, but I'm not going to undertake a big effort to add it
comprehensively.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9itowACgkQbDjKyiDZ
s5IVBhAA3Xl9hjUo8Gg/iwY4GjPNuXjhiQelRjaBriH/hvgnQo9/jS50yxo/iubA
4l3oaGnCE6mhb1pYmRUdDh2UczxjgSX6LWwL7bYhVKFNGaByV8Ec+FXVXne4FPfz
MWFU6cJ/ChrHyPtE51goFwrK8n9YgsoE6Djyh+38ZfJwb9+qXfzBUGeADdDHQMxA
gokv23s46uuhPvdcnlaV1D8K+t/3XjWdIkViL8VQSY3r6oFGK+YWwimDfzXvwoyG
JNBbVmn7uH0Je6kWso5zLiXkSrsEhnP5+KXM/2cnsVBckDpz4+vefEsXBlInwwZM
ub4nrJcBSrEoqMm4SFWCfPbF/dq9zACeUA2R7145IyPwlBWqNk1xMOKXlxSrQGw+
lKE3YLqkKoUb522W8YfC5uhl4ESyn/5JZFa2v0uSs8QxQfDOOEGbZaKefegb9L0k
0jLMJQT5MuJTFynLhvh17yLdE75Rhm3RwyWMTJHEH14EiXTaPtr8Ttsc6JGwXJEh
8wVUIrQGF46SODzS0ik/xEb898l3hSDeO4glP9TriG1OCGjAUI7BSOrUpyG629YZ
ARMuC88i/dP094tF6it7sqx22/DOX+i9IfvuCFvOEMNNN8QzSpaktfStCj+z3034
yiPTShattioWSJSYoUe6wD+MQLg1jHX5ts6QyhyOP81hEv/Xi98=
=476E
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--

