Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAB2C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AB22073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NONVj+Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AB22073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9zmO-0001Yo-Uz
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 18:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j9zlF-0000aG-F4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j9zlE-0002ld-Aw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:18:37 -0500
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:35302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j9zlD-0002kW-Qn; Thu, 05 Mar 2020 18:18:35 -0500
Received: by mail-vs1-xe44.google.com with SMTP id u26so379131vsg.2;
 Thu, 05 Mar 2020 15:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8G8DYzV4+k5eDdvlRAgIYoVYwz7I40ZoA9ZyhuMHNt0=;
 b=NONVj+NmsZBgXIsULysZoWvneAWUpVGagTFX7aDH759+CcPtugtTWe6Ej/EC806PPW
 CW0OlaN0zVXvUfNkrYR/GdiQ7DjkFH0qwl76qUM0G4kZLpvVTdgeN7YnNtt1CpN9rFK7
 Le5QNjkFq/CFeeMEygPLLAuQT5lJyDUA5YnTLyLJPUOlWQfYfNPjCT1vA9CH2FVLriiX
 jftMCWcnKg5Rz1wwn+b2BRfIH1R5BCqOQt6uFcrrm0w45YLrBtOm0hU1holOQ5Syyohs
 N0JIb8GkRSB7map0GKDWDaUjI9RQ9IMu4TsmV/syBrbujt/5T/RIAwUQdw2XcwBAXNPh
 exLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8G8DYzV4+k5eDdvlRAgIYoVYwz7I40ZoA9ZyhuMHNt0=;
 b=pN3NxR3PSU1/gg1qiFKSsNNKQd3sVFOOl9zX+nUxCCnxQFcZGIIvG0fZP/SW1ucDFe
 SMUj1vqZHxLC94F+4jb0LndF3MoW7T0YQ07DFusKc/Z3Gh5L0pBuN1r7k5J2Adgr0lmx
 9lcwvePz4MBIE5NsjR1SfC/LkcVYpYtgRe+BAOaK4521GkanWC6A3GDeqZLa2n5VIyUq
 gFXh6E95ud3GMNz+IUQZmbj++F+bE0YAgGYKzRui0tSmScA6Cy/PqvSJ5g0EELGWwfzB
 KupF4nvqpm/ItSGMpvrEj2epwYSqexmGjwIB2Ds1vH/imIlmgaM7rA4Q6aP0qqt17E5K
 M30Q==
X-Gm-Message-State: ANhLgQ0aAI5JtDc9l965xDWJyMJ3801lJMfpVdYwHXtBG09MnllOxYtp
 Y/NeyHxktJpvb/SODqCFZHl7qiX6jvC2FBOonag=
X-Google-Smtp-Source: ADFU+vs4ziIyRL2LBoaIObKiQDaAYezXZhwa7vIGLSxBVKyqcTAfQTzPuZoPLzxMC1FIRp9ZV7ReEGq8ZAtyARIHW+8=
X-Received: by 2002:a05:6102:3c2:: with SMTP id
 n2mr517363vsq.172.1583450314758; 
 Thu, 05 Mar 2020 15:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20200305175651.4563-1-philmd@redhat.com>
 <20200305175651.4563-7-philmd@redhat.com>
In-Reply-To: <20200305175651.4563-7-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2020 15:10:52 -0800
Message-ID: <CAKmqyKN0f_Tx1x06i3X4Pp1s8EVV8-cvLex-U-nTUCFz=8bZTA@mail.gmail.com>
Subject: Re: [PATCH 6/6] hw/net/can: Make CanBusClientInfo::can_receive()
 return a boolean
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e44
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 9:59 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> The CanBusClientInfo::can_receive handler return whether the
> device can or can not receive new frames. Make it obvious by
> returning a boolean type.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/can/can_sja1000.h | 2 +-
>  include/net/can_emu.h    | 2 +-
>  hw/net/can/can_sja1000.c | 8 ++++----
>  net/can/can_socketcan.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h
> index 220a622087..7ca9cd681e 100644
> --- a/hw/net/can/can_sja1000.h
> +++ b/hw/net/can/can_sja1000.h
> @@ -137,7 +137,7 @@ void can_sja_disconnect(CanSJA1000State *s);
>
>  int can_sja_init(CanSJA1000State *s, qemu_irq irq);
>
> -int can_sja_can_receive(CanBusClientState *client);
> +bool can_sja_can_receive(CanBusClientState *client);
>
>  ssize_t can_sja_receive(CanBusClientState *client,
>                          const qemu_can_frame *frames, size_t frames_cnt)=
;
> diff --git a/include/net/can_emu.h b/include/net/can_emu.h
> index d4fc51b57d..fce9770928 100644
> --- a/include/net/can_emu.h
> +++ b/include/net/can_emu.h
> @@ -83,7 +83,7 @@ typedef struct CanBusClientState CanBusClientState;
>  typedef struct CanBusState CanBusState;
>
>  typedef struct CanBusClientInfo {
> -    int (*can_receive)(CanBusClientState *);
> +    bool (*can_receive)(CanBusClientState *);
>      ssize_t (*receive)(CanBusClientState *,
>          const struct qemu_can_frame *frames, size_t frames_cnt);
>  } CanBusClientInfo;
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 39c78faf9b..ea915a023a 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -733,21 +733,21 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwadd=
r addr, unsigned size)
>      return temp;
>  }
>
> -int can_sja_can_receive(CanBusClientState *client)
> +bool can_sja_can_receive(CanBusClientState *client)
>  {
>      CanSJA1000State *s =3D container_of(client, CanSJA1000State, bus_cli=
ent);
>
>      if (s->clock & 0x80) { /* PeliCAN Mode */
>          if (s->mode & 0x01) { /* reset mode. */
> -            return 0;
> +            return false;
>          }
>      } else { /* BasicCAN mode */
>          if (s->control & 0x01) {
> -            return 0;
> +            return false;
>          }
>      }
>
> -    return 1; /* always return 1, when operation mode */
> +    return true; /* always return true, when operation mode */
>  }
>
>  ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame =
*frames,
> diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
> index 29bfacd4f8..807f31fcde 100644
> --- a/net/can/can_socketcan.c
> +++ b/net/can/can_socketcan.c
> @@ -110,9 +110,9 @@ static void can_host_socketcan_read(void *opaque)
>      }
>  }
>
> -static int can_host_socketcan_can_receive(CanBusClientState *client)
> +static bool can_host_socketcan_can_receive(CanBusClientState *client)
>  {
> -    return 1;
> +    return true;
>  }
>
>  static ssize_t can_host_socketcan_receive(CanBusClientState *client,
> --
> 2.21.1
>
>

