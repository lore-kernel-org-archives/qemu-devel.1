Received: from eggs.gnu.org ([209.51.188.92]:39050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwkge-00008z-Ni
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwkgd-0001Sl-Nz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:30:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gwkgd-0001RX-Cc
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:30:35 -0500
Date: Thu, 21 Feb 2019 09:30:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190221093022.GD17899@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1550731902-28842-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1550731902-28842-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ui/gtk: Fix the license information
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

On Thu, Feb 21, 2019 at 07:51:42AM +0100, Thomas Huth wrote:
> The license information in this file is very messy. A short note at
> the beginning says GPL first, but the long boilerplate code then
> talks about "GNU Lesser General Public License version 2.0". First,
> there is no such version of the "GNU Lesser GPL", it only started with
> version 2.1. In version 2.0, it was still called "GNU Library GPL"
> instead. Second, you can easily get the license of this file wrong
> if you only quickly glance at the long boilerplate code.
>=20
> Anyway, looking at the text of the LGPL (see COPYING.LIB in the top
> directory), the license clearly states in section "3." that one should
> rather replace the license information with the GPL information in
> such a case of a mixture instead. Thus let's clean up the confusing
> statements and use the proper GPL text only.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Move the boilerplate code to the top
>=20
>  ui/gtk.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>=20
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 949b143..ff505ae 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -6,29 +6,25 @@
>   * Authors:
>   *  Anthony Liguori   <aliguori@us.ibm.com>
>   *
> - * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> - * See the COPYING file in the top-level directory.
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - * Portions from gtk-vnc:
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> + *
> + * Portions from gtk-vnc (originally licensed under the LGPL v2):

s/v2/v2+/

With that fixed

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
