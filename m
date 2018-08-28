Received: from eggs.gnu.org ([2001:4830:134:3::10]:58163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fufEy-0004W6-5J
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fufEx-0007pW-FE
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:45:08 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-31-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-31-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 16:44:58 +0200
Message-ID: <w51sh2yr1n9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 30/31] block: BDS options may
 lack the "driver" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:27 PM CEST, Max Reitz wrote:
> When BDSs are created by qemu itself (e.g. as filters in block jobs),
> they may not have a "driver" option in their options QDict.  When
> generating a json:{} filename, however, it must always be present.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
