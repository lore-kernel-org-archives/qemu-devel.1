Received: from eggs.gnu.org ([2001:4830:134:3::10]:38947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPZVx-000102-Fv
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPZVw-00067e-IZ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:17:37 -0400
References: <20170621131157.16584-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bb5dec50-75bc-e7bb-5fb2-290e8d0f4afe@redhat.com>
Date: Mon, 26 Jun 2017 15:17:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170621131157.16584-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: 181 does not work
 for all formats
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



On 06/21/2017 09:11 AM, Max Reitz wrote:
> Test 181 only works for formats which support live migration (naturally,
> as it is a live migration test). Disable it for all formats which do
> not.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/181 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
> index e969a2a..f73ad5a 100755
> --- a/tests/qemu-iotests/181
> +++ b/tests/qemu-iotests/181
> @@ -43,6 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.qemu
>  
>  _supported_fmt generic
> +# Formats that do not support live migration
> +_unsupported_fmt qcow vdi vhdx vmdk vpc vvfat
>  _supported_proto generic
>  _supported_os Linux
>  
> 

Does this come up elsewhere in iotests? I guess not often enough to
justify some macro like formats_unmigratable.

Eh.

Reviewed-by: John Snow <jsnow@redhat.com>
