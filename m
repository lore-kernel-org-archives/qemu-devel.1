Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZWWm-0000bd-9H
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZWWl-0001FW-8j
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:44:24 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZWWj-0001DU-LE
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:44:23 -0500
Received: by mail-wr1-x433.google.com with SMTP id u4so17446423wrp.3
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 23:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
	<CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
	<20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
	<CAJ+F1CJtFJ_vk817tQsGEi3B+xC4bH3eGxA+tRPayyj3F0gnsw@mail.gmail.com>
	<20181219071325.c7ayirk564s7kuhn@sirius.home.kraxel.org>
In-Reply-To: <20181219071325.c7ayirk564s7kuhn@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 19 Dec 2018 11:44:07 +0400
Message-ID: <CAJ+F1CKzb3DmmuQG5itgsUxvUwM34fh242FsgxKp1Aj-fksrBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Dec 19, 2018 at 11:13 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Also:  remote-viewer accepts config files.  I'd suggest to write one,=
 so
> > > it is easy to restart remote-viewer.  Also I would not use a temp dir
> >
> > Where should it be written?
>
> /run/user/$uid/qemu/$vmname/remote-viewer.vv ?
>
> > What should be the content of
> > the .vv file?
>
> Everything needed, so launching remote-viewer is
> just "remote-viewer /path/to/config.vv".

If it's just what is needed to launch the viewer, why not stick to the
url syntax?

.vv files are quite specific to virt-viewer/remote-viewer.

>
> We might consider writing such a config file
> unconditionally, even without -display app.
>
> > Should it use a template to avoid proxying all the
> > options?
>
> Is this needed?  virt-viewer has a user settings file,
> shouldn't user preferences go there instead?

User settings files are quite limited at this point. Afaik, it's only
used for the "ask-quit" preference, and "monitor-mapping". Other
options are either from command line or .vv files.

>
> > > for the files and sockets, but some fixed location.
> > > /run/user/$uid/qemu/$vmname for example (where $vmname is whatever yo=
u
> > > passed to qemu using -name).
> >
> > That's easy enough, although if no -name is given, I suppose a
> > temporary location is still better than a fixed location.
>
> Yes, just replace $vmname with `mktemp --directory` then.
>
> cheers,
>   Gerd
>

thanks

--=20
Marc-Andr=C3=A9 Lureau
