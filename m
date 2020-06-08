Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91030C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C2D206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNeUuv+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C2D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiI0t-0007c3-HB
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiI06-00079w-8M
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:39:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiI05-0006jk-0O
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:39:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so17452586wru.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NJGC0G0MMRHw+d1d+gIo+8gkPXO/9yo0nihSRNSyuJI=;
 b=aNeUuv+FyL6VHjrV6DxGqDSkagOY1HTjdR2+n8SL9RiJynN2AH9JMk1WXg5wwzjAZb
 qAIPPVcORCrfUXFe/m+Xix60hyVG+YgPGIPQJxH+IpDgm1VQ8bL8VmnAqLdCbOPk8xRN
 PdNulDsQ2+uh6iRRjjZlxz3Y8t2L06cwUYASrC/q77r7kWta9FK0RVpR56Hf+K423Lx7
 T5oPgB2YeBFQGD1a9sNDqxfUfDAlCRU//1V7aT3BS06wk3IyyoFy5M9NDjMLpp3DDomV
 SumTOJuD3h8Ee/hOQXzH6AP/2rdF6VulMCDvMdEJ9j5n3IIeIICj8jl6WKGtE1tGRWJ1
 Z5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NJGC0G0MMRHw+d1d+gIo+8gkPXO/9yo0nihSRNSyuJI=;
 b=dxzqaUjy+h09ybGzGqho4lz1RDTmRW1pK62IEiodFuA4DW2OBXDPnK2zZ8w64jRB3v
 2ksA2EEKkXd/9zNxDBw/E93V47I462UwwV5vJLx4Q4DqfSy8TGKTOtYYl3XV10g3fSQo
 WkYdMrWhIC27Tkq66nTcjHbArK7V8gOAXnVEX8feCVpg8biBURb3hiCGIwJpXoG2j/HW
 yfrTGSLo3YLAv4Kc/5NQnU37qA1D32f9tQeCzcSaO3vLQlTVi5In6ncNU8UvEP1OkZzM
 H7Ld02UWdqIbtf15JZKdvpyxDcvKUx1rUGmmStoHJtmUlTy6VLToP/3LgGkRhmh5KXvP
 9Ayw==
X-Gm-Message-State: AOAM530lzlhhSEHUAuxB41ekLMLl+gqCtqvYC42G/Zsm9xjrWWs0zUnE
 A5tQHY12vpWtI8aIX9ZG8c6e5Q==
X-Google-Smtp-Source: ABdhPJyUUKUVdQcABJi5YUoNb3547/l10Acu2WhuMVchGj8feKW59YM4wjReOsWRw8NTMlab1FnU8A==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr23147832wrw.169.1591623579345; 
 Mon, 08 Jun 2020 06:39:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r4sm23398736wro.32.2020.06.08.06.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 06:39:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD1E01FF7E;
 Mon,  8 Jun 2020 14:39:36 +0100 (BST)
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-2-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 01/13] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
In-reply-to: <20200605173422.1490-2-robert.foley@linaro.org>
Date: Mon, 08 Jun 2020 14:39:36 +0100
Message-ID: <877dwh7k2v.fsf@linaro.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Lingfeng Yang <lfy@google.com>,
 peter.puhov@linaro.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: Lingfeng Yang <lfy@google.com>
>
> We tried running QEMU under tsan in 2016, but tsan's lack of support for
> longjmp-based fibers was a blocker:
>   https://groups.google.com/forum/#!topic/thread-sanitizer/se0YuzfWazw
>
> Fortunately, thread sanitizer gained fiber support in early 2019:
>   https://reviews.llvm.org/D54889
>
> This patch brings tsan support upstream by importing the patch that annot=
ated
> QEMU's coroutines as tsan fibers in Android's QEMU fork:
>   https://android-review.googlesource.com/c/platform/external/qemu/+/8446=
75
>
> Tested with '--enable-tsan --cc=3Dclang-9 --cxx=3Dclang++-9 --disable-wer=
ror'
> configure flags.
>
> Signed-off-by: Lingfeng Yang <lfy@google.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [cota: minor modifications + configure changes]
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> [RF: configure changes for warnings, erorr handling + minor modifications]
<snip>
>=20=20
> +#define UC_DEBUG 0
> +#if UC_DEBUG && defined(CONFIG_TSAN)
> +#define UC_TRACE(fmt, ...) fprintf(stderr, "%s:%d:%p " fmt "\n", \
> +    __func__, __LINE__, __tsan_get_current_fiber(), ##__VA_ARGS__);
> +#else
> +#define UC_TRACE(fmt, ...)
> +#endif
> +

We shouldn't be introducing new debug printfs if we can avoid it. I
suspect a separate patch could introduce some relevant trace points that
are outside the #if CONFIG_TSAN chunks.

>  /**
>   * Per-thread coroutine bookkeeping
>   */
> @@ -65,7 +80,20 @@ union cc_arg {
>      int i[2];
>  };
>=20=20
> -static void finish_switch_fiber(void *fake_stack_save)
> +/* QEMU_ALWAYS_INLINE only does so if __OPTIMIZE__, so we cannot use it.=
 */
> +static inline __attribute__((always_inline))
> +void on_new_fiber(CoroutineUContext *co)
> +{

We could put a tracepoint here at something like trace_new_fibre() but I
suspect for following what's going on you could probably just have
tracepoints in the higher coroutine functions and leave the fibre stuff
as purely a CONFIG_TSAN detail.

Please we wouldn't have to ague about American vs British spelling for
the tracepoints ;-)

<snip>

Otherwise without the UC_TRACE verbiage:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

