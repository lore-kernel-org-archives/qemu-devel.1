Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528F5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6D4207F9
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AZlhhrLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6D4207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhUUY-0005ed-CQ
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jhUSs-0003hN-PY; Sat, 06 Jun 2020 04:46:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49283 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jhUSq-0005F5-1X; Sat, 06 Jun 2020 04:46:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49fClh3xm1z9sSc; Sat,  6 Jun 2020 18:45:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591433152;
 bh=YoMdeniGBGn7TbfMONb8QyzbR+59Cq/gi2fKNL7nRBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AZlhhrLEwdJSBK46arLMA0LpVtzngJJQ+Doq0U1Fz+A7y0PoSsylrPH7nEDkieKkS
 y3uxYbQKR17t4YdoDzNNzdl9JRYH8pTZAwX6Au9pB/spDiAkViWQ1uagufCwB643Zz
 skLebW6XgA2iVdVLqTKfWkzkKJTJDj5RyXFDCxjI=
Date: Sat, 6 Jun 2020 18:24:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200606082458.GK228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <87tuzr5ts5.fsf@morokweng.localdomain>
 <20200604062124.GG228651@umbus.fritz.box>
 <87r1uu1opr.fsf@morokweng.localdomain>
 <dc56f533-f095-c0c0-0fc6-d4c5af5e51a7@redhat.com>
 <87pnae1k99.fsf@morokweng.localdomain>
 <ec71a816-b9e6-6f06-def6-73eb5164b0cc@redhat.com>
 <87sgf9i8sy.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cy+5HEalSgyXkpVS"
Content-Disposition: inline
In-Reply-To: <87sgf9i8sy.fsf@morokweng.localdomain>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 04:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Cy+5HEalSgyXkpVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 05:01:07PM -0300, Thiago Jung Bauermann wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 05/06/20 01:30, Thiago Jung Bauermann wrote:
> >> Paolo Bonzini <pbonzini@redhat.com> writes:
> >>> On 04/06/20 23:54, Thiago Jung Bauermann wrote:
> >>>> QEMU could always create a PEF object, and if the command line defin=
es
> >>>> one, it will correspond to it. And if the command line doesn't defin=
e one,
> >>>> then it would also work because the PEF object is already there.
> >>>
> >>> How would you start a non-protected VM?
> >>> Currently it's the "-machine"
> >>> property that decides that, and the argument requires an id
> >>> corresponding to "-object".
> >>
> >> If there's only one object, there's no need to specify its id.
> >
> > This answers my question.  However, the property is defined for all
> > machines (it's in the "machine" class), so if it takes the id for one
> > machine it does so for all of them.
>=20
> I don't understand much about QEMU internals, so perhaps it's not
> practical to implement but from an end-user perspective I think this
> logic can apply to all architectures (since my understanding is that all
> of them use only one object): make the id optional. If it's not
> specified, then there must be only one object, and the property will
> implicitly refer to it.
>=20
> Then, if an architecture doesn't need to specify parameters at object
> creation time, it can be implicitly created and the user doesn't have to
> worry about this detail.

Seems overly complicated to me.  We could just have it always take an
ID, but for platforms with no extra configuration make the
pre-fabricated object available under a well-known name.

That's essentially the same as the way you can add a device to the
"pci.0" bus without having to instantiate and name that bus yourself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cy+5HEalSgyXkpVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7bUtcACgkQbDjKyiDZ
s5KGWRAAx4ggMFCRE7+DfjUQOmDiAMZxpB19AEh1v3ohIYHDxx88pn0seVlvJqIx
ujGOc891w1XcGHuw3Umye5OOB1KM+qgYFvMlBYkqj7IrRIcU87P8bVb8WKWuCSJc
txUd2CYUHHWJpI8TRdKw/BzkflOF9NTQA51SFEzupj4mTpGDwnN9ZygS2Lxv+WbG
CNz5MyU1fP5GA3hKBDhp6HN1CK0SPk85DPx4gRCSE7mj5BDA7kElB+dCwvvvAl18
bD0UrVkpaENCNXLbPYTTRydi0OSF6NP6TWQ449dBHsjcOVOXhlwK+X5QtNYtFVzg
k5xYV4Rluu4JsgNO3fZIleFcZn1145FWpEokUPwqnCVRPW84zeRI5AhHu8dTEL+v
hgy/9cYZjPFWLBI8YPtdZxshUCFRHL0nNmPabxyO0xmg+kYaHuTasdS+nJMPSU/k
c3hGWBCsEIGE19akQDCyd1/oFumZJyqZXPlDLoHMS4+lQSP8o30q8TZAKGGFr+2B
FtjRYKIKltfAsapyXzHAIkEXy59anPnDMcFAG/xNh3P0WePC1p+CAjohfKK9oYG6
TunO7a27yInF7NowUhfcAmtTyRyEXS57A0XVmrfLeW3gdsn+J+ts+H8PeM2Kb4vP
ATwzQEghKh235o5aAQygw7QNi94VbS1mPHWa/kLnVHvxmFmKxcY=
=1I5c
-----END PGP SIGNATURE-----

--Cy+5HEalSgyXkpVS--

