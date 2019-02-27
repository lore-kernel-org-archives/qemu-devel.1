Received: from eggs.gnu.org ([209.51.188.92]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gywcQ-0000lX-Q4
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gywcO-0005U8-S1
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:39:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gywcM-0005QU-VU
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:39:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so17321109wrt.11
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 02:39:13 -0800 (PST)
Date: Wed, 27 Feb 2019 11:39:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190227103908.xao5xy7ryx47ndeo@steredhat>
References: <20190227012132.16271-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227012132.16271-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH] Allow -sandbox off with --disable-seccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: otubo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, Feb 27, 2019 at 12:21:32PM +1100, David Gibson wrote:
> At present, when seccomp support is compiled out with --disable-seccomp
> we fail with an error if the user puts -sandbox on the command line.
> 
> That kind of makes sense, but it's a bit strange that we reject a request
> to disable sandboxing with "-sandbox off" saying we don't support
> sandboxing.
> 
> This puts in a small sandbox to (correctly) silently ignore -sandbox off
> when we don't have sandboxing support compiled in.  This makes life easier
> for testcases, since they can safely specify "-sandbox off" without having
> to care if the qemu they're using is compiled with sandbox support or not.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  vl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
