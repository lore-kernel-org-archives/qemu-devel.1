Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F077C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D242072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbsF2PVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D242072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1Ha-0007Rv-9B
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jg1Gp-0006zP-1q
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:23:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44406
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jg1Go-0004R5-1X
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591082612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnhdNzEXoMsMKqGyC3xhEybeCiNJArw5ugx7Gyqbt0c=;
 b=YbsF2PVvu7wGF2LQUt2RDwkS/cNJVgdJHWSGI14MKVyx+jvNZ8F4djqbKQqpnEf1+ZxUAS
 4CMZ9yO3LbBfN6jLIl8JFXYHbf+pWAPSoR7XiiIiuro689GUTkyM4DMD6gY8Su1hHn32oP
 5NwJ0gUNdTMYldBakGTZFAL26571GlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-MNnG_AOdNo2gNHHbghj8Tw-1; Tue, 02 Jun 2020 03:23:30 -0400
X-MC-Unique: MNnG_AOdNo2gNHHbghj8Tw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 467851856940;
 Tue,  2 Jun 2020 07:23:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA15360C80;
 Tue,  2 Jun 2020 07:23:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5D11E1138601; Tue,  2 Jun 2020 09:23:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
References: <20200601092057.10555-1-f4bug@amsat.org>
Date: Tue, 02 Jun 2020 09:23:27 +0200
In-Reply-To: <20200601092057.10555-1-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 1 Jun 2020 11:20:57
 +0200")
Message-ID: <87imga7wy8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> I don't have much clue about the Renesas hardware, but at least
> I know now the source files a little bit, so I volunteer to pick
> up patches and send pull-requests for them during my scarce
> hobbyist time, until someone else with more knowledge steps up
> to do this job instead.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0944d9c731..cbba3ac757 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -298,9 +298,7 @@ SH4 TCG CPUs
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  S: Odd Fixes
>  F: target/sh4/
> -F: hw/sh4/
>  F: disas/sh4.c
> -F: include/hw/sh4/
> =20
>  SPARC TCG CPUs
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> @@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
>  F: pc-bios/u-boot-sam460ex-20100605.bin
>  F: roms/u-boot-sam460ex
> =20
> +Renesas Hardware
> +----------------
> +SH4 Hardware
> +M: Aurelien Jarno <aurelien@aurel32.net>
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +S: Odd Fixes
> +F: hw/sh4/
> +F: hw/char/sh_serial.c
> +F: hw/intc/sh_intc.c
> +F: hw/timer/sh_timer.c
> +F: include/hw/sh4/
> +
>  SH4 Machines
>  ------------
>  R2D
> @@ -1246,6 +1256,7 @@ S: Maintained
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
>  F: hw/timer/sh_timer.c
> +F: include/hw/sh4/sh_intc.h
> =20
>  Shix
>  M: Magnus Damm <magnus.damm@gmail.com>

hw/sh4 include/hw/sh4/ is Aurelien's "SH4 TCG CPUs" less target/sh4
disas/sh4.c.  Aurelien is fine with this overlap, so no problem.

hw/sh4/r2d.c hw/sh4/shix.c hw/intc/sh_intc.c hw/timer/sh_timer.c overlap
with "R2D" and "Shix".  You pointed out that Magnus hasn't been active
in years.  Having MAINTAINERS claim him even as "odd fixer" is
misleading then.  Have we tried to contact Magnus?

Say we can't reach him, or he instructs us to remove him from
MAINTAINERS.

The only parts of these two sections your new section doesn't claim is
hw/sh4/r2d.c and hw/sh4/shix.c.  Would you be willing to serve as odd
fixer for them, too?  Yes, I understand you don't have access to the
hardware, but how much worse is that for these too files than for the
remainder of hw/sh4/?


