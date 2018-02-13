Received: from eggs.gnu.org ([2001:4830:134:3::10]:49420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elZl9-0003vb-0i
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elZl8-0001Fj-18
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:32:31 -0500
Date: Tue, 13 Feb 2018 13:32:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180213123217.GE5083@localhost.localdomain>
References: <cover.1517840876.git.berto@igalia.com>
	<bd3547b670b8d0af11480c760991a22bcae5b48c.1517840877.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd3547b670b8d0af11480c760991a22bcae5b48c.1517840877.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v4 37/39] iotests: Test valid values of
 l2-cache-entry-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Am 05.02.2018 um 15:33 hat Alberto Garcia geschrieben:
> The l2-cache-entry-size setting can only contain values that are
> powers of two between 512 and the cluster size.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/103     | 17 +++++++++++++++++
>  tests/qemu-iotests/103.out |  3 +++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
> index d0cfab8844..7a2ca22803 100755
> --- a/tests/qemu-iotests/103
> +++ b/tests/qemu-iotests/103
> @@ -66,6 +66,14 @@ $QEMU_IO -c "open -o cache-size=1M,refcount-cache-size=2M $TEST_IMG" 2>&1 \
>  $QEMU_IO -c "open -o cache-size=0,l2-cache-size=0,refcount-cache-size=0 $TEST_IMG" \
>      2>&1 | _filter_testdir | _filter_imgfmt
>  
> +# Invalid cache entry sizes
> +$QEMU_IO -c "open -o l2-cache-entry-size=256 $TEST_IMG" \
> +    2>&1 | _filter_testdir | _filter_imgfmt
> +$QEMU_IO -c "open -o l2-cache-entry-size=300 $TEST_IMG" \
> +    2>&1 | _filter_testdir | _filter_imgfmt

If you wanted to test non-power-of-two values here, it would be better
to use a value that isn't < 512 at the same time.

> +$QEMU_IO -c "open -o l2-cache-entry-size=128k $TEST_IMG" \
> +    2>&1 | _filter_testdir | _filter_imgfmt

Kevin
