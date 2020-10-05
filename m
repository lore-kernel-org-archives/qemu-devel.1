Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08314C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7843E2083B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2KNUjxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7843E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPO49-00085E-Cp
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPO32-0007em-20
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:48:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPO2z-0001D4-NE
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:48:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so3560851wrp.10
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=P9gU8ZNa/Cy3R6kc7LXLMx5orvGKQrA7KN2BHyDXrAQ=;
 b=E2KNUjxmJO0akFlCS5EZgFIT4MIGkNzTqTwAWZyhSy5StRSQFpcwo2/hYuXbdmd3YB
 no77fOwTko8pOC+tyFgINEhKoa4IE8A36zgETH9t3W2DxD6V+Hne0v3t/DRGBSv0iA/b
 iSTWwcCVH4cJ0NmoQoFKbOq5wyNdcbUkxjKbCV0gskoL/egbRo7YY9MFAvSJbxNy/Eqv
 TdNYj5bOJupeQ5E2aoIUqaVrFh1qEzjTpN6KY+Cr1QsDdmqJ4En/a1G/3GGgaSUX7+Fy
 tG1BENzRcbUwMPpvOzFuzOCQnChYDvS+fRaSGuFtJ2N7TLanLT91573FjOaouoOlcycy
 IV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=P9gU8ZNa/Cy3R6kc7LXLMx5orvGKQrA7KN2BHyDXrAQ=;
 b=STMAAVGdZGfs5ID6ChELBIdELIIyEVIzx9qsqEoN3gEXBW3favaSvscieFAlFNM6/8
 d7iDr6j2s1rNtFz7IezGXw9MqZRSg5ZtfNY1VKh4ewjZYQJTeajC8F51oKfIANs/Q+ck
 euhNIGisC5j1PachqrmMHFbLmWuKRLu99cNDR8UMVTYmNXwAty2qqeA+0QnRL0xO8iit
 vtRxOWLNBsqluKbSmMY24B7yranOwwblvKb7AxCFrd1m0//BA2T18etlOjyu9zQaRg13
 rLKUt+VbvkWwLoCr6vxnbIZLXUUzf3k1PmCWZYjed3WFxdwRXBXiLIdhZFSvveC46E/P
 zT8g==
X-Gm-Message-State: AOAM531BlrhV1YGwawU1dDwYw+LZWTFW/VF++W+d5ePQXKSfCWQQQTm5
 uUiP1xg0vPiOKSyymjsm5U7lBg==
X-Google-Smtp-Source: ABdhPJycgP8sYTVERJBOsHCP+GB6qkCwYHMneuOQSeUhI2OtTWUjVTLpa5LixLyHyE10QOQprWf2aA==
X-Received: by 2002:a5d:61c7:: with SMTP id q7mr17198303wrv.343.1601894927472; 
 Mon, 05 Oct 2020 03:48:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a5sm12625312wrp.37.2020.10.05.03.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:48:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF6181FF7E;
 Mon,  5 Oct 2020 11:48:45 +0100 (BST)
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-6-luoyonggang@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 5/6] plugin: getting qemu_plugin_get_hwaddr only
 expose one function prototype
In-reply-to: <20201001163429.1348-6-luoyonggang@gmail.com>
Date: Mon, 05 Oct 2020 11:48:45 +0100
Message-ID: <87pn5x2bjm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yonggang Luo <luoyonggang@gmail.com> writes:

> This is used for counting how much function are export to qemu plugin.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  plugins/api.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/plugins/api.c b/plugins/api.c
> index f16922ca8b..d325084385 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -252,10 +252,12 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t=
 info)
>=20=20
>  #ifdef CONFIG_SOFTMMU
>  static __thread struct qemu_plugin_hwaddr hwaddr_info;
> +#endif
>=20=20
>  struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t =
info,
>                                                    uint64_t vaddr)
>  {
> +#ifdef CONFIG_SOFTMMU
>      CPUState *cpu =3D current_cpu;
>      unsigned int mmu_idx =3D info >> TRACE_MEM_MMU_SHIFT;
>      hwaddr_info.is_store =3D info & TRACE_MEM_ST;
> @@ -267,14 +269,10 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(q=
emu_plugin_meminfo_t info,
>      }
>=20=20
>      return &hwaddr_info;
> -}
>  #else
> -struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t =
info,
> -                                                  uint64_t vaddr)
> -{
>      return NULL;
> -}
>  #endif
> +}

Hmm I'm not sure about this, surely you want the plugin system to
complain early if your plugin is going to use a function that is
incorrect for the mode you are running in?

Although we do currently unconditionally export the syscall functions
and arguably they should be CONFIG_USER only as well.

>=20=20
>  bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
>  {


--=20
Alex Benn=C3=A9e

