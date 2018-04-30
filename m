Received: from eggs.gnu.org ([2001:4830:134:3::10]:45343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBFp-0001sO-HA
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBFo-0003mC-No
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:02:17 -0400
References: <20180428163442.6238-1-mreitz@redhat.com>
	<20180428163442.6238-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2529cb3-1ef0-3608-0b91-18026e523a46@redhat.com>
Date: Mon, 30 Apr 2018 11:01:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180428163442.6238-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Repairing error during
 snapshot deletion
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

On 04/28/2018 11:34 AM, Max Reitz wrote:
> This adds a test for an I/O error during snapshot deletion, and maybe
> more importantly, for how to repair the resulting image.  If the
> snapshot has been deleted before the error occurs, the only negative
> result will be leaked clusters -- and those should be repairable with
> qemu-img check -r leaks.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/217     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/217.out | 42 ++++++++++++++++++++++
>   tests/qemu-iotests/group   |  1 +
>   3 files changed, 132 insertions(+)
>   create mode 100755 tests/qemu-iotests/217
>   create mode 100644 tests/qemu-iotests/217.out
> 

> +
> +# Internal snapshots are (currently) impossible with refcount_bits=1
> +_unsupported_imgopts 'refcount_bits=1[^0-9]'
> +

And even if they are made possible (by cloning clusters instead of 
incrementing refcounts), you STILL need a refcount > 1 to test the 
particular repair functionality just fixed.

Up to you if you want to reword that comment a bit.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
