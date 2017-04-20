Received: from eggs.gnu.org ([2001:4830:134:3::10]:58524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1EUc-0001W0-9P
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1EUb-0001ex-AA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:59:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170414083717.13641-1-lvivier@redhat.com>
	<CAFEAcA-NTpaXL9foLOqZ1AyBOcFokKfJGMxicQFXeAzkMATfBA@mail.gmail.com>
Date: Thu, 20 Apr 2017 17:59:27 +0200
In-Reply-To: <CAFEAcA-NTpaXL9foLOqZ1AyBOcFokKfJGMxicQFXeAzkMATfBA@mail.gmail.com>
	(Peter Maydell's message of "Thu, 20 Apr 2017 14:02:38 +0100")
Message-ID: <871ssn9ijk.fsf@dusky.pond.sub.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Antony Pavlov <antonynpavlov@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 14 April 2017 at 09:37, Laurent Vivier <lvivier@redhat.com> wrote:
>> This series removes all the remaining uses of
>> cannot_destroy_with_object_finalize_yet to finally remove
>> the flag itself.
>>
>> The ARM patch has already been sent alone and reviewed by Markus.
>> I have tested the ppc one on ppc64 machine with KVM and using
>> QDM device-list-properties command.
>>
>> For the versatile one, the flag allowed to workaround a problem
>> in the bus unparent function: the bus unparent is trying to
>> unparent all the children of the bus. To do that, it has a list
>> of the children of the bus, and calls object_unparent() for each
>> child, and object_unparent() calls object_property_del_child() if
>> obj->parent is not NULL.  As qdev_set_parent_bus() set only
>> parent_bus and the list of children, parent is NULL and the child
>> is never deleted.  We can avoid the problem by moving the
>> qdev_set_parent_bus() to the realize part.
>>
>> I've tested all the changes with "make check" (including
>> device-introspect-test). I've booted a versatilepb machine
>> with a 3.16.0-4 debian installer kernel.
>>
>> Laurent Vivier (4):
>>   arm: remove remaining cannot_destroy_with_object_finalize_yet
>>   ppc: remove cannot_destroy_with_object_finalize_yet
>>   versatile: remove cannot_destroy_with_object_finalize_yet
>>   qdev: remove cannot_destroy_with_object_finalize_yet
>
> Markus -- are you planning to take this whole series through
> your tree? I'm happy with the ARM patches but I guess we
> should keep the whole series together since patch 4 depends
> on the other 3...

We have no qdev maintainer.  David, you wrote you applied PATCH 2.  Are
you okay with me taking all four?  If yes, would you like me to add your
Acked-by or Reviewed-by to PATCH 2?

> I guess that means
> Acked-by: Peter Maydell <peter.maydell@linaro.org>

Noted.
