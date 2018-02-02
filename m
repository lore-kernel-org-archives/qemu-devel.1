Received: from eggs.gnu.org ([208.118.235.92]:55059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdL3-0002HM-17
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdGE-000743-GR
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:16 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <4c401bce-cdc8-9c70-7d16-c101ef72e291@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
	<4c401bce-cdc8-9c70-7d16-c101ef72e291@redhat.com>
Date: Fri, 02 Feb 2018 10:56:32 +0100
Message-ID: <w51o9l7zpdb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 27/39] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Thu 01 Feb 2018 08:26:26 PM CET, Max Reitz <mreitz@redhat.com> wrote:
>> @@ -1273,12 +1276,13 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
>>                      case QCOW2_CLUSTER_NORMAL:
>>                      case QCOW2_CLUSTER_ZERO_ALLOC:
>>                          if (offset_into_cluster(s, offset)) {
>> +                            int l2_index = slice * s->l2_slice_size + j;
>>                              qcow2_signal_corruption(
>>                                  bs, true, -1, -1, "Cluster "
>>                                  "allocation offset %#" PRIx64
>>                                  " unaligned (L2 offset: %#"
>>                                  PRIx64 ", L2 index: %#x)",
>> -                                offset, l2_offset, j);
>> +                                offset, l2_offset, l2_index);
>
> This makes it a bit weird that in other patches l2_index is now
> generally the L2 slice index...

You're right, I can call it l2_table_index, I think this is the only
case where it does not refer to the slice index.

Berto
