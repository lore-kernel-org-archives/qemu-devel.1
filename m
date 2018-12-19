Received: from eggs.gnu.org ([2001:4830:134:3::10]:33838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZbNt-0005hg-5F
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZbNp-0006H4-LB
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:55:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZbNp-0006GO-F7
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:55:29 -0500
Date: Wed, 19 Dec 2018 13:55:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181219125527.6vvjnmegmihso5ix@sirius.home.kraxel.org>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
	<CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
	<20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
	<CAJ+F1CJtFJ_vk817tQsGEi3B+xC4bH3eGxA+tRPayyj3F0gnsw@mail.gmail.com>
	<20181219071325.c7ayirk564s7kuhn@sirius.home.kraxel.org>
	<CAJ+F1CKzb3DmmuQG5itgsUxvUwM34fh242FsgxKp1Aj-fksrBg@mail.gmail.com>
	<20181219095442.oayncn5ufysvntet@sirius.home.kraxel.org>
	<CAJ+F1CJ-jg9fSoE1Z3g3vQvXO8sz320YrBEs7sa_Dr+o-JQAYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJ-jg9fSoE1Z3g3vQvXO8sz320YrBEs7sa_Dr+o-JQAYg@mail.gmail.com>
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

> > > > Everything needed, so launching remote-viewer is
> > > > just "remote-viewer /path/to/config.vv".
> > >
> > > If it's just what is needed to launch the viewer, why not stick to the
> > > url syntax?
> >
> > First, the info needed to launch is located on a fixed & well known
> > place on disk then, so it is easy to restart remote-viewer.
> 
> It would also be a fixed URI, if we use the spice+unix:// syntax.

Ah, good.  Fine with me then.

> > I think it is more useful to extend that instead of passing through
> > options from the qemu command line to virt-viewer.
> 
> Hmm, although it limits what you can easily configure per instance as well..

We might decide on a case-by-vase basis, which make sense as
per-instance and which not.  For example: Hotkeys is more a user
preference and I don't think we need them be configurable per-vm.
For fullscreen it is probably more useful to have that as vm-specific
option.

cheers,
  Gerd
