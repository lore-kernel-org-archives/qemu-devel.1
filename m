Received: from eggs.gnu.org ([2001:4830:134:3::10]:60082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZW2w-00024q-QB
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZW2r-0007po-QY
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:13:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZW2r-0007pb-KS
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:13:29 -0500
Date: Wed, 19 Dec 2018 08:13:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181219071325.c7ayirk564s7kuhn@sirius.home.kraxel.org>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
	<CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
	<20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
	<CAJ+F1CJtFJ_vk817tQsGEi3B+xC4bH3eGxA+tRPayyj3F0gnsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJtFJ_vk817tQsGEi3B+xC4bH3eGxA+tRPayyj3F0gnsw@mail.gmail.com>
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

  Hi,

> > Also:  remote-viewer accepts config files.  I'd suggest to write one, so
> > it is easy to restart remote-viewer.  Also I would not use a temp dir
> 
> Where should it be written?

/run/user/$uid/qemu/$vmname/remote-viewer.vv ?

> What should be the content of
> the .vv file?

Everything needed, so launching remote-viewer is
just "remote-viewer /path/to/config.vv".

We might consider writing such a config file
unconditionally, even without -display app.

> Should it use a template to avoid proxying all the
> options?

Is this needed?  virt-viewer has a user settings file,
shouldn't user preferences go there instead?

> > for the files and sockets, but some fixed location.
> > /run/user/$uid/qemu/$vmname for example (where $vmname is whatever you
> > passed to qemu using -name).
> 
> That's easy enough, although if no -name is given, I suppose a
> temporary location is still better than a fixed location.

Yes, just replace $vmname with `mktemp --directory` then.

cheers,
  Gerd
