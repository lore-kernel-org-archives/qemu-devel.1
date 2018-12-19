Received: from eggs.gnu.org ([2001:4830:134:3::10]:53872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZYYv-0006Pt-9d
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZYYu-0003hv-Eu
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:54:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZYYu-0003gz-7e
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:54:44 -0500
Date: Wed, 19 Dec 2018 10:54:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181219095442.oayncn5ufysvntet@sirius.home.kraxel.org>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
	<CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
	<20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
	<CAJ+F1CJtFJ_vk817tQsGEi3B+xC4bH3eGxA+tRPayyj3F0gnsw@mail.gmail.com>
	<20181219071325.c7ayirk564s7kuhn@sirius.home.kraxel.org>
	<CAJ+F1CKzb3DmmuQG5itgsUxvUwM34fh242FsgxKp1Aj-fksrBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKzb3DmmuQG5itgsUxvUwM34fh242FsgxKp1Aj-fksrBg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] display: add -display app launching
 external application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Dec 19, 2018 at 11:44:07AM +0400, Marc-Andr=E9 Lureau wrote:
> On Wed, Dec 19, 2018 at 11:13 AM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> >
> >   Hi,
> >
> > > > Also:  remote-viewer accepts config files.  I'd suggest to write =
one, so
> > > > it is easy to restart remote-viewer.  Also I would not use a temp=
 dir
> > >
> > > Where should it be written?
> >
> > /run/user/$uid/qemu/$vmname/remote-viewer.vv ?
> >
> > > What should be the content of
> > > the .vv file?
> >
> > Everything needed, so launching remote-viewer is
> > just "remote-viewer /path/to/config.vv".
>=20
> If it's just what is needed to launch the viewer, why not stick to the
> url syntax?

First, the info needed to launch is located on a fixed & well known
place on disk then, so it is easy to restart remote-viewer.

Second, with a vv file you can do a bit more, for example setting "ca"
in case TLS is configured, or set enable-{smartcard,usbredir} depending
on guest configuration.

> .vv files are quite specific to virt-viewer/remote-viewer.

The same is true for the URL syntax.  Trying to pass a URL to vncviewer
doesn't work ...

> > > Should it use a template to avoid proxying all the
> > > options?
> >
> > Is this needed?  virt-viewer has a user settings file,
> > shouldn't user preferences go there instead?
>=20
> User settings files are quite limited at this point. Afaik, it's only
> used for the "ask-quit" preference, and "monitor-mapping". Other
> options are either from command line or .vv files.

Ok.

I think it is more useful to extend that instead of passing through
options from the qemu command line to virt-viewer.

cheers,
  Gerd
