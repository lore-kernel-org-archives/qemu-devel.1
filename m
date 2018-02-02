Received: from eggs.gnu.org ([2001:4830:134:3::10]:56055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdHJ-00076r-Uf
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdGF-00075J-Mu
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:29:25 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <06131f65-28d8-44fb-ee96-2d8e78fe4b3c@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<896a464d5933927db49c968682de8c2b6e59635f.1516978645.git.berto@igalia.com>
	<06131f65-28d8-44fb-ee96-2d8e78fe4b3c@redhat.com>
Date: Fri, 02 Feb 2018 11:10:27 +0100
Message-ID: <w51lggbzoq4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 31/39] qcow2: Update qcow2_truncate() to
 support L2 slices
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

On Thu 01 Feb 2018 08:46:46 PM CET, Max Reitz <mreitz@redhat.com> wrote:
>> @@ -3261,8 +3261,9 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
>>          guest_offset = old_length;
>>          while (nb_new_data_clusters) {
>>              int64_t guest_cluster = guest_offset >> s->cluster_bits;
>> -            int64_t nb_clusters = MIN(nb_new_data_clusters,
>> -                                      s->l2_size - guest_cluster % s->l2_size);
>> +            int64_t nb_clusters = MIN(
>> +                nb_new_data_clusters,
>> +                s->l2_slice_size - guest_cluster % s->l2_slice_size);
>
> An alternative would be the
> "s->l2_slice_size - offset_to_l2_slice_index(s, guest_offset)" we
> basically have elsewhere, but that's longer and doesn't really matter:

It's a bit longer but it looks better and we can get rid of
guest_cluster, so I think I'll change it.

Berto
