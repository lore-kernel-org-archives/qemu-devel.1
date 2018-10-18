Received: from eggs.gnu.org ([2001:4830:134:3::10]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gD823-0000yf-Hn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gD822-0007XH-Nx
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:08:07 -0400
Date: Thu, 18 Oct 2018 15:07:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181018130755.GC4946@localhost.localdomain>
References: <cover.1539852875.git.berto@igalia.com>
	<b5ca9aac2a1ed2cd054b6ceaa821533904cbce68.1539852875.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ca9aac2a1ed2cd054b6ceaa821533904cbce68.1539852875.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotest: Test x-blockdev-change on a
 Quorum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 18.10.2018 um 10:59 hat Alberto Garcia geschrieben:
> This patch tests that you can add and remove drives from a Quorum
> using the x-blockdev-change command.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

> --- a/tests/qemu-iotests/081
> +++ b/tests/qemu-iotests/081
> @@ -198,6 +198,92 @@ quorum="$quorum,file.children.2.driver=raw"
>  
>  $QEMU_IO -c "open -o $quorum" | _filter_qemu_io
>  
> +echo
> +echo "== dinamically adding a child to a quorum =="

s/dinamically/dynamically/ (and in three more instances)

Thanks, fixed the typo and applied the series to the block branch.

Kevin
