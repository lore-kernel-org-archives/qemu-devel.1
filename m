Received: from eggs.gnu.org ([2001:4830:134:3::10]:58857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f72C2-0002wn-SF
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 13:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f72C1-0005qH-Ve
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 13:08:58 -0400
References: <20180227155514.16721-1-eblake@redhat.com>
	<20180227162944.17343-2-eblake@redhat.com>
	<w51vaehpfzw.fsf@maestria.local.igalia.com>
	<89477aaf-a1af-861d-fcd5-5bfe2143f8b8@redhat.com>
	<w51po4pp54z.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f1d1c403-1a2a-aee2-5fe6-7cfbb81339d6@redhat.com>
Date: Fri, 13 Apr 2018 19:08:40 +0200
MIME-Version: 1.0
In-Reply-To: <w51po4pp54z.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

On 2018-02-28 15:20, Alberto Garcia wrote:
> On Wed 28 Feb 2018 03:01:33 PM CET, Eric Blake wrote:
> 
>>>> The refcount table has implications on the maximum host file size; a
>>>> larger cluster size is required for the refcount table to cover
>>>> larger offsets.
>>>
>>> Why is this? Because of the refcount_table_clusters field ?
>>>
>>> I think the maximum offset allowed by that is ridiculously high,
>>> exceeding any other limit imposed by the L1/L2 tables.
>    [...]
>>> With 512 byte clusters and 64 bit refcount entries I still get 8 PB,
>>> way over what's limited by the L1/L2 tables (128 GB).
>>
>> Do I need to make any modifications to the sentence, then?
> 
> I guess what surprised me the first time that I read it was that it
> suggests that this has to be taken into account when calculating the
> physical limits of an image, while in practice it can be ignored.
> 
> You could say something like 
> 
>   Although the larger the cluster size, the larger the offsets that can
>   be covered by the refcount table, in practice these limits cannot be
>   reached because they are larger than the ones imposed by other data
>   structures.

Are there any updates here?  I guess I personally would just drop the
whole paragraph, because I think it really doesn't matter...

Also note that the maximum file size of ext4 is 16 PB (for 4 kB blocks).
 OK, it's bigger for XFS, but that still gives some perspective.

Also, long before anyone is going to complain about the specification
failing to mention that limit, they are going to complain that qemu
refuses to open their image (because of its limit on the reftable size).

Max

> although I'm sure that you can come up with a better wording than mine :)
> 
> Berto
> 
