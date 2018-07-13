Received: from eggs.gnu.org ([2001:4830:134:3::10]:36193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fe4SI-0000Kz-40
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 16:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fe4SH-00036x-Bh
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 16:14:18 -0400
References: <20180713194100.7511-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4347078d-5854-ac6e-f0cd-7512cbd9f419@redhat.com>
Date: Fri, 13 Jul 2018 16:14:11 -0400
MIME-Version: 1.0
In-Reply-To: <20180713194100.7511-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotest: Fix filtering order in 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 07/13/2018 03:41 PM, Max Reitz wrote:
> The test directory should be filtered before the image format, otherwise
> the test will fail if the image format is part of the test directory,
> like so:
> 
> [...]
> -can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
> +can't open: Could not open '/tmp/test-IMGFMT/t.IMGFMT': Is a directory
> [...]
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Too many gotchas in our test suite.

Thanks :(

Reviewed-by: John Snow <jsnow@redhat.com>
