Received: from eggs.gnu.org ([2001:4830:134:3::10]:46565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIzv-0005sJ-Ca
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIzt-0002dW-Jm
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:29:03 -0500
References: <20181206192544.3987-1-jsnow@redhat.com>
	<20181206192544.3987-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99292902-c7bd-7f1f-0a5d-72894c83dd93@redhat.com>
Date: Fri, 7 Dec 2018 10:28:51 -0600
MIME-Version: 1.0
In-Reply-To: <20181206192544.3987-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] block: remove 'x' prefix from
 experimental bitmap APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

On 12/6/18 1:25 PM, John Snow wrote:
> The 'x' prefix was added because we were uncertain of the direction we'd
> take for the libvirt API. With the general approach solidified, I feel
> comfortable committing to this API for 4.0.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> +++ b/tests/qemu-iotests/223
> @@ -112,9 +112,9 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabilities"}' "return"
>   _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
>     "arguments":{"driver":"qcow2", "node-name":"n",
>       "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
> -_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
>     "arguments":{"node":"n", "name":"b"}}' "return"
> -_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
>     "arguments":{"node":"n", "name":"b2"}}' "return"
>   _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
>     "arguments":{"addr":{"type":"unix",

No iotests coverage of block-dirty-bitmap-merge.  We should fix that as 
part of this series; separate patch is fine.

I'm glad you remembered to renumber all the 'since' tags to 4.0 (as the 
new spelling is indeed new to 4.0, not when we introduced the older x- 
variant).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
