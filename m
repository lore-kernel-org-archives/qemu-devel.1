Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRKej-0005Uy-06
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRKed-0007Qx-7V
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:22:12 -0500
Date: Tue, 19 Dec 2017 16:21:57 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171219162157.GD3567@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1513700253-10045-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513700253-10045-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: Remove legacy "-mon default=on"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org

On Tue, Dec 19, 2017 at 05:17:33PM +0100, Thomas Huth wrote:
> The "default" parameter of the "-mon" option is useless since
> QEMU v2.4.0, and marked as deprecated since QEMU v2.8.0. That
> should have been long enough to let people update their scripts,
> so time to remove it now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  monitor.c     | 3 ---
>  qemu-doc.texi | 9 ---------
>  vl.c          | 4 ----
>  3 files changed, 16 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index e36fb53..e53c6e1 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4141,9 +4141,6 @@ QemuOptsList qemu_mon_opts = {
>              .name = "chardev",
>              .type = QEMU_OPT_STRING,
>          },{
> -            .name = "default",  /* deprecated */
> -            .type = QEMU_OPT_BOOL,
> -        },{
>              .name = "pretty",
>              .type = QEMU_OPT_BOOL,
>          },
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index d9861b3..6913b32 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2401,15 +2401,6 @@ setting ``-machine kernel_irqchip=off''.
>  The ``-no-kvm'' argument is now a synonym for setting
>  ``-machine accel=tcg''.
>  
> -@subsection -mon default=on (since 2.4.0)
> -
> -The ``default'' option to the ``-mon'' argument is
> -now ignored. When multiple monitors were enabled, it
> -indicated which monitor would receive log messages
> -from the various subsystems. This feature is no longer
> -required as messages are now only sent to the monitor
> -in response to explicitly monitor commands.
> -
>  @subsection -vnc tls (since 2.5.0)

It occurs to me that qemu.org only ever displays the very latest version
of the qemu-tech doc.

So if someone has deployed QEMU 2.11, and reads the doc online, once your
patches are commited, all the info about deprecated features that affect
their 2.11 version will have gone, despite 2.12 not yet existing. They'll
only find deprecation info in their locally installed doc. I think this
is pretty undesirable.

So rather than deleting entries from the deprecation appendix, should
we move them to a separate appendix, or "Formerly deprecated, now
deleted" features. Or just change the annotation

  (since 2.4.0)

to

  (deprecated since 2.4.0, deleted in 2.12.0)


same comment for all your patches deleting deprecated features.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
