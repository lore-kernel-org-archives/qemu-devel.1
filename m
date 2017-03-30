Received: from eggs.gnu.org ([2001:4830:134:3::10]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaXe-0002o1-FU
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaXd-0000cJ-3R
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:45404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctaXc-0000bA-Qr
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctaXc-0000kC-1i
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:55:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 096DD2E8043
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:55:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2017 13:40:29 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1571084 <1571084@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160415205455.23997.28010.malonedeb@gac.canonical.com>
Message-Id: <20170330134031.26275.99740.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1571084] Re: Qemu 2.x dont build on last Gtk dev
 3.0+
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1571084

Title:
  Qemu 2.x dont build on last Gtk dev 3.0+

Status in QEMU:
  Fix Released

Bug description:
  here the build exit

  ui/gtk.c: In function =E2=80=98gd_mouse_set=E2=80=99:
  ui/gtk.c:479:5: error: =E2=80=98gdk_display_get_device_manager=E2=80=99 i=
s deprecated: Use 'gdk_display_get_default_seat' instead [-Werror=3Ddepreca=
ted-declarations]
       mgr =3D gdk_display_get_device_manager(dpy);
       ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:170:20: note: declared here
   GdkDeviceManager * gdk_display_get_device_manager (GdkDisplay *display);
                      ^
  ui/gtk.c:482:5: error: =E2=80=98gdk_device_manager_get_client_pointer=E2=
=80=99 is deprecated [-Werror=3Ddeprecated-declarations]
       gdk_device_warp(gdk_device_manager_get_client_pointer(mgr),
       ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:32:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdevicemanager.h:44:14: note: declared h=
ere
   GdkDevice *  gdk_device_manager_get_client_pointer (GdkDeviceManager *de=
vice_manager);
                ^
  ui/gtk.c: In function =E2=80=98gd_grab_devices=E2=80=99:
  ui/gtk.c:1316:5: error: =E2=80=98gdk_display_get_device_manager=E2=80=99 =
is deprecated: Use 'gdk_display_get_default_seat' instead [-Werror=3Ddeprec=
ated-declarations]
       GdkDeviceManager *mgr =3D gdk_display_get_device_manager(display);
       ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:170:20: note: declared here
   GdkDeviceManager * gdk_display_get_device_manager (GdkDisplay *display);
                      ^
  ui/gtk.c:1317:5: error: =E2=80=98gdk_device_manager_list_devices=E2=80=99=
 is deprecated [-Werror=3Ddeprecated-declarations]
       GList *devs =3D gdk_device_manager_list_devices(mgr, GDK_DEVICE_TYPE=
_MASTER);
       ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:32:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdevicemanager.h:41:14: note: declared h=
ere
   GList *      gdk_device_manager_list_devices       (GdkDeviceManager *de=
vice_manager,
                ^
  ui/gtk.c:1327:13: error: =E2=80=98gdk_device_grab=E2=80=99 is deprecated:=
 Use 'gdk_seat_grab' instead [-Werror=3Ddeprecated-declarations]
               gdk_device_grab(dev, win, GDK_OWNERSHIP_NONE, FALSE,
               ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkdnd.h:33:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkevents.h:34,
                   from /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdevice.h:250:15: note: declared here
   GdkGrabStatus gdk_device_grab        (GdkDevice        *device,
                 ^
  ui/gtk.c:1330:13: error: =E2=80=98gdk_device_ungrab=E2=80=99 is deprecate=
d: Use 'gdk_seat_ungrab' instead [-Werror=3Ddeprecated-declarations]
               gdk_device_ungrab(dev, GDK_CURRENT_TIME);
               ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkdnd.h:33:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkevents.h:34,
                   from /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdevice.h:259:15: note: declared here
   void          gdk_device_ungrab      (GdkDevice        *device,
                 ^
  ui/gtk.c: In function =E2=80=98gd_grab_pointer=E2=80=99:
  ui/gtk.c:1392:5: error: =E2=80=98gdk_display_get_device_manager=E2=80=99 =
is deprecated: Use 'gdk_display_get_default_seat' instead [-Werror=3Ddeprec=
ated-declarations]
       GdkDeviceManager *mgr =3D gdk_display_get_device_manager(display);
       ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:170:20: note: declared here
   GdkDeviceManager * gdk_display_get_device_manager (GdkDisplay *display);
                      ^
  ui/gtk.c:1400:5: error: =E2=80=98gdk_device_manager_get_client_pointer=E2=
=80=99 is deprecated [-Werror=3Ddeprecated-declarations]
       gdk_device_get_position(gdk_device_manager_get_client_pointer(mgr),
       ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:32:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdevicemanager.h:44:14: note: declared h=
ere
   GdkDevice *  gdk_device_manager_get_client_pointer (GdkDeviceManager *de=
vice_manager);
                ^
  ui/gtk.c: In function =E2=80=98gd_ungrab_pointer=E2=80=99:
  ui/gtk.c:1432:5: error: =E2=80=98gdk_display_get_device_manager=E2=80=99 =
is deprecated: Use 'gdk_display_get_default_seat' instead [-Werror=3Ddeprec=
ated-declarations]
       GdkDeviceManager *mgr =3D gdk_display_get_device_manager(display);
       ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:170:20: note: declared here
   GdkDeviceManager * gdk_display_get_device_manager (GdkDisplay *display);
                      ^
  ui/gtk.c:1434:5: error: =E2=80=98gdk_device_manager_get_client_pointer=E2=
=80=99 is deprecated [-Werror=3Ddeprecated-declarations]
       gdk_device_warp(gdk_device_manager_get_client_pointer(mgr),
       ^
  In file included from /usr/local/include/gtk-3.0/gdk/gdkdisplay.h:32:0,
                   from /usr/local/include/gtk-3.0/gdk/gdkscreen.h:32,
                   from /usr/local/include/gtk-3.0/gdk/gdkapplaunchcontext.=
h:31,
                   from /usr/local/include/gtk-3.0/gdk/gdk.h:32,
                   from /usr/local/include/gtk-3.0/gtk/gtk.h:30,
                   from /home/amigaone/src/qemu/include/ui/gtk.h:9,
                   from ui/gtk.c:42:
  /usr/local/include/gtk-3.0/gdk/gdkdevicemanager.h:44:14: note: declared h=
ere
   GdkDevice *  gdk_device_manager_get_client_pointer (GdkDeviceManager *de=
vice_manager);
                ^

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1571084/+subscriptions
