Received: from eggs.gnu.org ([2001:4830:134:3::10]:36780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVA1j-0003U0-Cw
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVA1f-00081l-F6
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:22:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVA1f-00081a-A7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:21:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E64CF7DAC4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 06:21:58 +0000 (UTC)
Date: Tue, 19 Jun 2018 08:21:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180619062158.xreqany3tlnpmzn6@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180618161729.334-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/26] dmabuf: add y0_top,
 pass it to spice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

On Mon, Jun 18, 2018 at 06:17:06PM +0200, Marc-Andr=E9 Lureau wrote:
> Some scanouts during boot are top-down without this.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/ui/console.h | 1 +
>  ui/spice-display.c   | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 981b519dde..fb969caf70 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -186,6 +186,7 @@ struct QemuDmaBuf {
>      uint32_t  stride;
>      uint32_t  fourcc;
>      uint32_t  texture;
> +    bool      y0_top;
>  };
> =20
>  typedef struct DisplayChangeListenerOps {

Looks incomplete, who sets y0_top?

Also: send the bugfixes (patches 1-6 ?) separate, so they can be merged
already while the input + gpu details are hashed out?

cheers,
  Gerd
