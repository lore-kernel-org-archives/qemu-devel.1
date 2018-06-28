Received: from eggs.gnu.org ([2001:4830:134:3::10]:40529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYbN1-0002wF-Qz
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYbN0-0006D5-DH
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:10:15 -0400
References: <20180628180042.3881-1-jsnow@redhat.com>
	<20180628180042.3881-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c807689d-be3e-d343-925b-112ade12ad57@redhat.com>
Date: Thu, 28 Jun 2018 13:10:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180628180042.3881-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: add 222 to test basic
 fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 06/28/2018 01:00 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/222     | 149 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/222.out |  60 ++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 210 insertions(+)
>   create mode 100644 tests/qemu-iotests/222
>   create mode 100644 tests/qemu-iotests/222.out
> 

> +
> +    log('')
> +    log('--- Cleanup ---')
> +    log('')
> +
> +    #log(vm.hmp_qemu_io(srcNode, 'flush'))
> +    log(vm.qmp('block-job-cancel', device=srcNode))

Is the commented line still worthwhile to keep?

> +    log(vm.qmp('nbd-server-stop'))
> +    log(vm.qmp('blockdev-del', node_name=tgtNode))
> +    vm.shutdown()
> +
> +    log('')
> +    log('--- Confirming writes ---')
> +    log('')
> +
> +    for p in (overwrite + remainder):
> +        cmd = "read -P%s %s %s" % p
> +        log(cmd)
> +        assert qemu_io_silent(base_img_path, '-c', cmd) == 0
> +

Thanks for the additions compared to v1 (including the previously 
missing .out file ;)
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
