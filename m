Received: from eggs.gnu.org ([2001:4830:134:3::10]:60065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eo9Er-0002Ig-G2
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eo9Eo-0008IH-Df
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:49:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eo9Eo-0008Hq-7x
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:49:46 -0500
Date: Tue, 20 Feb 2018 14:49:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180220144938.GL6021@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAG9FBFpFBrUrG0bRwjAo6xHYG4rnc0BT_ufLSa-HsO2WWgvKJw@mail.gmail.com>
	<3de4128f-7749-fc52-d5ec-5744b4e74301@redhat.com>
	<20180220083857.5l33rci3iz35uaze@sirius.home.kraxel.org>
	<869bcfe6-8199-d7fa-7193-4bb17f6d6ca7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <869bcfe6-8199-d7fa-7193-4bb17f6d6ca7@redhat.com>
Subject: Re: [Qemu-devel] qemu warnings and errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, James Barrett <xucaen@gmail.com>

On Tue, Feb 20, 2018 at 08:45:00AM -0600, Eric Blake wrote:
> On 02/20/2018 02:38 AM, Gerd Hoffmann wrote:
> >    Hi,
> > 
> > > What version of QEMU?
> > > 
> > > > unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org
> > > 
> > > This part is the only part that urges you to report the error, but I
> > > don't know much about what's going on here.
> > > 
> > > Maybe Gerd knows?
> > 
> > We had lots of keymap/keycode changes recently, most likely this will be
> > fixed in 2.12, maybe it already is in 2.11.  So, when using something
> > older, try upgrading first (or just ignore it in case it happes to be a
> > key you don't need).
> 
> The error message doesn't mention a numeric code or other way to figure out
> which key is problematic.  While this particular message may disappear when
> you upgrade, it would also be worth investigating if this message can give
> more details to figure out which keycode is problematic in case of future
> mismatches, other than just "unnamed".

It isn't about a specific key. This message is basically saying we don't
know what keymapping the X server is using, so we've given up. Historically
QEMU could only identify evdev and/or kbd key mappings. With the newly
merged code, we can now detect many more especially including Windows and
OS-X X11 server mappings. So git master hopefully removed the most common
cases that would trigger this particular error message. There's probably
still some remaining though, as there's a huge range of X11 servers impls
in the world.  With current git master this message will instruct the user
to provide us a list of relevant info to help us diagnose it - see the
end of ui/x_keymap.c file.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
