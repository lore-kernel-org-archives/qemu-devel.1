Received: from eggs.gnu.org ([2001:4830:134:3::10]:58360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqywE-0002nm-Pq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqywB-00066k-LC
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:26:18 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180227162944.17343-2-eblake@redhat.com>
References: <20180227155514.16721-1-eblake@redhat.com>
	<20180227162944.17343-2-eblake@redhat.com>
Date: Wed, 28 Feb 2018 11:26:11 +0100
Message-ID: <w51vaehpfzw.fsf@maestria.local.igalia.com>
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

On Tue 27 Feb 2018 05:29:41 PM CET, Eric Blake wrote:
> +The refcount table has implications on the maximum host file size; a
> +larger cluster size is required for the refcount table to cover
> larger +offsets.

Why is this? Because of the refcount_table_clusters field ?

I think the maximum offset allowed by that is ridiculously high,
exceeding any other limit imposed by the L1/L2 tables.

If my numbers are right, with the default values that's 64 ZB.

In addition to that, the size that can be covered by the refcount table
also depends on the size of refcount entries (refcount_order).

With 512 byte clusters and 64 bit refcount entries I still get 8 PB, way
over what's limited by the L1/L2 tables (128 GB).

Berto
