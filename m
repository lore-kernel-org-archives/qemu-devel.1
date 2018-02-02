Received: from eggs.gnu.org ([2001:4830:134:3::10]:56003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdHH-00074j-4N
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdGD-00072i-7m
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:29:23 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <df7822e9-025c-75b0-6139-e958dab0e745@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<6799e51bdf50179b3632adf20c768cf22c260e8c.1516978645.git.berto@igalia.com>
	<df7822e9-025c-75b0-6139-e958dab0e745@redhat.com>
Date: Fri, 02 Feb 2018 10:43:12 +0100
Message-ID: <w51vaffzpzj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 21/39] qcow2: Update
 qcow2_alloc_cluster_link_l2() to support L2 slices
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

On Thu 01 Feb 2018 07:44:56 PM CET, Max Reitz <mreitz@redhat.com> wrote:
> On 2018-01-26 15:59, Alberto Garcia wrote:
>> There's a loop in this function that iterates over the L2 entries in a
>> table, so now we need to assert that it remains within the limits of
>> an L2 slice.
>> 
>> Apart from that, this function doesn't need any additional changes, so
>> this patch simply updates the variable name from l2_table to l2_slice.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block/qcow2-cluster.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> Hm, well, strictly speaking this patch should not be at this point in
> this series -- e.g. handle_alloc() so far only limits its nb_clusters to
> the L2 size, not the L2 slice size.

Yeah, I didn't try to be too strict with this because you can only
change the slice size after everything else is ready.

Berto
