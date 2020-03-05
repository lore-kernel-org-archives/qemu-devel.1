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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54165C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200E020716
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmS7kmXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200E020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9veM-0000U4-6b
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 13:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j9vdV-0007u6-TZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j9vdU-0002QZ-RL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:54:21 -0500
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:43848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j9vdU-0002PW-JR; Thu, 05 Mar 2020 13:54:20 -0500
Received: by mail-vs1-xe42.google.com with SMTP id 7so4292057vsr.10;
 Thu, 05 Mar 2020 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9WlH75BN1udAgD+33THQruL8q+EWLnMXDXUqFlXchmo=;
 b=PmS7kmXLhQ+FbFufdDFbYhizGEA7DkGLFOuivQL1r/Uo4DMOFPhcBuDN9JRycej6Dq
 3nN/LDXSZRRBIfSWKQua6pf5VZ7AkvX7oMAofaF23jZps+hJCAyAITeghPnVAw3raq/j
 gshN3qQe8cW+IBl/tQ7/YZeJnife69C8Jeyst2TwMqNoDb7cjIR4DsCiAfFv1ukEHUId
 oc2E1x7CL76pOCzzYEYbeb/SMmrw1LcCize913ASQ/6U8yJNVEmLtQRvRZNVrgXMe8cx
 21Sq2GXU12Bzl+spdesubPuysEUwS6r4Ie0TRBagV+3zs7L/XZ5khlVBm68zOHGPfHvn
 +IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9WlH75BN1udAgD+33THQruL8q+EWLnMXDXUqFlXchmo=;
 b=JLfiiLPgFUzm7HR00b/eyJRqqRm+FIGyX0K6f1v76Bpd6iHdXdbm10mxIL2raZ8oG3
 zEMCyRWJRLFbWqEUBRMKaoGQVykoCtzvau/EYaZMP8gNDFGNrWNzIoPTcysSVJO3oQqy
 Fu1Hz62iM21xlkK/0kpNGNbEc7APrL/qlWYcA3yy9cxn9X68rhUFb0rOVTEB+0l97TPw
 iG+33FQe/NDjIELQaTGikkuPWTIYicYZA7JAZJVREVT9n6bzFSPzSJ39hEF4hy2wRtGq
 Wum0Y1wUQOv0riUHooUoGaHERMLcDczISBwqw78oa4Ob7uriuoKTAdYJz09wqib02bR7
 0qdw==
X-Gm-Message-State: ANhLgQ1nFfOCOJ1CqvUT+/w0eUIGrQcpp42JKrAySJc2kmgokyCohsBN
 tf/fHwgIegWGiPMbpQ4/ZWagc2SYnGcQsN4KgNM=
X-Google-Smtp-Source: ADFU+vvgos6attJpB5ENUUCjmoaC4sb5LEqYhhq09gJvWgEoubLoagIcBBlcahSF5rzFLnJs/6FVLGBfGZDj0C2QszA=
X-Received: by 2002:a05:6102:3019:: with SMTP id
 s25mr173996vsa.133.1583434459899; 
 Thu, 05 Mar 2020 10:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20200305175651.4563-1-philmd@redhat.com>
 <20200305175651.4563-2-philmd@redhat.com>
In-Reply-To: <20200305175651.4563-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2020 10:46:37 -0800
Message-ID: <CAKmqyKMvrXreJvzSEPyrCDyUe=65n6PX3pNTA66kG2Uhe15CzQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] hw/net/e1000e_core: Let e1000e_can_receive() return a
 boolean
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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

On Thu, Mar 5, 2020 at 9:57 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> The e1000e_can_receive() function simply returns a boolean value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/e1000e_core.h | 2 +-
>  hw/net/e1000e_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> index 49abb136dd..aee32f7e48 100644
> --- a/hw/net/e1000e_core.h
> +++ b/hw/net/e1000e_core.h
> @@ -143,7 +143,7 @@ e1000e_core_set_link_status(E1000ECore *core);
>  void
>  e1000e_core_pci_uninit(E1000ECore *core);
>
> -int
> +bool
>  e1000e_can_receive(E1000ECore *core);
>
>  ssize_t
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 94ea34dca5..e0bafe975b 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -967,7 +967,7 @@ e1000e_start_recv(E1000ECore *core)
>      }
>  }
>
> -int
> +bool
>  e1000e_can_receive(E1000ECore *core)
>  {
>      int i;
> --
> 2.21.1
>
>

