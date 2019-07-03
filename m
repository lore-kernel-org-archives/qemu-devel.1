Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BDEC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B8021881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GAt4Wrgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B8021881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hifJO-0002FE-6k
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 09:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hifGQ-0006XP-TA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hifGP-0002jf-33
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:34 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52945 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hifGN-0002dc-4J; Wed, 03 Jul 2019 09:25:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45f20j48KMz9sR3; Wed,  3 Jul 2019 23:25:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562160325;
 bh=ntHHvOac8zM+soDalpzNvakAvvxLBH20fTgAZJj961Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GAt4Wrgu7e/bIswbw16V9jD6vMBtTjNggRGXTKAeV3JNakjUwcRGO9iT08gTYa7Yi
 bitLea1Iuj6YsqnXtut7VgR6AMkmDx+xkr9DQegfpX1ZjzLm1d3Ls6kiKQyclfwZVG
 Jlh2jiEoBSGU3SdE6yrwiWYWww9RNYlvWyY/qYsE=
Date: Wed, 3 Jul 2019 16:53:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190703065302.GO9442@umbus.fritz.box>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
 <20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
 <20190328183923.lcd3p6fpy4qvvxoo@maxibm>
 <20190329132951.451d4ef0@bahia.lan>
 <20190401145858.lw7v3xt7fqanp6nc@maxibm>
 <20190402122807.1a141e37@bahia.lan>
 <20190408042747.GI16627@umbus.fritz.box>
 <fb1fe659eb80b99b9696ff4b128cd070c4e0dabc.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IpgPcFyQO6wM49Um"
Content-Disposition: inline
In-Reply-To: <fb1fe659eb80b99b9696ff4b128cd070c4e0dabc.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IpgPcFyQO6wM49Um
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 06:24:07PM +0200, Andrea Bolognani wrote:
> Apologies for taking this long to respond.
>=20
> On Mon, 2019-04-08 at 14:27 +1000, David Gibson wrote:
> > On Tue, Apr 02, 2019 at 12:28:07PM +0200, Greg Kurz wrote:
> > > The recent fixes around "host-serial" and "host-model" simply moved
> > > the decision to expose host data to the upper layer, ie. libvirt
> > > which should be involved in this discussion.
> >=20
> > Right, that's deliberate.  Note that roughly-equivalent information on
> > x86 is currently supplied via the SMBIOS.  OpenStack Nova sets that,
> > rather than qemu, and I'd like to move towards a common configuration
> > model with x86, though it's a fairly long path to there.
> >=20
> > OpenStack had an equivalent security problem to our one, which it
> > addressed by taking the host serial from /etc/machine-id if present
> > rather than the real host info.
>=20
> IIUC the situation is a bit different between x86 and ppc64, because
> while for the latter SPAPR defines a way for the guest to access
> information about the host it's running on, that's not the case for
> the former, at least to the best of my knowledge.

Well, guests are getting this information in smbios somehow.  I don't
know what specifies that what bit of info in the smbios is host info,
but I guess it must at least be a de facto convention?

> What OpenStack is doing is reading the machine-id (if explicitly
> configured to do so: the default is to use the guest's own UUID[1])
> and exposing that as the *guest* serial, not as the *host* serial.

Uh.. I'm not sure about that.  I think the default is just to pass
nothing here.  The confusion is increased because this host info was
always handled at the above-libvirt (openstack) level on x86, using
explicit smbios configuration options down to libvirt and qemu.

On power we handled it in qemu, because that seemed the obvious way,
but it makes recombining them a pain.

> >From libvirt's point of view, the entire mechanism is entirely
> optional, so unless the management layer explicitly asks it to set
> a certain value for the serial, libvirt will simply pass no
> information down to QEMU.
>=20
> The relevant XML elements[2] are clearly modeled after x86, so I
> wonder if Nova is setting them also on ppc64 and if so, what the
> guest will ultimately see...
>=20
> > > Cc'ing Andrea for expertise. Problem exposed below.
> > >=20
> > > The pseries machine used to expose the content of the host's
> > > /proc/device-tree/system-id and /proc/device-tree/model in the guest
> > > DT. This led to a CVE and QEMU doesn't do that anymore for new machine
> > > types. Instead, two new properties where added to the pseries machine:
> > >=20
> > > pseries-4.0.host-serial=3Dstring (Host serial number to advertise in =
guest device tree)
> > > pseries-4.0.host-model=3Dstring (Host model to advertise in guest dev=
ice tree)
> > >=20
> > > It is up to the caller to pass something... which may be anything,
> > > including something like $(cat /proc/device-tree/system-id) or
> > > randomly generated.
>=20
> What happens if the caller doesn't provide any value? Will QEMU come
> up with something itself?

Currently, no, it will just omit the properties.

> Adding a few extra knobs in the vein as the existing ones sounds like
> a fairly reasonable idea. It will still be up to the management layer
> to actually provide the values.
>=20
> > > Is there a chance libvirt can be taught to pass a different string
> > > to the target QEMU in case of migration ?
>=20
> libvirt already supports providing a different XML to the target
> host, so changing a couple values should be no big deal.
>=20
>=20
> As a final note, unless I've gotten it wrong and x86 actually *does*
> provide a way for the guest to figure out its host's serial, then any
> software relying on the attributes defined by SPAPR is ultimately not
> portable to non-ppc64 hardware and should probably be rearchitected
> to go through the management layer, as Daniel was also suggesting
> earlier in the thread.
>=20
>=20
> [1] https://github.com/openstack/nova/blob/master/nova/virt/libvirt/drive=
r.py#L364-L372
> [2] https://libvirt.org/formatdomain.html#elementsSysinfo

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IpgPcFyQO6wM49Um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cUM4ACgkQbDjKyiDZ
s5K4xBAAz54cyRjHHqpniJ9BEI5R2C0jRplSIxZBoaPTuX44hoviQ5nQMSG5VG0F
UVHiS1sUTW5WMDcPGCz/SYw2ar1ou15UpqbB5UlSwV4VC5ZE8pZbVmsF2qmmMboz
lMAfuAtfiQm50PaM28nk36XfUDvh85SATq8zLfOeEgaLgEdLWgr4nhF86IwPOmfi
TJ3B0jV1jaMK7FdYMNDACCxEbkrXKdK/OZxtC77FVyikELetxTvh3lRo30ccYt8m
v84HlvwRqOHcXGPZ9NjyxqaUsOTqXoqPtx9GC8P7CYmqIa5szOBZoMIbZd0Tzqx+
ysGlmjJveKRKPKbgVjEg9eOI0WWeoMQNxMlZhbfjr2murfWbTsW5NQRMbZ0UXVVY
+HaJYP2WZqvog3yUk3mhVoZBTzWGtiRF5BRXqAbPCyGFGy95t7eHuOwkZGIJsRR3
Hjhbk2hSQV4AOmuwIB+ULqet4FoijR+vOSzHvXVc22xu1FEZ3khBH+bj2RB+XZhF
GpizLg/Mh3oDcdrmDBuDQoKine6t6YYqSEfsBoLMCMxX2JPIn6gE21JZuo0y3gbd
b1Ittzkb2fQ88YLpPAJoMuXTY3ZsJd2if54KeyHTOq4wg+09DE0g0RFNr9WT7rUU
UA/o/Uo5BzaDyquIa6lBPk5cyMmaGmRJCpTZBdIceNincSL2xXQ=
=KcTs
-----END PGP SIGNATURE-----

--IpgPcFyQO6wM49Um--

