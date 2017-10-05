Received: from eggs.gnu.org ([2001:4830:134:3::10]:42704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e07LE-0006d3-0C
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e07L8-0008J6-Dk
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:41:36 -0400
Date: Thu, 5 Oct 2017 10:41:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171005144119.GG10969@stefanha-x1.localdomain>
References: <20171004014347.25099-1-eblake@redhat.com>
	<20171004014347.25099-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004014347.25099-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] iotests: Add test 197 for covering
 copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Oct 03, 2017 at 08:43:47PM -0500, Eric Blake wrote:
> Add a test for qcow2 copy-on-read behavior, including exposure
> for the just-fixed bugs.
> 
> The copy-on-read behavior is always to a qcow2 image, but the
> test is careful to allow running with most image protocol/format
> combos as the backing file being copied from (luks being the
> exception, as it is harder to pass the right secret to all the
> right places).  In fact, for './check nbd', this appears to be
> the first time we've had a qcow2 image wrapping NBD, requiring
> an additional line in _filter_img_create to match the similar
> line in _filter_img_info.
> 
> Invoking blkdebug to prove we don't write too much took some
> effort to get working; and it requires that $TEST_WRAP (based
> on $TEST_DIR) not be subject to word splitting.  We may decide
> later to have the entire iotests suite use relative rather than
> absolute names, to avoid problems inherited by the absolute
> name of $PWD or $TEST_DIR, at which point the sanity check in
> this commit could be simplified.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: test 0-length query [Kevin], sanity check TEST_DIR [Jeff]
> 
> I only tested with -raw, -qcow2, -qed, and -nbd. I won't be
> surprised if the test fails in some other setup...
> ---
>  tests/qemu-iotests/common.filter |   1 +
>  tests/qemu-iotests/197           | 102 +++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/197.out       |  26 ++++++++++
>  tests/qemu-iotests/group         |   1 +
>  4 files changed, 130 insertions(+)
>  create mode 100755 tests/qemu-iotests/197
>  create mode 100644 tests/qemu-iotests/197.out

Aside from the 2GB request issue:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
