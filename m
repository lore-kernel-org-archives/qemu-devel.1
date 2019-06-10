Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF89C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 08:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82B82082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 08:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82B82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haG9W-0000vK-A9
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 04:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35488)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1haG91-0000Un-Tk
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 04:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1haG90-0000FN-M0
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 04:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1haG90-0000Df-Ds
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 04:59:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1756430832EF;
 Mon, 10 Jun 2019 08:59:03 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3199760BF1;
 Mon, 10 Jun 2019 08:58:53 +0000 (UTC)
Date: Mon, 10 Jun 2019 09:58:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190610085850.GB7809@redhat.com>
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-8-crosa@redhat.com>
 <20190607172915.GN28838@redhat.com>
 <20190607181207.GA20051@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190607181207.GA20051@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 10 Jun 2019 08:59:04 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 02:12:07PM -0400, Cleber Rosa wrote:
> On Fri, Jun 07, 2019 at 06:29:15PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Fri, Jun 07, 2019 at 11:22:22AM -0400, Cleber Rosa wrote:
> > > This goes a bit further than the other tests, and does a basic (rea=
d
> > > only) interaction with the VNC protocol.
> > >=20
> > > This is not a enough to perform a handshake, but enough to make sur=
e
> > > that the socket is somewhat operational and that the expected initi=
al
> > > step of the handshake is performed by the server and that the versi=
on
> > > matches.
> >=20
> > The GTK-VNC project provides a low level library libgvnc that can
> > be used to talk the RFB protocol in a fairly fine grained manner.
> > This is built using GObject, so is accessible from Python thanks
> > to GObject Introspection.
> >
>=20
> Interesting.
>=20
> > We could use libgvnc for exercising the VNC server instead of writing
> > custom RFB code. For your simple test just sending/receiving the
> > version it won't save much, but if we ever want to test TLS or
> > SASL integration, it would save alot of work dealing wth the auth
> > handshake and subsequent encryption needs.
> >
>=20
> Absolutely.
>=20
> > The main limitation it would have is that it would only work well
> > for sending "well formed" RFB protocol messages. If we ever want to
> > send intentionally evil/bad RFB data to check QEMU's VNC server
> > security hardening it would be harder.
> >
>=20
> Right.  Still, there's a lot that can be done until we eventually
> exaust all possibilities and look into sending bad messages.
>=20
> > As the maintainer of GTK-VNC though, I would be open to adding more
> > APIs to the low level gvnc library to facilitate QEMU's testing
> > needs if we want.
> >
>=20
> I personally need to get acquainted with the currently available APIs
> first, but it looks like you alread have ideas for extensions that
> would come in handy.
>=20
> Also, the one concern I have is how to deploy the library and Python
> bindings so that we can host those more advanced tests and still allow
> for a "make check-acceptance"-like experience.  What I mean is, I
> expect the Python bindings to be easily installed by pip, by I'd be
> (positively) surprised if the libgvnc would also have such an easy
> bootstrap.
>=20
> Any ideas on this?

IMHO we shouldn't try to install anything from pip. It should all be
available from distro repos already. In fact if you have "virt-install"
or "virt-manager" installed, you should already have the required
python bits.

On RHEL/Fedora you need python3-gobject to get the GObject introspection
support and then all you need is the native gvnc library. There is no
python library for gvnc because GObject introspection makes this
redundant - the python API is dynamically created at runtime using
FFI to access the native library APIs.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

