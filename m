Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD5AC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A9A24656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJQ3o66U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A9A24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4iNc-000777-Sx
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j4iN3-0006ia-71
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j4iN1-0002bi-6E
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:43:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j4iN0-0002aO-UV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:43:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id n10so3876462wrm.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 01:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lFmcWhrIlE4G+7LrD5RU2dfPqQS+ttkp2E6vk30fBec=;
 b=BJQ3o66USyQ8DBWs2BZk7gITiQnM7B+ZiqW6iM4RxH2ESXi+BuiCJSuCTG3rkQsQBi
 Ihscqvtn8oZ0dheTY5WXipf8jDh5LtXh0+IhI3VVb+TgtjyKDed4adU/d8NerCgF9v/v
 UUmp4esA2moS9fyzROBGry4DovYZdCc5P0FrWUV2c4tE8jqATPXW6hddmdzrpiMGG0WU
 lo0FHw/2AnR5VOzYcJNa8h+R1VK5FgTodlcHHNC+QlGnk3HXApz91kzzC3hs+G4eIBch
 suPgrEeXv2eJquT+ZgTebyfKcPr4XogzLN1hZ5wl/NMpS4CXely+n/+3B8KgWwPjQzwM
 6hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lFmcWhrIlE4G+7LrD5RU2dfPqQS+ttkp2E6vk30fBec=;
 b=VUKKtX6ZJeq8Q/kuQ09ZvneB3aN+PHBllL6DB4KvxoLJ6jsuC3wFpgZa9WLTrJiLvc
 ZG4XhTanN1TyqiA3yWJYmJsYaQOpiux+E2wiJqrUbDga2JCJvdn+usnukZjS/H+1Xsuq
 qTM7dChUdYIYEvttYv4hrdOGWj5yC+Vu6c7jMwkuAyeOVhtuKn4te3c7HmoBCLx216N4
 Ktl6KhEyNBXuHrxwOQvDeNNIsm96cu+YzTjr/Gucq2ej6NLUulDv1TZG6JT8VIz+MFAL
 shgswHyRZa1dXXNXlz/rZytfTWo9XVxjj5oV5N1VyQHYHAdbNhIcQBuOErIly7O1hpTt
 3K+A==
X-Gm-Message-State: APjAAAWP6ntCBuWtJsPFZ4az9heEdHh2nAxWxbph6UqTLkA0l07tLTk2
 jFx/QZopjJ5TbEHAv/eDVA0CbmF9sici2Fa6qT4=
X-Google-Smtp-Source: APXvYqwnd45LGoxXl41xUn3oqE829Var8UklaCV1tMabvbVDrR/QaErQabfTJBykeZ7bCPNSL0ZAI9BZmbmdY4KD0es=
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr39681792wrx.381.1582191824824; 
 Thu, 20 Feb 2020 01:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
In-Reply-To: <87a75dn1gd.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Feb 2020 10:43:32 +0100
Message-ID: <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Feb 20, 2020 at 8:49 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Thanks to the QMP coroutine support, the screendump handler can
> > trigger a graphic_hw_update(), yield and let the main loop run until
> > update is done. Then the handler is resumed, and the ppm_save() will
> > write the screen image to disk in the coroutine context (thus
> > non-blocking).
> >
> > For now, HMP doesn't have coroutine support, so it remains potentially
> > outdated or glitched.
> >
> > Fixes:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
> >
> > Based-on: <20200109183545.27452-2-kwolf@redhat.com>
> >
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/ui.json    |  3 ++-
> >  ui/console.c    | 35 +++++++++++++++++++++++++++--------
> >  ui/trace-events |  2 +-
> >  3 files changed, 30 insertions(+), 10 deletions(-)
> >
> > diff --git a/qapi/ui.json b/qapi/ui.json
> > index e04525d8b4..d941202f34 100644
> > --- a/qapi/ui.json
> > +++ b/qapi/ui.json
> > @@ -96,7 +96,8 @@
> >  #
> >  ##
> >  { 'command': 'screendump',
> > -  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
> > +  'data': {'filename': 'str', '*device': 'str', '*head': 'int'},
> > +  'coroutine': true }
> >
> >  ##
> >  # =3D=3D Spice
> > diff --git a/ui/console.c b/ui/console.c
> > index ac79d679f5..db184b473f 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -167,6 +167,7 @@ struct QemuConsole {
> >      QEMUFIFO out_fifo;
> >      uint8_t out_fifo_buf[16];
> >      QEMUTimer *kbd_timer;
> > +    Coroutine *screendump_co;
> >
> >      QTAILQ_ENTRY(QemuConsole) next;
> >  };
> > @@ -194,7 +195,6 @@ static void dpy_refresh(DisplayState *s);
> >  static DisplayState *get_alloc_displaystate(void);
> >  static void text_console_update_cursor_timer(void);
> >  static void text_console_update_cursor(void *opaque);
> > -static bool ppm_save(int fd, DisplaySurface *ds, Error **errp);
> >
> >  static void gui_update(void *opaque)
> >  {
> > @@ -263,6 +263,9 @@ static void gui_setup_refresh(DisplayState *ds)
> >
> >  void graphic_hw_update_done(QemuConsole *con)
> >  {
> > +    if (con && con->screendump_co) {
>
> How can !con happen?

I don't think it can happen anymore (the patch evolved over several
years, this is probably a left-over). In any case, it doesn't hurt.


>
> > +        aio_co_wake(con->screendump_co);
> > +    }
> >  }
> >
> >  void graphic_hw_update(QemuConsole *con)
> > @@ -310,16 +313,16 @@ void graphic_hw_invalidate(QemuConsole *con)
> >      }
> >  }
> >
> > -static bool ppm_save(int fd, DisplaySurface *ds, Error **errp)
> > +static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
> >  {
> > -    int width =3D pixman_image_get_width(ds->image);
> > -    int height =3D pixman_image_get_height(ds->image);
> > +    int width =3D pixman_image_get_width(image);
> > +    int height =3D pixman_image_get_height(image);
> >      g_autoptr(Object) ioc =3D OBJECT(qio_channel_file_new_fd(fd));
> >      g_autofree char *header =3D NULL;
> >      g_autoptr(pixman_image_t) linebuf =3D NULL;
> >      int y;
> >
> > -    trace_ppm_save(fd, ds);
> > +    trace_ppm_save(fd, image);
> >
> >      header =3D g_strdup_printf("P6\n%d %d\n%d\n", width, height, 255);
> >      if (qio_channel_write_all(QIO_CHANNEL(ioc),
> > @@ -329,7 +332,7 @@ static bool ppm_save(int fd, DisplaySurface *ds, Er=
ror **errp)
> >
> >      linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
> >      for (y =3D 0; y < height; y++) {
> > -        qemu_pixman_linebuf_fill(linebuf, ds->image, width, 0, y);
> > +        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
> >          if (qio_channel_write_all(QIO_CHANNEL(ioc),
> >                                    (char *)pixman_image_get_data(linebu=
f),
> >                                    pixman_image_get_stride(linebuf), er=
rp) < 0) {
>
> Looks like an unrelated optimization / simplification.  If I was
> maintainer, I'd ask for a separate patch.

I can be split, but it's related. We should pass a reference to
pixman_image_t, rather than a pointer to DisplaySurface, as the
underlying image may change over time, and would result in corrupted
coroutine save or worse.

> > @@ -340,11 +343,18 @@ static bool ppm_save(int fd, DisplaySurface *ds, =
Error **errp)
> >      return true;
> >  }
> >
> > +static void graphic_hw_update_bh(void *con)
> > +{
> > +    graphic_hw_update(con);
> > +}
> > +
> > +/* may be called in coroutine context or not */
>
> Hmm.
>
> Even though the QMP core always calls in coroutine context, the comment
> is correct: hmp_screendump() calls it outside coroutine context.
> Because of that...
>
> >  void qmp_screendump(const char *filename, bool has_device, const char =
*device,
> >                      bool has_head, int64_t head, Error **errp)
> >  {
> >      QemuConsole *con;
> >      DisplaySurface *surface;
> > +    g_autoptr(pixman_image_t) image =3D NULL;
> >      int fd;
> >
> >      if (has_device) {
> > @@ -365,7 +375,15 @@ void qmp_screendump(const char *filename, bool has=
_device, const char *device,
> >          }
> >      }
> >
> > -    graphic_hw_update(con);
> > +    if (qemu_in_coroutine()) {
> > +        assert(!con->screendump_co);
>
> What if multiple QMP monitors simultaneously screendump?  Hmm, it works
> because all execute one after another in the same coroutine
> qmp_dispatcher_co.  Implicit mutual exclusion.
>
> Executing them one after another is bad, because it lets an ill-behaved
> QMP command starve *all* QMP monitors.  We do it only out of
> (reasonable!) fear of implicit mutual exclusion requirements like the
> one you add.
>
> Let's not add more if we can help it.

The situation is not worse than the current blocking handling.

>
> Your screendump_co is per QemuConsole instead of per QMP monitor only
> because you need to find the coroutine in graphic_hw_update_done().  Can
> we somehow pass it via function arguments?

I think it could be done later, so I suggest a TODO.

> In case avoiding the mutual exclusion is impractical: please explain it
> in a comment to make it somewhat less implicit.
>
> > +        con->screendump_co =3D qemu_coroutine_self();
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                graphic_hw_update_bh, con);
> > +        qemu_coroutine_yield();
> > +        con->screendump_co =3D NULL;
> > +    }
> > +
>
> ... the command handler needs extra code to cope with either.  Is this
> really what we want for coroutine QMP command handlers?  We'll acquire
> more of them, and I'd hate to make each one run both in and outside
> coroutine context.  Shouldn't we let the HMP core take care of this?  Or
> at least have some common infrastructure these handlers can use?

We have several functions that have this dual support, for ex QIO.

Changing both QMP & HMP commands to run in coroutine is likely
additional work that we may not care at this point.

I propose to leave a TODO, once we have several similar QMP & HMP mix
cases we can try to find a common HMP solution to make the code
simpler in QMP handler.

I don't know if this is going to be a common pattern, we may end up
with conversions that can run both without explicit handling (like the
ppm_save() function, thanks to QIO).

>
> Why is it okay not to call graphic_hw_update() anymore when
> !qemu_in_coroutine()?

You could call it, but then you should wait for completion by
reentering the main loop (that was the point of my earlier qapi-async
series)

>
> If qemu_in_coroutine(), we now run graphic_hw_update() in a bottom half,
> then yield until the update completes (see graphic_hw_update_done()
> above).  Can you explain the need for the bottom half?

At least spice rendering is done in a separate thread, completion is async.

>
> >      surface =3D qemu_console_surface(con);
> >      if (!surface) {
> >          error_setg(errp, "no surface");
> > @@ -379,7 +397,8 @@ void qmp_screendump(const char *filename, bool has_=
device, const char *device,
> >          return;
> >      }
> >
> > -    if (!ppm_save(fd, surface, errp)) {
> > +    image =3D pixman_image_ref(surface->image);
> > +    if (!ppm_save(fd, image, errp)) {
> >          qemu_unlink(filename);
> >      }
> >  }
> > diff --git a/ui/trace-events b/ui/trace-events
> > index 0dcda393c1..e8726fc969 100644
> > --- a/ui/trace-events
> > +++ b/ui/trace-events
> > @@ -15,7 +15,7 @@ displaysurface_create_pixman(void *display_surface) "=
surface=3D%p"
> >  displaysurface_free(void *display_surface) "surface=3D%p"
> >  displaychangelistener_register(void *dcl, const char *name) "%p [ %s ]=
"
> >  displaychangelistener_unregister(void *dcl, const char *name) "%p [ %s=
 ]"
> > -ppm_save(int fd, void *display_surface) "fd=3D%d surface=3D%p"
> > +ppm_save(int fd, void *image) "fd=3D%d image=3D%p"
> >
> >  # gtk.c
> >  # gtk-gl-area.c
>
>



--=20
Marc-Andr=C3=A9 Lureau

