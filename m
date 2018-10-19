Received: from eggs.gnu.org ([2001:4830:134:3::10]:42807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDQYO-00055t-4F
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDQYK-0006c4-PE
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:54:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gDQYK-0006aB-DN
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:54:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A34E230BB344
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:54:39 +0000 (UTC)
References: <1539886203-33670-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7e01d8d-82ad-69e9-6e72-3da7c1badb00@redhat.com>
Date: Fri, 19 Oct 2018 10:54:30 +0200
MIME-Version: 1.0
In-Reply-To: <1539886203-33670-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: famz@redhat.com, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 2018-10-18 20:10, Paolo Bonzini wrote:
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

Fixes: 89d85cde75143325205e332dd97bf1bb8402d7c1

Reviewed-by: Thomas Huth <thuth@redhat.com>
