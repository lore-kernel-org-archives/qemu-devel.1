Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FD82063A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f4RMuflO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FD82063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKlg-00040X-DX
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjg-0000lS-06; Thu, 25 Jun 2020 01:47:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50083 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joKjd-0004VD-SS; Thu, 25 Jun 2020 01:47:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49spv509mmz9sT9; Thu, 25 Jun 2020 15:47:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593064049;
 bh=gnSHCl8vwImx7o9H0Ein+TSImN511M/Zl2woK1V+Fks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f4RMuflOGe+siIzPupiMAEhRQvHrh8t+/mvPGK44eZgNtCNrBq8v89NlHTANwcj3B
 otoGXUAYuJua6V1vH89LZRpp2hW3l4alcIJp4MgF4/x1Q2GeUTadOXLyZWzitFucsF
 C4BFxkAUXDW7athopwzP1jkL17XoNMP3oDaryPn0=
Date: Thu, 25 Jun 2020 15:44:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200625054448.GF172395@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <2fa7c84a-6929-ef04-1d61-f76a4cac35f5@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <2fa7c84a-6929-ef04-1d61-f76a4cac35f5@de.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 22:09:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 04:27:28PM +0200, Christian Borntraeger wrote:
> On 19.06.20 04:05, David Gibson wrote:
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
> > "host-trust-limitation" property pointing to a platform specific
> > object which configures and manages the specific details.
> >=20
> > For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> > can be extended to cover the Intel and s390 mechanisms as well,
> > though.
>=20
> Let me try to summarize what I understand what you try to achieve:
> one command line parameter for all platforms that=20
>=20
> common across all platforms:
> - disable KSM
> - by default enables iommu_platform

Pretty much, yes.  Plus, in future if we discover other things that
don't make sense in the context of a guest whose memory we can't
freely access, it can check for those and set sane defaults
accordingly.

> per platform:
> - setup the necessary encryption scheme when appropriate
> - block migration

That's true for now, but I believe there are plans to make secure
guests migratable, so that's not an inherent property.

> -....
>=20
>=20
> The tricky part is certainly the per platform thing. For example on
> s390 we just have a cpumodel flag that provides interfaces to the guest
> to switch into protected mode via the ultravisor. This works perfectly
> fine with the host model, so no need to configure anything.  The platform
> code then disables KSM _on_switchover_ and not in general.

Right, because your platform code is aware of the switchover.  On
POWER, we aren't.

> Because the=20
> guest CAN switch into protected, but it does not have to.
>=20
> So this feels really hard to do right. Would a virtual BoF on KVM forum
> be too late? We had a BoF on protected guests last year and that was
> valuable.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70OdAACgkQbDjKyiDZ
s5IUJQ/9EKOS1WmdsXTeIqzvdTE1f0NTDsgME+rPrh8z6e3ZcJgY1Fei6Clr2Amq
+F5xcLnOAq8P8zfk6dpjyZ8oa0lyxfC6j9n9raoQMJrDL7e4mricPn7ERaSrBcyI
5rTOkx1i64cdlRR1/ajN2N8KpR+IkiTkJVxlXIO8xq7Vgha/sP3hb2qyMLFeCd1H
wj59bduUNo1BMMrU6EAC13S+ZpuiCd10V6XMfmaXGN4Y6IWAKckLCIjTtjWuxA1A
7GNNt88iIFKkIHd7mYLwuHBeryO2D/D/VVym1ssYUfzDWqG6J6K5lwpcjkbrbCLL
rA6N0kIbHZqcIaHgfqf3j3V16oh9r3KJydjDHR2h75lPcqqZNNZ3f5xMFSnYWrXv
6CJ2cxfcI3eF1zPFwVSTOmd8xOx2YJPlVU1RNurwBxO4OVoljsdqfWSErkfB30Zd
7oHOQ9tePXBv3rkzgGpF9RUnqFz2SNyGfzQjvQAzlXTNQRwp6KVS1NazEa6e+VI4
t42scr5er3V9qyp0mwoyq86RAbcObNZS8JOya9RqYJTrJdGFHVeWbSBKYX9vUm0H
cPtlwYHMGT9A+Qk7tbPK4m7kLtu4EMwU6jJl53Dlm5/7AB/Dla+O2/EXQ5cP5vbm
NEhNz5N0yx/v/douwEJCJ8Catj81QtVn+mMh4KfUGt1EFwnufW0=
=6tvg
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--

