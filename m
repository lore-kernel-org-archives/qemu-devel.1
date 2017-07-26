Received: from eggs.gnu.org ([2001:4830:134:3::10]:59424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daLhS-0000ct-GU
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daLhP-0000Pc-RC
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daLhP-0000Ow-LO
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:45:59 -0400
Date: Wed, 26 Jul 2017 13:45:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726124551.GK7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724164601.21063-1-berrange@redhat.com>
	<88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
	<20170725083251.GB26394@redhat.com>
	<1500983620.29790.3.camel@redhat.com>
	<20170726112826.GE7620@redhat.com>
	<1501069447.29903.4.camel@redhat.com>
	<20170726120529.GG7620@redhat.com>
	<1501072390.29903.6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501072390.29903.6.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org

On Wed, Jul 26, 2017 at 02:33:10PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > FYI, after adding qcodes to the keycodemapdb, (but not having picked
> > your branch),
> 
> I don't think this is a good idea.  qkeycode numbers are a qemu-private 
> thing, they can (and did in the past) change.  The names are api and
> must not change.

Sorry, yes, I meant only adding the names  - libvirt needs to know the
qcode names and what they map to in other key maps, to use the send-key
command. 

> > I was actually just going add an entry for QKeyCode names to the
> > keycodemapdb, so we can convert straight to that, and also let
> > us auto-generate the qemu_input_linux_to_qcode() table.
> 
> Ok, with the names it should work.
> 
> > Strangely there is no Linux key code defined for AltGr, so if we
> > map via Linux key codes, we would loose ability to send AltGr
> 
> KEY_RIGHTALT?

It seems KEY_RIGHTALT is different from AltGr - it maps to AT set 1
extended scancode 0xe0 0x38, where as AltGr generates 0x64 on my
keyboard


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
