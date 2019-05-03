Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0256C004C9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E5C2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E5C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45133 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMc4V-0002Io-0z
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:34:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hMc2r-0001c4-Ae
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hMc2q-0002An-Ck
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:32:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hMc2q-00029u-7A
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:32:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A2E9307EA93;
	Fri,  3 May 2019 17:32:23 +0000 (UTC)
Received: from localhost (ovpn-116-59.ams2.redhat.com [10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3CE12A5D;
	Fri,  3 May 2019 17:32:18 +0000 (UTC)
Date: Fri, 3 May 2019 11:32:16 -0600
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190503173216.GB10354@stefanha-x1.localdomain>
References: <20190425133503.30847-1-stefanha@redhat.com>
	<87v9yr52ph.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <87v9yr52ph.fsf@zen.linaroharston>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 03 May 2019 17:32:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
 developer docs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Otubo <otubo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503173216.O9a7DI0B01U3lNmSCyJzrWH2qJYnyl3Og8-HseP2TkI@z>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 10:04:10AM +0100, Alex Benn=E9e wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > +Isolation mechanisms
> > +~~~~~~~~~~~~~~~~~~~~
> > +Several isolation mechanisms are available to realize this architectur=
e of
> > +guest isolation and the principle of least privilege.  With the except=
ion of
> > +Linux seccomp, these mechanisms are all deployed by management tools t=
hat
> > +launch QEMU, such as libvirt.  They are also platform-specific so they=
 are only
> > +described briefly for Linux here.
> > +
> > +The fundamental isolation mechanism is that QEMU processes must run as
> > +**unprivileged users**.  Sometimes it seems more convenient to launch =
QEMU as
> > +root to give it access to host devices (e.g. ``/dev/net/tun``) but thi=
s poses a
> > +huge security risk.  File descriptor passing can be used to give an ot=
herwise
> > +unprivileged QEMU process access to host devices without running QEMU
> > as root.
>=20
> Should we mention that you can still maintain running as a user and just
> make the devices you need available to the user/group rather than
> becoming root? For example I generally make /dev/kvm group accessible to
> my user account.

Sure.  I checked that /dev/vhost-* device nodes are root:root on Fedora
so at least the distro doesn't expect you to do that.  The /dev/kvm
device node is root:kvm so it's easy to do it by joining the kvm group
there.

Stefan

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzMeyAACgkQnKSrs4Gr
c8jxWggAkYeMlZq+jsxHtTKiJ/6lLf2lmdbiiHy7ObDjGH/B1SsOZbDKaIvvjXE1
uQpBh2UfItsiRLou0ZrTpSmc747MgYU9YWj03i4g795HDY4go+2HZUtWAKh2wFuJ
Et+z+i2t0coX/9pGVK8DhXX1ZyDB5bFCYVHTUeQNNZAcL01Co9TU8X4WU/HEd8oX
FjjhssMC58ZrgkICAsisNI8ukQOv6FdMFtRtrYlqd7grlZ0WC6sIv/nQPje8lDWM
j0Y2Cg8BlzToFKg+bzFWticR199J/9AAJyFJsC9CWNsghpYQPcNcJlvYftk3Hy6B
R1qk0suaeR/MeTdgOYRYKQA539We8Q==
=uxmS
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

