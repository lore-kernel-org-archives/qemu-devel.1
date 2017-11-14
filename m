Received: from eggs.gnu.org ([2001:4830:134:3::10]:43843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEVXu-00010U-Bx
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEVXr-0003Ay-0W
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:22:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEVXq-0003AI-RV
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:22:06 -0500
Date: Tue, 14 Nov 2017 08:21:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171114072159.nx77jscj22xzikuv@sirius.home.kraxel.org>
References: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
	<20171113145041.GI18828@redhat.com>
	<CAJ+F1CLxYBq7zfzMSrhnxb+9Np7ZDnrbLqf+e=FoZyC=bZFA+Q@mail.gmail.com>
	<77699873-C42D-4678-9E29-432D2A36BCCE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77699873-C42D-4678-9E29-432D2A36BCCE@gmail.com>
Subject: Re: [Qemu-devel] Command-line option to change ungrab key(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> >>> Would this feature be something you would consider adding to QEMU?
> >> 
> >> As context, virt-manager allows customization for the ungrab sequence, and
> >> so do spice-gtk/gtk-vnc at the API level. So conceptually I think it is
> >> reasonable for any UI console that is intended as more than just a toy.
> > 
> > Would it make sense to share the virt-viewer/remote-viewer --hotkeys
> > option format ? (see man remote-viewer / virt-viewer)
> 
> I think you are referring to information found on this page: https://www.mankier.com/1/remote-viewer
> 
> The command-line option for changing hotkey actions would be:
> --hotkeys=<action1>=<key1>[+<key2>][,<action2>=<key3>[+<key4>]]
> 
> So this means changing the mouse ungrab would look something like this:
> 
> --hotkeys=release-cursor=F19 (or some other key)
> 
> Gerd what you think of this idea?

Certainly not this way.  The display configuration we have right now is
pretty messy already.  I want clean this up (draft patch series at
https://www.kraxel.org/cgit/qemu/log/?h=lupin/display-cmdline), and this
should be done before adding new stuff.

Also when making this configurable it should be consistent across all
user interfaces we have, which surely is a non-trivial amount of work.

cheers,
  Gerd
