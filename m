Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782B0C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DCF20715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/T+9Q8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DCF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ErR-00011x-9u
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 14:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j1Eq9-0000Ae-1f
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j1Eq7-0000v2-UB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:35:28 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j1Eq7-0000sO-Kt
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:35:27 -0500
Received: by mail-lj1-x244.google.com with SMTP id f25so8642486ljg.12
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 11:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ANlq9UNfnyfQq8LaVwLtXx+qhv/e22hUkK+FJ331+t8=;
 b=D/T+9Q8t2bnLzjAUy1k8NSsK8d9+UUsefkWKI0GhGeFVyxTwN3REwEBQDyiMjUZk2E
 M44x7PoiEOqthTpajhoSL/oABNGWHKLjAfNfOwg/t0C98sEN6eWbBeGPdh3/cChzEIDh
 b+/6GriAD5vCKxyXQuf/kB6lg8Gi+0w/LpSaIbX/H+fB3TaQeUHASN6/t3o0jX3NGuJn
 iMUKL0QhDqFtkfLdH3AjEVwgVpWtMb0wW6+1TdooobHzNLA3n20vM1Zahx3+QZUTouy1
 b0GIyqQeDUDWa2H4d2zbyxOK1l4Wj/WA9MjKzKNhVWqvgvbSjPtij4WMUwvGZGM77Ywo
 1+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ANlq9UNfnyfQq8LaVwLtXx+qhv/e22hUkK+FJ331+t8=;
 b=fbZ2VMqHaWVPhNRA1I5e6DYeCMGIlEMrHpVSuxHnoZNR0YKRREniCt0bGrKn29PX0d
 q0LgUS9fzWtFgEsTCI7kE7NzZCNo31BV3dfgLRz1i9HAfmQW7UMHE361UQzRkJAXd5fw
 zTmNJsag5g4OwucpOF5VuPmm9KksL56Z2iOv5JmxmanLi9yyL7kOMqB+9h5gPvxDRwTY
 Uz2PtI07YkMNrQ3VjAPkk2wpmPame79OW6Mdot/ILm7rCqMITOXOXmQCf2ioHHtUV2KN
 SVSGUSoqhDL/PgGXqc90i8fmKAYu+nq9gVs7oynpGQutJkKfX58HeTQBWlM8ChZxeS1X
 L/xQ==
X-Gm-Message-State: APjAAAW1k3TEPxAsTpkAm3eeWcgLR/bXpfxRuLhqkc7HXCuxtMoywO+R
 TrG5V6+htQUyVREuKUv2Hqfo26CuiUczDbmdTYQZyw==
X-Google-Smtp-Source: APXvYqzG6UOK/yKLitkKWF1EFsrgAsb6h+Y+dpFko4K3KYM3gIkSsvOio61A8zYoP97NNA5pGt/v1IRn29ScnJGdr+M=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr1917164ljg.166.1581363325754; 
 Mon, 10 Feb 2020 11:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20200207150118.23007-1-alex.bennee@linaro.org>
 <20200207150118.23007-6-alex.bennee@linaro.org>
In-Reply-To: <20200207150118.23007-6-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 10 Feb 2020 14:34:50 -0500
Message-ID: <CAEyhzFv1YxBZY5weU+hiGHwUq-6MFnRZfKgfnyeV8CuALLAVtw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] tests/plugins: make howvec clean-up after itself.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: qemu-devel@nongnu.org, robhenry@microsoft.com, aaron@os.amperecomputing.com,
 cota@braap.org, kuhn.chenqun@huawei.com, Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 10:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> TCG plugins are responsible for their own memory usage and although
> the plugin_exit is tied to the end of execution in this case it is
> still poor practice. Ensure we delete the hash table and related data
> when we are done to be a good plugin citizen.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/plugin/howvec.c | 12 +++++++++++-
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
>      g_autoptr(GString) report =3D g_string_new("Instruction Classes:\n")=
;
> @@ -213,12 +220,15 @@ static void plugin_exit(qemu_plugin_id_t id, void *=
p)
>          g_list_free(it);
>      }
>
> +    g_list_free(counts);
> +    g_hash_table_destroy(insns);
> +

Just one minor comment.  Seems like there might be an option to use
g_autoptr(GList) for counts.

Reviewed-by: Robert Foley <robert.foley@linaro.org>

>      qemu_plugin_outs(report->str);
>  }
>
>  static void plugin_init(void)
>  {
> -    insns =3D g_hash_table_new(NULL, g_direct_equal);
> +    insns =3D g_hash_table_new_full(NULL, g_direct_equal, NULL, &free_re=
cord);
>  }
>
>  static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
> --
> 2.20.1
>

