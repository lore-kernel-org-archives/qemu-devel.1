Received: from eggs.gnu.org ([2001:4830:134:3::10]:42738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9VMU-0003I3-2r
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9VMP-0001rq-4j
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:09:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-13-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-13-mreitz@redhat.com>
Date: Tue, 31 Oct 2017 13:09:23 +0100
Message-ID: <w51k1zbldsc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 12/25] quorum: Make bdrv_dirname()
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

On Fri 29 Sep 2017 06:53:34 PM CEST, Max Reitz wrote:
> While the common implementation for bdrv_dirname() should return NULL
> for quorum BDSs already (because they do not have a file node and their
> exact_filename field should be empty), there is no reason not to make
> that explicit.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
