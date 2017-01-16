Received: from eggs.gnu.org ([2001:4830:134:3::10]:53353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT6NG-0002RB-8k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT6NF-0003uT-Dm
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:26:58 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170115203014.GA12068@var.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54d064db-076e-b3cc-f151-3c4e74163121@redhat.com>
Date: Mon, 16 Jan 2017 13:26:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170115203014.GA12068@var.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Drop duplicate display option documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Cc: qemu-trivial@nongnu.org

On 15/01/2017 21:30, Samuel Thibault wrote:
> The curses and none possibilities are already documented on a separate line,
> so documenting it on the sdl line was both unneeded and confusing.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c534a2f7f9..9c81d3752d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -927,7 +927,7 @@ ETEXI
>  
>  DEF("display", HAS_ARG, QEMU_OPTION_display,
>      "-display sdl[,frame=on|off][,alt_grab=on|off][,ctrl_grab=on|off]\n"
> -    "            [,window_close=on|off][,gl=on|off]|curses|none|\n"
> +    "            [,window_close=on|off][,gl=on|off]\n"
>      "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
>      "-display vnc=<display>[,<optargs>]\n"
>      "-display curses\n"
> 
> 
