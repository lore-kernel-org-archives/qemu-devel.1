Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D316C3B185
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA4921739
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJTnfECb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA4921739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15qo-0002KY-7z
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j15q7-0001gP-0y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j15q5-0005L2-Tl
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:58:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j15q5-0005KS-Qj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581328729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uezzjb/M0zDb4Z6HHFJym8PgOrwYZqphLq4djMxoW/0=;
 b=AJTnfECbeqNR0+H7nYNrA/l075afj+Kks+76JCPrzCnrIqJBAvUPJSiUCkDYOuSJscNn+m
 iGlnhYtxFw8967Vz3RnBBWhYE17AWUj8rXg3vQqswUV/7h0DunpeRUlnPlCwvtOCp/nwdf
 fEJt0pj9Q6qzr9RfYSSKZEpinaM9j14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-jNl1hSXDPBaXlunAwCN2AA-1; Mon, 10 Feb 2020 04:58:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8276610054E3;
 Mon, 10 Feb 2020 09:58:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCB14857B4;
 Mon, 10 Feb 2020 09:58:38 +0000 (UTC)
Date: Mon, 10 Feb 2020 10:58:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 06/13] hw/arm/raspi: Trivial code movement
Message-ID: <20200210105837.16cc1c60@redhat.com>
In-Reply-To: <20200208165645.15657-7-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-7-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jNl1hSXDPBaXlunAwCN2AA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "open
 list:Trivial patches" <qemu-trivial@nongnu.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Laurent Vivier <laurent@vivier.eu>, Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat,  8 Feb 2020 17:56:38 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> There is no point in creating the SoC object before allocating the RAM.
> Move the call to keep all the SoC-related calls together.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/raspi.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 7a2ca97347..b3e6f72b55 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -227,9 +227,6 @@ static void raspi_init(MachineState *machine, uint32_=
t board_rev)
>          exit(1);
>      }
> =20
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
> -                            board_soc_type(board_rev), &error_abort, NUL=
L);
> -
>      /* Allocate and map RAM */
>      memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram"=
,
>                                           machine->ram_size);
> @@ -237,6 +234,8 @@ static void raspi_init(MachineState *machine, uint32_=
t board_rev)
>      memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram,=
 0);
> =20
>      /* Setup the SOC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
> +                            board_soc_type(board_rev), &error_abort, NUL=
L);
>      object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ra=
m),
>                                     &error_abort);
>      object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",


