Received: from eggs.gnu.org ([2001:4830:134:3::10]:59979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3M9m-0008Fr-IV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3M9l-0004lQ-OV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:34:54 -0400
Date: Wed, 26 Apr 2017 14:34:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170426123441.GD4538@noname.str.redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-14-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426033413.17192-14-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 13/21] iotests: 091: Quit QEMU before
 checking image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/091 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
> index 32bbd56..10ac4a8 100755
> --- a/tests/qemu-iotests/091
> +++ b/tests/qemu-iotests/091
> @@ -95,7 +95,9 @@ echo "vm2: qemu process running successfully"
>  echo "vm2: flush io, and quit"
>  _send_qemu_cmd $h2 'qemu-io disk flush' "(qemu)"
>  _send_qemu_cmd $h2 'quit' ""
> +_send_qemu_cmd $h1 'quit' ""
>  
> +wait

I think it's better to use the function from common.qemu for this:

    wait=1 _cleanup_qemu

Kevin
