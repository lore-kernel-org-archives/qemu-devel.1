Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD830C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11A3239A1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odl/6qKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11A3239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdGb-00082S-NQ
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carenas@gmail.com>) id 1kKdEH-00077E-PY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:00:51 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:34335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carenas@gmail.com>) id 1kKdEE-0003SP-SF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:00:49 -0400
Received: by mail-vs1-xe43.google.com with SMTP id y190so9757860vsy.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=96BpHiJTMCBm/zOdVnuBOQxeMZLUHq8aLZrrmKjDghg=;
 b=odl/6qKLMkrL3RK6/1VOjuKRcc8I0XsN4vzYG1sHbFfZxbEgfBjI7eI2fsIdOkCZ2n
 PLMf5YsdacnjDVA+I1bsuRQIGaIoY8qV7QrIaq8P0zx/zVHDvXzWhUIAdq2YBijXI6Xi
 xb45sp429dOyILOQqa5jWTk8byAwUJnKLpOvEicHn5CH2i4zpb8cktEY4DoRPUN2u33J
 8v9bi3uo8Eu3XW3NfJluuMIEWRSO4mjRkTB6cG9ydz2xoOyCgn5mbeYSRUwaqWgiqUeI
 HefN4njxFEUO6xgyPMwlWR2nUOBMG5HLUcMMnK01q1/kL67JAGO/JpwCpKp5XLP1zFp4
 gYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=96BpHiJTMCBm/zOdVnuBOQxeMZLUHq8aLZrrmKjDghg=;
 b=CFLqsAfGOT5/JJ2Vn//SaFqMJpE2gNIrFSyh5Fn743IZ7dgUDW2NqrFkPCt7v0lUs5
 gKotTbzz6qbjD4Gk9N4KksNOhVBmMxoSqaaL/Oo/rRF1jKvgpJcCAoEQLzct8pMxwkgq
 rR0qrzh/nCvg2lx+tXAIVY/MJWqJ/uJd6jT8IaHr0lDYJytTR7a3nVwC22pJACCLvnUI
 ePSFgEpresRKDsaqdmzR+YfOEsiPpP0pFxg/vM5U37MdsGU1A8iNFTDl+J+D7kkHsfIF
 Ivo8UJGBUlEnZ/nNbIHq/1TpewvvpZTR6xXW/AaEW6SaH4BVwKIIbepeBSXW5Rz6nDXX
 W2Tw==
X-Gm-Message-State: AOAM531rjZOEB7Lq5zXEySnhQmftM0EoDqAMW3wJfCLkbQJ6w4czP9dZ
 CLqqxnBxyU0Sc5igAjrZKR0ZS263HLgsbS6q8W4=
X-Google-Smtp-Source: ABdhPJxcCd5UgLjo5/Fb29gNs2bRIB1FIOBBuk7GqQ8a7CESVc53Gx0eQWEAQ7hzp9UnwCSD9/N8RO8nbSN1eZNFfrw=
X-Received: by 2002:a67:8802:: with SMTP id k2mr2362949vsd.42.1600761645233;
 Tue, 22 Sep 2020 01:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <1600742967-12933-1-git-send-email-chenhc@lemote.com>
 <1600742967-12933-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1600742967-12933-3-git-send-email-chenhc@lemote.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 22 Sep 2020 01:00:34 -0700
Message-ID: <CAPUEspjsv09JhMgurc+rS-ds0drn9ZviN6UBmo+mmPUDH3j7Cw@mail.gmail.com>
Subject: Re: [PATCH V10 2/8] target/mips: Fix PageMask with variable page size
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=carenas@gmail.com; helo=mail-vs1-xe43.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 7:53 PM Huacai Chen <zltjiangshi@gmail.com> wrote:
> was just added to mips target and that's nolonger true.
s/nolonger/no longer/

IMHO might be worth also mentioning that it was added with ee3863b9d4
(target/mips: Support variable page size, 2020-04-08) to give a little
more context.

some other typos below might have been raised earlier as well.

> +     * When invalid, ensure the value is bigger tan or equel to

s/bigger tan or equel/bigger than or equal

> +     * the minimal but smaller than or equel to the maxium.

s/equel to the maxium/equal to the maximum

Carlo

