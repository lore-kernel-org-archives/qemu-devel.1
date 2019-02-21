Received: from eggs.gnu.org ([209.51.188.92]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwqla-0003Dm-Ek
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gwqlX-00007m-Mw
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:00:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gwqlW-00005o-1j
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:00:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id n2so19022146wrw.8
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 08:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
	<20190221110703.5775-12-marcandre.lureau@redhat.com>
	<20190221132352.f66y5qljs7q4dmse@sirius.home.kraxel.org>
	<CAJ+F1CJrfnqaeHcMveNzRUavmyxLpCRxfeertfV9SrH6-Vd86Q@mail.gmail.com>
	<20190221143923.7k7fjyu64mcv4sdd@sirius.home.kraxel.org>
	<CAJ+F1C+Kj5+J_-TXBmmGxzNOf_ehJ2xDzBAQoE8vjmUJJAChZA@mail.gmail.com>
	<20190221151856.4ypn2zxq5entu6aj@sirius.home.kraxel.org>
In-Reply-To: <20190221151856.4ypn2zxq5entu6aj@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Feb 2019 16:59:48 +0100
Message-ID: <CAJ+F1CKn-9Zvf6RW3GXALC59cHOvr90GHc1z6Yc4skQZqxmcJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/11] display: add -display spice-app
 launching a Spice client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Feb 21, 2019 at 4:19 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Too bad.  So broken for pretty much everyone I guess?
> >
> > It should be easy to backport the patch for older virt-viewer.
> >
> > But to get the "complete" experience, I would recommend you use the
> > upcoming virt-viewer. Without it, you won't have the QMP monitor
> > handling, VTE serial console, etc..
> >
> > > I think we should have a fallback which exec's remote-viewer then, fo=
r
> > > the next 2-3 years, until a fixed virt-viewer is in widespread use ..=
.
> >
> > I am not sure, I think it make sense to require the upcoming
> > virt-viewer instead.
> >
> > After all, if you use a bleeding edge qemu, you can use bleeding edge
> > virt-viewer, no?
>
> Fair enough, but please add a hint to the error message then so users
> have a clue how to deal with it.
>

Would something like that be helpful?

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 4f5229f3ee..69f92e440c 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -181,6 +181,7 @@ static void spice_app_display_init(DisplayState
*ds, DisplayOptions *opts)
     g_app_info_launch_default_for_uri(uri, NULL, &err);
     if (err) {
         error_report("Failed to launch %s URI: %s", uri, err->message);
+        error_report("You need a capable Spice client, such as
virt-viewer 8.0");
         exit(1);
     }
     g_free(uri);

--=20
Marc-Andr=C3=A9 Lureau
