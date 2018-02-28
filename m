Received: from eggs.gnu.org ([2001:4830:134:3::10]:60539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1er2bn-0001Nw-08
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1er2bj-0008ED-PQ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:21:26 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <89477aaf-a1af-861d-fcd5-5bfe2143f8b8@redhat.com>
References: <20180227155514.16721-1-eblake@redhat.com>
	<20180227162944.17343-2-eblake@redhat.com>
	<w51vaehpfzw.fsf@maestria.local.igalia.com>
	<89477aaf-a1af-861d-fcd5-5bfe2143f8b8@redhat.com>
Date: Wed, 28 Feb 2018 15:20:44 +0100
Message-ID: <w51po4pp54z.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

On Wed 28 Feb 2018 03:01:33 PM CET, Eric Blake wrote:

>>> The refcount table has implications on the maximum host file size; a
>>> larger cluster size is required for the refcount table to cover
>>> larger offsets.
>> 
>> Why is this? Because of the refcount_table_clusters field ?
>> 
>> I think the maximum offset allowed by that is ridiculously high,
>> exceeding any other limit imposed by the L1/L2 tables.
   [...]
>> With 512 byte clusters and 64 bit refcount entries I still get 8 PB,
>> way over what's limited by the L1/L2 tables (128 GB).
>
> Do I need to make any modifications to the sentence, then?

I guess what surprised me the first time that I read it was that it
suggests that this has to be taken into account when calculating the
physical limits of an image, while in practice it can be ignored.

You could say something like 

  Although the larger the cluster size, the larger the offsets that can
  be covered by the refcount table, in practice these limits cannot be
  reached because they are larger than the ones imposed by other data
  structures.

although I'm sure that you can come up with a better wording than mine :)

Berto
