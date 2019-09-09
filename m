Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8282DC433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDDB21920
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICILznEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDDB21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Fhz-0006kw-FZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7FhI-0006Jz-DH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7FhG-0000Wn-W5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:10:56 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:44092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i7FhG-0000VG-Qn
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:10:54 -0400
Received: by mail-oi1-x22c.google.com with SMTP id w6so9883008oie.11
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=QmGoxJq9yft+YcIwS00sNNWjuulrNyBFUpzgfuK/BQg=;
 b=ICILznEPq7LvP7UHzY79nQbOb7dnQXX+EC9PbpQktTVhTQKuFysz0/Wf8a5/EddOzO
 nDRTyTp350cFbJyJuP90Oy7uUqg3HgOMwzh29dINBK6K+FIRbFCBx0lMgTeNZfB8iuJQ
 Pw3bcajIp4Sr7KCfDAyS6vGaAp6Oy1PeKxa1FOv83GnuqdS6RVRWrNo+Dn+i8eEpfAb3
 wNaEReqcKU+VFnnPdd2pDj06VUjLQHzBLrc9agE28BN91jEg0T0SzQcKV4RPekPZyJOY
 IHAd5/XAavTY/B9vxvbRNs/Q2yf9IMMjtiP5th58v00IQ7S5QWF0EqwTDf6TTJ445lcD
 JmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=QmGoxJq9yft+YcIwS00sNNWjuulrNyBFUpzgfuK/BQg=;
 b=YynsE4bwehHtsR8BzDzqHzk0XEKOear9RkcK62Yafovj/NWtiqhd9wEFlPvUDzX9RJ
 /OYPRvi9Ir9AF4owt7uGLwwupmFIN9ABwN1CZX1a0AT85gcuymWa3Sv7gdCqTpyKvACA
 V1woWzp+FB75ftAcimyugkoilSj9roZMpsRHxEGIB6pE4MViw9gnbqSAmnIeo1IzEQlr
 9w8wvsUo+QUnD8vQWWVKlZkVQnR9xZ/Y1nwYDStM6KjfU2K7zwV2seMyJ5Me9suxT9hm
 DYG0f3+9iy5XeZIqUTjfHYo4yu0SERATl44TvUxFtmAYoNr/o66WgU+E+ysZSwiBL0SE
 THcg==
X-Gm-Message-State: APjAAAXDtphpi8z48LarS00eG6WdX9rUeIkT9PFGUSjfsEERMMmVk4QD
 AzrUf1DCEWChU3Vz1ZdJknl5ePw+ClX/H+7eEc8=
X-Google-Smtp-Source: APXvYqzOZlfjZmoVAKVwJy+fd5dcrWzaNC3opc//H92xzZ2xL6IhFUkSFxjUWY8jcFv1BK3z+QpPCDdGbQGShUh/XI4=
X-Received: by 2002:aca:7291:: with SMTP id p139mr16372172oic.53.1568020252868; 
 Mon, 09 Sep 2019 02:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Mon, 9 Sep 2019 02:10:52 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Mon, 9 Sep 2019 02:10:52 -0700 (PDT)
In-Reply-To: <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Sep 2019 11:10:52 +0200
Message-ID: <CAL1e-=hTw6UEBOoTq8PVZ_yry-HGN3MCkd=CO+k7pJmL-GwXPA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<amarkovic@wavecomp.com> wrote:
> > ...
> > tcg_gen_extend_s_i32_i64
> > tcg_gen_extend_0_i32_i64
>
> These should not drift too far from the other extension names,
>
>     tcg_gen_ext{8,16}{u,s}_i32
>     tcg_gen_ext{8,16,32}{u,s}_i64
>
> What if we use the AArch64 mnemonics: zxt (zero-extend) and sxt
(sign-extend)?
>  This would give us
>
>     tcg_gen_zxt8_i32
>     tcg_gen_sxt8_i32
>     (etc)
>     tcg_gen_zxt_i32_i64
>     tcg_gen_sxt_i32_i64
>

After a while, I realized that this idea would remove majority of potential
confusing spots, and even make names slightly shorter: (suppose other names
would remain intact)

* tcg_gen_ext8s_i32 t0, t1  to  tcg_gen_sxt8_i32 t0, t1
* tcg_gen_ext8u_i32 t0, t1 to  tcg_gen_zxt8_i32 t0, t1
* tcg_gen_ext16s_i32 t0, t1  to  tcg_gen_sxt16_i32 t0, t1
* tcg_gen_ext16u_i32 t0, t1  to  tcg_gen_zxt16_i32 t0, t1

8 or 16-bit sign/zero extension (both operands must be 32-bit)

* tcg_gen_ext8s_i64 t0, t1  to  tcg_gen_sxt8_i64 t0, t1
* tcg_gen_ext8u_i64 t0, t1 to  tcg_gen_zxt8_i64 t0, t1
* tcg_gen_ext16s_i64 t0, t1  to  tcg_gen_sxt16_i64 t0, t1
* tcg_gen_ext16u_i64 t0, t1  to  tcg_gen_zxt16_i64 t0, t1
* tcg_gen_ext32s_i64 t0, t1  to  tcg_gen_sxt32_i64 t0, t1
* tcg_gen_ext32u_i64 t0, t1  to  tcg_gen_zxt32_i64 t0, t1

8, 16 or 32-bit sign/zero extension (both operands must be 64-bit)

* tcg_gen_ext_i32_i64 t0, t1  to  tcg_gen_sxt_i32_i64 t0, t1

Convert t1 (32-bit) to t0 (64-bit) and does sign extension

* tcg_gen_extu_i32_i64 t0, t1  to  tcg_gen_zxt_i32_i64 t0, t1

Convert t1 (32-bit) to t0 (64-bit) and does zero extension

Any observation?

Thanks,

Aleksandar

>
> r~
>
