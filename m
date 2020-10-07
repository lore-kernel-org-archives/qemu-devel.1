Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF63C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864F42076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kq6S9jJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864F42076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQF0Y-0007d6-EU
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQExc-00069v-Cq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:18:48 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQExZ-0006ZI-7C
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:18:48 -0400
Received: by mail-ed1-x543.google.com with SMTP id l24so3357376edj.8
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G27J4QAupmWFVg/mYbLXYrM++wzdzHh71grXpDOYGfM=;
 b=Kq6S9jJby9nPMAA3OXwAySDoXaVUd5PXYWn/WZ8g4Qk0xEuE9YSoaZ+0iY1WqOZpnr
 OYXAwb8o0BlZ8NB9tUMa2KVG+ALcoPZpEnv+d8hGPPcog3hvarvL2Wd2c/1SFmHJU8rD
 nyvmPQaWP14E7vKue7pPvvXQaiwGDFuq+jQtu36TwZOYOEhu8zondZysKdh+VHTiD9K3
 h6JJQMatcQ5QwTNOs7NI0wSexDVY+lDvOoSm09QZEM+ze/Fn4LW6z4tk156c01bmDpre
 YS5mxHb8bWg/gcYoyBXHeTUL0KqVlzC7ujF/X9ltadiZ+MtBH0T7SrCc32tzqjNrTp2b
 DGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G27J4QAupmWFVg/mYbLXYrM++wzdzHh71grXpDOYGfM=;
 b=OvegG6rtkAIdnrI15eXJjaA0XaIoo5zdhDRBP1KmC383D7WLETh0UtJTE6jWXitldt
 LLwOrfam0m/me2g6B0KWnztEXbhRGXS6RUISLS4/p0hIiFZnBxT2Xz2NadEWvQV9QkA2
 kOKqfWuMHDPcvFhp5W/1O1TItJANTOUupaf5259zhAG67d/Z/85WHjj6XQoLYjfe1ZCq
 1aNcP6Qb4bPVc1YmviCJ21DgwYcRT9gC0Y/dtEGnC4XrAXJS0jXDC+3KufZCtXObvFM5
 BMmT6l/t/P/Fi/b65p/kVwj1Z38hZeM0KiI6UwAG4GI+QtPPbuEUsQaaOOSPgRk/QrIJ
 VCMA==
X-Gm-Message-State: AOAM5314/yhmu4YuYb03CT3kyikd8plP/rZswRGmuJ0SlsfC1fPKcjKQ
 1ldP0hWOwVGPTGoUlM4DjjhUdUvbo3uSYiMPslGtPg==
X-Google-Smtp-Source: ABdhPJy24X1Lq5fgnKn4fD6WJzpudtao5xbfZ6NjByGCdeW75ZkuW08ueEr8cGaLOncVF0JzqS9rKAJtvVV6igxTds0=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr5479604edf.52.1602098322538; 
 Wed, 07 Oct 2020 12:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201007162138.425-1-luoyonggang@gmail.com>
 <CAE2XoE9sf0p5QuG=dSqbOvmGvbzDaEBN8qSG1ejM=RH+D+zq1g@mail.gmail.com>
 <798fb17d-fcf5-3234-1e17-37b3c0a18b8e@redhat.com>
In-Reply-To: <798fb17d-fcf5-3234-1e17-37b3c0a18b8e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Oct 2020 20:18:31 +0100
Message-ID: <CAFEAcA8ivKMgGCjQSB1jmVjYDt4oMDfj+L1-coqVpEJnhEfwpQ@mail.gmail.com>
Subject: Re: [PATCH v6] scripts: Convert qemu-version.sh to qemu-version.py
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Oct 2020 at 17:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> I have no idea how to fix it.  Probably it can be made to work using a
> string argument and "shell=True", but at this point it makes more sense
> to keep the shell script version.

If you're keeping the shell script version could you queue
the bugfix patch to it?

https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/

thanks
-- PMM

