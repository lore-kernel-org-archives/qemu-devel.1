Received: from eggs.gnu.org ([2001:4830:134:3::10]:58424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3cI8-0008PO-IL
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3cI3-0006zK-MU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:53:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3cI3-0006z5-HA
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:53:03 -0400
Date: Wed, 4 Apr 2018 14:52:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180404065252.GC12052@lemon.usersys.redhat.com>
References: <20180326090350.30014-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326090350.30014-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: Inline "prep_fail" in run script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, 03/26 17:03, Fam Zheng wrote:
> We don't source common.rc where prep_fail is defined, so spell out the
> commands and do what was intended.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/run | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/run b/tests/docker/run
> index 9dd362bb98..7aebf4b569 100755
> --- a/tests/docker/run
> +++ b/tests/docker/run
> @@ -29,7 +29,7 @@ export TEST_DIR=/tmp/qemu-test
>  mkdir -p $TEST_DIR/{src,build,install}
>  
>  # Extract the source tarballs
> -tar -C $TEST_DIR/src -xf $BASE/qemu.tar || prep_fail "Failed to untar source"
> +tar -C $TEST_DIR/src -xf $BASE/qemu.tar || { echo "Failed to untar source"; exit 2; }
>  if test -f $TEST_DIR/src/Makefile; then
>      export FEATURES="$FEATURES dtc"
>  fi
> -- 
> 2.14.3
> 

Queued, thanks!

Fam
