Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51185C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B343207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7QrubM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B343207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXxD-0006i7-M7
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kZXwf-0006DT-8k
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:24:17 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kZXwd-0007lL-52
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:24:16 -0500
Received: by mail-pl1-x644.google.com with SMTP id t6so6651674plq.11
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mYbIFK1vPZMCZXBjfRyftvToN2oZtamsI1KveVMp7e0=;
 b=i7QrubM1wDznm0N2gjc+MTjGDi1avfr6dynaPuQ+X8T9hegJX7NzYaDjMiQVAKzzeY
 WAIf9APVN+EHaJT/YTdke3oYld8dxCpauegfuLgSkXRM2JoL7Vrj4VdRLUUCqc+3mOEA
 yYU4pt5Mlstym0ow9Ngey0FNg3BubrJwn8XNjjF7KO6JAWt91dbd93PCE67tho3WV2wJ
 03NejerwvcfTFSx0LRFzCNuyYjWEU9LKmYYY+N5GpX3xlssHRpaEPUzc1DlX/4/MCv1o
 LJ7nSzJpJWZp4AGgL07/fiajPebKM2JKULAcl7+UwwftOvFiQx+7HxxnXTCubEiezyyV
 G60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mYbIFK1vPZMCZXBjfRyftvToN2oZtamsI1KveVMp7e0=;
 b=ENunbzFUrUra08JeCCPraHciMPgD5DTTnBoUs6MWeeMdppGASDS4vn23MlazD1zFE1
 2zYdLiF5PZSIsCumlm6Fro99FqZeDheCwJJgP+SCgNId91+cCRuUbeyttm8+zJY7nQXk
 n2CatC4dNGbI8j+j4o899uVa8oM4UqsoNYayViu8Xn8ndtXfbOyuA223VCMAZFLmRjZp
 jMH8ZKu9RJisIQ4Ah9PQ2e56K8hTU5VrOuJztp8OuEunNaKYnmi77eZSlGZGDmeuVyfA
 850h7jvex/ZYopDJ9uyudrEXQeq+WcLhQIk2sZXl0a1mMMJDSZQzCl31uFCZT3sQoq2W
 nyBA==
X-Gm-Message-State: AOAM530a0mkf6cHUN0CoXRf+DISZvE/0axtpwOUxTSwz6nmPCU4NIUtB
 2bSuigUpe58DGuxQA+opDBEFiZ1LvMVs53ObEfQ=
X-Google-Smtp-Source: ABdhPJxYBg8kt5WVVcuAXa3a+Tr9cucHHNDKgcSGeHRw1qDkdJaPsOZpENbl3swU9CnnDLN1kHgbHkfo6nf/lQh1JQ8=
X-Received: by 2002:a17:902:9697:b029:d6:c3f6:8dcf with SMTP id
 n23-20020a1709029697b02900d6c3f68dcfmr7233574plp.8.1604316253821; Mon, 02 Nov
 2020 03:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20201030174700.7204-1-peter.maydell@linaro.org>
 <20201030174700.7204-2-peter.maydell@linaro.org>
In-Reply-To: <20201030174700.7204-2-peter.maydell@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Nov 2020 11:24:02 +0000
Message-ID: <CAJSP0QWTwUW5HrtczzT0G_i5HCxHbzMOiQ7jUnf8-9MNf_wf0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] scripts/kerneldoc: For Sphinx 3 use c:macro for
 macros with arguments
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 5:47 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The kerneldoc script currently emits Sphinx markup for a macro with
> arguments that uses the c:function directive. This is correct for
> Sphinx versions earlier than Sphinx 3, where c:macro doesn't allow
> documentation of macros with arguments and c:function is not picky
> about the syntax of what it is passed. However, in Sphinx 3 the
> c:macro directive was enhanced to support macros with arguments,
> and c:function was made more picky about what syntax it accepted.
>
> When kerneldoc is told that it needs to produce output for Sphinx
> 3 or later, make it emit c:function only for functions and c:macro
> for macros with arguments. We assume that anything with a return
> type is a function and anything without is a macro.
>
> This fixes the Sphinx error:
>
> /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/qom/object.h:155:Error in declarator
> If declarator-id with parameters (e.g., 'void f(int arg)'):
>   Invalid C declaration: Expected identifier in nested name. [error at 25]
>     DECLARE_INSTANCE_CHECKER ( InstanceType,  OBJ_NAME,  TYPENAME)
>     -------------------------^
> If parenthesis in noptr-declarator (e.g., 'void (*f(int arg))(double)'):
>   Error in declarator or parameters
>   Invalid C declaration: Expecting "(" in parameters. [error at 39]
>     DECLARE_INSTANCE_CHECKER ( InstanceType,  OBJ_NAME,  TYPENAME)
>     ---------------------------------------^
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/kernel-doc | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>

