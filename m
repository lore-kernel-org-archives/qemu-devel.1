Received: from eggs.gnu.org ([2001:4830:134:3::10]:58262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbFm-0007Cy-Nr
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbFl-0000pB-VP
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:51:58 -0400
Date: Mon, 23 Jul 2018 15:51:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180723135147.GE8817@localhost.localdomain>
References: <20180713173721.14915-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713173721.14915-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: remove LUKS support from test
 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 13.07.2018 um 19:37 hat John Snow geschrieben:
> This test doesn't actually care about the format anyway, it just
> supports "all formats" as a convenience. LUKS however does not use a
> simple image filename which confuses this iotest.
> 
> We can simply skip the test for formats that use IMGOPTSSYNTAX for
> their filenames without missing much coverage.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Thanks, applied to the block branch.

Kevin
