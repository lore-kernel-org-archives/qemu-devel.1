Received: from eggs.gnu.org ([2001:4830:134:3::10]:46680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gEZo4-0001y6-Kw
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gEZny-0000gj-3H
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gEZnn-0000VS-Ks
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:59:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3809369C9
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:59:14 +0000 (UTC)
Date: Mon, 22 Oct 2018 20:59:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181022125911.GB11958@magic>
References: <1539886203-33670-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539886203-33670-1-git-send-email-pbonzini@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 10/18 20:10, Paolo Bonzini wrote:
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
> -- 
> 1.8.3.1
> 

Queued, thanks.

Fam
