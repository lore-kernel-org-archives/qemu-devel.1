Received: from eggs.gnu.org ([2001:4830:134:3::10]:46054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eIFqU-0005um-7o
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eIFqR-0005Pg-1u
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:24:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eIFqQ-0005P8-RX
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:24:46 -0500
Date: Fri, 24 Nov 2017 16:24:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171124152439.GB4010@localhost.localdomain>
References: <20171124085351.26386-1-famz@redhat.com>
	<20171124085351.26386-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124085351.26386-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qemu-options: Mention locking
 option of file driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Philipp Hahn <hahn@univention.de>, mreitz@redhat.com

Am 24.11.2017 um 09:53 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-options.hx | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3728e9b4dd..f10c2a3ddb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -693,6 +693,10 @@ This is the protocol-level block driver for accessing regular files.
>  The path to the image file in the local filesystem
>  @item aio
>  Specifies the AIO backend (threads/native, default: threads)
> +@item locking
> +Specifies whether the image file is protected with Linux OFD / POSIX locks. The
> +default is to use the Linux Open File Descriptor API if avaiable, otherwise no

s/avaiable/available/

I'll fix this while applying.

> +lock is applied.  (auto/on/off, default: auto)
>  @end table
>  Example:
>  @example

Kevin
