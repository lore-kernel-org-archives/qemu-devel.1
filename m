Received: from eggs.gnu.org ([2001:4830:134:3::10]:36686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cb7he-0004JF-Pu
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cb7hY-00084J-Pd
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:29:10 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170127094154.19778-1-berto@igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5370d078-6f29-3d56-635b-5871a6b95983@redhat.com>
Date: Tue, 7 Feb 2017 16:28:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170127094154.19778-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Clarify that -vga std is now the
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org



On 27/01/2017 10:41, Alberto Garcia wrote:
> The QEMU manual page states that Cirrus Logic is the default video
> card if the user doesn't specify any. However this is not true since
> QEMU 2.2.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 80df52651a..66ee562821 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1195,12 +1195,12 @@ Select type of VGA card to emulate. Valid values for @var{type} are
>  Cirrus Logic GD5446 Video card. All Windows versions starting from
>  Windows 95 should recognize and use this graphic card. For optimal
>  performances, use 16 bit color depth in the guest and the host OS.
> -(This one is the default)
> +(This card was the default before QEMU 2.2)
>  @item std
>  Standard VGA card with Bochs VBE extensions.  If your guest OS
>  supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if you want
>  to use high resolution modes (>= 1280x1024x16) then you should use
> -this option.
> +this option. (This card is the default since QEMU 2.2)
>  @item vmware
>  VMWare SVGA-II compatible adapter. Use it if you have sufficiently
>  recent XFree86/XOrg server or Windows guest with a driver for this
> 

Queued, thanks.

Paolo
