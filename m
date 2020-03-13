Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA892C5ACBF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 23:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BCA20637
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 23:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BCA20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCuAd-0000jW-Vn
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 19:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1jCuA5-0000Ff-3C
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 19:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1jCuA3-0008FX-VR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 19:56:17 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:47810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1jCuA3-000871-Kg
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 19:56:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 27F82D10E;
 Sat, 14 Mar 2020 00:56:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XQZ2Sfe1rh0r; Sat, 14 Mar 2020 00:56:10 +0100 (CET)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr
 [86.234.239.11])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id A96CAD10D;
 Sat, 14 Mar 2020 00:56:10 +0100 (CET)
Received: from samy by function with local (Exim 4.93)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1jCu9x-001Avv-BH; Sat, 14 Mar 2020 00:56:09 +0100
Date: Sat, 14 Mar 2020 00:56:09 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH 1/4] usb-serial: Move USB_TOKEN_IN into a helper function
Message-ID: <20200313235609.bmfiyzhsat3pqvkt@function>
References: <20200312125524.7812-1-jandryuk@gmail.com>
 <20200312125524.7812-2-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312125524.7812-2-jandryuk@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Andryuk, le jeu. 12 mars 2020 08:55:20 -0400, a ecrit:
> We'll be adding a loop, so move the code into a helper function.  break=
s
> are replaced with returns.
>=20
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  hw/usb/dev-serial.c | 77 +++++++++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index daac75b7ae..71fa786bd8 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -358,13 +358,53 @@ static void usb_serial_handle_control(USBDevice *=
dev, USBPacket *p,
>      }
>  }
> =20
> +static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
> +{
> +    int first_len, len;
> +    uint8_t header[2];
> +
> +    first_len =3D RECV_BUF - s->recv_ptr;
> +    len =3D p->iov.size;
> +    if (len <=3D 2) {
> +        p->status =3D USB_RET_NAK;
> +        return;
> +    }
> +    header[0] =3D usb_get_modem_lines(s) | 1;
> +    /* We do not have the uart details */
> +    /* handle serial break */
> +    if (s->event_trigger && s->event_trigger & FTDI_BI) {
> +        s->event_trigger &=3D ~FTDI_BI;
> +        header[1] =3D FTDI_BI;
> +        usb_packet_copy(p, header, 2);
> +        return;
> +    } else {
> +        header[1] =3D 0;
> +    }
> +    len -=3D 2;
> +    if (len > s->recv_used)
> +        len =3D s->recv_used;
> +    if (!len) {
> +        p->status =3D USB_RET_NAK;
> +        return;
> +    }
> +    if (first_len > len)
> +        first_len =3D len;
> +    usb_packet_copy(p, header, 2);
> +    usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
> +    if (len > first_len)
> +        usb_packet_copy(p, s->recv_buf, len - first_len);
> +    s->recv_used -=3D len;
> +    s->recv_ptr =3D (s->recv_ptr + len) % RECV_BUF;
> +
> +    return;
> +}
> +
>  static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
>  {
>      USBSerialState *s =3D (USBSerialState *)dev;
>      uint8_t devep =3D p->ep->nr;
>      struct iovec *iov;
> -    uint8_t header[2];
> -    int i, first_len, len;
> +    int i;
> =20
>      switch (p->pid) {
>      case USB_TOKEN_OUT:
> @@ -382,38 +422,7 @@ static void usb_serial_handle_data(USBDevice *dev,=
 USBPacket *p)
>      case USB_TOKEN_IN:
>          if (devep !=3D 1)
>              goto fail;
> -        first_len =3D RECV_BUF - s->recv_ptr;
> -        len =3D p->iov.size;
> -        if (len <=3D 2) {
> -            p->status =3D USB_RET_NAK;
> -            break;
> -        }
> -        header[0] =3D usb_get_modem_lines(s) | 1;
> -        /* We do not have the uart details */
> -        /* handle serial break */
> -        if (s->event_trigger && s->event_trigger & FTDI_BI) {
> -            s->event_trigger &=3D ~FTDI_BI;
> -            header[1] =3D FTDI_BI;
> -            usb_packet_copy(p, header, 2);
> -            break;
> -        } else {
> -            header[1] =3D 0;
> -        }
> -        len -=3D 2;
> -        if (len > s->recv_used)
> -            len =3D s->recv_used;
> -        if (!len) {
> -            p->status =3D USB_RET_NAK;
> -            break;
> -        }
> -        if (first_len > len)
> -            first_len =3D len;
> -        usb_packet_copy(p, header, 2);
> -        usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
> -        if (len > first_len)
> -            usb_packet_copy(p, s->recv_buf, len - first_len);
> -        s->recv_used -=3D len;
> -        s->recv_ptr =3D (s->recv_ptr + len) % RECV_BUF;
> +        usb_serial_token_in(s, p);
>          break;
> =20
>      default:
> --=20
> 2.24.1
>=20

--=20
Samuel
Tu as lu les docs. Tu es devenu un informaticien. Que tu le veuilles
ou non. Lire la doc, c'est le Premier et Unique Commandement de
l'informaticien.
-+- TP in: Guide du Linuxien pervers - "L'=C3=A9vangile selon St Thomas"

