Received: from eggs.gnu.org ([2001:4830:134:3::10]:55425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLtnJ-0006eJ-Ij
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLtnG-0006Fp-GY
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:40:37 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-23-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-23-mreitz@redhat.com>
Date: Mon, 04 Dec 2017 17:40:24 +0100
Message-ID: <w51po7u30qv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 22/25] block: Do not copy
 exact_filename from format file
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

On Mon 20 Nov 2017 09:10:01 PM CET, Max Reitz wrote:
> If the a format BDS's file BDS is in turn a format BDS, we cannot simply
> use the same filename, because when opening a BDS tree based on a
> filename alone, qemu will create only one format node on top of one
> protocol node (disregarding a potential backing file).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
