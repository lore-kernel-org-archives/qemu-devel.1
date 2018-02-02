Received: from eggs.gnu.org ([208.118.235.92]:56841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdM3-0003AW-4t
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdG9-0006yj-1P
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:29:19 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <376f5dc1-6d47-5f47-713f-487712482cb0@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<395d808b99997ca8718bba951c5a2eebe6794650.1516978645.git.berto@igalia.com>
	<376f5dc1-6d47-5f47-713f-487712482cb0@redhat.com>
Date: Fri, 02 Feb 2018 10:46:28 +0100
Message-ID: <w51shajzpu3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 24/39] qcow2: Update discard_single_l2()
 to support L2 slices
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

On Thu 01 Feb 2018 08:07:15 PM CET, Max Reitz <mreitz@redhat.com> wrote:
> On 2018-01-26 15:59, Alberto Garcia wrote:
>> discard_single_l2() limits the number of clusters to be discarded to
>> the amount that fits inside an L2 table. Since we'll be loading L2
>> slices instead of full tables we need to update that limit.
>
> Hmmmm, maybe rename the function to discard_l2_slice() or
> discard_in_l2_slice() or discard_all_in_l2_slice() or
> discard_single_l2_slice()?

Good idea, I think I that will change that (also the related comment in
qcow2_cluster_discard()).

Berto
