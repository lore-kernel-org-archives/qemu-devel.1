Received: from eggs.gnu.org ([2001:4830:134:3::10]:36924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1driU2-0006d4-RT
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1driU1-0001gx-Ve
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:31:58 -0400
Date: Tue, 12 Sep 2017 12:31:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170912103148.GE29136@localhost.localdomain>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170809215510.22802-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/12] qemu-iotests: limit
 non-_PROG-suffixed variables to common.rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 09.08.2017 um 23:55 hat Paolo Bonzini geschrieben:
> These are never used by "check", with one exception that does not need
> $QEMU_OPTIONS.  Keep them in common.rc, which will be soon included only
> by the tests.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
> index 50720f080f..f58e56fc40 100644
> --- a/tests/qemu-iotests/common
> +++ b/tests/qemu-iotests/common
> @@ -454,11 +454,3 @@ fi
>  #
>  list=`sort $tmp.list`
>  rm -f $tmp.list $tmp.tmp $tmp.sed
> -
> -[ "$QEMU" = "" ] && _fatal "qemu not found"
> -[ "$QEMU_IMG" = "" ] && _fatal "qemu-img not found"
> -[ "$QEMU_IO" = "" ] && _fatal "qemu-io not found"
> -
> -if [ "$IMGPROTO" = "nbd" ] ; then
> -    [ "$QEMU_NBD" = "" ] && _fatal "qemu-nbd not found"
> -fi

Hm, does this mean that instead of ./check failing when a binary is
missing, we try each test case now and each one fails with the same
error message?

*tries it out*

Okay, it's already broken today because the strings are never empty but
contain the name of the wrapper functions, but it's still bad behaviour.
Instead of just telling me that the binary is missing like it used to
work, I get tons of test case diffs.

Kevin
