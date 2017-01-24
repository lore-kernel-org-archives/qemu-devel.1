Received: from eggs.gnu.org ([2001:4830:134:3::10]:48912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzx9-00078G-MS
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzx8-0002yX-EE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:11:59 -0500
Date: Tue, 24 Jan 2017 12:11:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124121146.GH14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-4-berrange@redhat.com>
	<3d01b4f0-c641-43ce-2359-9a0ab9c360d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d01b4f0-c641-43ce-2359-9a0ab9c360d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 03/15] qcow: document another weakness
 of qcow AES encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Mon, Jan 16, 2017 at 08:37:57PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > Document that use of guest virtual sector numbers as the basis for
> > the initialization vectors is a potential weakness, when combined
> > with internal snapshots or multiple images using the same passphrase.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-img.texi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/qemu-img.texi b/qemu-img.texi
> > index 174aae3..8efcf89 100644
> > --- a/qemu-img.texi
> > +++ b/qemu-img.texi
> > @@ -554,6 +554,15 @@ change the passphrase to protect data in any qcow images. The files must
> >  be cloned, using a different encryption passphrase in the new file. The
> >  original file must then be securely erased using a program like shred,
> >  though even this is ineffective with many modern storage technologies.
> > +@item Initialization vectors used to encrypt sectors are based on the
> > +guest virtual sector number, instead of the host physical sector. When
> > +a disk image has multiple internal snapshots this means that data in
> > +multiple physical sectors is encrypted with the same initialization
> > +vector. With the CBC mode, this opens the possibility of watermarking
> > +attacks if the attack can collect multiple sectors encrypted with the
> > +same IV and some predictable data. Having multiple qcow2 images with
> > +the same passphrase also exposes this weakness since the passphrase
> > +is directly used as the key.
> >  @end itemize
> 
> In the output manpage, this itemize looks pretty broken to me:
> 
> @item foo
> bar baz
> 
> is formatted as:
> 
> -<foo>
>     bar baz
> 
> Which may be used intentionally, but it certainly isn't here.
> 
> It should probably be written as:
> 
> @item
> foo bar baz
> 
> which becomes
> 
> -    foo bar baz
> 
> (which is what the other itemize in qemu-img.texi does)
> 
> Do you want to fix that in this series?

Yes, will do.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
