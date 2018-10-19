Received: from eggs.gnu.org ([2001:4830:134:3::10]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDRNd-0001Om-U5
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDRNa-000579-H7
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:47:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDRNa-00055x-Ao
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:47:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so3074828wmt.2
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 02:47:38 -0700 (PDT)
References: <1539886203-33670-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c85602f6-c794-d81b-98c7-a1db9618dbaf@redhat.com>
Date: Fri, 19 Oct 2018 11:47:35 +0200
MIME-Version: 1.0
In-Reply-To: <1539886203-33670-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: docker: update test-mingw for GTK+
 2.0 removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 18/10/2018 20:10, Paolo Bonzini wrote:
> --with-gtkabi does not exist anymore; remove it from the configure invocation.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/test-mingw | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
> index 7cca7e1..b078f22 100755
> --- a/tests/docker/test-mingw
> +++ b/tests/docker/test-mingw
> @@ -28,8 +28,7 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
>          --enable-vnc \
>          --enable-bzip2 \
>          --enable-guest-agent \
> -        --with-sdlabi=2.0 \
> -        --with-gtkabi=3.0
> +        --with-sdlabi=2.0
>      install_qemu
>      make clean
>  
> 

$ ./configure ...
C compiler        i686-w64-mingw32.shared-gcc
SDL support       yes (2.0.5)
GTK support       no
GTK GL support    no
mingw32 support   yes

$ make
...
  LINK    arm-softmmu/qemu-system-armw.exe
  GEN     arm-softmmu/qemu-system-arm.exe

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
