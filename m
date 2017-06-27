Received: from eggs.gnu.org ([2001:4830:134:3::10]:43365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dPlmG-0005I1-8u
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dPlmF-0005BX-6r
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:23:16 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dPlmE-000594-Us
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:23:15 -0400
Received: by mail-lf0-x242.google.com with SMTP id n136so2105147lfn.2
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 01:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20170621140219.4568-1-marcandre.lureau@redhat.com>
	<20170621140219.4568-3-marcandre.lureau@redhat.com>
	<20170623210845.GA10776@localhost.localdomain>
In-Reply-To: <20170623210845.GA10776@localhost.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Jun 2017 08:23:03 +0000
Message-ID: <CAJ+F1CLUHM2+hMQqCmN04nwWEMDDDK8104=vK9rnoTsetw9JVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/3] Add memfd based hostmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org

Hi Eduardo

On Fri, Jun 23, 2017 at 11:09 PM Eduardo Habkost <ehabkost@redhat.com>
wrote:

> On Wed, Jun 21, 2017 at 04:02:18PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Add a new memory backend, similar to hostmem-file, except that it
> > doesn't need to create files. It also enforces memory sealing.
> >
> > This backend is mainly useful for sharing the memory with other
> > processes.
>
> How exactly can the memfd be used to share memory?  Is there an existing
> mechanism for sharing the memfd file descriptor with another process



Since there is no backing file, the traditional mechanism is by passing fd,
via socket ancillary data or forking etc.. Both ivshmem and vhost-user have
such messages, with eventually details for the memory map usage.


> >
> > Note that Linux supports transparent huge-pages of shmem/memfd memory
> > since 4.8. It is relatively easier to set up THP than a dedicate
> > hugepage mount point by using "madvise" in
> > /sys/kernel/mm/transparent_hugepage/shmem_enabled.
> >
> > Usage:
> > -object memory-backend-memfd,id=3Dmem1,size=3D1G
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  backends/hostmem-memfd.c | 67
> ++++++++++++++++++++++++++++++++++++++++++++++++
> >  backends/Makefile.objs   |  2 ++
> >  qemu-options.hx          | 11 ++++++++
> >  3 files changed, 80 insertions(+)
> >  create mode 100644 backends/hostmem-memfd.c
> >
> [...]
>
> --
> Eduardo
>
> --
Marc-Andr=C3=A9 Lureau
