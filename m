Received: from eggs.gnu.org ([2001:4830:134:3::10]:47153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1e95bT-0006Fy-L6
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1e95bS-0000gb-Oc
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:39:27 -0400
Date: Mon, 30 Oct 2017 09:39:16 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171030083916.z5bglhjeiabfeoy5@eukaryote>
References: <20171029125338.25988-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171029125338.25988-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Use -nographic in 182
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Sun, Oct 29, 2017 at 01:53:38PM +0100, Kevin Wolf wrote:
> This avoids that random UI frontend error messages end up in the output.
> In particular, we were seeing this line in CI error logs:
> 
> +Unable to init server: Could not connect: Connection refused
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/182 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
> index 2e078ceed8..4b31592fb8 100755
> --- a/tests/qemu-iotests/182
> +++ b/tests/qemu-iotests/182
> @@ -62,7 +62,7 @@ _launch_qemu -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
>  
>  echo
>  echo "Starting a second QEMU using the same image should fail"
> -echo 'quit' | $QEMU -monitor stdio \
> +echo 'quit' | $QEMU -nographic -monitor stdio \

Isn't "-display none" preferred instead of "-nographic"?

Assuming you'll change it to "-display none":

    Reviewed-by: Kashyap CHamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap
