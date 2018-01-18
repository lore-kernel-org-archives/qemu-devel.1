Received: from eggs.gnu.org ([2001:4830:134:3::10]:50421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ecBSp-0005Jl-90
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ecBSm-0007jr-L0
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:46:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <65d05fd6-3ae6-ef57-7731-3f6ef99416d0@virtuozzo.com>
References: <cover.1513342045.git.berto@igalia.com>
	<192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
	<b4f7c92c-4690-6b0e-1a24-e320d9a9dace@virtuozzo.com>
	<w51inc01ofz.fsf@maestria.local.igalia.com>
	<65d05fd6-3ae6-ef57-7731-3f6ef99416d0@virtuozzo.com>
Date: Thu, 18 Jan 2018 15:46:39 +0100
Message-ID: <w513733ql68.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 17 Jan 2018 05:57:32 PM CET, Anton Nefedov wrote:
> On 17/1/2018 6:42 PM, Alberto Garcia wrote:
>> On Tue 16 Jan 2018 05:52:36 PM CET, Anton Nefedov wrote:
>>>
>>> Cosmetic: maybe this l2_load() better be merged with the copied L2 case?
>>> e.g.
>>>
>>>     if (!(l1_table[l1_index] & COPIED))
>>>       l2_allocate();
>>>     l2_load();
>> 
>> I'm not sure about that, since there's also the qcow2_free_clusters()
>> call afterwards, so the final code might be harder to follow.
>
> actually shouldn't qcow2_free_clusters() be done before l2_load()?
> Otherwise we bail out on error and leak space.

Good catch, I think that you're right. I'll fix that.

Berto
