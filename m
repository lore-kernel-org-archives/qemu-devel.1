Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED145C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C5020693
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C5020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6BVq-0000jp-NT
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i6BUn-0008L8-F1
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i6BUk-0001Ig-N9
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:29:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i6BUk-0001IG-4S
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:29:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 303F73082E25;
 Fri,  6 Sep 2019 10:29:33 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C601C19C70;
 Fri,  6 Sep 2019 10:29:27 +0000 (UTC)
Date: Fri, 6 Sep 2019 11:29:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190906102926.GF5900@stefanha-x1.localdomain>
References: <20190905152136.30637-1-stefanha@redhat.com>
 <20190905174021.GR2700@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
In-Reply-To: <20190905174021.GR2700@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 06 Sep 2019 10:29:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 0/3] virtiofsd: get/set log level via DBus
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 06:40:21PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > It is likely that virtiofsd will need to support "management commands" =
for
> > reconfiguring it at runtime.  The first use case was proposed by Eryu G=
uan for
> > getting/setting the current log level.
> >=20
> > I promised to try out DBus as the management interface because it has a=
 rich
> > feature set and is accessible from most programming languages.  It shou=
ld be
> > able to support all the use cases we come up with.
> >=20
> > This patch series is a prototype that implements the get-log-level and
> > set-log-level management commands via DBus.  Use the new virtiofsctl to=
ol to
> > talk to a running virtiofsd process:
> >=20
> >   # dbus-run-session ./virtiofsd ...
> >   ...
> >   Using dbus address unix:abstract=3D/tmp/dbus-H9WBbpjk3O,guid=3D0be16a=
cefb868e6025a8737f5d7124d2
> >   # export DBUS_SESSION_BUS_ADDRESS=3Dunix:abstract=3D/tmp/dbus-H9WBbpj=
k3O,guid=3D0be16acefb868e6025a8737f5d7124d2
> >   # ./virtiofsctl set-log-level err
> >=20
> > Most of the work is done by gdbus-codegen(1).  It generates code for the
> > org.qemu.Virtiofsd.xml interface definition.  Our code can use the simp=
le
> > virtiofsd_get/set_log_level() APIs and it will make corresponding DBus =
calls.
> >=20
> > I'm pretty happy with this approach because the code is straightforward=
=2E  It
> > hasn't even triggered seccomp failures yet :).
>=20
> Yes it's less complex than I'd worried.
> Now, I do think we've got to think about how qemu in general is going to
> use dbus as people were discussing it, because then we have to think
> what the security aspects are - do we need to look at some calls only
> available to some clients etc.

The approach I took in this patch series is to launch a session bus just
for this virtiofsd.  The abstract socket unix(7) namespace used by GDBus
by default does not offer any security.  I think any process on the host
can connect to it, regardless of uid/gid.

A path like unix:path=3D/tmp/foo would allow us to use UNIX Domain Socket
permissions as the main security mechanism.  I'm not enthusiastic about
using SELinux or some kind of DBus-specific policy language if we can
avoid it because it's complex and obscure.

Stefan

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yNQYACgkQnKSrs4Gr
c8h2KQgAkoXMgZxWjDLU0NS68GhsgBMGLEib8ww18Uj2FzrM1efTLHKC4oFVjLqD
owOI/mR2RL46mIH4on8VpiqqiOxgRN5Kb+Nc0rr16F6ekoXAMYGGqlr7E3vEtBqi
cCt0GTqnZnDK26V57jrGGpUgi/oR1nkplVKsgeXt/RLkE5b/Vi6KVygw1OC9KcKp
fJCCmm1qMNRlOHc9pWpDEQ3fEvMZ91xKavB8A11m2OtfURsm1On+/S/zmgzzrZ8j
0YYnRMYDRcNnYJvE1/BK1XfWy9jaGhRYVSzsElpunT54X6JensTw0XMt583sW50k
EWblPB+T48jW3wcxxhmrknj+ihzCCA==
=vF04
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--

