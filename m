Received: from eggs.gnu.org ([2001:4830:134:3::10]:54035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhrC-0005j5-VP
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhr8-0007Gi-2Y
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:27:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOhr7-0007Fu-SQ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:27:37 -0500
Message-ID: <1483519725.5670.44.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Jan 2017 09:48:45 +0100
In-Reply-To: <87bmw2vgvy.fsf@mail.parknet.co.jp>
References: <87bmw2vgvy.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] ui/gtk: Fix mouse wheel on 3.4.0 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: qemu-devel@nongnu.org

> +#if GTK_CHECK_VERSION(3, 4, 0)
> +    } else if (scroll->direction =3D=3D GDK_SCROLL_SMOOTH) {
> +        gdouble delta_x, delta_y;
> +        if (!gdk_event_get_scroll_deltas((GdkEvent*)scroll, &delta_x, &d=
elta_y))
> +            return TRUE;
> +        if (delta_y > 0)
> +            btn =3D INPUT_BUTTON_WHEEL_DOWN;
> +        else
> +            btn =3D INPUT_BUTTON_WHEEL_UP;
> +#endif

Patch looks good, except for some codestyle issues:

=3D=3D=3D checkpatch complains =3D=3D=3D
ERROR: "(foo*)" should be "(foo *)"
#13: FILE: ui/gtk.c:1024:
+        if (!gdk_event_get_scroll_deltas((GdkEvent*)scroll, &delta_x,
&delta_y))

ERROR: braces {} are necessary for all arms of this statement
#13: FILE: ui/gtk.c:1024:
+        if (!gdk_event_get_scroll_deltas((GdkEvent*)scroll, &delta_x,
&delta_y))
[...]

ERROR: braces {} are necessary for all arms of this statement
#15: FILE: ui/gtk.c:1026:
+        if (delta_y > 0)
[...]
+        else
[...]

total: 3 errors, 0 warnings, 16 lines checked

cheers,
  Gerd
