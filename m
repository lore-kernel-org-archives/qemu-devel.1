Received: from eggs.gnu.org ([2001:4830:134:3::10]:59124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1coS0H-0007h8-UU
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1coS0E-0003O3-RT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:47:29 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com
	([104.47.0.104]:18560
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1coS0E-0003NT-B4
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:47:26 -0400
Message-ID: <1489657576.561.24.camel@nokia.com>
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Thu, 16 Mar 2017 11:46:16 +0200
In-Reply-To: <1489562641.15659.16.camel@redhat.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<1489562641.15659.16.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, 2017-03-15 at 08:24 +0100, Gerd Hoffmann wrote:
> >
> > The short answer: emulating real hardware.
>=20
> Ok, that is reason enough.
>=20
> Adding bootonceindex everywhere doesn't look like the best plan to me
> though.=C2=A0=C2=A0Possibly we can pimp up bootindex in a backward-compat=
ible
> way?
> Something like bootindex=3D<normal>[.<once>] ?

That would (likely) avoid modifying all devices, but wouldn't
that make the 'bootindex' property a string (now: 'int32')
and thus change the QOM API?

I did consider making device_add_bootindex_property() to
automatically add the new property too, but since that API
is currently such that the _caller_ provides the name of the
added property, it would mean that the function would need
to generate the second name using some magic mangling rule
and that didn't seem very nice to me. Of course the API could
be modified so that the caller provides two names, but then
we are already back to modifying all relevant devices.
