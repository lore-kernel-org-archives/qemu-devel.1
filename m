Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C68C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B482078B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNAski7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B482078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Vyx-0003zp-9K
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5VxY-0002uw-Qp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:13:04 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:37090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5VxV-000082-TM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:13:04 -0400
Received: by mail-oo1-xc44.google.com with SMTP id p137so2686320oop.4
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LdpFub9+xNeGhskw7mUUM3MV5tMAPS/uO6yidlmJL1E=;
 b=HNAski7QlXBnxkl1KtNV5VQFAxiI73EuhbTu02IITPZVMp9AKry5saHpX6XLQvjz/J
 zVE5hGB1AzG+vgKOqTNBl29EpgAiVk5aYkwMiLdRkXxw7OWcEopQy+ydM4zIDmyAFL4n
 ArSYH6wSAPxBWcZc4njPiEaFOYqN3NcxIHZpt4Oeeame27egRPBLI89shWn96MlIizod
 13Zgug8MnAI5t8lGxezKR1avYNOOuhmr/sQE/AclrL3idUgveSrOqyxDFnD4g3NvEyui
 mldEy14Qr9f6PJ70wzAjelpgtxtN+4CzU7jM/HJRwj1L/5UjMuVgwg7Nl1IG+PbBNv4G
 8/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LdpFub9+xNeGhskw7mUUM3MV5tMAPS/uO6yidlmJL1E=;
 b=S0K+8emoaonEqD2Rbeg1NFS1rpw02gEzWwmtCfAmF1+pNXB7RP2EqoJ5m1Ll1hUq6m
 YCajQVMDelbtx3HHVSdj4jIosjA1n0zHYsQfUxGZSzAha+i8S+lK8Xc7/gqcy2LHpbrE
 f7ovwxYPyEsZaSLuaT+ysbILp9rXOeXT7EfNVqkYdsbYEhDD7su4D3Br6RvQFy30LR//
 OUAR8WssvbjlPbl3rclXPsPZ92ifLX/+7UHcnmqykQIt3zTpn9rhu+L4hIFLQF13K5dK
 8fhIwqY01vljgrZKcByGf/GuQZBEfSwJ5iQ6b2rSTSSl+XdGCqtBwarBxQ50hb3LRTB7
 /A4w==
X-Gm-Message-State: AOAM533FmiHA47ZcOdG28I9kjCaG43r0NNkxf1ik/wGfnH5AK1EA4ZLm
 kdrx1+W3/tgRPqo9lQ8SXGcplvtSs0Q9oqMUFWRuog==
X-Google-Smtp-Source: ABdhPJxwMW031ntFuoAuc8LeWqlH17ChQ0tdVNpmK+fCkHi0+P5/ZDbNBKGjY+JgUP9nN6dG9KE2JY7LvS0VorCeiSE=
X-Received: by 2002:a4a:4c44:: with SMTP id a65mr5586674oob.20.1597158779463; 
 Tue, 11 Aug 2020 08:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200811012759.16329-1-gromero@linux.ibm.com>
 <CAFEAcA9U9Q9QCm+Pk+ktnxxRGrC3F3UdQwp-bvGBZ6x2EY1oMw@mail.gmail.com>
 <3c978275-f4b4-5032-6f79-6e08a1ff3fe3@linux.vnet.ibm.com>
 <CAFEAcA80NQXiHaNcsJqkH4aoeH-G=0dbpwanjjPjfS-Mqs-DHA@mail.gmail.com>
 <7c9ddd92-fb99-bd46-38f7-4c318be5e79e@linux.vnet.ibm.com>
In-Reply-To: <7c9ddd92-fb99-bd46-38f7-4c318be5e79e@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2020 16:12:48 +0100
Message-ID: <CAFEAcA8DdKs0bPGfM5Wc1-kxWo7ZVJhQUMOC76S1Dpf6R7KbDw@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Integrate icount to purr, vtb, and tbu40
To: Gustavo Romero <gromero@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 at 16:09, Gustavo Romero <gromero@linux.vnet.ibm.com> wrote:
> Right, if I change the code to call gen_stop_exception() like
> in gen_darn() everything goes fine.
>
> So, I'll send a v2 based on your review then PPC64 folks can
> probably take a look at it. Could I add:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> to v2?

I'd rather wait and see your patch first; feel free to cc me.

-- PMM

