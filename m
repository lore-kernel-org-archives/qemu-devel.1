Received: from eggs.gnu.org ([209.51.188.92]:45736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hEdAF-00074Y-1B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hEdAD-0001z4-Ui
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:07:03 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hEdAD-0001xY-J7
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:07:01 -0400
Received: by mail-ed1-f46.google.com with SMTP id d13so5877522edr.5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
In-Reply-To: <20190411130245.ltfyp7d2dfe2cr3h@steredhat>
Reply-To: dillaman@redhat.com
From: Jason Dillaman <jdillama@redhat.com>
Date: Thu, 11 Apr 2019 13:06:49 -0400
Message-ID: <CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: dillaman <dillaman@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Apr 11, 2019 at 9:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Apr 11, 2019 at 08:35:44AM -0400, Jason Dillaman wrote:
> > On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >
> > > RBD APIs don't allow us to write more than the size set with rbd_create()
> > > or rbd_resize().
> > > In order to support growing images (eg. qcow2), we resize the image
> > > before RW operations that exceed the current size.
> >
> > What's the use-case for storing qcow2 images within a RBD image? RBD
> > images are already thinly provisioned, they support snapshots, they
> > can form a parent/child linked image hierarchy.
> >
>
> Hi Jason,
> I understand your point of view, maybe one use case could be if you have
> a qcow2 image and you want to put it in the rdb pool without convert it.
>
> I'm going through this BZ [1] and I'll ask if they have other
> use cases in mind.

Assuming no good use-cases, perhaps it would just be better to make
the qemu-img error messages more clear.

> Anyway, if we want to support only raw format on RBD driver, maybe we
> should return something different from current behaviour, also avoiding
> to create the image:
>
> $ qemu-img create -f qcow2 rbd:test/qcow.img 1G
>   qemu-img: rbd:test/qcow.img: Could not write qcow2 header: Invalid argument
>
> What do you think?
>
> Thanks,
> Stefano
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1171007



-- 
Jason
