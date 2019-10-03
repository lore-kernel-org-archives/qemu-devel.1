Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD52C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 06:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A9F222BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 06:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YVw1KNze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A9F222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFuSx-0002bc-Rw
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 02:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFuS8-00021U-8O
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFuS6-0003yk-HT
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 02:19:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57207 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFuS4-0003ua-5f; Thu, 03 Oct 2019 02:19:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kNB65Frbz9sN1; Thu,  3 Oct 2019 16:18:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570083534;
 bh=VCPNx624BGXwrTJ+rV2QY28E02rG4/Q8QIddsfG6n4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YVw1KNzeWuDRvlHVdSn7QrdD6TNi15fjLK8NlqHKck5+3HLXyWP3kZ8WKFtm31MMQ
 7mNEpegHdPFW1dyM6HaMQUK0KmbbR+1OsiMKjSOxri2EBz/3VdKzJ96P5zxsSH7agE
 oF6AgDDAtpMZHiGFoBoiptLKGmfO2xQVpF/0kao8=
Date: Thu, 3 Oct 2019 16:18:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/34] spapr: IRQ subsystem cleanup
Message-ID: <20191003061845.GS11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sCshgy9RPHTe3gCr"
Content-Disposition: inline
In-Reply-To: <20191002025208.3487-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sCshgy9RPHTe3gCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 12:51:34PM +1000, David Gibson wrote:
> This is a substantial rework to clean up the handling of IRQs in
> spapr.  It includes some cleanups to both the XICS and XIVE interrupt
> controller backends, as well as more to the common spapr irq handling
> infrastructure.

Since there seems to be general agreement on that part, I've now
merged the first 20 patches of this series into ppc-for-4.2, which I
intend to send a PR for tomorroow.

>=20
> Changes since v2:
>  * Fixed a bug where the "move handling multiple irq frees" to
>    frontend patch was actually freeing one irq over and over, rather
>    than freeing multiple irqs
>  * Fixed some places I missed still using only-Error * style, and flow
>    on adjustments
>  * New idiom to iterate across all constructed backends for the things
>    that need that (cpu_intc_create, claim & freem), rather than
>    open-coding a call on the xics, then xive versions.
>=20
> Changes since v1:
>  * Lots of extra patches
>  * Many minor adjustments based on feedback
>  * Moved towards return value + Error * style, instead of just Error *
>    style
>=20
> David Gibson (34):
>   xics: Minor fixes for XICSFabric interface
>   xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
>   xics: Rename misleading ics_simple_*() functions
>   xics: Eliminate reset hook
>   xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
>   xics: Create sPAPR specific ICS subtype
>   spapr: Fold spapr_phb_lsi_qirq() into its single caller
>   spapr: Replace spapr_vio_qirq() helper with spapr_vio_irq_pulse()
>     helper
>   spapr: Clarify and fix handling of nr_irqs
>   spapr: Eliminate nr_irqs parameter to SpaprIrq::init
>   spapr: Fix indexing of XICS irqs
>   spapr: Simplify spapr_qirq() handling
>   spapr: Eliminate SpaprIrq:get_nodename method
>   spapr: Remove unhelpful tracepoints from spapr_irq_free_xics()
>   spapr: Handle freeing of multiple irqs in frontend only
>   spapr, xics, xive: Better use of assert()s on irq claim/free paths
>   xive: Improve irq claim/free path
>   spapr: Use less cryptic representation of which irq backends are
>     supported
>   spapr: Add return value to spapr_irq_check()
>   spapr: Eliminate SpaprIrq::init hook
>   spapr, xics, xive: Introduce SpaprInterruptController QOM interface
>   spapr, xics, xive: Move cpu_intc_create from SpaprIrq to
>     SpaprInterruptController
>   spapr, xics, xive: Move irq claim and free from SpaprIrq to
>     SpaprInterruptController
>   spapr: Formalize notion of active interrupt controller
>   spapr, xics, xive: Move set_irq from SpaprIrq to
>     SpaprInterruptController
>   spapr, xics, xive: Move print_info from SpaprIrq to
>     SpaprInterruptController
>   spapr, xics, xive: Move dt_populate from SpaprIrq to
>     SpaprInterruptController
>   spapr, xics, xive: Match signatures for XICS and XIVE KVM connect
>     routines
>   spapr: Remove SpaprIrq::init_kvm hook
>   spapr, xics, xive: Move SpaprIrq::reset hook logic into
>     activate/deactivate
>   spapr, xics, xive: Move SpaprIrq::post_load hook to backends
>   spapr: Remove SpaprIrq::nr_msis
>   spapr: Move SpaprIrq::nr_xirqs to SpaprMachineClass
>   spapr: Remove last pieces of SpaprIrq
>=20
>  hw/char/spapr_vty.c         |   3 +-
>  hw/intc/spapr_xive.c        | 298 ++++++++-----
>  hw/intc/spapr_xive_kvm.c    |  30 +-
>  hw/intc/trace-events        |  10 +-
>  hw/intc/xics.c              | 210 +++------
>  hw/intc/xics_kvm.c          |   9 +-
>  hw/intc/xics_spapr.c        | 157 ++++++-
>  hw/net/spapr_llan.c         |   3 +-
>  hw/ppc/pnv_psi.c            |   6 +-
>  hw/ppc/spapr.c              |  57 ++-
>  hw/ppc/spapr_caps.c         |  64 +++
>  hw/ppc/spapr_cpu_core.c     |   3 +-
>  hw/ppc/spapr_hcall.c        |   7 +-
>  hw/ppc/spapr_irq.c          | 847 +++++++++++-------------------------
>  hw/ppc/spapr_pci.c          |  10 +-
>  hw/ppc/spapr_vio.c          |   3 +-
>  hw/ppc/trace-events         |   4 -
>  include/hw/pci-host/spapr.h |  11 +-
>  include/hw/ppc/spapr.h      |  14 +-
>  include/hw/ppc/spapr_irq.h  |  89 ++--
>  include/hw/ppc/spapr_vio.h  |   5 +-
>  include/hw/ppc/spapr_xive.h |   9 +-
>  include/hw/ppc/xics.h       |  33 +-
>  include/hw/ppc/xics_spapr.h |  10 +-
>  include/hw/ppc/xive.h       |   2 +-
>  25 files changed, 897 insertions(+), 997 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sCshgy9RPHTe3gCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VksMACgkQbDjKyiDZ
s5LH+BAAoclB5E46FZU4rDYM0FADmdFTJ4SEZk1kHwN0kv0RQwVqih9lvpXk8Y0p
7hD894DcmM5ETygnNCg4IZ0+JPf0jPPYFcTT1TEogzfRxTDv48iCzxTBlIxcy8Am
RxBLP72Y2OH3WEDWYh8TNWnjqItyopIzYpKqVvlzMcRIkIZz017EadrDizk8oaxk
DX9uDhN2oNwL67PvqI/iQPujMSL8pFOMv+wu2v4Lek656mbEIzzXIGeDGnrpGZMy
NkAfFPRPNmbOICloiVBN/bXYis8G5Q+ggiFU9ABHzebc4JfkoSl4TkH3yW3zH/5J
kdeB7y9SbY9Paf1NaUKgZeY69abQJNvOXn020g8XkTdG+oaxg92oYohocI1G13k+
TXT+l+KvQ6wavk5EGjgnBKasyVi/jT48ckeL7xfQhjeYTov9xCVugs/OOz3SvwjQ
A05LuSNeZR2jHklpv+wpCXpR7rmQeRrFMFrvhD00/UQLPO7UpNRzDRYjd9C4GnF5
p2cOWFF1SOvMCPTVOI3YFAwEylQVWnNNZMQHJAnCJ0RJ7dZ10spcRkH2/0Avrfgj
uuCXOJ0l1S1DSO665SKwL1VWfUvcD4JDkfbBV6c8dVtk/i3mckuzlUMNT+N1YtTY
2V6h3+xFZpbWb4XcYNKZvv545vRjnB0nisWqHdLwRE7Uc0Mpbo4=
=WhXT
-----END PGP SIGNATURE-----

--sCshgy9RPHTe3gCr--

