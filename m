Received: from eggs.gnu.org ([2001:4830:134:3::10]:55777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1vl8-0006Ee-Ro
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1vl5-0003DW-LJ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:43:50 -0400
Date: Tue, 10 Oct 2017 15:43:37 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171010144337.GG30015@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171009150231.GN2954@redhat.com>
	<20171010102418.13487-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171010102418.13487-1-anthony.perard@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] ui/gtk: Fix deprecation of
 vte_terminal_copy_clipboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Oct 10, 2017 at 11:24:18AM +0100, Anthony PERARD wrote:
> vte_terminal_copy_clipboard() is deprecated in VTE 0.50.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  ui/gtk.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 5bd87c265a..342e96fbe9 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1702,7 +1702,12 @@ static void gd_menu_copy(GtkMenuItem *item, void *opaque)
>      GtkDisplayState *s = opaque;
>      VirtualConsole *vc = gd_vc_find_current(s);
>  
> +#if VTE_CHECK_VERSION(0, 50, 0)
> +    vte_terminal_copy_clipboard_format(VTE_TERMINAL(vc->vte.terminal),
> +                                       VTE_FORMAT_TEXT);
> +#else
>      vte_terminal_copy_clipboard(VTE_TERMINAL(vc->vte.terminal));
> +#endif
>  }
>  
>  static void gd_vc_adjustment_changed(GtkAdjustment *adjustment, void *opaque)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
