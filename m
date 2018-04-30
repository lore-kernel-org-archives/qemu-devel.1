Received: from eggs.gnu.org ([2001:4830:134:3::10]:55245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBuX-0006lc-DX
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBuW-0006B3-L2
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:44:21 -0400
References: <20180428144123.30333-1-mreitz@redhat.com>
	<20180428144123.30333-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9482f2c-31a8-9d94-9e02-357eb1c1d3d8@redhat.com>
Date: Mon, 30 Apr 2018 11:44:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180428144123.30333-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] iotests: Let 216 make use of qemu-io's
 exit code
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

On 04/28/2018 09:41 AM, Max Reitz wrote:
> As a showcase of how you can use qemu-io's exit code to determine
> success or failure (same for qemu-img), this test is changed to use
> qemu_io_silent() instead of qemu_io(), and to assert the exit code
> instead of logging the filtered result.
> 
> One real advantage of this is that in case of an error, you get a
> backtrace that helps you locate the issue in the test file quickly.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/216     | 23 ++++++++++++-----------
>   tests/qemu-iotests/216.out | 17 ++---------------
>   2 files changed, 14 insertions(+), 26 deletions(-)

> -    qemu_img_pipe('create', '-f', iotests.imgfmt, base_img_path, '64M')
> +    assert qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M') == 0

Yeah, I can see how writing the setup for a test gets simpler when you 
don't have to worry about logging and filtering the stuff that isn't the 
heart of the test.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
