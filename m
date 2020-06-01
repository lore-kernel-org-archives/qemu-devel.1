Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08F1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01082076B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWPOBpEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01082076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfero-0002GL-Oj
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 03:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jfepz-0001KC-SV; Mon, 01 Jun 2020 03:26:23 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jfepx-0005Yx-JI; Mon, 01 Jun 2020 03:26:23 -0400
Received: by mail-ed1-x544.google.com with SMTP id g1so5635471edv.6;
 Mon, 01 Jun 2020 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=01TZDSO3dojveQeklKTr8Gf5qjCbs63AIjG69MKbth4=;
 b=SWPOBpENIza2X2ovj4OdRkqXs/ryMDs5pbXsYp0qV9Tqvikk43s4k4FA6pLWSZJcmA
 A8N4bNAUAWEnkUGqT9Ej8DTnxjW1j/5SXBQJ4atyzZ15ku4N4/sDUAUqhewYxv6SZo4O
 PKhADaAdEjTM+vlKXo0giH5kPQwgHstBHaCJFMPtZ1pwEk/KIOvMqO47cUpEKlsTUoSg
 JwkLaoqGqT7ypzkMpQTmqGUSLef1yRYADCZfbTzLuFBanxdvlXgPTx69CNlTvDsgPlrJ
 CqV1QpS1V7AHwmM7U4qwlh7nNbBMKwZVKDgLxeEKTDV+GxQVuhYgfqimCaLJ/BInDC0k
 4ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=01TZDSO3dojveQeklKTr8Gf5qjCbs63AIjG69MKbth4=;
 b=jeZYL0iX6xoh51Sy7QBjO9CBc0X+sIWQwoFsoBS0ojWX5Tplpgix5gwGlZy80hxw6R
 wJVDU6D63AzXzMpOeopTPSuhrSbpic+01XPVMs+39azItT5c1PioKWhkkVRGtbg9WdHe
 6MMDWuEptaomalmuaQgbBkklOAgc5GGrfGEA19tn9LhC0RE9sUy1fVPrMAonLJN0VhQJ
 7w4uw8sOqSgtd+xzq00zxDGoEA5c513TqMuK/xD/65l+PN+0G+3qyKbXn4zLlWBMUSSn
 wF67nJjUfObrWBCm+GEoAsHXkYEA2i8dtJm7w18BFrdeWtbwEnyDpuDeYcKVpowbu6Q7
 qPVA==
X-Gm-Message-State: AOAM532xAb/joBDtm13+O9WU7OInpLcUXmqjo6YAJ0caDHkkBi0EBwye
 7Zd19LbnONqHr0qAAek10pE=
X-Google-Smtp-Source: ABdhPJyfRslWjZ3RjWM9oZQ++gfLq4y6Y5KnkAMbIiJFd+YvpBjLyYaKNlGBTfvqqWbxOr9NJ7Y0cg==
X-Received: by 2002:aa7:cb94:: with SMTP id r20mr20679771edt.215.1590996378792; 
 Mon, 01 Jun 2020 00:26:18 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id w12sm15278153eds.4.2020.06.01.00.26.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 00:26:18 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <f4bug@amsat.org>,
 <qemu-devel@nongnu.org>
References: <20200531173814.8734-1-f4bug@amsat.org>
 <20200531173814.8734-8-f4bug@amsat.org>
In-Reply-To: <20200531173814.8734-8-f4bug@amsat.org>
Subject: RE: [PATCH 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix
 definitions
Date: Mon, 1 Jun 2020 08:26:16 +0100
Message-ID: <000001d637e5$f0c4b4f0$d24e1ed0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQK5AEx/dP7iXwJVovNs/KrDX2tj3QLWDH7zpucakaA=
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Reply-To: paul@xen.org
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Eduardo Habkost' <ehabkost@redhat.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>, 'Andrew Jeffery' <andrew@aj.id.au>,
 'Helge Deller' <deller@gmx.de>, 'Joel Stanley' <joel@jms.id.au>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?'Herv=C3=A9_Poussineau'?= <hpoussin@reactos.org>,
 =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>,
 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, 'Richard Henderson' <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.com> =
On Behalf Of Philippe Mathieu-Daud=C3=A9
> Sent: 31 May 2020 18:38
> To: qemu-devel@nongnu.org
> Cc: Andrew Jeffery <andrew@aj.id.au>; Helge Deller <deller@gmx.de>; =
Peter Maydell
> <peter.maydell@linaro.org>; Richard Henderson <rth@twiddle.net>; =
Eduardo Habkost
> <ehabkost@redhat.com>; Paul Durrant <paul@xen.org>; Herv=C3=A9 =
Poussineau <hpoussin@reactos.org>; Marcel
> Apfelbaum <marcel.apfelbaum@gmail.com>; =
xen-devel@lists.xenproject.org; Paolo Bonzini
> <pbonzini@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>; =
C=C3=A9dric Le Goater <clg@kaod.org>;
> qemu-trivial@nongnu.org; Joel Stanley <joel@jms.id.au>; =
qemu-arm@nongnu.org; Michael S. Tsirkin
> <mst@redhat.com>; Anthony Perard <anthony.perard@citrix.com>; =
qemu-ppc@nongnu.org; Philippe Mathieu-
> Daud=C3=A9 <f4bug@amsat.org>
> Subject: [PATCH 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix =
definitions
>=20
> IEC binary prefixes ease code review: the unit is explicit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i386/xen/xen-hvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 82ece6b9e7..679d74e6a3 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -9,6 +9,7 @@
>   */
>=20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>=20
>  #include "cpu.h"
>  #include "hw/pci/pci.h"
> @@ -230,7 +231,7 @@ static void xen_ram_init(PCMachineState *pcms,
>           * Xen does not allocate the memory continuously, it keeps a
>           * hole of the size computed above or passed in.
>           */
> -        block_len =3D (1ULL << 32) + x86ms->above_4g_mem_size;
> +        block_len =3D 4 * GiB + x86ms->above_4g_mem_size;

Not strictly necessary but could we retain the brackets please?

  Paul

>      }
>      memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
>                             &error_fatal);
> --
> 2.21.3



