Received: from eggs.gnu.org ([2001:4830:134:3::10]:59198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d7l5r-0006N3-FT
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d7l5n-0007Vh-Nx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d7l5n-0007VC-Ea
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:00:59 -0400
Date: Mon, 8 May 2017 17:00:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170508160051.GZ18871@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	<87wp9r689l.fsf@dusky.pond.sub.org>
	<CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
	<bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
Subject: Re: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Carl Karsten <carl@personnelware.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Mon, May 08, 2017 at 11:32:12AM -0400, John Snow wrote:
> 
> 
> On 05/08/2017 10:15 AM, Carl Karsten wrote:
> > On Mon, May 8, 2017 at 3:51 AM, Markus Armbruster <armbru@redhat.com> wrote:
> > 
> >> Carl Karsten <carl@personnelware.com> writes:
> >>
> >>> juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -drive
> >>> file=disk.cow -drive file=boot.img
> >>> WARNING: Image format was not specified for 'boot.img' and probing
> >> guessed
> >>> raw.
> >>>          Automatically detecting the format is dangerous for raw images,
> >>> write operations on block 0 will be restricted.
> >>>          Specify the 'raw' format explicitly to remove the restrictions.
> >>>
> >>> This is OK, as I don't want anything writing to that thing anyway.  So to
> >>> get rid of the waring:
> >>>
> >>> juser@gator:~/temp$ qemu-system-x86_64 -drive
> >>> file=boot.img,format=raw,readonly qemu-system-x86_64: Can't use a
> >> read-only
> >>> drive
> >>> qemu-system-x86_64: Initialization of device ide-hd failed: Device
> >>> initialization failed.
> >>
> >> -drive without if=... creates an IDE disk[*].  IDE disks can't do
> >> read-only.  Have you tried omitting ",readonly"?
> >>
> > 
> > 
> > omitting works, but my goal was for the drive to be read only.
> > 
> > 
> 
> I don't think there's a way to make physical IDE drives "read only." I
> don't think there's any jumper settings or any of the like which can
> accomplish this.

You could use an IDE cdrom though, rather than an IDE disk, as that's
readonly from guest POV (we don't emulate a cd-writer).

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
