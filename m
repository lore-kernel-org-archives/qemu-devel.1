Received: from eggs.gnu.org ([2001:4830:134:3::10]:46424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcNe-0006Ap-AE
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcNb-0003DH-8m
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:00:18 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmcNb-0003D5-2g
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:00:15 -0400
Received: by mail-wm0-x241.google.com with SMTP id l19so3007588wmi.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:00:14 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:00:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829090012.GB25960@stefanha-x1.localdomain>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
	<20170828015654.2530-2-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-2-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 01/14] hvf: add support for
 Hypervisor.framework in the configure script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Aug 27, 2017 at 08:56:41PM -0500, Sergio Andres Gomez Del Real wrote:
> @@ -3619,6 +3619,16 @@ applicable to MAC and Windows platform, and thus does not conflict with
>  KVM.
>  ETEXI
>  
> +DEF("enable-hvf", 0, QEMU_OPTION_enable_hvf, \
> +    "-enable-hvf     enable Hypervisor.framework virtualization support\n", QEMU_ARCH_I386)
> +STEXI
> +@item -enable-hvf
> +@findex -enable-hvf
> +Enable Hypervisor.framework support. This option is only available if
> +HVF support is enabled when compiling. HVF is only applicable to MAC
> +platform, and thus does not conflict with KVM.
> +ETEXI

-enable-$ACCEL is a legacy option.  The preferred syntax is -M accel=$ACCL.

There's no need to add -enable-hvf, please remove it in the next
revision of this patch.  Users that want hvf should use the modern -M
accel=hvf syntax.

Besides this:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
