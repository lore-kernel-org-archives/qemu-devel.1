Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BC1C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 06:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D89206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 06:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOHxWgHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D89206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR9LA-0003sj-Kp
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 02:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jR9KV-0003R0-U1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jR9KU-0003II-VZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:57:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59479
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jR9KU-0003Br-Hc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587538672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9Khf0S83IMMMFH5SsF2u/hzV7mixM2tndfv5CZs/xo=;
 b=SOHxWgHVm75eoY3UGmB1h+7wn5lzdf8KV0Fs41b3eOymn9ozvlanaK4tjcqA/BzJnYCbUu
 t7bgTtRvFkfP06pHrEZ9wT17rcgU2Ffnfm32nohobXRojCMaJXNHXUAjews3+5ZVi6XDZ5
 z3muEQ8hZ0ZHfj39WhgtpY2Or+jDD3s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-tlvKxcc5OPK58mhsH3drYw-1; Wed, 22 Apr 2020 02:57:50 -0400
X-MC-Unique: tlvKxcc5OPK58mhsH3drYw-1
Received: by mail-wr1-f72.google.com with SMTP id r17so581020wrg.19
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 23:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=72V92ihuZyarwtwtontyRZ05m7UjMoqRzglk9a/a4M8=;
 b=re8VBBsg0vLs6DCK8176AGOHZsW22mmYGHqrGQzqThzZlG194oj0sZnXVfLof09BEQ
 BztAGMdjbjRgokiV0P+hLnXXTBJWAnPcK0PHq/Rs8xVWckTa79v4TAe+bYz6j755taEV
 xMET6q88f1hIlcLFQL3MtsA6COixWxiBWJHi5FUZ4HGQoIQTjdab7GXfPf/lX/CUXB+V
 JFvZesmqw7yRPIRTQoUfjCdjBvsekKH+lofBih5nMqfKrlz5Mqzw9AbTRIGJVy8PbDqo
 pG+zAJeSyIF/it2sBlp0uCJyD6vE4QspdBrz5Ge+9FPoXb4XV6rSudYW4TPL3QWKuqT1
 nmmw==
X-Gm-Message-State: AGi0PuYX3d4EipfpbKRbB1HpNJA3xVS5c3ozjM1fFvkIQWFdSspVdv1G
 zcSBKO4GvsLbvDxW06irtbaS2cpd3RApCH+P57yW6+h38Up85SyElWPQV5kGpBQPp6lktxiEQul
 w/voieQNZKbUulVk=
X-Received: by 2002:a05:600c:2645:: with SMTP id
 5mr8657815wmy.168.1587538669191; 
 Tue, 21 Apr 2020 23:57:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwfAjryvsJSHqQtrt4eQIZJNxgtkwRm/jhP1i/obi/30UfEimpbJkp8Di5vOMbr6ktn6MD2A==
X-Received: by 2002:a05:600c:2645:: with SMTP id
 5mr8657799wmy.168.1587538668953; 
 Tue, 21 Apr 2020 23:57:48 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s12sm6195547wmc.7.2020.04.21.23.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 23:57:48 -0700 (PDT)
Subject: Re: [PATCH 6/6] target/arm: Restrict TCG cpus to TCG accel
To: qemu-devel@nongnu.org
References: <20200421131926.12116-1-philmd@redhat.com>
 <20200421131926.12116-7-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <33af5de5-96e8-3537-d290-2a43f6827a18@redhat.com>
Date: Wed, 22 Apr 2020 08:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200421131926.12116-7-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 3:19 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> A KVM-only build won't be able to run TCG cpus.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This patch review is funnier using:
> 'git-diff --color-moved=3Ddimmed-zebra'
> ---
>   target/arm/cpu.c         | 634 -------------------------------------
>   target/arm/cpu_tcg.c     | 663 +++++++++++++++++++++++++++++++++++++++
>   target/arm/Makefile.objs |   1 +
>   3 files changed, 664 insertions(+), 634 deletions(-)
>   create mode 100644 target/arm/cpu_tcg.c
[...]
> diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
> new file mode 100644
> index 0000000000..899d3ac7bc
> --- /dev/null
> +++ b/target/arm/cpu_tcg.c
> @@ -0,0 +1,663 @@
> +/*
> + * ARM generic helpers.
> + * QEMU ARM CPU

Here I meant one line "QEMU ARM TCG CPU" instead of "ARM generic=20
helpers. QEMU ARM CPU"

> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "internals.h"
> +
> +/* CPU models. These are not needed for the AArch64 linux-user build. */
> +#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)[...]


