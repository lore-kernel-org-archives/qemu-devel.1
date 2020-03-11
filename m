Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F39C3F2D0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 01:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F22520727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 01:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bEfcrfUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F22520727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBpwV-0001Ns-Kv
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 21:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBpvj-0000Bw-5B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBpvh-0006MW-6j
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:13:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47643 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBpvg-0006Ee-CO; Tue, 10 Mar 2020 21:13:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48cYq86MwHz9s3x; Wed, 11 Mar 2020 12:12:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583889172;
 bh=+CszKDr7fO0+FpcSdH7H2y06uqZ8OAFvqPf9hPwHqgo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bEfcrfUBPDtcGf6wqxeXSVWzvu5O9cl4OoAYj0VfbzWsZovTAPy3SEtro0ehH6BU8
 8wzF4QQrjntAvQeUIBaXd1fL/+gSVvizK6ETTTtNrejYfvjcYc7//UXdZuN3r+/2CO
 p2PLLiPWkvLe8r4NY17Acgd0aKm3LJRDgkRmsgNw=
Date: Wed, 11 Mar 2020 12:12:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr:
 Use vIOMMU translation for virtio by default
Message-ID: <20200311011247.GT660117@umbus.fritz.box>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200310114343.GD3234052@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/FJxnyttrH06HRq2"
Content-Disposition: inline
In-Reply-To: <20200310114343.GD3234052@redhat.com>
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, groug@kaod.org,
 qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org, mdroth@us.ibm.com,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/FJxnyttrH06HRq2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 11:43:43AM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Mar 05, 2020 at 03:30:07PM +1100, David Gibson wrote:
> > Upcoming Secure VM support for pSeries machines introduces some
> > complications for virtio, since the transfer buffers need to be
> > explicitly shared so that the hypervisor can access them.
> >=20
> > While it's not strictly speaking dependent on it, the fact that virtio
> > devices bypass normal platform IOMMU translation complicates the issue
> > on the guest side.  Since there are some significan downsides to
> > bypassing the vIOMMU anyway, let's just disable that.
> >=20
> > There's already a flag to do this in virtio, just turn it on by
> > default for forthcoming pseries machine types.
>=20
> Breaking existing guest OS to support a new secure VM feature that
> may not even be used/wanted doesn't seems like a sensible tradeoff
> for default out of the box behaviour.
>=20
> IOW, if Secure VM needs this, can we tie the change in virtio and
> IOMMU defaults to the machine type flag that enables the use of
> Secure VM.

There is no such flag.

In the POWER secure VM model, the secure mode option isn't something
that's constructed in when the hypervisor builds the VM.  Instead the
VM is started normally and transitions itself to secure mode by
talking directly with the ultravisor (it then uses TPM shenannigans to
safely get the keys to its real storage backend(s)).

> That way the changed virtio defaults only take effect if a user/mgmt
> app has explicitly opted in to the new Secure VM feature, and existing
> users won't be broken by a new feature they don't even use.

Sure, but qemu has no natural way to know if secure VM is in use,
until too late.

I am wondering if we have to introduce an "svm=3Don" flag anyway.  It's
pretty ugly, since all it would be doing is changing defaults here and
there for compatibilty with a possible future SVM transition, but
maybe it's the best we can do :/.

> > Any opinions on whether dropping support for the older guest kernels
> > is acceptable at this point?
>=20
>=20
> I think this question has different answers depending on whether you
> are considering downstream vendor policy, current upstream policy,
> and a possible new downstream policy on guest support. IOW a bit of a
> can of worms...
>=20
>=20
> In the case of RHEL downstream there is a very narrow matrix for
> what guest OS are considered supported.
>=20
> In the case of current upstream, there has essentially never been
> any documented guest matrix. The unwritten implicit rule upstream
> has followed is to not change defaults in a way that would break
> ability to run existing guest OS.

Hrm, ok, that's not how I've been treating it for for pseries, though
previous breakages have been for much older / rarer cases.  We broke
support for guests that don't call "ibm,client-architecture-support"
long, long ago (but such guests are really, really ancient).  We broke
support (without workarounds) for guests with 4kiB standard page size
more recently, but those are at least a decade old for common
downstream distros (you can build such kernels today, but
approximately nobody does).

> As an example, on x86 upstream defaults to i440fx and thus still
> uses virtio devices in transitional mode by default, while downstream
> RHEL used its narrow support matrix as a justification for why it was
> ok to switch to q35 by default & loose guest support in many cases.
> Even that was problematic though, because RHEL still needed to support
> RHEL-6 guest which are broken by default with q35 since they only
> support legacy mode virtio. Thus we needed work in management apps
> to enable RHEL-6 to continue working with q35 chipset, by placing
> the devices onto a PCI bridge, instead of a PCIe root port, or by
> explicitly using i440fx instead.

Yeah, and here's where x86's visibility with mgmt because a big
thing.  Most of these changes are easily enough worked around with
machine type options - and there's no inherent reason those are harder
to work with than whole machine types, or other config details.  But
getting mgmt apps to support machine option based workarounds for us
is a real challenge.

> Thus if we follow our *current* upstream guest support policy, I don't
> think it is acceptable to break existing guests with the new machine
> type upstream.  It is reasonable to do it downstream if the downstream
> is willing to sacrifice these guests, or invest to make any mgmt apps=20
> add workaround/revert QEMU changes.
>=20
>=20
> With that all said, I do *NOT* think current upstream practice is good
> or sustainable long term (though I admit I've argued on the other side
> in the past).
>=20
> This policy is why we're still using a machine designed in 1995 on x86
> by default, in order that we avoid breaking the popular guest OS of the
> day, like Windows 95.
>=20
> This is similar to the problem we had with host build platforms, where
> we afraid to make any change which would break an existing build platform,
> or on the flipside made arbitrary ad-hoc changes with no consistent
> approach across different subsystems.
>=20
>=20
> I think that we should aim define some clearer policy around how we
> want to support guest OS in upstream. As we did with our host build
> platforms policy, any guest support policy should aim to move forward
> at a reasonable pace so that we are not locked at a specific point in
> time forever.
>=20
> I can imagine three tiers
>=20
>  1. Recommended. Expected to work well with machine type defaults
>  2. Supported. Should work with QEMU but may need special settings applied
>  3. Unsupported. Will not work with QEMU regardless of settings
>=20
> I don't have an opinion right now on what guest OS should fall in which
> category. One possible way to classify them would be to look at whether
> the vendor themselves still supported the OS.  IOW, to be in the
> "Recommended" criteria, it must be actively supported by the vendor.
> Once EOL by the vendor it would be capped at the "Supported" tier.
>=20
> That definition wouldn't help your pseries issue though, because RHEL-6
> is still considered a supported OS.
>=20
> Another possible way to classify guest OS would be to look purely at
> the original release date, and set a cap of "$TODAY - 5 years" for
> the "Recommended" tier. That would exclude RHEL-6.

That seems fairly reasonable to me, but it doesn't really help me move
forward right now.  Right now, we have no sane way of distinguishing
early enough between a RHEL-6 guest that needs legacy virtio and a
guest that wants to go to secure mode, and can't have legacy virtio. :(

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/FJxnyttrH06HRq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5oOwwACgkQbDjKyiDZ
s5LRpxAAyTa9Z/NOZLMmq0ts7NNfh3Afn+RIB0XZElXW8/qPMo83+CAOS92m/dJV
leCd+dtIFd8ywo54yuczc+MedKmNTTCFEWGKtU2Yrzvfs96iXR1CNc7DUbnldCsf
6lHd3NzlDjpSHzPObjB96SJ2cJNq0p0q+3vx36f2SkxMQUiRlYPlMPdIHuoBbtKy
IqM7VjPzdIsDo3Nq2lEcotz4QA0GFR2T9q52OIxpDR/m8isTR9PGK7ZrB8n8AAh1
Unu1uDc9S44GZla+0l0LH1sJHR40/HFmPid7enLxoV4r0R8Kg+gDoV02KV0FQypU
1x0sADFfIKceWuNyHfUZOkDukOpAi33HKei7ABQcGDGFpRWNukpRhKyTSVfMSuMz
qEcYcq6L4jH5UH5pGqHC+lTbFHxYpgUt/gMlbkozmf3g9E/LrnBNGCLaD3XsOwC8
YSRJLSASYVr4OfcGowbmycp790TQmNeKbrJRcivnSqZyyKjAZY9aTi4aO60Iivy5
Rnj21XKCNjXeFUX783F3NsmgC61GZNqAWYw5tWG4Lo5QASawwY3UHb8ae7V9pjBJ
OGicjZ1VCsZabhz/fEWPrxfwoJrLw0GKGlu8jx03W1Om1yha0xCSGqKDEVrOoHIw
3g9L/XDNnKuOnKi4Y3QF+ClVedDod0lhAsgRdA8OJxfEovqLDaI=
=0mLd
-----END PGP SIGNATURE-----

--/FJxnyttrH06HRq2--

