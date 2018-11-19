Received: from eggs.gnu.org ([2001:4830:134:3::10]:47481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gOgg2-00079f-WF
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gOgVe-0001Ip-8y
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:10:26 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181116164526.31487-3-mreitz@redhat.com>
References: <20181116164526.31487-1-mreitz@redhat.com>
	<20181116164526.31487-3-mreitz@redhat.com>
Date: Mon, 19 Nov 2018 11:10:19 +0100
Message-ID: <w51k1l9z8c4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1? v2 2/3] file-posix: Fix shared
 locks on reopen commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri 16 Nov 2018 05:45:25 PM CET, Max Reitz <mreitz@redhat.com> wrote:
> s->locked_shared_perm is the set of bits locked in the file, which is
> the inverse of the permissions actually shared.  So we need to pass them
> as they are to raw_apply_lock_bytes() instead of inverting them again.
>
> Reported-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
