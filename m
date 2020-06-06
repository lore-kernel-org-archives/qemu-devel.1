Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363BDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E53207F9
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Dj0x4Ld0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E53207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhUUR-0005My-9I
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jhUSs-0003hO-QX; Sat, 06 Jun 2020 04:46:06 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jhUSp-0005F4-Lk; Sat, 06 Jun 2020 04:46:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49fClh5Xbfz9sRh; Sat,  6 Jun 2020 18:45:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591433152;
 bh=MD9Vy9t80FMoa1MWr1bErDl8DYW9eXWurKymfv5V+hg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dj0x4Ld0zGOyYNvHNh34xSS4k7ShfK/bK0chdoJDc0pBfrqf+sCLBNp0gwHAaRaDr
 mWy4S0YAEaNqCSOohcM3XnZB2EwqoRv1iriIZGC+0b4erf2zuXdujnnHximcLEuO49
 HJMDjkcDf+UOA7pp3S2yyl7g8S/weSqIQBjTk6OY=
Date: Sat, 6 Jun 2020 18:44:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200606084409.GL228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200605125505.3fdd7de8.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vTUhhhdwRI43FzeR"
Content-Disposition: inline
In-Reply-To: <20200605125505.3fdd7de8.cohuck@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vTUhhhdwRI43FzeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 12:55:05PM +0200, Cornelia Huck wrote:
> On Thu, 21 May 2020 13:42:46 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > A number of hardware platforms are implementing mechanisms whereby the
> > hypervisor does not have unfettered access to guest memory, in order
> > to mitigate the security impact of a compromised hypervisor.
> >=20
> > AMD's SEV implements this with in-cpu memory encryption, and Intel has
> > its own memory encryption mechanism.  POWER has an upcoming mechanism
> > to accomplish this in a different way, using a new memory protection
> > level plus a small trusted ultravisor.  s390 also has a protected
> > execution environment.
> >=20
> > The current code (committed or draft) for these features has each
> > platform's version configured entirely differently.  That doesn't seem
> > ideal for users, or particularly for management layers.
> >=20
> > AMD SEV introduces a notionally generic machine option
> > "machine-encryption", but it doesn't actually cover any cases other
> > than SEV.
> >=20
> > This series is a proposal to at least partially unify configuration
> > for these mechanisms, by renaming and generalizing AMD's
> > "memory-encryption" property.  It is replaced by a
> > "guest-memory-protection" property pointing to a platform specific
> > object which configures and manages the specific details.
> >=20
> > For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> > can be extended to cover the Intel and s390 mechanisms as well,
> > though.
>=20
> For s390, there's the 'unpack' cpu facility bit, which is indicated iff
> the kernel indicates availability of the feature (depending on hardware
> support). If that cpu facility is available, a guest can choose to
> transition into protected mode. The current state (protected mode or
> not) is tracked in the s390 ccw machine.
>=20
> If I understand the series here correctly (I only did a quick
> read-through), the user has to instruct QEMU to make protection
> available, via a new machine property that links to an object?

Correct.  We used to have basically the same model for POWER - the
guest just talks to the ultravisor to enter secure mode.  But we
realized that model is broken.  You're effectively advertising
availability of a guest hardware feature based on host kernel or
hardware properties.  That means if you try to migrate from a host
with the facility to one without, you won't know there's a problem
until too late.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vTUhhhdwRI43FzeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7bV1cACgkQbDjKyiDZ
s5KuTxAAuHsZpdab6NhUviRv5pmLEZ0qSYnV6DIZFKYl6a6Uv5G7n/HFqTlvizXl
IBnDK/W/fGxSjnmYel9i7aGptRKkli5Vuxg+Iafwn8oIu5RiIqUA0CmgWCdwC2ys
6d4S3l4ZocqAAqFbDzjRW5FhyH0E09aCqn4dLUYDHkYZQYM+vq8kusMSGQ5v4rEr
DgMbyDtV0AMlmqsfdVG7GPifQCY5s5Eo6SbdsQ2swY2Krt+p85+yt5KQYrdZGyxy
37L/QlFjbFFiYYXJ19JuMHIdK86kIc9SaJEUcc282jCJuLCQHs0l4nsel4lOjhkB
ud86lwTeR00ruFjnwH9VKHKc13V6EkY3VL8sTpb7Ckvz6AT5fum7QsayXC7P5ZNC
tg/xbryLE36+J+bwT3/djtYcNUrDMhIgeVQNPfvDXfuPU2bajx6qsnsIub/8Adio
4me8QeHyGOL6I0vrffMEfEAZIGGyEQhRFbhlRKorMzoKij8iv/eMcUVyJTzbqNDd
vcF5KeoxglpeodzvmR60GfYgJLjpXh1S6fQL2kHAr+tbZaD9GVewhlKN0NUFQTCF
t7ijyD3WKcBEWCVsqk9QtdvYLwCGxdXjOQmYJo4RceVoy6nQUs4xwBnnWT5ACvrZ
qRCz7P8nWYrYtr1VVYdzv6IVAg9a0uGjHPkVO2DrNyGRnmqZh4A=
=yDWK
-----END PGP SIGNATURE-----

--vTUhhhdwRI43FzeR--

