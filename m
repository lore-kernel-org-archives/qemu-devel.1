Received: from eggs.gnu.org ([2001:4830:134:3::10]:48412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RJa-0005sf-2T
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RJZ-0004e9-6r
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:41:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170414083717.13641-1-lvivier@redhat.com>
Date: Fri, 21 Apr 2017 07:40:55 +0200
In-Reply-To: <20170414083717.13641-1-lvivier@redhat.com> (Laurent Vivier's
	message of "Fri, 14 Apr 2017 10:37:13 +0200")
Message-ID: <87tw5i1fo8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/4] qdev: remove all remaining
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Antony Pavlov <antonynpavlov@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Laurent Vivier <lvivier@redhat.com> writes:

> This series removes all the remaining uses of
> cannot_destroy_with_object_finalize_yet to finally remove
> the flag itself.
>
> The ARM patch has already been sent alone and reviewed by Markus.
> I have tested the ppc one on ppc64 machine with KVM and using
> QDM device-list-properties command.
>
> For the versatile one, the flag allowed to workaround a problem
> in the bus unparent function: the bus unparent is trying to
> unparent all the children of the bus. To do that, it has a list
> of the children of the bus, and calls object_unparent() for each
> child, and object_unparent() calls object_property_del_child() if
> obj->parent is not NULL.  As qdev_set_parent_bus() set only
> parent_bus and the list of children, parent is NULL and the child
> is never deleted.  We can avoid the problem by moving the
> qdev_set_parent_bus() to the realize part.
>
> I've tested all the changes with "make check" (including
> device-introspect-test). I've booted a versatilepb machine
> with a 3.16.0-4 debian installer kernel.

Applied to my tree, thanks!
