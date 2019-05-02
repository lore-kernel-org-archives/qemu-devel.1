Received: from eggs.gnu.org ([209.51.188.92]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM9hB-0003Dm-3h
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM9hA-0004xP-8s
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:16:09 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hM9h9-0004wo-E2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:16:07 -0400
Received: by mail-wr1-f48.google.com with SMTP id a9so2776193wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 04:16:07 -0700 (PDT)
Date: Thu, 2 May 2019 13:16:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190502111603.wwf2lpymrhx76x6g@steredhat>
References: <20190501134127.21104-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501134127.21104-1-thuth@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests/qemu-iotests: Fix more
 reference output files due to recent qemu-io change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, May 01, 2019 at 03:41:27PM +0200, Thomas Huth wrote:
> The output of qemu-io changed recently - most tests have been fixed in
> commit 36b9986b08787019ef42 ("tests/qemu-iotests: Fix output of qemu-io
> related tests") already, but the qcow1 and the vmdk test was still missing.
> 
> Fixes: 99e98d7c9fc1a1639fad ("qemu-io: Use error_[gs]et_progname()")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/059.out |  8 ++++----
>  tests/qemu-iotests/092.out | 24 ++++++++++++------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
