Received: from eggs.gnu.org ([2001:4830:134:3::10]:49069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOac-00067z-W3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOac-0005oP-6L
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:26:06 -0500
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <844e7b9e-52c5-cbdb-dc6c-a5974ce939c9@redhat.com>
Date: Fri, 9 Mar 2018 14:26:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180309172713.26318-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] qemu-iotests: Test luks QMP image
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>

On 03/09/2018 11:27 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/208       | 211 +++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/208.out   | 136 ++++++++++++++++++++++++++++
>   tests/qemu-iotests/common.rc |   2 +-
>   tests/qemu-iotests/group     |   1 +
>   4 files changed, 349 insertions(+), 1 deletion(-)
>   create mode 100755 tests/qemu-iotests/208
>   create mode 100644 tests/qemu-iotests/208.out

I've seen another patch using 208 - someone gets to renumber ;)

> +# creator
> +owner=kwolf@redhat.com
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1	# failure is the default!

Whatever happened to Jeff's efforts to reduce pointless boilerplate?


> +function do_run_qemu()
> +{
> +    echo Testing: "$@"
> +    $QEMU -nographic -qmp stdio -serial none "$@"

Is -nodefaults better than -serial none?

At any rate, my comments are trivial, whether or not you do something 
about them, so

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
