Received: from eggs.gnu.org ([209.51.188.92]:54669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpGiz-000661-9u
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpGix-0000Yc-Ch
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:06:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpGiv-0000So-Da
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:06:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190128141506.12731-1-lifei1214@126.com>
Date: Thu, 31 Jan 2019 19:05:40 +0100
In-Reply-To: <20190128141506.12731-1-lifei1214@126.com> (Fei Li's message of
	"Mon, 28 Jan 2019 22:14:43 +0800")
Message-ID: <87womkvh1n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/11] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

I'm afraid you made a bit of a mess :)

"[PATCH for-4.0 00/11]" suggests this is v1 of eleven patches.

Fei Li <lifei1214@126.com> writes:

> Hi,
>
> This idea comes from BiteSizedTasks, and this patch series implement
> the error checking of qemu_thread_create: make qemu_thread_create
> return a flag to indicate if it succeeded rather than failing with
> an error; make all callers check it.
>
> The first patch modifies the qemu_thread_create() by passing
> &error_abort and returing a value to indicate if it succeeds. The next
> 10 patches will improve on &error_abort for callers who could handle
> more properly.
>
> Please help to review, thanks a lot! 
>
> v10:
> - Make qemu_thread_create() return -errno instead of a Boolean.
> - Add more cleanup for pci_edu_realize()/emulated_realize(). 
> - Polish for iothread_complete()/compress_threads_save_cleanup()/
>   vnc_start_worker_thread()/touch_all_pages.
> - Change to return H_HARDWARE for h_resize_hpt_prepare().
> - Remove five derivative patches as they have been merged.

It's actually v10.

[...]
> Fei Li (11):
>   qemu_thread: make qemu_thread_create() take Error ** argument
>   qemu_thread: supplement error handling for qemu_X_start_vcpu
>   qemu_thread: supplement error handling for qmp_dump_guest_memory
>   qemu_thread: supplement error handling for pci_edu_realize
>   qemu_thread: supplement error handling for h_resize_hpt_prepare
>   qemu_thread: supplement error handling for emulated_realize
>   qemu_thread: supplement error handling for iothread_complete
>   qemu_thread: supplement error handling for qemu_signalfd_compat
>   qemu_thread: supplement error handling for migration
>   qemu_thread: supplement error handling for vnc_start_worker_thread
>   qemu_thread: supplement error handling for touch_all_pages

It is eleven patches.  However, I got only 01-07/11 with this cover
letter.  A later batch (no cover letter) has 07-11/11 and 07-09/11
again.

I could guess which of the duplicates I should review, but that's work.
Just resend the whole thing as v11, please.

[...]
