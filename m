Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B09FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535C52072E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="azJaSYNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535C52072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgj8v-0002DQ-Ch
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgj7D-0000UZ-6y; Thu, 04 Jun 2020 02:12:35 -0400
Received: from ozlabs.org ([203.11.71.1]:39537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgj7B-0002nQ-3C; Thu, 04 Jun 2020 02:12:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cwRc3tX0z9sSf; Thu,  4 Jun 2020 16:12:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591251148;
 bh=+2BiyWsAjxRyUm+rxFtynXbdjxfdq5CMaIjOKUxVXlc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=azJaSYNlfNmpMi+g8I443joKrfQxgO+mGtPHQ+0aL0K8CcZhYRaq3CqQQ5mlXVR3M
 fGIr37NPIT6cmfps8E4e66HvALbbPFoc0cri+DTZ2CEQcTTIlW3uHHwoKHlx3trr9s
 GBO4ZRIXqRdgdyIluH7GnEDTq8efFa07f8gVqFeU=
Date: Thu, 4 Jun 2020 13:05:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200604030531.GA228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200529221926.GA3168@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200529221926.GA3168@linux.intel.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 03:19:26PM -0700, Sean Christopherson wrote:
> On Thu, May 21, 2020 at 01:42:46PM +1000, David Gibson wrote:
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
> >=20
> > Note: I'm using the term "guest memory protection" throughout to refer
> > to mechanisms like this.  I don't particular like the term, it's both
> > long and not really precise.  If someone can think of a succinct way
> > of saying "a means of protecting guest memory from a possibly
> > compromised hypervisor", I'd be grateful for the suggestion.
>=20
> Many of the features are also going far beyond just protecting memory, so
> even the "memory" part feels wrong.  Maybe something like protected-guest
> or secure-guest?

I think those are too vague.  There are *heaps* of things related to
protecting or securing guests, the relevance of this stuff is that
it's protecting it from a compromised hypervisor.

> A little imprecision isn't necessarily a bad thing, e.g. memory-encryption
> is quite precise, but also wrong once it encompasses anything beyond plain
> old encryption.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7YZPkACgkQbDjKyiDZ
s5I0DxAAhUQiemOH1FQiFgGP7UsHU8vGg1PD+vb3LJKDOwpxvKCjvjpxwb5bxrf7
PKjbiZ7dGO2cZiToDwIXyl5jrH44KC6Me99oFTimg4UbLv6tlomXSbZXz9Sb9asg
bgu8vBOVeBhWHo/ipMR5yFHvz/gPblsLVIIILJH0b7QFVJn0VlXnq4N4d66p+nuW
SrNAfRp7JbsGb81Zn+sexCjWtNB3cQBHcpINU8jo1UocySt/T3LV8klIfZ0f0LF8
zrpUO8nT9OCEJ4XLxAUhlvOe0GJ3//Zn24gtWgeuVt+W+sGJtUELJ5BeMzm6oBGt
USTj661kKXoeuDUmftW6QEXA+IT5N5M3OfLMTLM+4Qh4OURAfRYbQaSpeMZBnPfb
tKykqke0smEv9nzkkyaPjpPqrDsmc99ZR1ZxY8M5JJeTdisqySKP4w3asOvQi1LY
Do7Ee4m67zgPpT7TRo6J6I8x/fIXXyf8eBEa+uLWYeWxHEpSrL6e6ry9u/U3VBkc
yy9/FzSdPVJ/CP6lOAJT9txkMAN5IC8OT8ryT9QX/fWGBK7fQZuy9jbrg4S/Pw3r
CwBfolUd9d5y4BxUZZBFffszBRmdylIgxRxgYekMvsH+YrCfbFI2OM7jCq3cuTaN
GKGuaQ53um4ihL2kUwIlO21TplOUCugia9aO2gOglZe1oh7bs2Y=
=yNx8
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

