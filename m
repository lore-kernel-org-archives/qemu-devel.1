Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BF4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A72206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrbD/gyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A72206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwaN-00073d-9p
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlwZc-0006SL-1k
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:35:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlwZZ-0007bt-6q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592494524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ttfQhqAJ59sT4RarvibgBtYM0IyzQZUtgmArPyKa6q4=;
 b=SrbD/gySGBr7pw85aFMgnH6bUeM8gR0qVvx/7MieL6d+d59IU/2aSbWFzzneVZnqqmvtz6
 V0WYAilHulOeZR1UB0UQ1Ds/uwl99wXo+Od6fo2l5SuVsHR4cNPrMolkXmvdH4BOiLndii
 VOCHoaz3Q2gctF3gMfi+9SpT0gg3DrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-_5JReB47PlGEE02BNutWhA-1; Thu, 18 Jun 2020 11:35:20 -0400
X-MC-Unique: _5JReB47PlGEE02BNutWhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3205310CE782;
 Thu, 18 Jun 2020 15:35:19 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D526F1E2267;
 Thu, 18 Jun 2020 15:35:17 +0000 (UTC)
Date: Thu, 18 Jun 2020 16:35:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] scripts/tracetool: Add plainlog backend
Message-ID: <20200618153516.GE1956319@stefanha-x1.localdomain>
References: <20200617134505.9D06E7482D3@zero.eik.bme.hu>
 <20200618073124.GA1956319@stefanha-x1.localdomain>
 <20200618090741.GC671599@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200618090741.GC671599@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 10:07:41AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 18, 2020 at 08:31:24AM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jun 17, 2020 at 03:36:29PM +0200, BALATON Zoltan wrote:
> > > Add a backend that is the same as the log backend but omits the
> > > process id and timestamp so logs are easier to read and diff-able.
> > >=20
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > >  scripts/tracetool/backend/plainlog.py | 48 +++++++++++++++++++++++++=
++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644 scripts/tracetool/backend/plainlog.py
> > >=20
> > > diff --git a/scripts/tracetool/backend/plainlog.py b/scripts/tracetoo=
l/backend/plainlog.py
> > > new file mode 100644
> > > index 0000000000..40bbfa6d76
> > > --- /dev/null
> > > +++ b/scripts/tracetool/backend/plainlog.py
> > > @@ -0,0 +1,48 @@
> > > +# -*- coding: utf-8 -*-
> > > +
> > > +"""
> > > +Stderr built-in backend, plain log without proc ID and time.
> > > +"""
> > > +
> > > +__author__     =3D "Llu????s Vilanova <vilanova@ac.upc.edu>"
> > > +__copyright__  =3D "Copyright 2012-2017, Llu????s Vilanova <vilanova=
@ac.upc.edu>"
> >=20
> > There is a Unicode issue here, Llu=EDs' name is not printed correctly.
> >=20
> > > +__license__    =3D "GPL version 2 or (at your option) any later vers=
ion"
> > > +
> > > +__maintainer__ =3D "Stefan Hajnoczi"
> > > +__email__      =3D "stefanha@linux.vnet.ibm.com"
> > > +
> > > +
> > > +from tracetool import out
> > > +
> > > +
> > > +PUBLIC =3D True
> > > +
> > > +
> > > +def generate_h_begin(events, group):
> > > +    out('#include "qemu/log-for-trace.h"',
> > > +        '')
> > > +
> > > +
> > > +def generate_h(event, group):
> > > +    argnames =3D ", ".join(event.args.names())
> > > +    if len(event.args) > 0:
> > > +        argnames =3D ", " + argnames
> > > +
> > > +    if "vcpu" in event.properties:
> > > +        # already checked on the generic format code
> > > +        cond =3D "true"
> > > +    else:
> > > +        cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.nam=
e.upper())
> > > +
> > > +    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> > > +        '        qemu_log("%(name)s " %(fmt)s "\\n" %(argnames)s);',
> > > +        '    }',
> > > +        cond=3Dcond,
> > > +        name=3Devent.name,
> > > +        fmt=3Devent.fmt.rstrip("\n"),
> > > +        argnames=3Dargnames)
> >=20
> > It is not necessary to introduce a new backend. There could be an optio=
n
> > that controls whether or not the timestamp/tid is printed. For example,
> > -trace timestamp=3Doff or maybe the timestmap/tid can be integrated int=
o
> > qemu_log() itself so that it's used more consistently and a -d timestam=
p
> > option enables it.
>=20
> QEMU already has a "-msg timestamp=3Don|off" option that controls whether
> error reports on stderr get a timestamp. I think it is probably reasonabl=
e
> for this existing option to apply to anything QEMU prints to stdout/err,
> and thus we could wire it up for qemu_log().

I thought about that but the features are somewhat unrelated.

If we unify them, how about making the timestamp/tid apply to *all*
qemu_log() output, not just tracing?

Stefan

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7ribQACgkQnKSrs4Gr
c8g4cQf/VYK88ehewD7DAsjXVw8yKpuzMYol1yA4u6pJWh0qhUqpD05/p6W66kzG
POD8hIDNMaY9C9gKFSX7yWr25NAV/ZAZin6R4WxVRYE+VQImw9pV386MhP/m1GuX
t/lc9S1GRZ3X1drfG5n3Pd0PmxyrSh1KCidhyTKCWY3u/mEsVtONqRqgHbR66x6k
aaGhY+uq7k7AtS76Bz4QG+bRQjvMayu1pXVw+uSY/XwJW1pBXdLGr8IDjVcnkwPk
gp68i7dgSV2dzCVsWGnw6OadotFrF/nDA89D0tkKdI8bYCcMA4SckI4ttWMq3WW5
oV39IpLpmCnI2fGhGxPCIk+UVm02FA==
=8tsd
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--


