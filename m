Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7876C3524F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8744B20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoZ+fz6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8744B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYWB-0002ku-Op
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyYVF-0001Kx-E4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyYVD-0003fj-Bq
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:58:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyYVD-0003ex-8X
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580723926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OKVhoxbcOsa4y2NJ/NR0P2E5oTl2ckYF89/zgSjhPU=;
 b=hoZ+fz6xs9jYF2saBmbtMzzYKbdnM6vGlnt55KhymSJ9ioNoh2NX2zJ/ZKi5Y0hjO0sQuy
 0CF1ZzmzEZhohnAPKhjj/wFnv2q6pQ5o1MUTubxk12znRqdIJDcQOLEk9Z3LyRN7jGVWO6
 kj+zSJG0/4jOaMiEPqyWVrI/9PQ3WnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-10jlmojkO02A8tfOGlx61A-1; Mon, 03 Feb 2020 04:58:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D2A41005512;
 Mon,  3 Feb 2020 09:58:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29BD28EA0B;
 Mon,  3 Feb 2020 09:58:40 +0000 (UTC)
Date: Mon, 3 Feb 2020 10:58:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 4/6] hw/arm/raspi: Get board RAM size from board
 revision code
Message-ID: <20200203105839.2d369c9f@redhat.com>
In-Reply-To: <20200203082619.7426-5-f4bug@amsat.org>
References: <20200203082619.7426-1-f4bug@amsat.org>
 <20200203082619.7426-5-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 10jlmojkO02A8tfOGlx61A-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  3 Feb 2020 09:26:17 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> The amount of RAM is encoded in the board revision.
> Add the board_ram_size() helper, it will allow us to quickly
> support new boards.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/raspi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index f5e54fe876..656d834e07 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -13,6 +13,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "hw/arm/bcm2836.h"
> @@ -71,6 +72,11 @@ static const RaspiBoardInfo raspi_boards[] =3D {
>  #endif
>  };
> =20
> +static uint64_t board_ram_size(const RaspiBoardInfo *config)
> +{
> +    return 1 * MiB << extract32(config->board_rev, 20, 4);
> +}
> +
>  static int board_chip_id(const RaspiBoardInfo *config)
>  {
>      return extract32(config->board_rev, 12, 4);
> @@ -222,10 +228,13 @@ static void raspi_init(MachineState *machine, const=
 RaspiBoardInfo *config)
>      BlockBackend *blk;
>      BusState *bus;
>      DeviceState *carddev;
> +    uint64_t ram_size;
> =20
> -    if (machine->ram_size > 1 * GiB) {
> -        error_report("Requested ram size is too large for this machine: =
"
> -                     "maximum is 1GB");
> +    ram_size =3D board_ram_size(config);
> +    if (machine->ram_size !=3D ram_size) {
> +        char *size_str =3D size_to_str(ram_size);
> +        error_report("This machine can only be used with %s", size_str);
> +        g_free(size_str);
>          exit(1);
>      }
> =20


