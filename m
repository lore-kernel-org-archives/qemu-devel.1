Received: from eggs.gnu.org ([209.51.188.92]:46795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hJyTe-0003d3-L7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hJyTd-0003Tv-Ej
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:53:10 -0400
Date: Fri, 26 Apr 2019 12:53:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190426105301.GA20769@localhost.localdomain>
References: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
Subject: Re: [Qemu-devel] Failing qemu-iotest 005 with raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, hch@lst.de

Am 26.04.2019 um 11:41 hat Thomas Huth geschrieben:
> 
> When running iotest 005 with raw, the test currently fails for me:
> 
> 005         - output mismatch (see 005.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/005.out	2019-04-23
> 16:43:11.000000000 +0200
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/005.out.bad	2019-04-26
> 11:34:11.000000000 +0200
> @@ -1,13 +1,12 @@
>  QA output created by 005
> 
>  creating large image
> +qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file
> format 'IMGFMT'
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=5368709120000
> [...]
> 
> Could this be fixed somehow, or should the test rather be skipped for
> IMGFMT=raw?

The test passes for me on XFS. Looks like the raw driver can handle
large image files, but your host filesystem can't.

We would have to check whether the host filesystem can support large
files and skip the test if it can't. I'm not sure how to do that. But
actually, this isn't testing anything interesting for raw, so just
unconditionally disabling the test for raw could be reasonable enough.

Kevin
