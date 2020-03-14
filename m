Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F9DC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDD12074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze7ZmtVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDD12074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD3O9-0008OF-QW
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 05:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jD3NI-0007wL-6m
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jD3NH-0007Pr-2H
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:46:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34664
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jD3NG-0007Kd-TS
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584179189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfEvVe0ieZ+PIfex7rTp+QsWCQhNh8o0eq3b95oA1Qg=;
 b=Ze7ZmtVpNxz0tgku8xY8mI5n7WEXOTuwoEgMSGbfGnBVq7zd8pgoYzDlsaQPGX7IGjvKC+
 zNH8Nw3L3HG5hT4xp2L7CHs/ENVTjAspoRK+yb3wfS0ZTfsbATMISfF6/eZ8hQAFfc0vAD
 O+E4IgxvTv7fL+/m4dpgBXYPDbKejao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-GKvaHAs_NDmMFundKX96QQ-1; Sat, 14 Mar 2020 05:46:27 -0400
X-MC-Unique: GKvaHAs_NDmMFundKX96QQ-1
Received: by mail-wr1-f69.google.com with SMTP id p5so5643755wrj.17
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 02:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2HccAC5iqcs2nWHhAWIO9mXkYavwl1bIV8SYyF3n+Zo=;
 b=bQs8nUfVnQNFJsGEt4BMDvjYYRRw0xyhlxlBKSK8UM1ZFXFxdfC3AS+l+7LrnyHWkg
 hgJzTLVefROpbU/cQ/lyD1ReMD3CSfiRtrD0S7X8cpODGVj3gzBVmjUTQ69jFmH2Ln1a
 GpW+8a1g4SImORFVwiDWHtXLC4QuC4g29kbDyJnBc3j+M30IdA5pdvqswJ0Afk8tnXGX
 k0eptz2ID4DCLJ/2w1XgukilWtzzE8G2TA6uJT/2J2wGMSgFwTd+dzrNvcIeQ3MYug0J
 5iWFUC0pDsrjId03zhBhJNqQ9tNj3t5ZiGkQPU6tzEofo6b2NVYVFnTP1KRTXjEOp/Gm
 zNKg==
X-Gm-Message-State: ANhLgQ0sIkN9TmbcmDKy3MtvzCbnPwOyXfuwlsIcD5CjF6tez3EbP54T
 Y3DMs44op5ctSAedj+tZuh2/EnbemvFBDc3Qtr7bwNV1hggmxnlPX6Din74i2kPNz5iNdnhL1+o
 wodX85pA27XMzhQA=
X-Received: by 2002:a5d:414d:: with SMTP id c13mr24264416wrq.40.1584179185944; 
 Sat, 14 Mar 2020 02:46:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvNEpXGsqMbLyV0nWrNHw3U5xW6HekZKSM3aY5NE2LbbHJXD++BHwgl7Gd28F0TIN4VvlZbxA==
X-Received: by 2002:a5d:414d:: with SMTP id c13mr24264392wrq.40.1584179185725; 
 Sat, 14 Mar 2020 02:46:25 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id y3sm47646263wrm.46.2020.03.14.02.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 02:46:25 -0700 (PDT)
Subject: Re: [PATCH 8/9] hw/core: Add qdev stub for user-mode
To: qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-9-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7775dd60-7c5d-e973-162d-5eb742b41c07@redhat.com>
Date: Sat, 14 Mar 2020 10:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313184607.11792-9-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 7:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> While user-mode does not use peripherals (devices), it uses a
> CPU which is a device.
> In the next commit we will reduce the QAPI generated code for
> user-mode. Since qdev.c calls qapi_event_send_device_deleted(),
> let's add a stub for it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/core/qdev-stubs.c  | 20 ++++++++++++++++++++
>   hw/core/Makefile.objs |  1 +
>   2 files changed, 21 insertions(+)
>   create mode 100644 hw/core/qdev-stubs.c
>=20
> diff --git a/hw/core/qdev-stubs.c b/hw/core/qdev-stubs.c
> new file mode 100644
> index 0000000000..0819dcba12
> --- /dev/null
> +++ b/hw/core/qdev-stubs.c
> @@ -0,0 +1,20 @@
> +/*
> + * QAPI qdev stubs
> + *
> + * Copyright (c) 2020 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/qapi-events-qdev.h"
> +
> +void qapi_event_send_device_deleted(bool has_device,
> +                                    const char *device, const char *path=
)
> +{
> +}
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 6215e7c208..89bf247173 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -8,6 +8,7 @@ common-obj-y +=3D vmstate-if.o
>   # irq.o needed for qdev GPIO handling:
>   common-obj-y +=3D irq.o
>  =20
> +common-obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o

This should be:

    obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o

(not common).

>   common-obj-$(CONFIG_SOFTMMU) +=3D reset.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>=20


