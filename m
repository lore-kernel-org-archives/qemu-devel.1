Received: from eggs.gnu.org ([2001:4830:134:3::10]:33451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9Uzo-0003wv-J1
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9Uzj-0003N5-NY
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:46:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-12-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-12-mreitz@redhat.com>
Date: Tue, 31 Oct 2017 12:45:57 +0100
Message-ID: <w51mv47leve.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 11/25] blkverify: Make bdrv_dirname()
 return NULL
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

On Fri 29 Sep 2017 06:53:33 PM CEST, Max Reitz wrote:
> blkverify's BDSs have a file BDS, but we do not want this to be
> preferred over the raw node. There is no way to decide between the two
> (and not really a reason to, either), so just return NULL in blkverify's
> implementation of bdrv_dirname().
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
