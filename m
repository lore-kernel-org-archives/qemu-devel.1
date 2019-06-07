Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF29C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26970208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26970208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKPN-0003hP-76
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hZJLs-00084v-UK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hZJLp-0007aq-LE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:12:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hZJLp-0007XE-CV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33C3D3081252;
 Fri,  7 Jun 2019 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-62.rdu2.redhat.com
 [10.10.122.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CA2E10AFE6E;
 Fri,  7 Jun 2019 18:12:15 +0000 (UTC)
Date: Fri, 7 Jun 2019 14:12:07 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190607181207.GA20051@localhost.localdomain>
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-8-crosa@redhat.com>
 <20190607172915.GN28838@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190607172915.GN28838@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 07 Jun 2019 18:12:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/8] VNC Acceptance test: check protocol
 version
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 06:29:15PM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 07, 2019 at 11:22:22AM -0400, Cleber Rosa wrote:
> > This goes a bit further than the other tests, and does a basic (read
> > only) interaction with the VNC protocol.
> >=20
> > This is not a enough to perform a handshake, but enough to make sure
> > that the socket is somewhat operational and that the expected initial
> > step of the handshake is performed by the server and that the version
> > matches.
>=20
> The GTK-VNC project provides a low level library libgvnc that can
> be used to talk the RFB protocol in a fairly fine grained manner.
> This is built using GObject, so is accessible from Python thanks
> to GObject Introspection.
>

Interesting.

> We could use libgvnc for exercising the VNC server instead of writing
> custom RFB code. For your simple test just sending/receiving the
> version it won't save much, but if we ever want to test TLS or
> SASL integration, it would save alot of work dealing wth the auth
> handshake and subsequent encryption needs.
>

Absolutely.

> The main limitation it would have is that it would only work well
> for sending "well formed" RFB protocol messages. If we ever want to
> send intentionally evil/bad RFB data to check QEMU's VNC server
> security hardening it would be harder.
>

Right.  Still, there's a lot that can be done until we eventually
exaust all possibilities and look into sending bad messages.

> As the maintainer of GTK-VNC though, I would be open to adding more
> APIs to the low level gvnc library to facilitate QEMU's testing
> needs if we want.
>

I personally need to get acquainted with the currently available APIs
first, but it looks like you alread have ideas for extensions that
would come in handy.

Also, the one concern I have is how to deploy the library and Python
bindings so that we can host those more advanced tests and still allow
for a "make check-acceptance"-like experience.  What I mean is, I
expect the Python bindings to be easily installed by pip, by I'd be
(positively) surprised if the libgvnc would also have such an easy
bootstrap.

Any ideas on this?

Thanks!
- Cleber.

> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/acceptance/vnc.py | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> > index d32ae46685..b000446d7c 100644
> > --- a/tests/acceptance/vnc.py
> > +++ b/tests/acceptance/vnc.py
> > @@ -11,6 +11,7 @@
> >  import os
> >  import tempfile
> >  import shutil
> > +import socket
> > =20
> >  from avocado_qemu import Test
> > =20
> > @@ -71,5 +72,16 @@ class VncUnixSocket(Test):
> >                                              arg=3D'new_password')
> >          self.assertEqual(set_password_response['return'], {})
> > =20
> > +    def test_protocol_version(self):
> > +        self.vm.add_args('-nodefaults', '-S',
> > +                         '-vnc', 'unix:%s' % self.socket_path)
> > +        self.vm.launch()
> > +        self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'=
])
> > +        client =3D socket.socket(socket.AF_UNIX)
> > +        client.connect(self.socket_path)
> > +        expected =3D b'RFB 003.008'
> > +        actual =3D client.recv(len(expected))
> > +        self.assertEqual(expected, actual, "Wrong protocol version")
> > +
> >      def tearDown(self):
> >          shutil.rmtree(self.socket_dir)
> > --=20
> > 2.21.0
> >=20
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|

