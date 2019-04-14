Received: from eggs.gnu.org ([209.51.188.92]:37715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hFf91-00060l-DV
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 09:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hFf3f-0004pu-0x
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 09:20:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hFf3c-0004dn-DF
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 09:20:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so18140067wrn.11
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 06:20:13 -0700 (PDT)
Date: Sun, 14 Apr 2019 15:20:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically
 the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dillaman@redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Apr 11, 2019 at 01:06:49PM -0400, Jason Dillaman wrote:
> On Thu, Apr 11, 2019 at 9:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Thu, Apr 11, 2019 at 08:35:44AM -0400, Jason Dillaman wrote:
> > > On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > RBD APIs don't allow us to write more than the size set with rbd_create()
> > > > or rbd_resize().
> > > > In order to support growing images (eg. qcow2), we resize the image
> > > > before RW operations that exceed the current size.
> > >
> > > What's the use-case for storing qcow2 images within a RBD image? RBD
> > > images are already thinly provisioned, they support snapshots, they
> > > can form a parent/child linked image hierarchy.
> > >
> >
> > Hi Jason,
> > I understand your point of view, maybe one use case could be if you have
> > a qcow2 image and you want to put it in the rdb pool without convert it.
> >
> > I'm going through this BZ [1] and I'll ask if they have other
> > use cases in mind.
> 
> Assuming no good use-cases, perhaps it would just be better to make
> the qemu-img error messages more clear.
> 

Hi Jason,
I asked about use-cases and they want to use qcow2 on rbd in order to
take advantage of these qcow2 features [1]: external snapshots,
Copy-on-write, and optional compression and encryption.

Maybe the more interesting are external snapshots and Copy-on-write,
since encryption can be achieved with LUKS and rbd should support
compression for a specified pool.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1171007#c13

Cheers,
Stefano
