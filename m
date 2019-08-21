Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465ECC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2292339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2292339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Qfl-0002fl-BX
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0Qci-0007fS-TB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0Qch-0001b7-GV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0Qch-0001aj-9O
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:25:59 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F77183F4C
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:25:58 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id v15so1232864wrg.13
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GqKn29SWMbJRkwcj2D71PwBa39tuXlL9JMmgWiJEmVA=;
 b=V1NNVuAadd8/54nIzAmfj3h7HzYdWb8kx4wnWaYf1TT6EELXVQdt+o79psQBwqcag9
 jAbxerf1OSqMKqIqadHWc14RAaCpoaDs3dQK6CDv83o0aGeSq/2LAL4c3+OG57FdPgz5
 iu6QXw7nSD5Ra8++UDg3cGRShl722MToX+cCiOFn5AAjz/pfBriiMZPsLomuqMjKgrkJ
 LQfgizMmslDyv+Fb2jrQwaJMmmUnJC8WVxDxvigXs+71ALA3qdKlEdPLd8y5Pco3lf4c
 ZWzU67JxQukW1HufikXbjhjWOIXhk0vTOE3ReR2idkAj9jPqUdY6i/VWH2I84OrCvUHx
 xaiw==
X-Gm-Message-State: APjAAAVQgqUwOqv1rEMj2R+A5tjMO5MBasf5YowTdEfiknJZusSDyFPC
 mtoc7cISXoLf0LaPrhSwm1DgZdKR1IAJIVbysibMgu8VlIUl0O4qnV6QPpvXugC8bSrtBShTjUK
 T/nJ2rV0JRY0Bv08=
X-Received: by 2002:a7b:c019:: with SMTP id c25mr3645wmb.116.1566393957084;
 Wed, 21 Aug 2019 06:25:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxWyV1rJzq3GoaXz5I/qXj/EJpaW69m6fK/12yqrCC5Jgu74qUkacSmM2nFtwm5lJUxKdjqoA==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr3623wmb.116.1566393956860;
 Wed, 21 Aug 2019 06:25:56 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id p9sm21430447wru.61.2019.08.21.06.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 06:25:56 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-45-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ca8d024c-c9c8-dc0d-d025-3a3cf50bf155@redhat.com>
Date: Wed, 21 Aug 2019 15:25:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819213755.26175-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 44/68] target/arm: Add skeleton for T16
 decodetree
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 11:37 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/translate.c   |  6 ++++++
>  target/arm/Makefile.objs |  6 ++++++
>  target/arm/t16.decode    | 20 ++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>  create mode 100644 target/arm/t16.decode
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 49bab7d863..90d608a2d2 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7538,6 +7538,7 @@ static int t32_branch24(DisasContext *s, int x)
>  #include "decode-a32.inc.c"
>  #include "decode-a32-uncond.inc.c"
>  #include "decode-t32.inc.c"
> +#include "decode-t16.inc.c"
> =20
>  /* Helpers to swap operands for reverse-subtract.  */
>  static void gen_rsb(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
> @@ -10550,6 +10551,11 @@ static void disas_thumb_insn(DisasContext *s, =
uint32_t insn)
>      TCGv_i32 tmp2;
>      TCGv_i32 addr;
> =20
> +    if (disas_t16(s, insn)) {
> +        return;
> +    }
> +    /* fall back to legacy decoder */
> +
>      switch (insn >> 12) {
>      case 0: case 1:
> =20
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 7806b4dac0..cf26c16f5f 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -43,12 +43,18 @@ target/arm/decode-t32.inc.c: $(SRC_PATH)/target/arm=
/t32.decode $(DECODETREE)
>  	  $(PYTHON) $(DECODETREE) --static-decode disas_t32 -o $@ $<,\
>  	  "GEN", $(TARGET_DIR)$@)
> =20
> +target/arm/decode-t16.inc.c: $(SRC_PATH)/target/arm/t16.decode $(DECOD=
ETREE)
> +	$(call quiet-command,\
> +	  $(PYTHON) $(DECODETREE) -w 16 --static-decode disas_t16 -o $@ $<,\
> +	  "GEN", $(TARGET_DIR)$@)
> +
>  target/arm/translate-sve.o: target/arm/decode-sve.inc.c
>  target/arm/translate.o: target/arm/decode-vfp.inc.c
>  target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
>  target/arm/translate.o: target/arm/decode-a32.inc.c
>  target/arm/translate.o: target/arm/decode-a32-uncond.inc.c
>  target/arm/translate.o: target/arm/decode-t32.inc.c
> +target/arm/translate.o: target/arm/decode-t16.inc.c
> =20
>  obj-y +=3D tlb_helper.o debug_helper.o
>  obj-y +=3D translate.o op_helper.o
> diff --git a/target/arm/t16.decode b/target/arm/t16.decode
> new file mode 100644
> index 0000000000..e954f61fe4
> --- /dev/null
> +++ b/target/arm/t16.decode
> @@ -0,0 +1,20 @@
> +# Thumb1 instructions
> +#
> +#  Copyright (c) 2019 Linaro, Ltd
> +#
> +# This library is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU Lesser General Public
> +# License as published by the Free Software Foundation; either
> +# version 2 of the License, or (at your option) any later version.
> +#
> +# This library is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# Lesser General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public
> +# License along with this library; if not, see <http://www.gnu.org/lic=
enses/>.
> +
> +#
> +# This file is processed by scripts/decodetree.py
> +#
>=20

