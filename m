Received: from eggs.gnu.org ([2001:4830:134:3::10]:44088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ce1NY-0003Gu-DH
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ce1NV-0001Cb-8G
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:20:24 -0500
Date: Wed, 15 Feb 2017 15:20:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170215152013.GH24672@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<20170215151419.GD16064@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170215151419.GD16064@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Maor Lipchuk <mlipchuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>, qemu-discuss@nongnu.org

On Wed, Feb 15, 2017 at 03:14:19PM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 13, 2017 at 05:46:19PM +0200, Maor Lipchuk wrote:
> > I was wondering if that is possible to provide a new API that
> > estimates the size of
> > qcow2 image converted from a raw image. We could use this new API to
> > allocate the
> > size more precisely before the convert operation.
> > 
> [...]
> > We think that the best way to solve this issue is to return this info
> > from qemu-img, maybe as a flag to qemu-img convert that will
> > calculate the size of the converted image without doing any writes.
> 
> Sounds reasonable.  qcow2 actually already does some of this calculation
> internally for image preallocation in qcow2_create2().
> 
> Let's try this syntax:
> 
>   $ qemu-img query-max-size -f raw -O qcow2 input.raw
>   1234678000
> 
> As John explained, it is only an estimate.  But it will be a
> conservative maximum.

This forces you to have an input file. It would be nice to be able to
get the same information by merely giving the desired capacity e.g

  $ qemu-img query-max-size -O qcow2 20G


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
