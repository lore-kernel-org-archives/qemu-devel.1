Received: from eggs.gnu.org ([2001:4830:134:3::10]:47530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEblr-0001yW-SS
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEbln-00031i-6H
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:00:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEblm-00031D-VD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:00:55 -0500
Date: Tue, 14 Nov 2017 15:00:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171114140050.gje7ig3qtquwqmxb@sirius.home.kraxel.org>
References: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
	<20171113145041.GI18828@redhat.com>
	<CAJ+F1CLxYBq7zfzMSrhnxb+9Np7ZDnrbLqf+e=FoZyC=bZFA+Q@mail.gmail.com>
	<77699873-C42D-4678-9E29-432D2A36BCCE@gmail.com>
	<20171114072159.nx77jscj22xzikuv@sirius.home.kraxel.org>
	<82E2A9D3-FF38-4BBF-ADCE-3494505F0E8D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82E2A9D3-FF38-4BBF-ADCE-3494505F0E8D@gmail.com>
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

> > Certainly not this way.
> 
> Did you have an idea on how something like this should look like? This
> feature would only change the old mouse ungrab keys to a
> user-specified one. So the basic algorithm would be change the text
> that displays at the top of the QEMU window to say (Press <user
> specified key(s)> to release mouse.

That is the easy part ;)

> Then tell the code that looks for
> the ungrab keys which keys to look out for.

Here it becomes more difficuilt.

> >  The display configuration we have right now is pretty messy
> >  already.  I want clean this up (draft patch series at
> >  https://www.kraxel.org/cgit/qemu/log/?h=lupin/display-cmdline), and
> >  this should be done before adding new stuff.
> 
> My original idea was to make a patch that would only change the
> cocoa.m file. I'm thinking you want this code to be elsewhere.
> Somewhere where other UI code like GTK would be able to use. Is that
> what you prefer?

Well, at least the command line parsing part should be in common code,
yes.  Detecting and handling the hotkeys will most likely stay in
UI-specific code.

> > Also when making this configurable it should be consistent across
> > all user interfaces we have, which surely is a non-trivial amount of
> > work.
> 
> I know Cocoa but my lack of GTK experience would not permit me to make
> a patch for that UI code. When you are done with your display
> configuration work, would there even be a need to patch the Cocoa/GTK
> code? I'm under the impression you are trying to consolidate some of
> the UI code under one file.

No.  But standardize the interface between UIs and qemu, which will not
only standardize the configuration, but should also make it easier to
build the UIs as modules.

cheers,
  Gerd
