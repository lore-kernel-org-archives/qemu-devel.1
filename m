Received: from eggs.gnu.org ([2001:4830:134:3::10]:50367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlde-0000C0-1t
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eOlda-000116-Bi
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:34:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eOlda-00010q-4M
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:34:26 -0500
Date: Tue, 12 Dec 2017 14:34:21 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171212143421.GD26971@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
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

On Sun, Dec 10, 2017 at 02:10:41AM -0500, Programmingkid wrote:
> On Macintosh keyboards there is a key called fn that is used to give the
> function keys more functionality. Does this key exist in the keyboard keys
> database?

When you say "Macintosh keyboards" are you talking about the old style
keyboards with Apple's custom ADB connector, or simply Apple branded
USB keyboards ?

If it is the former (ADB) what key does this correspond to on this
picture:

http://www.archive.org/stream/apple-guide-macintosh-family-hardware/Apple_Guide_to_the_Macintosh_Family_Hardware_2e#page/n345/mode/2up


If its the latter (USB), then please plug it into a Linux machine, and
in a text console (ie not X11) run 'showkey' and press this 'fn' key on
its own and tell me what (if any) hex code gets printed.

Also, under OS-X run this app:

  https://manytricks.com/keycodes/

and again let me know what it reports when the fn key is pressed on its
on.

Then also do the same but press 'fn' in combination with another function
key.

The key thing we need to understand is whether this magic behaviour of
the 'fn' key is actually changing what the main function keys send as
scancodes.

> Also could keys F16 to F24 (Q_KEY_CODE_F16 to Q_KEY_CODE_F24) be added to
> the database?

Those are already defined in keycodemapdb, so we just need to give them
names in the qapi schema, and then add the name mapping to keycodemapdb.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
