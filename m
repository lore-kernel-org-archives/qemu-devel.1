Received: from eggs.gnu.org ([209.51.188.92]:46597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwUX8-000260-5f
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwUX6-00026G-4l
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:15:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gwUX5-0001gs-B5
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:15:39 -0500
Date: Wed, 20 Feb 2019 16:15:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190220161508.GN21870@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1550678735-25394-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1550678735-25394-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui/gtk: Fix the license information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>

On Wed, Feb 20, 2019 at 05:05:35PM +0100, Thomas Huth wrote:
> The license information in this file is very messy. A short note at
> the beginning says GPL first, but the long boilerplate code then
> talks about "GNU Lesser General Public License version 2.0". First,
> there is no such version of the "GNU Lesser GPL", it only started with
> version 2.1. In version 2.0, it was still called "GNU Library GPL"
> instead. Second, you can easily get the license of this file wrong
> if you only quickly glance at the long boilerplate code.
> 
> Anyway, looking at the text of the LGPL (see COPYING.LIB in the top
> directory), the license clearly states in section "3." that one should
> rather replace the license information with the GPL information in
> such a case of a mixture instead. Thus let's clean up the confusing
> statements and use the proper GPL text only.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  ui/gtk.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 949b143..af7e5b2 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -6,9 +6,6 @@
>   * Authors:
>   *  Anthony Liguori   <aliguori@us.ibm.com>
>   *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.

This part of the header was describing the license of the QEMU originated
code for gtk.c

> - *
>   * Portions from gtk-vnc:
>   *
>   * GTK VNC Widget
> @@ -16,19 +13,18 @@
>   * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
>   * Copyright (C) 2009-2010 Daniel P. Berrange <dan@berrange.com>
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2.0 of the License, or (at your option) any later version.
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> + * General Public License for more details.
>   *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.

while this part of the header was describing the license of the original
GTK-VNC code that was copied into this file.

Changing this text is not correct, because now it no longer describes
the original gtk-vnc license.

If you want to change this file you'll need the main license text for
QEMU further up, *before* the line starting "Portions from gtk-vnc:"

The bit about GTK-VNC could reasonably be simplified to

    "Portions taken from gtk-vnc under the terms of the GNU
     Lesser General Public License 2.1 or later."


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
