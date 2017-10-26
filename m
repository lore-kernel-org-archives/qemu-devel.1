Received: from eggs.gnu.org ([2001:4830:134:3::10]:40832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e7gqS-0004gO-I8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e7gqR-0004GH-Va
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:01:08 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-6-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-6-mreitz@redhat.com>
Date: Thu, 26 Oct 2017 14:00:21 +0200
Message-ID: <w51y3ny15m2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 05/25] block: Make path_combine() return
 the path
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

On Fri 29 Sep 2017 06:53:27 PM CEST, Max Reitz wrote:
> Besides being safe for arbitrary path lengths, after some follow-up
> patches all callers will want a freshly allocated buffer anyway.
>
> In the meantime, path_combine_deprecated() is added which has the same
> interface as path_combine() had before this patch. All callers to that
> function will be converted in follow-up patches.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
