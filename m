Received: from eggs.gnu.org ([209.51.188.92]:35283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpQrX-00047z-Hu
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 23:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpQrU-0008FU-UO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 23:55:35 -0500
Received: from m50-112.126.com ([123.125.50.112]:33646)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpQrM-00087e-NJ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 23:55:29 -0500
References: <20190128141506.12731-1-lifei1214@126.com>
	<87womkvh1n.fsf@dusky.pond.sub.org>
From: Fei Li <lifei1214@126.com>
Message-ID: <5b4bb02b-875e-91a5-440f-c50a90d5b761@126.com>
Date: Fri, 1 Feb 2019 12:55:00 +0800
MIME-Version: 1.0
In-Reply-To: <87womkvh1n.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>


ÔÚ 2019/2/1 ÉÏÎç2:05, Markus Armbruster Ð´µÀ:
> I'm afraid you made a bit of a mess :)
>
> "[PATCH for-4.0 00/11]" suggests this is v1 of eleven patches.
Awkward, I forgot the v10.. =-O
>
> Fei Li <lifei1214@126.com> writes:
>
>> Hi,
>>
>> This idea comes from BiteSizedTasks, and this patch series implement
>> the error checking of qemu_thread_create: make qemu_thread_create
>> return a flag to indicate if it succeeded rather than failing with
>> an error; make all callers check it.
>>
>> The first patch modifies the qemu_thread_create() by passing
>> &error_abort and returing a value to indicate if it succeeds. The next
>> 10 patches will improve on &error_abort for callers who could handle
>> more properly.
>>
>> Please help to review, thanks a lot!
>>
>> v10:
>> - Make qemu_thread_create() return -errno instead of a Boolean.
>> - Add more cleanup for pci_edu_realize()/emulated_realize().
>> - Polish for iothread_complete()/compress_threads_save_cleanup()/
>>    vnc_start_worker_thread()/touch_all_pages.
>> - Change to return H_HARDWARE for h_resize_hpt_prepare().
>> - Remove five derivative patches as they have been merged.
> It's actually v10.
Yes.
>
> [...]
>> Fei Li (11):
>>    qemu_thread: make qemu_thread_create() take Error ** argument
>>    qemu_thread: supplement error handling for qemu_X_start_vcpu
>>    qemu_thread: supplement error handling for qmp_dump_guest_memory
>>    qemu_thread: supplement error handling for pci_edu_realize
>>    qemu_thread: supplement error handling for h_resize_hpt_prepare
>>    qemu_thread: supplement error handling for emulated_realize
>>    qemu_thread: supplement error handling for iothread_complete
>>    qemu_thread: supplement error handling for qemu_signalfd_compat
>>    qemu_thread: supplement error handling for migration
>>    qemu_thread: supplement error handling for vnc_start_worker_thread
>>    qemu_thread: supplement error handling for touch_all_pages
> It is eleven patches.  However, I got only 01-07/11 with this cover
> letter.  A later batch (no cover letter) has 07-11/11 and 07-09/11
> again.
>
> I could guess which of the duplicates I should review, but that's work.
> Just resend the whole thing as v11, please.

Ok, and sorry for the trouble.

Have a nice day, thanks
Fei
>
> [...]
