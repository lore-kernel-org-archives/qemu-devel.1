Received: from eggs.gnu.org ([2001:4830:134:3::10]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKFMc-0006YT-8f
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKFMb-0006i4-Fa
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:18:14 -0500
Date: Thu, 30 Nov 2017 11:18:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130031803.GL16237@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-9-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123020832.8165-9-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/17] iotests: Skip 103 for refcount_bits=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Thu, 11/23 03:08, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/103 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
> index ecbd8ebd71..d0cfab8844 100755
> --- a/tests/qemu-iotests/103
> +++ b/tests/qemu-iotests/103
> @@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file nfs
>  _supported_os Linux
> +# Internal snapshots are (currently) impossible with refcount_bits=1
> +_unsupported_imgopts 'refcount_bits=1[^0-9]'

What is the "[^0-9]" part for?

Fam
