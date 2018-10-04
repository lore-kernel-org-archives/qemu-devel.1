Received: from eggs.gnu.org ([2001:4830:134:3::10]:51913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1g82ma-0000jH-OE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1g82e4-00032v-8T
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:22:21 -0400
Date: Thu, 4 Oct 2018 13:22:12 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181004122212.GE27120@redhat.com>
References: <20181003170228.95973-1-vsementsov@virtuozzo.com>
	<bccd1e94-431f-c7cf-4a0c-599dcf345e73@redhat.com>
	<a6a5cfb4-bfad-a4f5-fb86-e9329da851b6@virtuozzo.com>
	<e4459a14-298e-1cd7-0805-e7ec30c3fb01@redhat.com>
	<79d591fa-d839-d5ba-c3e8-6c33ce4ecc0d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79d591fa-d839-d5ba-c3e8-6c33ce4ecc0d@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] nbd server: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>

On Thu, Oct 04, 2018 at 12:10:17PM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> this is a bit more difficult and more overhead than option in Qemu.. Bu=
t=20
> I don't sure we should care about

I think Eric's point is that dropping oldstyle in qemu-nbd isn't
really a problem because nbdkit has no plans to drop oldstyle.  So
there will remain a path for very old clients to keep working (whether
using nbdkit natively, or using nbdkit to proxy to qemu-nbd).  Eric's
example used the more complex proxy case.  By contrast the nbdkit
native case is very simple:

  nbdkit -o file disk.img

(where the =E2=80=98-o=E2=80=99 flag switches to oldstyle protocol).

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
