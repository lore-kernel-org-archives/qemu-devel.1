Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF12C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181A12076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pfgOscu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181A12076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Yvv-00071G-Ce
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8YvF-00064w-FO; Wed, 19 Aug 2020 20:59:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54701 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8YvC-0007Ln-KC; Wed, 19 Aug 2020 20:59:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX5rR2Jb2z9sTQ; Thu, 20 Aug 2020 10:59:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597885143;
 bh=HXYsVBU9j6hC75I3sH44gjiy7byEg93XWn2XSSBDvl4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pfgOscu5nuM7zzW6D9lhUP/y6SJU8Uam6lEDk1kqbVTkziL5kwRF7aTjgCO+aZYML
 oWiKCgGXpzzPyTj+qy/dG6mZksKqrva5S54VMfhA/FYc5GmidN5C0iz1pu+r1HJ+n7
 Lg6rZAojkLIzj10PPhCi5Jokwo0KapSlEMJdF9io=
Date: Thu, 20 Aug 2020 10:42:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] spapr/xive: Allocate IPIs from the vCPU contexts
Message-ID: <20200820004246.GB271315@yekko.fritz.box>
References: <20200814150358.1682513-1-clg@kaod.org>
 <42e8bb9f-c052-5abb-9ffe-0700bfe3904d@kaod.org>
 <20200816043000.GH12805@yekko.fritz.box>
 <2d621c86-b951-8c62-2015-e307f955c93a@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <2d621c86-b951-8c62-2015-e307f955c93a@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:59:03
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2020 at 03:38:20PM +0200, C=E9dric Le Goater wrote:
> On 8/16/20 6:30 AM, David Gibson wrote:
> > On Fri, Aug 14, 2020 at 05:08:13PM +0200, C=E9dric Le Goater wrote:
> >>
> >> This works as expected with a 128 vCPUs guest with pinned vcpus. The
> >> first 64 IPIs are allocated on the first chip and the remaining 64
> >> on the second chip.
> >>
> >> Still, this is more an RFC. We have time before the end of the merge
> >> window.
> >=20
> > It looks reasonable to me.  AFAICT it makes things better than they
> > were, and even if we can improve it further, that won't break
> > migration or other interfaces we need to preserve.
>=20
> Yeah. What I don't like is this test below. I am not sure that=20
> machine->smp.cpus is the correct way to test the number of currently
> active vCPUs.

Ah, yeah.  It should be correct at initial startup, but might not be
after a bunch of hotplugs/unplugs, which could result in a sparse set
of active vcpus.

Usually this code will be called during initial setup, but I think
there are some edge cases where it won't be (e.g. boot a XICS kernel,
do some vcpu plugs/unplugs, reboot into a XIVE kernel).

So I think we need to explicitly check for each vcpu # if it's
currently active.  Using... spapr_find_cpu(), I guess?

>=20
> >>> +    if (srcno < machine->smp.cpus) {
> >>> +        return kvmppc_xive_reset_ipi(xive, srcno, errp);
> >>> +    }
> >>> +
> >>>      if (xive_source_irq_is_lsi(xsrc, srcno)) {
> >>>          state |=3D KVM_XIVE_LEVEL_SENSITIVE;
> >>>          if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl89xwQACgkQbDjKyiDZ
s5Jbgw/8DuO3cyFqec5/5HPZwMkFg3SsoEl3DGGuJQazgadh9NJqteBaqGrs2Ft5
IhJm7j26+W090cw11uJAt808rCkSATBwcqtG2VSKH1x9Dc7KDHkIIzXCRHWQolb4
c64E9yUloYs0l3fhGNthD4XfbzEUJypiRmR/brSzn+i86opX7vfgjd218MdKiomI
njMoLgsu6M0mpQePMYImk0p0n3gvBirMA4BuqYgF5FtbhBCNaRBf//UZdwBJsd1e
n0dlRNKD685troFT/pl9ZSMzzDoHJaWvlld6lMIegAk9yZhFFAHjPVgR7RB5pRjm
QtjFW6+qE9ZK88HZb83bwX0Iuxl3tlJ4Cx3ckznxccGVfdPThx14MkKG6xnHH9uv
N/Qk8YFdkEJmK3Rb8x9btjmY1F6ZSKqZMcz+Ax5mUEMfjFIVHremr9PgbeB1MJYJ
Bd5lBndFDz28yigPj4vROWW/mucb0wsd3dt/MdZ3vOyi+MZ7HrXOdGzZ6qUnZRKK
qQ2bIxNPCAsc9vh76RL94Si0jEwKO/s+zMzcmNlHOrBEtHxk4sf3IAMpExxEE6FI
oxEuM7CyQBa2vA8g28/jooE7bijb0nnr1bXlmFQuQazKCf3N78KxRCmR4t6z54dy
I8Tz6GgIpRQ74j7YlmB8pvf3aBGi+O5jkMVAWfpXQdArQSG5JnY=
=cyED
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

