Received: from eggs.gnu.org ([2001:4830:134:3::10]:40522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMox-0002Cj-Tp
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMot-0006r7-V2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:44:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evMot-0006qO-PV
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FFB38D6D7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 12:44:51 +0000 (UTC)
Date: Mon, 12 Mar 2018 12:44:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312124446.GA8576@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180205152455.12088-1-berrange@redhat.com>
	<20180205152455.12088-8-berrange@redhat.com>
	<d9a1c2af-e5f8-1d46-d5c5-ecb2ce20981a@redhat.com>
	<20180206091337.GA20001@redhat.com>
	<6f0d724e-3275-6700-d41d-8f378de8835b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f0d724e-3275-6700-d41d-8f378de8835b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 7/9] sockets: allow SocketAddress 'fd'
 to reference numeric file descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Feb 06, 2018 at 08:48:43AM -0600, Eric Blake wrote:
> On 02/06/2018 03:13 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
> > > > +++ b/qapi/sockets.json
> > > > @@ -123,6 +123,13 @@
> > > >    #
> > > >    # @unix:  Unix domain socket
> > > >    #
> > > > +# @vsock: VMCI address
> > > > +#
> > > > +# @fd: decimal is for file descriptor number, otherwise a file d=
escriptor name.
> > > > +#      Named file descriptors are permitted in monitor commands,=
 in combination
> > > > +#      with the 'getfd' command. Decimal file descriptors are pe=
rmitted at
> > > > +#      startup or other contexts where no monitor context is act=
ive.
> > > > +#
> > > >    # Since: 2.9
> > >=20
> > > There doesn't seem to be any way to introspect if we support decima=
l fds
> > > from the command line; is that going to be a problem?
> >=20
> > Libvirt needs to know when it can use it, so any suggestions ?
>=20
> Patch 9/9 modified qemu_chardev_opts; does that change reflect through
> query-command-line-options?  Not all QemuOpts changes are introspectibl=
e
> yet, and Markus has been trying to tackle that, but if this particular =
one
> works, we can use that as our witness (after all, if I understand corre=
ctly,
> the new feature you are adding here is NOT affecting the QMP usage, but=
 is
> an enhancement for command-line usage).

Yeah, 'fd' does appear there, so that's good enough for now.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
