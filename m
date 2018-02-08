Received: from eggs.gnu.org ([2001:4830:134:3::10]:53116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejuzA-0007Zf-5N
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejuz9-0002qQ-Cu
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:48:08 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae3cfcd8-93b0-c1ce-14c0-3db3146cb873@redhat.com>
Date: Thu, 8 Feb 2018 16:48:02 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/27] block/qapi: Introduce
 BlockdevCreateOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> This creates a BlockdevCreateOptions union type that will contain all of
> the options for image creation. We'll start out with an empty struct
> type BlockdevCreateDummy for all drivers.

Name here...

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8225308904..b59b1430bb 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3338,6 +3338,67 @@
>   { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
>   
>   ##
> +# @BlockdevCreateNotSupported:

...should match what you use here.

With that obvious fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
