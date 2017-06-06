Received: from eggs.gnu.org ([2001:4830:134:3::10]:40556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dICQe-0003KK-A1
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dICQd-0005ZB-L2
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:13:40 -0400
Date: Tue, 6 Jun 2017 13:13:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170606111331.GA5448@noname.redhat.com>
References: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] block/qcow.c: Fix memory leak in
 qcow_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 05.06.2017 um 15:55 hat Peter Maydell geschrieben:
> Coverity points out that the code path in qcow_create() for
> the magic "fat:" backing file name leaks the memory used to
> store the filename (CID 1307771). Free the memory before
> we overwrite the pointer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, applied to the block branch.

Kevin
