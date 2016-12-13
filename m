Received: from eggs.gnu.org ([2001:4830:134:3::10]:37224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGmw7-0005xI-3O
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGmw3-0007ty-Ti
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:16:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGmw3-0007tZ-Ni
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:15:59 -0500
Date: Tue, 13 Dec 2016 13:15:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161213131553.GJ28416@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
	<1481616362.27088.74.camel@redhat.com>
	<7ba29954-e3ad-529c-9978-b10d2788f9e4@cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ba29954-e3ad-529c-9978-b10d2788f9e4@cendio.se>
Subject: Re: [Qemu-devel] VNC LED state buggy, interop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Ossman <ossman@cendio.se>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, Dec 13, 2016 at 02:10:04PM +0100, Pierre Ossman wrote:
> On 13/12/16 09:06, Gerd Hoffmann wrote:
> > >   b) Remove the assumption from the code and the protocol.
> > 
> > Patches are welcome.
> > 
> 
> I was just aiming for a consensus on the intended behaviour, rather than fix
> the bug right now. :)
> But all right, attached patch is an attempt.
> 
> Btw, is there any client that implements this extension yet? I couldn't find
> anything.

gtk-vnc implements the LED state extension.

IIRC, there have been bug reports about it being mostly useless with
QEMU, since it only reflects LED changes initiated by the guest,
and not those initiated by virtual key presses sent by GTK-VNC.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
