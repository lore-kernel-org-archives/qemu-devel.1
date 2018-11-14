Received: from eggs.gnu.org ([2001:4830:134:3::10]:60824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMpKK-0000wd-E9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 02:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMpKH-0007Kt-4R
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 02:11:04 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <bf4041ab-7288-53fc-055c-1c7c7a607d42@redhat.com>
References: <20181113164544.9906-1-berto@igalia.com>
	<bf4041ab-7288-53fc-055c-1c7c7a607d42@redhat.com>
Date: Wed, 14 Nov 2018 08:10:47 +0100
Message-ID: <w51wopgjfrc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for 3.1? PATCH] qcow2: Assert that refcount block
 offsets fit in the refcount table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue 13 Nov 2018 06:06:54 PM CET, Eric Blake <eblake@redhat.com> wrote:

>> Refcount table entries have a field to store the offset of the
>> refcount block. The rest of the bits of the entry are currently
>> reserved.
>> 
>> The offset is always taken from the entry using REFT_OFFSET_MASK to
>> ensure that we only use the bits that belong to that field.
>> 
>> While that mask is used every time we read from the refcount table, it
>> is never used when we write to it. Due to the other constraints of the
>> qcow2 format QEMU can never produce refcount block offsets that don't
>> fit in that field so any such offset when allocating a refcount block
>> would indicate a bug in QEMU.
>> ---
>>   block/qcow2-refcount.c | 3 +++
>>   1 file changed, 3 insertions(+)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Yes, for 3.1, shall I resend it with the updated subject message?

Berto
