Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3163C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D99321734
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPVpU5Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D99321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huf5K-0000Nq-TA
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hikarupsp@gmail.com>) id 1huf4a-0007v4-JR
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hikarupsp@gmail.com>) id 1huf4Z-0006fp-Js
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:38:56 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hikarupsp@gmail.com>) id 1huf4Z-0006eF-8e
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:38:55 -0400
Received: by mail-lj1-x243.google.com with SMTP id m23so79590937lje.12
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dO0bRjvyeRf4VDf72MQHmFk38oTfQL3ChnAy795ezuU=;
 b=PPVpU5KbI6yB5Ss6qdixIdBCmJJ286nb0j4zxdTU/SB7PwaXETJUbDNinNr+AuoxUF
 SZ0mvlQPq5QTs7AbRyFRjOdsXVe8aJpGpKf4rOBA1zymAwPa3pXRxOgb3dhly5+71eNw
 EHNMoPYsIDmtzuYsbhrRCavDHaxvU9vSY4mCNbkXJqdv8/XODHIHObC0eQ+XabnO4CIw
 4iguZ708WMZqFdkKAekZJ2H0VLoKSgYmDQT/FmZ06O7pgm98qQshPagn8uiiaI+EV5TM
 vsIXBZ8T7IqPX5e4T1HA49vWQzt65uLiVx28Fc6hxt3ayKvKYB6NM3OkOKgbShX/UmYL
 zDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dO0bRjvyeRf4VDf72MQHmFk38oTfQL3ChnAy795ezuU=;
 b=JO6DlVAH1/oSbVruzk+F4z94l+jtXHPiCDXpnIp2p7w2iu7XhPlPSQ+rbIC0cPljLI
 dUqhreYoJeFgpdwZbdhX8Tq60A0OcuIglXv1+UZhg7x/2IH0omnm4c1iAPKNDUw8ynQK
 gKecHrf5juFDkr4pHDDnagAPRK/u5s/MjGZZdvdBLHlL8ZYSSurio8Cj0uMMeNAG8FnQ
 sC16myiCi/CIMg4hcbieehgI/1okloVDoecJrMnBuVAYDb1n5lhQJnYkuwj0okocJjht
 PzDe+nmr04LSq9RW9EXe72rkovu30yJZER48y4V9dgLEYedb42+uYEBCTuySxBzhzJKf
 z9QQ==
X-Gm-Message-State: APjAAAVhURGuTEkEZyfAa/7O4pdP2H6yIUOX5LX0QM1LqdfQN13Zgajq
 57CxKF5OlokfvgYTPD/+pWyMkVwZI1EYjr7yH5Z9CdSK
X-Google-Smtp-Source: APXvYqwkfrYAMViJ6T+Grbse+PEDDU1jAOQ7Qa4DZni/nIkz6/Da2raXZxy61vz6aWUWu7GGv9ZfyXmaaCyrXOzg/9I=
X-Received: by 2002:a2e:9701:: with SMTP id r1mr11968837lji.12.1565019532292; 
 Mon, 05 Aug 2019 08:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190720060427.50457-1-hikarupsp@gmail.com>
In-Reply-To: <20190720060427.50457-1-hikarupsp@gmail.com>
From: Hikaru Nishida <hikarupsp@gmail.com>
Date: Tue, 6 Aug 2019 00:38:41 +0900
Message-ID: <CAD-w0GD_YGE-3iRbm=Qf+_zqWNyt36sHD3uKB9q2P0ff=0M55Q@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] xhci: Add No Op Command
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping...

2019=E5=B9=B47=E6=9C=8820=E6=97=A5(=E5=9C=9F) 15:04 <hikarupsp@gmail.com>:

> From: Hikaru Nishida <hikarupsp@gmail.com>
>
> This commit adds No Op Command (23) to xHC for verifying the operation
> of the Command Ring mechanisms.
> No Op Command is defined in XHCI spec (4.6.2) and just reports Command
> Completion Event with Completion Code =3D=3D Success.
> Before this commit, No Op Command is not implemented so xHC reports
> Command Completion Event with Completion Code =3D=3D TRB Error. This comm=
it
> fixes this behaviour to report Completion Code correctly.
>
> Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
> ---
>  hw/usb/hcd-xhci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 5894a18663..5ceff78280 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -2542,6 +2542,9 @@ static void xhci_process_commands(XHCIState *xhci)
>          case CR_GET_PORT_BANDWIDTH:
>              event.ccode =3D xhci_get_port_bandwidth(xhci, trb.parameter)=
;
>              break;
> +        case CR_NOOP:
> +            event.ccode =3D CC_SUCCESS;
> +            break;
>          case CR_VENDOR_NEC_FIRMWARE_REVISION:
>              if (xhci->nec_quirks) {
>                  event.type =3D 48; /* NEC reply */
> --
> 2.20.1 (Apple Git-117)
>
>
