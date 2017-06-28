Received: from eggs.gnu.org ([2001:4830:134:3::10]:50790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBCp-0003jv-8z
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBCm-0005Bg-29
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:32:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBCl-0005BJ-So
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:32:20 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170628111214.4ycvgzy4a53gt4tl@hz-desktop> (Haozhong Zhang's
	message of "Wed, 28 Jun 2017 19:12:14 +0800")
References: <20170628024358.29956-1-haozhong.zhang@intel.com>
	<87h8z07a2b.fsf@secure.mitica>
	<20170628111214.4ycvgzy4a53gt4tl@hz-desktop>
Reply-To: quintela@redhat.com
Date: Wed, 28 Jun 2017 13:32:14 +0200
Message-ID: <87wp7w5ow1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] exec: fix access to ram_list.dirty_memory
 when sync dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xiao Guangrong <xiaoguangrong@tencent.com>

Haozhong Zhang <haozhong.zhang@intel.com> wrote:
> On 06/28/17 11:09 +0200, Juan Quintela wrote:
>> Haozhong Zhang <haozhong.zhang@intel.com> wrote:
>> > In cpu_physical_memory_sync_dirty_bitmap(rb, start, ...), the 2nd
>> > argument 'start' is relative to the start of the ramblock 'rb'. When
>> > it's used to access the dirty memory bitmap of ram_list (i.e.
>> > ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]->blocks[]), an offset to
>> > the start of all RAM (i.e. rb->offset) should be added to it, which has
>> > however been missed since c/s 6b6712efcc. For a ramblock of host memory
>> > backend whose offset is not zero, cpu_physical_memory_sync_dirty_bitmap()
>> > synchronizes the incorrect part of the dirty memory bitmap of ram_list
>> > to the per ramblock dirty bitmap. As a result, a guest with host
>> > memory backend may crash after migration.
>> >
>> > Fix it by adding the offset of ramblock when accessing the dirty memory
>> > bitmap of ram_list in cpu_physical_memory_sync_dirty_bitmap().
>> >
>> > Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> 
>> 
>> Hi
>> 
>> I need to add this patch to make it compile for me with all
>> architectures enabled.
>> 
>> I am adding that to you patch, are you ok?
>>
>
> Remind me why your following patch is related to mine? My patch does
> not touch any vmstate.

O:-)

Because sometimes I got a bit sloppy.

Sorry.

Later, Juan.
