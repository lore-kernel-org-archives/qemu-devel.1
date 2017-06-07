Received: from eggs.gnu.org ([2001:4830:134:3::10]:35809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIW0V-0008GM-4A
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIW0R-0008Dx-Tj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:07:59 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA9arhJuzCs=ec4dW+_cgSodi0NWTnBB+-4mwAjSGMaLDA@mail.gmail.com>
	(Peter Maydell's message of "Tue, 6 Jun 2017 18:49:08 +0100")
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
	<20170606025135.2685-2-david@gibson.dropbear.id.au>
	<CAFEAcA9arhJuzCs=ec4dW+_cgSodi0NWTnBB+-4mwAjSGMaLDA@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 10:07:53 +0200
Message-ID: <87fufc43vq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 01/17] migration: remove register_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 6 June 2017 at 03:51, David Gibson <david@gibson.dropbear.id.au> wrote:
>> From: Laurent Vivier <lvivier@redhat.com>
>>
>> We can replace the four remaining calls of register_savevm() by
>> calls to register_savevm_live(). So we can remove the function and
>> as we don't allocate anymore the ops pointer with g_new0()
>> we don't have to free it then.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/net/vmxnet3.c            |  8 ++++++--
>>  hw/s390x/s390-skeys.c       |  9 +++++++--
>>  hw/s390x/s390-virtio-ccw.c  |  8 ++++++--
>>  include/migration/vmstate.h |  8 --------
>>  migration/savevm.c          | 16 ----------------
>>  slirp/slirp.c               |  8 ++++++--
>>  6 files changed, 25 insertions(+), 32 deletions(-)
>
> Great to see register_savevm() finally disappearing.
>
> Any chance of an update to docs/migration.txt, which still
> mentions register_savevm(), but on the other hand doesn't
> say anything about register_savevm_live() and unregister_savevm().
> (Doc comments in the .h file for those functions would be
> nice too...)

Ok, will take a look.

> Things that would be interesting to explain/document:
>  * what is special about vmxnet3 that makes it the only pci device
>    that needs to use this rather than having a vmstate struct?

Will take a look.  vmxnet3 used to be a mess (in relation to migration).

>  * why does s390-skeys call the register function with a NULL
>    pointer but the unregister pointer with a device pointer?

No clue, will left that 

> (Could we replace the uses of these which pass a dev pointer
> with vmstate structs and then drop the dev parameter?)

Not sure, have to take a look.

Thanks, Juan.
