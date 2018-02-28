Received: from eggs.gnu.org ([2001:4830:134:3::10]:33120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1er0hF-0000ii-1z
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1er0hA-0002mf-7c
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:18:57 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180227162944.17343-3-eblake@redhat.com>
References: <20180227155514.16721-1-eblake@redhat.com>
	<20180227162944.17343-3-eblake@redhat.com>
Date: Wed, 28 Feb 2018 13:18:48 +0100
Message-ID: <w51sh9lpas7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/5] qcow2: Reduce REFT_OFFSET_MASK
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

On Tue 27 Feb 2018 05:29:42 PM CET, Eric Blake wrote:
> Match our code to the spec change in the previous patch - there's
> no reason for the refcount table to allow larger offsets than the
> L1/L2 tables. In practice, no image has more than 64PB of
> allocated clusters anyways, as anything beyond that can't be
> expressed via L2 mappings to host offsets.
>
> Suggested-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
