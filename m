Received: from eggs.gnu.org ([209.51.188.92]:46762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHNff-00062e-Ff
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 03:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHNfe-0001ho-Gd
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 03:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hHNfe-0001hQ-7Z
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 03:10:50 -0400
References: <20190418224706.14014-1-programmingkidx@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
Date: Fri, 19 Apr 2019 09:10:46 +0200
MIME-Version: 1.0
In-Reply-To: <20190418224706.14014-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

On 19/04/2019 00.47, John Arbuckle wrote:
> Capstone is not necessary in order to use QEMU. Disable it by default.
> This will save the user the pain of having to figure why QEMU isn't
> building when this library is missing.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a7027..77d7967f92 100755
> --- a/configure
> +++ b/configure
> @@ -433,7 +433,7 @@ opengl_dmabuf="no"
>  cpuid_h="no"
>  avx2_opt=""
>  zlib="yes"
> -capstone=""
> +capstone="no"
>  lzo=""
>  snappy=""
>  bzip2=""

AFAIK we ship capstone as a submodule, so how can this be missing? Also,
our philosophy is to keep everything enabled by default if possible, so
that the code paths don't bitrot. Thus I don't think that disabling this
by default is a good idea. ... so if you've got a problem here, there
must be another solution (e.g. is the system capstone detection not
working right on your system?).

 Thomas
