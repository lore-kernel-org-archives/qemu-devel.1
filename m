Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBEFC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C4721741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ox722N3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C4721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Nnq-0003aa-Nd
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 05:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@web.de>) id 1j0Nky-00028x-SR
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1j0Nkx-0007R5-Iv
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:54:36 -0500
Received: from mout.web.de ([217.72.192.78]:39503)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1j0Nkx-0007Qw-6q
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581159268;
 bh=sYfdE61c9jgFzKD+slSRh/oTjHvfI2uPfM8W0Q9MQs0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Ox722N3HRxasP0+q9L4uyRAOi8FNleCCPu3n5uxcJ8kkDyU9l0GHl4JY/LURM9uUT
 mEaGBq/srKLS5HLnX5fr9a3EY+pJoSnQkEcqX1yELN56JgV/A2YWXLWYzIoBfhqXNu
 YDlEa51LLjSkLt/FyfdxzSILsBvLg2fp4kelvG88=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEeC-1il0c00GOe-00FWFj; Sat, 08
 Feb 2020 11:54:28 +0100
Subject: Re: [PATCH] ui/gtk: Get display refresh rate with GDK version 3.22 or
 later
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200116011217.2144-1-philmd@redhat.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <00874860-5ec7-505f-db6a-57f9cc6cae0f@web.de>
Date: Sat, 8 Feb 2020 11:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116011217.2144-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cDbkb4yiIOFxeLmiM6MaChTGaqZYSKvDGwAB5JaNa0lY4vvt3ES
 NT1bYiMBpoVyspfh90cvtcYl30hhNVC/5P+aZYOtK6UBIiooy5x4cSqdvu1EH7AWwAr1cGw
 K58YyUCbXVYsLBvTPQ14TGFCMzV2DwR1uJEuSshlhCtX8DdDa9ekRznuSrKPFDAoOrzGfOO
 kwcVwer8COWEKEot2DCgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5HNe4TCZx4I=:XEKoUMHv5VkXK/9grrgUoA
 b0INJluYfK34s1XQkoNeWl1pOrQBSBqk2ebzDHl8GqWOoaRj0nEbKR5Enl0Odk+QI7jf6V5TM
 R3IqPD5khviKBxZ8cdTKoiaMUDgPCFeFUXscKefTzvYBK0e2sbZl3iXkSccKK4DAuY3twEAJf
 lbwzjNpE7STa9MhE+TeHT61AVatMROiakPYSSc55TD/UMCU3sU22prMZ8rz6GwWP6wGcoqviV
 g3IoabIQqgRL+J2x1ijdlVR3axUogCJNdxL3t69lYArwa6gMzprZr68Nj9cTHfGUw/2DXXvL+
 u3QdcuGwwqK+1gwWxEozHV7YZvYZQT0dNAv3amC9kjF7HACanHOV20H6d8BtXkiD7ZXju7xdp
 20mWuPVbrAPF8v0cApl/EEJECEWqzlsLoRSYiIxwgo8nakvmvQfej/o3dkAJcBEpI8U780Gmu
 iuSt3gcMq1PALec7TfXc7X32pY5P0WzIFLYW35+/3GGRRSOTkuhtzMeGk7H5F7P/ecTU3zu82
 uRkuoKSNZ/XTaKdvEdbU6nznS6vm6rnWRrvZuegpdukd6hGUImdPwyhKTrewF8soaUTZu2y1u
 kw1+86tmlRj1JogyKO5ZSUT0+dWm8UFNF86uv17ezL7oLtdnREbCsVbcA9cKMEnaa7tbBvlad
 u06xMLDxx9PkH3M5mgsC7hYDDjM98LoF3uSgPPgvBJYdgphb6WTL9SJmQgp/uXMR23dBllvt2
 8XJH6f8KLnc/0r2ApHpsQZNjJdzfIYelBjuBfjHpkLpryWfs4PMpyz3xUwvw2Wpw/x12yL6cc
 aH+d04xttqhZS79f0fOJP1LrlmEFCjcLL8P/OBsc+S+FfbnGUFlA7Av67KTxTNQcDPEFvho7V
 v7/84Z06zUy6mwdM1ofe2si/ixGpOqi2p3GRxWS3oVKqn4P5vOiw8UQ6g1jg3kTNeVV/R/LQX
 hbKZI0Jbmlf5xCKVIYCGCa79gkSmdJsBHhHDgzI0FXz+q8DbpmvWvPUVlCI9ZskDd8FbCXBhj
 l5A4sZ8pbWa+ChDW37f13dK5zqHhe889pSfowDjszppK1QZz11DEft+TyN944uUfdTIq82Jlc
 zyxDwqucvsy8LDiT6chyjS+viQz2EMznYIBJ+eH+qjQDsC925Rgnyz5DkPabPykqYKg8LUYJ8
 1uEUvbuAiMEN4AT+qgAH7CXPNsty0Yn233dJ3LcHEE6sbcgPUDkemxjrG7+3e3p/dk5fZn+K2
 1oQBbPv3ZwNGO1AJF
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16.01.20 02:12, Philippe Mathieu-Daud=C3=A9 wrote:
> The GdkMonitor was introduced in GTK+ 3.22:
> https://developer.gnome.org/gdk3/stable/api-index-3-22.html#api-index-3.=
22
>
> If we build with older GTK+, the build fails:
>
>      CC      ui/gtk.o
>    qemu/ui/gtk.c: In function =E2=80=98gd_vc_gfx_init=E2=80=99:
>    qemu/ui/gtk.c:1973:5: error: unknown type name =E2=80=98GdkMonitor=E2=
=80=99
>         GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, w=
in);
>         ^
>    qemu/ui/gtk.c:1973:27: error: implicit declaration of function =E2=80=
=98gdk_display_get_monitor_at_window=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
>         GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, w=
in);
>                               ^
>    qemu/ui/gtk.c:1973:5: error: nested extern declaration of =E2=80=98gd=
k_display_get_monitor_at_window=E2=80=99 [-Werror=3Dnested-externs]
>         GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, w=
in);
>         ^
>    qemu/ui/gtk.c:1973:27: error: initialization makes pointer from integ=
er without a cast [-Werror=3Dint-conversion]
>         GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, w=
in);
>                               ^
>    qemu/ui/gtk.c:2035:28: error: implicit declaration of function =E2=80=
=98gdk_monitor_get_refresh_rate=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
>         refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);
>                                ^
>    qemu/ui/gtk.c:2035:5: error: nested extern declaration of =E2=80=98gd=
k_monitor_get_refresh_rate=E2=80=99 [-Werror=3Dnested-externs]
>         refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);
>         ^
>    cc1: all warnings being treated as errors
>    qemu/rules.mak:69: recipe for target 'ui/gtk.o' failed
>    make: *** [ui/gtk.o] Error 1
>
> We only use the GdkMonitor API to get the monitor refresh rate.
>
> GTK+ provides convenient definition in <gdk/gdkversionmacros.h>
> (already include by <gdk/gdk.h>) to check which API are available.
>
> Extract this code as a new gd_refresh_rate_millihz() function,
> and check GDK_VERSION_3_22 is defined before calling its API.
> If it is not defined, return 0. This is safe and fixes our build
> failure.
>
> Fixes: c4c00922cc (display/gtk: get proper refreshrate)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Sorry I missed that, I only tested Nikola's patch on my workstation
> which runs Fedora 30:
>
>    $ pkg-config --modversion gtk+-3.0
>    3.24.11
>
> If Gerd acks this patch, we might consider having it directly
> applied as a build fix.
> ---
>   ui/gtk.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 7355d34fcf..d18892d1de 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1961,6 +1961,23 @@ static GtkWidget *gd_create_menu_machine(GtkDispl=
ayState *s)
>       return machine_menu;
>   }
>
> +/*
> + * If available, return the refresh rate of the display in milli-Hertz,
> + * else return 0.
> + */
> +static int gd_refresh_rate_millihz(GtkDisplayState *s)
> +{
> +#ifdef GDK_VERSION_3_22
> +    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
> +    GdkWindow *win =3D gtk_widget_get_window(s->window);
> +    GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win)=
;
> +
> +    return gdk_monitor_get_refresh_rate(monitor);
> +#else
> +    return 0;
> +#endif
> +}
> +
>   static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
>                                 QemuConsole *con, int idx,
>                                 GSList *group, GtkWidget *view_menu)
> @@ -1968,10 +1985,6 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s,=
 VirtualConsole *vc,
>       bool zoom_to_fit =3D false;
>       int refresh_rate_millihz;
>
> -    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
> -    GdkWindow *win =3D gtk_widget_get_window(s->window);
> -    GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win)=
;
> -
>       vc->label =3D qemu_console_get_label(con);
>       vc->s =3D s;
>       vc->gfx.scale_x =3D 1.0;
> @@ -2032,7 +2045,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, =
VirtualConsole *vc,
>       vc->gfx.kbd =3D qkbd_state_init(con);
>       vc->gfx.dcl.con =3D con;
>
> -    refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);
> +    refresh_rate_millihz =3D gd_refresh_rate_millihz(s);
>       if (refresh_rate_millihz) {
>           vc->gfx.dcl.update_interval =3D MILLISEC_PER_SEC / refresh_rat=
e_millihz;
>       }
>

This (as well as c4c00922cc) gives

qemu-system-x86_64: Gdk: gdk_window_get_origin: assertion 'GDK_IS_WINDOW (=
window)' failed

on startup under gtk 3.22.30 (mate 1.20.1).

Jan

