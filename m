Received: from eggs.gnu.org ([2001:4830:134:3::10]:58937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eKpZ6-00041W-Jm
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eKpZ5-0004uy-Ua
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:57:32 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-4-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-4-mreitz@redhat.com>
Date: Fri, 01 Dec 2017 16:18:04 +0100
Message-ID: <w51efoe79zn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 03/25] block: Add
 BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Mon 20 Nov 2017 09:09:42 PM CET, Max Reitz wrote:
> If the backing file is overridden, this most probably does change the
> guest-visible data of a BDS. Therefore, we will need to consider this in
> bdrv_refresh_filename().
>
> Adding a new field to the BDS is not nice, but it is very simple and
> exactly keeps track of whether the backing file has been overridden.
>
> This commit adds a FIXME which will be remedied by a follow-up commit.
> Until then, the respective piece of code will not result in any behavior
> that is worse than what we currently have.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
