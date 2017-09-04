Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1donSi-00006S-HE
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1donSh-0001q2-M8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:14:32 -0400
Date: Mon, 4 Sep 2017 11:14:15 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170904091415.wgsuqx67y3il7hnd@eukaryote>
References: <20170901105434.3288-1-berrange@redhat.com>
	<20170901105434.3288-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901105434.3288-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] iotests: blacklist 194
 with the luks driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Sep 01, 2017 at 11:54:34AM +0100, Daniel P. Berrange wrote:
> The 194 test has alot of code that assumes a simple image file. Rewriting
> this to work with luks is possible, but non-trivial, so blacklist the
> luks format for now.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/194        | 1 +
>  tests/qemu-iotests/iotests.py | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
> index a3e3bad664..bfe1859ecf 100755
> --- a/tests/qemu-iotests/194
> +++ b/tests/qemu-iotests/194
> @@ -23,6 +23,7 @@ import os
>  import atexit
>  import iotests
>  
> +iotests.verify_image_format(unsupported_fmts=['luks'])
>  iotests.verify_platform(['linux'])
>  
>  img_size = '1G'
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 7233983f3c..3e7304b678 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -395,9 +395,11 @@ def notrun(reason):
>      print '%s not run: %s' % (seq, reason)
>      sys.exit(0)
>  
> -def verify_image_format(supported_fmts=[]):
> +def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
>      if supported_fmts and (imgfmt not in supported_fmts):
>          notrun('not suitable for this image format: %s' % imgfmt)
> +    if unsupported_fmts and (imgfmt in unsupported_fmts):
> +        notrun('not suitable for this image format: %s' % imgfmt)
>  
>  def verify_platform(supported_oses=['linux']):
>      if True not in [sys.platform.startswith(x) for x in supported_oses]:
> -- 
> 2.13.5
> 
> 

-- 
/kashyap
