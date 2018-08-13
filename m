Received: from eggs.gnu.org ([2001:4830:134:3::10]:38047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpDgq-0004b3-GZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpDgk-000682-QA
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:19:24 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180813010729.4844-4-lbloch@janustech.com>
References: <20180813010729.4844-1-lbloch@janustech.com>
	<20180813010729.4844-4-lbloch@janustech.com>
Date: Mon, 13 Aug 2018 16:19:15 +0200
Message-ID: <w51pnym73j0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 3/8] qcow2: Avoid duplication in setting
 the refcount cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon 13 Aug 2018 03:07:24 AM CEST, Leonid Bloch wrote:
> The refcount cache size does not need to be set to its minimum value in
> read_cache_sizes(), as it is set to at least its minimum value in
> qcow2_update_options_prepare().
>
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
