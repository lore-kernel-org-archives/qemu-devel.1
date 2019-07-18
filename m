Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FCCC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 03:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADDD2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 03:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lLdQYrww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADDD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnxQp-00040o-6j
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 23:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41453)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnxQc-0003Ua-79
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 23:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnxQb-00037v-0G
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 23:49:58 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47853 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnxQZ-000351-Ts; Wed, 17 Jul 2019 23:49:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45q0Wd3WMHz9sBF; Thu, 18 Jul 2019 13:49:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563421789;
 bh=SZCUGX/HuuWY2kq3D7lug8kE8s/RN1pxVoKX5brlM6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lLdQYrwwyG+HeLy37zGMtFlvtVaYwmf77FpHcQjctTGBXiC2MEOlwzmuDHlKlfhp+
 kYQ76nNI2rfcmuQFqQ0N8R3ywDx9lSFqbfeeETf1YTdFo7te+tdWfUEYRcWN5RGPvi
 WIA8sowsyyIZl/THZyyCdNZ8wo1OPHvdJN9Et0e0=
Date: Thu, 18 Jul 2019 11:53:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <20190718015351.GB8468@umbus.fritz.box>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
 <20190712011934.29863-3-mdroth@linux.vnet.ibm.com>
 <20190712064619.GH2561@umbus.fritz.box>
 <156294208686.22588.14626783330276025418@sif>
 <20190715022524.GA3440@umbus.fritz.box>
 <156329460197.5171.2898987669271477790@sif>
 <20190717012912.GA2217@umbus.fritz.box>
 <156339682748.9622.9735892189405094393@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <156339682748.9622.9735892189405094393@sif>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr: initial implementation for
 H_TPM_COMM hcall
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
Cc: qemu-ppc@nongnu.org, linuxram@us.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 03:53:47PM -0500, Michael Roth wrote:
> Quoting David Gibson (2019-07-16 20:29:12)
> > On Tue, Jul 16, 2019 at 11:30:01AM -0500, Michael Roth wrote:
> > > Quoting David Gibson (2019-07-14 21:25:24)
> > > > On Fri, Jul 12, 2019 at 09:34:46AM -0500, Michael Roth wrote:
> > > > > Quoting David Gibson (2019-07-12 01:46:19)
> > > > > > On Thu, Jul 11, 2019 at 08:19:34PM -0500, Michael Roth wrote:
> > > > > > > This implements the H_TPM_COMM hypercall, which is used by an
> > > > > > > Ultravisor to pass TPM commands directly to the host's TPM de=
vice, or
> > > > > > > a TPM Resource Manager associated with the device.
> > > > > > >=20
> > > > > > > This also introduces a new pseries machine option which is us=
ed to
> > > > > > > configure what TPM device to pass commands to, for example:
> > > > > > >=20
> > > > > > >   -machine pseries,...,tpm-device-file=3D/dev/tmprm0
> > > > > >=20
> > > > > > Bolting this into yet another machine parameter seems kind of u=
gly.
> > > > > > Wouldn't it make more sense to treat this as an virtual device =
(say
> > > > > > "spapr-vtpm").  Adding that device would enable the hcall, and =
would
> > > > > > have properties for the back end host device.
> > > > >=20
> > > > > That does sound nicer.
> > > > >=20
> > > > > Originally I had SpaprMachineClass implement the TYPE_TPM_IF inte=
rface so
> > > > > we could define a TPM backend via -tpmdev passthrough,path=3D...,=
 but after
> > > > > some discussion with the TPM maintainer it didn't quite work for =
the main
> > > > > use-case of passing through a TPM Resource Manager since it isn't=
 suitable
> > > > > for full vTPM front-ends (since multiple guests can interfere wit=
h each
> > > > > other's operations when running the full gamut of TPM functionali=
ty).
> > > > >=20
> > > > > I hadn't consider a stand-alone -device implementation though. It=
's not
> > > > > a proper VIO or PCI device so there's no proper bus to attach it =
to. I
> > > > > guess we would just make it a direct child of SpaprMachineState (=
sort
> > > > > of like SpaprDrcClass), then we could define it via something like
> > > > > -object spapr-tpm-proxy,path=3D....
> > > >=20
> > > > It should be -device not -object, but otherwise that looks ok.
> > >=20
> > > Ok, for some reason I thought -device needed either a specific bus or
> > > needed to be a SysBusDevice to attach to main-system-bus, but maybe t=
hat
> > > was just for qdev-managed reset handling. I've re-worked the series to
> > > allow configuration via:
> > >=20
> > >   -device spapr-tpm-proxy,host_path=3D/dev/tpmrmX
> >=20
> > That looks good.
> >=20
> > > > How does the TPM appear in the device tree?
> > >=20
> > > Nothing in the guest, on the host it appears as:
> >=20
> > Hrm.  That seems unwise.  I mean, I guess its being treated as a
> > hypervisor facility rather than a device per se, but what if we ever
> > need to advertise more metadata about it.
>=20
> It's a little bit awkward using a device tree in this case since it's
> generally the ultravisor that will be making this hcall on behalf of
> a guest requesting switch-over to SVM mode. The TPM device itself has
> a GetCapabilities command that seems like it would cover most of the
> metadata we might need though:
>=20
> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Rev-2.0-Part-3-C=
ommands-01.38.pdf
> (page 340)
>=20
> and if we need to add a layer of metadata on top of that there's also
> the option of introducing support for an additional operation in
> H_TPM_COMM itself, e.g. TPM_COMM_OP_GET_CAPABILITIES. Unsupported or
> invalid operations have a unique H_PARAMETER return code so callers
> should be able to reliably probe for it in the future if they need
> more information.

Yeah, ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0v0S0ACgkQbDjKyiDZ
s5Jg0A/+K59ZFWxPGLYHxZTV14OxQHFKUQoy/IwpHN+I2vSPoAWtmDJG8KNPakr4
hvmVb9/gN6cBBzF7wJiunU+Xc+sx8JWAJw5woLOkJbssEkYzkm6dtdBasNftOe5c
GwCOAla8MG8tUf7b8ay1WdX9Brvx5w3C5NvmgUyRBZD3Qvv+yDkq74BWYtOskvEK
8r/cPGC17QeQI2QzpkMjJsVNu8MTOdqy05Zv/gnKchVDc7Gv8Vm+DKPT8/BVeTCZ
dAbahSd8A/jJsaUvLRnqVMmgwhO2HQN4Bg82ZXzJ6WIUD4RMo0PBrFGa3kVOjJtF
olZh3dfCOyqanEneB/FvHaRWOk25U5YsLPQoWpZueycJiRPHME6e80jcNpi9zkAl
fBYIjMWkcqlCddQj9vkbjtXLQR+7h79btL9tqNYzs6XqVNKmmyFEGmq0hYg8ZZa4
mwBNH+zRIl9gSfrXBYi/ywxLI2zUTQJDViEsbuKD/Uvm5AiHWpXEYfNBZkwVLlm2
yB6WkvBzeZjpsXuJGIO8/4uXwNVfahCBkbvODwIzDZBwJPWYMneGMn2rqojx4FSm
s1RUfz05I+doca8BcLQp+23PHDKlhpH1ts3ZoxNJVgGWUJs0MGZNgkYDyYI8Vbco
iVw64qqEwMRvKH6hvfhhdNKxgsXBKDHk6aA+4ZvPdQrLLS2OKoA=
=edCo
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

