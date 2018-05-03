Received: from eggs.gnu.org ([2001:4830:134:3::10]:58168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fEDwh-0002N9-4M
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fEDwZ-0008Al-4D
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:06:51 -0400
MIME-Version: 1.0
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<bc77a1b2-27f3-21a0-8d82-b930bdf033a5@redhat.com>
In-Reply-To: <bc77a1b2-27f3-21a0-8d82-b930bdf033a5@redhat.com>
From: =?UTF-8?B?5Y+25q6L6aOO?= <renyime@gmail.com>
Date: Thu, 03 May 2018 13:06:31 +0000
Message-ID: <CA+6E1=kp+xYKEc0Xz8tj8M0r4nGb8PG+vxvxm=cDTEGCEsDTPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Thanks for your review, Eric.
Yes, the wr_highest_offset can tell the end offset at runtime, and
write_threshold similar to it. But in my situation, I need to know
the allocated end without a vm running.

Eric Blake <eblake@redhat.com> =E4=BA=8E2018=E5=B9=B45=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:02=E5=86=99=E9=81=93=EF=BC=9A

> On 05/02/2018 08:34 AM, Ivan Ren wrote:
> > qemu-img info with a block device which has a qcow2 format always
> > return 0 for disk size, and this can not reflect the qcow2 size
> > and the used space of the block device. This patch return the
> > allocated size of qcow2 as the disk size.
>
> How does this differ from what qemu can already give you at runtime via
> the wr_highest_offset property in BlockDeviceStats, and related to the
> write_threshold ('block-set-write-threshold command,
> BLOCK_WRITE_THRESHOLD event)?  Is there any code we can reuse, rather
> than writing something from scratch?
>
> >
> > Signed-off-by: Ivan Ren <ivanren@tencent.com>
> > ---
> >   block/qcow2-bitmap.c |  69 +++++++++++++++++
> >   block/qcow2.c        | 212
> +++++++++++++++++++++++++++++++++++++++++++++++++++
> >   block/qcow2.h        |  42 ++++++++++
> >   3 files changed, 323 insertions(+)
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
