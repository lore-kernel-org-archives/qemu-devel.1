Received: from eggs.gnu.org ([2001:4830:134:3::10]:40097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxXmU-0008L1-6P
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxXmT-00039F-Ek
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:23:38 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-26-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-26-mreitz@redhat.com>
Date: Wed, 05 Sep 2018 15:23:30 +0200
Message-ID: <w515zzkt6wd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 25/31] block: Do not copy
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:22 PM CEST, Max Reitz wrote:
> If a format BDS's file BDS is in turn a format BDS, we cannot simply use
> the same filename, because when opening a BDS tree based on a filename
> alone, qemu will create only one format node on top of one protocol node
> (disregarding a potential backing file).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
