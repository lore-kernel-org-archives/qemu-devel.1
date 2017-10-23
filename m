Received: from eggs.gnu.org ([2001:4830:134:3::10]:49966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6gAX-0004JY-KU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6gAS-0006VS-Nd
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:05:41 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e6gAS-0006V0-He
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:05:36 -0400
Received: by mail-wm0-x241.google.com with SMTP id u138so10855256wmu.5
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 10:05:36 -0700 (PDT)
Date: Mon, 23 Oct 2017 19:05:32 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171023170532.GA15029@stefanha-x1.localdomain>
References: <20171020112121.12321-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020112121.12321-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-pr-helper: Do not use {0} for
 initialization
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

On Fri, Oct 20, 2017 at 01:21:21PM +0200, Paolo Bonzini wrote:
> The first field in struct dm_ioctl is an array, and old GCC warns
> about it with -Wmissing-braces (GCC <= 4.8).  The "{0}" universal
> zero initializer is only useful if the other side might be a scalar;
> for a struct, "{}" is enough and shuts up the compiler.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scsi/qemu-pr-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
