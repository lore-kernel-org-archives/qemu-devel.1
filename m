Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3279FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B5324681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIL42nYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B5324681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwPge-00011h-5o
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iwPg0-0008VB-5n
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iwPfy-0006Es-GJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:09:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iwPfy-0006ED-AU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580213341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fciQBZjB3onG8nZAkYzfczdqcpaqYyrlf8H2QAj29Mw=;
 b=XIL42nYRj3iki7SExd7R9bljd5gBd/4DK3fKBVkDdCTfQ4vrW/X9WOsRuwt2yYlwRqVopX
 11Zjld7EkY//Dtvn2zggH0a4pK6AZjhxF7J1Onf9aZQ4JFW7r0T3ZyULQ9ITzyPvsBKJ0p
 k8CSRGzTGmrcgpiFG0EosUmwo6QYrNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-3yGTO8aEPR26xLSvs2YsBA-1; Tue, 28 Jan 2020 07:08:55 -0500
X-MC-Unique: 3yGTO8aEPR26xLSvs2YsBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E548017CC;
 Tue, 28 Jan 2020 12:08:54 +0000 (UTC)
Received: from localhost (unknown [10.33.36.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF415D9C9;
 Tue, 28 Jan 2020 12:08:53 +0000 (UTC)
Date: Tue, 28 Jan 2020 13:08:52 +0100
From: Sergio Lopez <slp@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
Message-ID: <20200128120852.zufs4us27fnea7ch@dritchie>
References: <20200107125401.18126-1-n54@gmx.com>
 <20200128091007.lh5re4neqhhqmr7x@dritchie>
 <d6078248-b6ca-1c9b-16a4-1e9eaccafa53@gmx.com>
MIME-Version: 1.0
In-Reply-To: <d6078248-b6ca-1c9b-16a4-1e9eaccafa53@gmx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4c5bazlwitplbdci"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, Maxime Villard <maxv@netbsd.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--4c5bazlwitplbdci
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 12:11:51PM +0100, Kamil Rytarowski wrote:
> On 28.01.2020 10:10, Sergio Lopez wrote:
> > On Tue, Jan 07, 2020 at 01:53:57PM +0100, Kamil Rytarowski wrote:
> >> Hello QEMU Community!
> >>
> >> Over the past year the NetBSD team has been working hard on a new user=
-mode API
> >> for our hypervisor that will be released as part of the upcoming NetBS=
D 9.0.
> >> This new API adds user-mode capabilities to create and manage virtual =
machines,
> >> configure memory mappings for guest machines, and create and control e=
xecution
> >> of virtual processors.
> >>
> >> With this new API we are now able to bring our hypervisor to the QEMU
> >> community! The following patches implement the NetBSD Virtual Machine =
Monitor
> >> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
> >>
> >> When compiling QEMU for x86_64 passing the --enable-nvmm flag will com=
pile the
> >> accelerator for use. At runtime using the '-accel nvmm' should see a
> >> significant performance improvement over emulation, much like when usi=
ng 'hax'
> >> on NetBSD.
> >>
> >> The documentation for this new API is visible at https://man.netbsd.or=
g under
> >> the libnvmm(3) and nvmm(4) pages.
> >>
> >> NVMM was designed and implemented by Maxime Villard.
> >>
> >> Thank you for your feedback.
> >=20
> > Thank you for working on this, it's nice to see that QEMU will gain
> > HW-assisted acceleration on NetBSD 9.0. A couple things:
> >=20
>=20
> Thank you for the review!
>=20
> >  - Are you and/or Maxime willing to step up as maintainers for the
> >    NVMM support in QEMU?
> >=20
>=20
> NVMM (as of today) is part of the NetBSD support and I am the maintainer
> for the NetBSD code (noted in MAINTAINERS).
>=20
> In case of non-trivial changes I will reach Maxime for his feedback.

OK, sounds good to me.

> >  - In the next version of the patch series, please use
> >    "scripts/get_maintainer.pl" to get the list of people you need to
> >    CC for the patch series.
> >=20
>=20
> I've submitted a fixup patch '[PATCH v2 2/4] Add the NetBSD Virtual
> Machine Monitor accelerator.' instead of the full series.
>=20
> I have rechecked the maintainers with the patch and I don't see anybody
> else as a candidate for review.

$ ./scripts/get_maintainer.pl /tmp/0004.patch=20
Paolo Bonzini <pbonzini@redhat.com> (maintainer:Main loop)
Richard Henderson <rth@twiddle.net> (maintainer:Overall TCG CPUs)
Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86 TCG CPUs)
qemu-devel@nongnu.org (open list:All patches CC here)

$ ./scripts/get_maintainer.pl /tmp/0002.patch=20
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

"Philippe Mathieu-Daud=E9" <philmd@redhat.com> (commit_signer:31/112=3D28%)
Paolo Bonzini <pbonzini@redhat.com> (commit_signer:31/112=3D28%)
Thomas Huth <thuth@redhat.com> (commit_signer:25/112=3D22%,commit_signer:14=
/53=3D26%)
"Daniel P. Berrang=E9" <berrange@redhat.com> (commit_signer:24/112=3D21%)
Laurent Vivier <laurent@vivier.eu> (commit_signer:22/112=3D20%,commit_signe=
r:10/53=3D19%)
Gerd Hoffmann <kraxel@redhat.com> (commit_signer:13/53=3D25%)
"Michael S. Tsirkin" <mst@redhat.com> (commit_signer:9/53=3D17%)
Markus Armbruster <armbru@redhat.com> (commit_signer:9/53=3D17%)
qemu-devel@nongnu.org (open list:All patches CC here)

I think you should resping the whole series as v2, adding Richard,
Eduardo and Philippe to the CC list. That should help with the review
process.

Thanks,
Sergio.

> I don't maintain a merge queue on my own. Please put the reviewed
> patches on a merge queue yourself.
>=20
>=20
> Thank you in advance,
>=20
> > Thanks,
> > Sergio.
> >=20
>=20
>=20




--4c5bazlwitplbdci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4wJFMACgkQ9GknjS8M
AjUJjw/7B1WDi/gGq4X0tUEJYBT2FgltalhoXBITRdfdMwywSVJgbpbPzj3w9A0z
3shb/NWxweQOrPW5nYNdksphSw3pmV1UFGyQUNbdPaXuemqsRwFzXoMQopih/IkP
m1YFXZrfeQaAiWDybJCidDbaUG5FfIR/XhElhs/GfAzXd+U3ZJt+MrK9KSsCZXWC
Xz7nVjcRW4BEpEDHf1QuoQq7GuXJI7CEo47UWy1NiSWHo+NVe4Y/bPXJTD42g2pr
OT9S2ghr6cKcXLlhhDwMQrhSNBM3Fg4Met16AbpSkl7M2XKKW080NNRoZWsa2FGA
1OI3WWAkaox95+REPYoOiyqWe+Eg+gkcij3w2A4nmBZrKvbar59VmAVdY49fqvjT
izQOR1FAbJjJOW7CshdgjLifSht/uf3Boobpw+9gZJwxQpFqi6LT5RXAJ9ZKptAX
VG5dhN5QZbVRocbBEnLrkheT3i4K95pcsSMlPqZQamQ5PFCRCl5l3RZhR2BW602T
RN3j4C3LgXhWY6ZktTTrhIi7r7aE7mfNznKhhtWEL6dVQ+lc82TrAeWWgLee7C7E
URTe2wHWSqxAYmr3vsDdF+UR+9PNKqQI0K+tFmH0UzILkeMRV3hhrrogSJtQZIZZ
uC1iGvDW1QGLxyOaquKK3Po3C9ebLZetu6gzgQthakbP6riJWVk=
=MYCy
-----END PGP SIGNATURE-----

--4c5bazlwitplbdci--


