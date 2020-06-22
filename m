Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF2BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AF6206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSfpnUNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AF6206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJcV-00074j-HF
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnJbp-0006Tx-Pw
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:23:25 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:33736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnJbn-0002F8-Sl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:23:25 -0400
Received: by mail-oo1-xc41.google.com with SMTP id v1so3245559ooh.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IWc/AAgYABcsDglxNPozLD/Yro+ORza0yWE34N177zQ=;
 b=lSfpnUNwqj22ezy4jvntzCiwzm9tC1d6fqXEQzXr2nlfxLPA0DCjbLGQ6kKdg6nGGG
 p0cJHYHLdFFWe+86O9aVXaoUr56CBBkRUB0EeDC05UVTHYnrAMWeknxIvMABZ2KBeooL
 6LN9TAdVDCdP9D/lyIE0mCItx2kd41Di9SqGPuO7/Gm0tIRxhiaIeHsQRkpcdxF9AklA
 PJW83CEq6j/U6kadJ1b2g7yuCHt5HAn53/YqxxHhCr4qhgngtBOcvKQNW9lAP5ZtLZuq
 XKPX5tOvI9gkIet/lSwpY0tU6/PJYvchpNulO5Yw5uUnG4dvLfcqFq623KctWEJ0U0xv
 +JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IWc/AAgYABcsDglxNPozLD/Yro+ORza0yWE34N177zQ=;
 b=gCe0a7T69+pL9tNqeESE2G3eA7mHGFeVMh2IZfrrgb34W3ezBGgIY5j4KNMGBIwCgB
 wffA5/6ZkMQn80W7pBse0VIRXMJGhaj3wOfFsQ/niYBzJewyCdBe1667BchBdft8dNEy
 /VgPK4gaOK/GnH4A4rXzIYMYlG7CZAEa/1OgS2UrS/kZcimuOuovw0cfqxX/crYOQyzX
 uZLt1StnC0lUURSWrCRrcRmUN7dSHcv6iyT89JY3IlJDTX+uNXWLc1DRAIJPz0J2Ugm6
 yV9MbSlcfBwlxFqanwt3oEwJxhg9y1ofQglLICmAT3nBF0Hh82TpC71y0+VnXqT+crse
 qYtA==
X-Gm-Message-State: AOAM532QXbbO0HPHzLfSx3YvAHCSFUY7qDAoDXTxbqbehgsZ79npBau1
 1tZKMkVkGgAQTxBwnPlcwrW94ghUYzrHRzd5a9r6Uw==
X-Google-Smtp-Source: ABdhPJwezVKuVFimO54de1RHHczwnda5Bs2yQIwGjWmlSbkNslzgn2wclfbzuwzgrLX62PuNX+KfbwKiwtdmcQv30bQ=
X-Received: by 2002:a4a:221a:: with SMTP id f26mr13537883ooa.69.1592821402024; 
 Mon, 22 Jun 2020 03:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200622053537.25245-1-jcmvbkbc@gmail.com>
In-Reply-To: <20200622053537.25245-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 11:23:11 +0100
Message-ID: <CAFEAcA-+L7=-TYqeiX8gVEx_vXqB5AkQ4gqGwKN4TgK3GDcrmw@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: drop gen_io_end call
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 at 06:36, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Since commit
> ba3e7926691e ("icount: clean up cpu_can_io at the entry to the block")
> it has been unnecessary for target code to call gen_io_end() after an IO
> instruction in icount mode; it is sufficient to call gen_io_start()
> before it and to force the end of the TB.
> Remaining call in xtensa target translator is for the opcodes that may
> change IRQ state. All of them end current TB, so gen_io_end is not
> needed. Drop gen_io_end call from the xtensa target translator.

Most of the insns which set XTENSA_OP_CHECK_INTERRUPTS in their
.op_flags also set XTENSA_OP_EXIT_TB_M1 or XTENSA_OP_EXIT_TB_0;
the ones which don't are "rfe", "rfi", "rfwo" and "rfwu". Looking
through what they do, they all end up calling gen_jump(), which
will end the TB.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

