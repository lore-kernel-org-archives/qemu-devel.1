Received: from eggs.gnu.org ([2001:4830:134:3::10]:48051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eP387-0008Hf-1S
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 04:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eP382-0006ri-UO
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 04:15:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eP382-0006rP-NW
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 04:15:02 -0500
Date: Wed, 13 Dec 2017 09:14:58 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171213091458.GA28379@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
	<20171212143421.GD26971@redhat.com>
	<11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
Subject: Re: [Qemu-devel] Adding more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Dec 12, 2017 at 12:49:34PM -0500, Programmingkid wrote:
> 
> > On Dec 12, 2017, at 9:34 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> > 
> > On Sun, Dec 10, 2017 at 02:10:41AM -0500, Programmingkid wrote:
> >> On Macintosh keyboards there is a key called fn that is used to give the
> >> function keys more functionality. Does this key exist in the keyboard keys
> >> database?
> > 
> > When you say "Macintosh keyboards" are you talking about the old style
> > keyboards with Apple's custom ADB connector, or simply Apple branded
> > USB keyboards ? 
> 
> USB keyboards.
> 
> > 
> > If its the latter (USB), then please plug it into a Linux machine, and
> > in a text console (ie not X11) run 'showkey' and press this 'fn' key on
> > its own and tell me what (if any) hex code gets printed.
> 
> There was no response to the fn key.

Doh, I made a mistake - you need to run   'showkey -s'  to get raw scancodes.
Can you try this again, pressing 'fn' on its own, and also press 'fn' in
combination with some function keys.


> >> Also could keys F16 to F24 (Q_KEY_CODE_F16 to Q_KEY_CODE_F24) be added to
> >> the database?
> > 
> > Those are already defined in keycodemapdb, so we just need to give them
> > names in the qapi schema, and then add the name mapping to keycodemapdb.
> 
> I have a vague memory of doing something like this a long time ago.
> Hopefully I can find the path if it exists.

In qapi/ui.json you need to edit the enum 'QKeyCode' to define the
extra keys.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
