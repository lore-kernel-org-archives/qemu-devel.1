Received: from eggs.gnu.org ([2001:4830:134:3::10]:41882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fcueo-0005vH-FL
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fcuen-0005Y7-LI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:34:26 -0400
References: <20180710093802.28308-1-famz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fd182f4f-3205-2683-bbb7-eca3b0972609@redhat.com>
Date: Tue, 10 Jul 2018 11:34:16 -0400
MIME-Version: 1.0
In-Reply-To: <20180710093802.28308-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: 222: Don't run with luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/10/2018 05:38 AM, Fam Zheng wrote:
> Luks needs special parameters to operate the image. Since this test is
> focusing on image fleecing, skip skip that format.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/222 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
> index ff3bfc1470..0ead56d574 100644
> --- a/tests/qemu-iotests/222
> +++ b/tests/qemu-iotests/222
> @@ -25,6 +25,8 @@ import iotests
>  from iotests import log, qemu_img, qemu_io, qemu_io_silent
>  
>  iotests.verify_platform(['linux'])
> +iotests.verify_image_format(supported_fmts=['qcow2', 'qcow', 'qed', 'vmdk',
> +                                            'vhdx', 'raw'])
>  
>  patterns = [("0x5d", "0",         "64k"),
>              ("0xd5", "1M",        "64k"),
> 

Ah; do we not have a nicer way to exclude just one format? Evidently not.

Apologies for breaking LUKS.

--js
