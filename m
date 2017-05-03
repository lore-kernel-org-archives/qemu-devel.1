Received: from eggs.gnu.org ([2001:4830:134:3::10]:50136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5pn1-000441-Qh
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5pn1-0008Ao-4T
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:37:39 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5pn0-0008AY-U2
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:37:39 -0400
Received: by mail-wr0-x243.google.com with SMTP id 6so21539017wrb.1
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 01:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20170503072819.14462-1-famz@redhat.com>
	<20170503074240.GC9318@lemon.lan>
In-Reply-To: <20170503074240.GC9318@lemon.lan>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 03 May 2017 08:37:26 +0000
Message-ID: <CAJ+F1CK9sup=RVT2wCuiFMiCPZAryPg1qYX9HtDGwvnTy73oRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: Acquire BQL around vm_start() in
 dump thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, peterx@redhat.com

Hi

On Wed, May 3, 2017 at 11:42 AM Fam Zheng <famz@redhat.com> wrote:

> On Wed, 05/03 15:28, Fam Zheng wrote:
> > This fixes an assertion failure in the following backtrace:
> >
>

Do you know if it's a regression? Is this a racy case? (I couldn't
reproduce)


> >     __GI___assert_fail
> >     memory_region_transaction_commit
> >     memory_region_add_eventfd
> >     virtio_pci_ioeventfd_assign
> >     virtio_bus_set_host_notifier
> >     virtio_blk_data_plane_start
> >     virtio_bus_start_ioeventfd
> >     virtio_vmstate_change
> >     vm_state_notify
> >     vm_prepare_start
> >     vm_start
> >     dump_cleanup
> >     dump_process
> >     dump_thread
> >     start_thread
> >     clone
> >
> > vm_start need BQL, acquire it if doing cleaning up from main thread.
>
> Oops, s/need/needs and s/main thread/detached thread/.
>

With that fixed,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau
