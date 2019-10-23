Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666EBCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1AB2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY4kMsiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1AB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNO3M-0002lu-Uz
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 17:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNKri-0005DL-Tl
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNKre-0005hY-BU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:56:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29821
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNKra-0005eC-EZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571853361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V17e9w4VZ/sRplMGBacPciw87+P8AjTgevZX+f/EuDY=;
 b=WY4kMsiJyQGKmE4s5GLhZ+UsOpHwmScjzzSimfj4dt64KAw77cj7PBxgFSzHcY8hk97q8z
 5JlVZTBREf0t1YBw/FgQ1aAf2bVwECV2a4KRsXA8CO1nlJ3nyr0xllQ7r4wT1yaxFUDGed
 qvgBo5oXv0apNM/P29I3n48MV/cqmJs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-an4seo8bMiewK0jf8cUAoA-1; Wed, 23 Oct 2019 13:56:00 -0400
Received: by mail-wr1-f69.google.com with SMTP id f4so11391488wrj.12
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BhuKc4XGTaz6vsD/c/Vl350EvmpVjQ/JTR0Qe98Nxg0=;
 b=ILgL/8bvZntTWXOzhVeitzGshQ7af1Tt8R324H2c80XlGZF8odla3yYKn212om6QuE
 MV3+s1bsG+LoGA4XXbDYzIssveByKuAS8+evZ7cE64l5H6bxx8x7sx51yXRdl605M+Xr
 eVcieHrgP6qCYXhzfBqxxcZxfeFFi0YQFQ59vVUYOE2mIybMzjkrIamaMLxFFV6myiBP
 Vt2Qwa95Ok3+UDhTouGiFXybLZhRh1bV4h4I+yTP99eNBDnIl0M/OL2kmvyNTq6PpGEb
 NQs4F5YWJjwy7Ik9jboNZcqPZcgFN3knAlqUCA9kmjn7nTzszXxBsy4D9JhqXQoFh4c9
 D2lA==
X-Gm-Message-State: APjAAAUJuMI633CGvfeWYLc1hYhbf5SsA6AGLMs8GB5sI4GP4xij/KIM
 XwV2YXwqaGet3cZrkj43irXAWJaYRl22W1bXtzbCVvFDrHAzm8fVA29hVIGdpufIoEhJwmuTm8P
 64CzaNYTqoWO9IF8=
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr971963wme.161.1571853359268;
 Wed, 23 Oct 2019 10:55:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTHydLQX4etoD/pBBXyKCbonP0FpSlQrwDs+qMwpHtFngN3CgpIJIeThXWap/6kUEt0IvsyQ==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr971948wme.161.1571853359064;
 Wed, 23 Oct 2019 10:55:59 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id y5sm11190369wmi.10.2019.10.23.10.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 10:55:58 -0700 (PDT)
Subject: Re: [PATCH] translate-all: Remove tb_alloc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191023164645.5518-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d52f0299-12ff-a070-1171-2d6e0f73385d@redhat.com>
Date: Wed, 23 Oct 2019 19:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023164645.5518-1-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: an4seo8bMiewK0jf8cUAoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 6:46 PM, Richard Henderson wrote:
> Since 2ac01d6dafab, this function does only two things: assert a
> lock is held, and call tcg_tb_alloc.  It is used exactly once,
> and its user has already done the assert.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>=20
> I noticed that this function was essentially a stub while
> reviewing Clement's tb->orig_tb fix.
>=20
> Note that the added newline in tb_gen_code both adds the
> missing break after the variable declaration block and
> also happens to highlight the assert mentioned above.  ;-)
>=20
>=20
> r~
>=20
> ---
>   accel/tcg/translate-all.c | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)
>=20
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f9b7ba159d..ae063b53f9 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1156,23 +1156,6 @@ void tcg_exec_init(unsigned long tb_size)
>   #endif
>   }
>  =20
> -/*
> - * Allocate a new translation block. Flush the translation buffer if
> - * too many translation blocks or too much generated code.
> - */
> -static TranslationBlock *tb_alloc(target_ulong pc)
> -{
> -    TranslationBlock *tb;
> -
> -    assert_memory_lock();
> -
> -    tb =3D tcg_tb_alloc(tcg_ctx);
> -    if (unlikely(tb =3D=3D NULL)) {
> -        return NULL;
> -    }
> -    return tb;
> -}
> -
>   /* call with @p->lock held */
>   static inline void invalidate_page_bitmap(PageDesc *p)
>   {
> @@ -1681,6 +1664,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       TCGProfile *prof =3D &tcg_ctx->prof;
>       int64_t ti;
>   #endif
> +
>       assert_memory_lock();
>  =20
>       phys_pc =3D get_page_addr_code(env, pc);
> @@ -1706,7 +1690,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       }
>  =20
>    buffer_overflow:
> -    tb =3D tb_alloc(pc);
> +    tb =3D tcg_tb_alloc(tcg_ctx);
>       if (unlikely(!tb)) {
>           /* flush must be done */
>           tb_flush(cpu);
>=20


