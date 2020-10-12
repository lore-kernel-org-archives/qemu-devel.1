Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 22:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F1A20757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 22:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="id6eJcNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F1A20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS6gz-0003fd-Di
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 18:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS6fw-00038s-Dg; Mon, 12 Oct 2020 18:52:17 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS6ft-0001xi-Dq; Mon, 12 Oct 2020 18:52:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C9DT20vFJz9sTR; Tue, 13 Oct 2020 09:52:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602543126;
 bh=R39wqKkvamR5VxgVfsDbIyQ+m3FfhRSZcdkKq3AqEAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=id6eJcNjdT9jsq4xJFeg4yNntz2j+YbLhyYdNltifYkj+Pi/unrWAxAgOrIv9RsS8
 VQbVWf1tF8P9rxSosb6/vCbjmnqd0fnrfENm1Lg3Um6Ui32hC8PcIJgn7dPZ/fogHY
 X7F37105zxskLbZH4lBv9VzAPKItdmLAKnRgT05w=
Date: Tue, 13 Oct 2020 09:48:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 4/5] spapr_numa: consider user input when defining
 associativity
Message-ID: <20201012224846.GC71119@yekko.fritz.box>
References: <20201007172849.302240-1-danielhb413@gmail.com>
 <20201007172849.302240-5-danielhb413@gmail.com>
 <cf0a0fbf-5c4f-96d6-039d-780513a724e0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <cf0a0fbf-5c4f-96d6-039d-780513a724e0@redhat.com>
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 07:44:14PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 10/7/20 7:28 PM, Daniel Henrique Barboza wrote:
> > A new function called spapr_numa_define_associativity_domains()
> > is created to calculate the associativity domains and change
> > the associativity arrays considering user input. This is how
> > the associativity domain between two NUMA nodes A and B is
> > calculated:
> >=20
> > - get the distance D between them
> >=20
> > - get the correspondent NUMA level 'n_level' for D. This is done
> > via a helper called spapr_numa_get_numa_level()
> >=20
> > - all associativity arrays were initialized with their own
> > numa_ids, and we're calculating the distance in node_id ascending
> > order, starting from node id 0 (the first node retrieved by
> > numa_state). This will have a cascade effect in the algorithm because
> > the associativity domains that node 0 defines will be carried over to
> > other nodes, and node 1 associativities will be carried over after
> > taking node 0 associativities into account, and so on. This
> > happens because we'll assign assoc_src as the associativity domain
> > of dst as well, for all NUMA levels beyond and including n_level.
> >=20
> > The PPC kernel expects the associativity domains of the first node
> > (node id 0) to be always 0 [1], and this algorithm will grant that
> > by default.
> >=20
> > Ultimately, all of this results in a best effort approximation for
> > the actual NUMA distances the user input in the command line. Given
> > the nature of how PAPR itself interprets NUMA distances versus the
> > expectations risen by how ACPI SLIT works, there might be better
> > algorithms but, in the end, it'll also result in another way to
> > approximate what the user really wanted.
> >=20
> > To keep this commit message no longer than it already is, the next
> > patch will update the existing documentation in ppc-spapr-numa.rst
> > with more in depth details and design considerations/drawbacks.
> >=20
> > [1] https://lore.kernel.org/linuxppc-dev/5e8fbea3-8faf-0951-172a-b41a21=
38fbcf@gmail.com/
> >=20
> > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> > ---
> >   capstone            |   2 +-
> >   hw/ppc/spapr_numa.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 110 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/capstone b/capstone
> > index f8b1b83301..22ead3e0bf 160000
> > --- a/capstone
> > +++ b/capstone
> > @@ -1 +1 @@
> > -Subproject commit f8b1b833015a4ae47110ed068e0deb7106ced66d
> > +Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
>=20
> Certainly unrelated to your patch.

Yeah, found and fixed that one already.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+E3UwACgkQbDjKyiDZ
s5LgnA//SunUMosm7ISkEpQBjU9sQ32xdVwTwlto7QYHIi95DVro5V08f3M+69Sj
u8TSi1/i+w1r2PdhosKsD9F2Mch6eItOwI9fZPh4cyMCpy36Q47ZgQpVVGlgXWbJ
QSK8T1b7m0cXUhPek0fK83SFiK0sHe1m0QfiMZT9VtfAvAnw9Ka7u9LGqC/WAmh+
Dh+7EdDKqPdouAqIU+ZgD3RfKlBjGj4VK3Bcd21FNLiD9q3UfmQFVdKFs3Y4RECJ
Bhh4/RVlWmOndkC+VZxzS1IzgW4idvkutU0huJGg4JKXb1WmRUfA/33yaGF27bp3
b/jv2se9HbEj+5achYwc3yihoZ06tc91CdlU5FjmsEgzrJqJ1b1W8Nnsf4QG5Gfw
/DzFs0d+/HYgEn94CcRkXo8xDSIutm9aJ1CzGqLscQMeF2WLMsqny9UB72ABGRGJ
NObMByUufCDpbqbLCQL4dalVt6T/7GwwihrHOzVjvICeDhumti32yWoJG6zDsC3P
K92f9dMQts4mRzmxCOD4fiYIS0a/7QV7zFjD2lsjW+SKQiDywkOnTrKQ8r9w0bua
CM2GEfgIa57p95VCRAgNUD3KIZ3ACN+mMwVbwLMQVU51rRdUQc/espqKjoc+Gt5z
PpWfNDLx2RGqyuwaleoQdUJyvQLogwBVnkMcrPCS/y43n6UTnGc=
=LWyO
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--

