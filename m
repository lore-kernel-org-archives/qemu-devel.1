Received: from eggs.gnu.org ([2001:4830:134:3::10]:49354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e4TcJ-0005FQ-Gr
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e4TcI-0002cV-Jq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:17:15 -0400
Date: Tue, 17 Oct 2017 17:16:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171017151658.GD7660@dhcp-200-186.str.redhat.com>
References: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
	<20171017151149.28062-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017151149.28062-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/1] qemu-iotests: Test backing_fmt with
 backing node reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: pkrempa@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Am 17.10.2017 um 17:11 hat Kevin Wolf geschrieben:
> This changes test case 191 to include a backing image that has
> backing_fmt set in the image file, but is referenced by node name in the
> qemu command line.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/191     | 5 +++--
>  tests/qemu-iotests/191.out | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
> index ac2b88fd78..00202efd47 100755
> --- a/tests/qemu-iotests/191
> +++ b/tests/qemu-iotests/191
> @@ -56,9 +56,10 @@ echo === Preparing and starting VM ===
>  echo
>  
>  TEST_IMG="${TEST_IMG}.base" _make_test_img $size
> -TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
> +IMGOPTS=$(_optstr_add "$IMGOPTS" "backing_fmt=$IMGFMT") \
> +    TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base" $size
>  _make_test_img -b "${TEST_IMG}.mid"
> -TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
> +TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid" $size

Please pretend you don't see the addition of " $size" here, it's
unnecessary and I'll remove it again.

Kevin
