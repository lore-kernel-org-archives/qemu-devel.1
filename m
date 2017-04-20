Received: from eggs.gnu.org ([2001:4830:134:3::10]:53167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1Bjm-0004PY-Es
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1Bjg-0004nP-Od
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:03:06 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1Bjg-0004n9-Ik
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:03:00 -0400
Received: by mail-wm0-x22d.google.com with SMTP id o81so103120678wmb.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 06:03:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170414083717.13641-1-lvivier@redhat.com>
References: <20170414083717.13641-1-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 14:02:38 +0100
Message-ID: <CAFEAcA-NTpaXL9foLOqZ1AyBOcFokKfJGMxicQFXeAzkMATfBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alistair Francis <alistair.francis@xilinx.com>, Antony Pavlov <antonynpavlov@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>

On 14 April 2017 at 09:37, Laurent Vivier <lvivier@redhat.com> wrote:
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
>
> Laurent Vivier (4):
>   arm: remove remaining cannot_destroy_with_object_finalize_yet
>   ppc: remove cannot_destroy_with_object_finalize_yet
>   versatile: remove cannot_destroy_with_object_finalize_yet
>   qdev: remove cannot_destroy_with_object_finalize_yet

Markus -- are you planning to take this whole series through
your tree? I'm happy with the ARM patches but I guess we
should keep the whole series together since patch 4 depends
on the other 3...

I guess that means
Acked-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
