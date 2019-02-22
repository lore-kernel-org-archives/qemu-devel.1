Received: from eggs.gnu.org ([209.51.188.92]:57874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx3km-0006r4-RW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx3ki-0000qF-Ty
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:52:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx3ki-0000Ix-CE
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:52:04 -0500
Date: Fri, 22 Feb 2019 06:51:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190222055135.i7bpdamtzmkqfxjj@sirius.home.kraxel.org>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
	<20190221110703.5775-12-marcandre.lureau@redhat.com>
	<20190221132352.f66y5qljs7q4dmse@sirius.home.kraxel.org>
	<CAJ+F1CJrfnqaeHcMveNzRUavmyxLpCRxfeertfV9SrH6-Vd86Q@mail.gmail.com>
	<20190221143923.7k7fjyu64mcv4sdd@sirius.home.kraxel.org>
	<CAJ+F1C+Kj5+J_-TXBmmGxzNOf_ehJ2xDzBAQoE8vjmUJJAChZA@mail.gmail.com>
	<20190221151856.4ypn2zxq5entu6aj@sirius.home.kraxel.org>
	<CAJ+F1CKn-9Zvf6RW3GXALC59cHOvr90GHc1z6Yc4skQZqxmcJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKn-9Zvf6RW3GXALC59cHOvr90GHc1z6Yc4skQZqxmcJQ@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>

  Hi,

> Would something like that be helpful?
> 
> diff --git a/ui/spice-app.c b/ui/spice-app.c
> index 4f5229f3ee..69f92e440c 100644
> --- a/ui/spice-app.c
> +++ b/ui/spice-app.c
> @@ -181,6 +181,7 @@ static void spice_app_display_init(DisplayState
> *ds, DisplayOptions *opts)
>      g_app_info_launch_default_for_uri(uri, NULL, &err);
>      if (err) {
>          error_report("Failed to launch %s URI: %s", uri, err->message);
> +        error_report("You need a capable Spice client, such as
> virt-viewer 8.0");

Yep, looks good to me.  Can you send that as incremental patch?

thanks,
  Gerd
