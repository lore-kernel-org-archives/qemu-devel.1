Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63517C4363D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0884F20639
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEYfMq/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0884F20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSjm-00037B-3L
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPSgj-0007zz-Rk
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:46:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPSgg-0000Dz-G6
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:46:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id j2so10151079wrx.7
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JZKuhGFzfHPjhry18zf7BYX9WOO14izstBDB8CGwCbY=;
 b=MEYfMq/7Z3E+K+swflKXw+OwgI2wCVOAn5PPavD4exKlFZhhAZyyhkWvBXsTfizC2x
 gu8pcceqECS0HVWSPRTnlQQnr2D4U3WXhQsQK+RR5lP37Cm0NO7nI9P0Ad2+0JVTkiXh
 kTJ0XptqBGDRj6Q6a8wAhHfCGBtog6fvJdDo3zEklOWVtv2xIrpg+bWma7NKLaPFFUMT
 sZR91AGrVKp7EHF+7DlZ8QqxYh3MkCOcasnKG6cHGOYB7ov1/VyRFyX3YrmHP2ruos0Y
 p0OK6PPV5djTZBgHiHY32mjnsCuWZQr41P9QaxSsK9Lc+LxuQRfy900hhjR6O76gJaRQ
 mWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JZKuhGFzfHPjhry18zf7BYX9WOO14izstBDB8CGwCbY=;
 b=CLpsfGIBfhhl5ZlBlojGVCjQPRU81Uqcu+EQRxwb8IsQzRxQnFLRHMh3mj4l/eNNlB
 7Tp9ZGLDe4Pjxc9HS11NY81EYw2U+CvqWdyG2eh37iJFHox5x+A9sdA7fCetRq1hjYKa
 o4pSAr08O4hGPyMR6eY7g+L2DzD2KJ/sKEGqojISLjtAP2ekaFq9JJjAoJEHimkTR+s9
 F89LpZNsjbyD1yPXRJVhPfLl59uov41KwnWEDzdNxfnN1Hwtd1bYCIShngvJT8VqUfRh
 V1Yjk5pkFdIQ3S8Ws7KXw/ycfglaxxKjzfjKdu84fnpe80zGwqX1m3QJp2b9wv6h224o
 65Bw==
X-Gm-Message-State: AOAM530RP/P88JbDEDHJ29NSfpfqkS/Yd1omBMLzvBSA5SSOa68JDJfY
 nbMxXCcUFs/7ai4rlvFL2u5osA==
X-Google-Smtp-Source: ABdhPJw2Xw/6/S3CtCz+eDMJI8xtPp0OHiWmfKRSR2Ifq+JXQVrcB4cIDwUxRgy2MjmGq104SK75Mw==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr28417wrw.18.1601912762827;
 Mon, 05 Oct 2020 08:46:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u66sm627409wme.1.2020.10.05.08.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:46:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BA2E1FF7E;
 Mon,  5 Oct 2020 16:46:00 +0100 (BST)
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-6-luoyonggang@gmail.com> <87pn5x2bjm.fsf@linaro.org>
 <CAE2XoE8GQ3K0gp6Pr2eeq3R=X_1Mc9tPkmjVKx-TeS0G+WFJcw@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: [PATCH v3 5/6] plugin: getting qemu_plugin_get_hwaddr only
 expose one function prototype
In-reply-to: <CAE2XoE8GQ3K0gp6Pr2eeq3R=X_1Mc9tPkmjVKx-TeS0G+WFJcw@mail.gmail.com>
Date: Mon, 05 Oct 2020 16:46:00 +0100
Message-ID: <87k0w43ccn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Mon, Oct 5, 2020 at 6:48 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>>
>> Yonggang Luo <luoyonggang@gmail.com> writes:
>>
>> > This is used for counting how much function are export to qemu plugin.
>> >
>> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> > ---
>> >  plugins/api.c | 8 +++-----
>> >  1 file changed, 3 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/plugins/api.c b/plugins/api.c
>> > index f16922ca8b..d325084385 100644
>> > --- a/plugins/api.c
>> > +++ b/plugins/api.c
>> > @@ -252,10 +252,12 @@ bool
> qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
>> >
>> >  #ifdef CONFIG_SOFTMMU
>> >  static __thread struct qemu_plugin_hwaddr hwaddr_info;
>> > +#endif
>> >
>> >  struct qemu_plugin_hwaddr
> *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
>> >                                                    uint64_t vaddr)
>> >  {
>> > +#ifdef CONFIG_SOFTMMU
>> >      CPUState *cpu =3D current_cpu;
>> >      unsigned int mmu_idx =3D info >> TRACE_MEM_MMU_SHIFT;
>> >      hwaddr_info.is_store =3D info & TRACE_MEM_ST;
>> > @@ -267,14 +269,10 @@ struct qemu_plugin_hwaddr
> *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
>> >      }
>> >
>> >      return &hwaddr_info;
>> > -}
>> >  #else
>> > -struct qemu_plugin_hwaddr
> *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
>> > -                                                  uint64_t vaddr)
>> > -{
>> >      return NULL;
>> > -}
>> >  #endif
>> > +}
>>
>> Hmm I'm not sure about this, surely you want the plugin system to
>> complain early if your plugin is going to use a function that is
>> incorrect for the mode you are running in?
> I merged these two function for couting how much function are exported, so
> getting the code easier to review, otherwise
>  function qemu_plugin_get_hwaddr   would be exported twice.

Ahh I see now..

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

