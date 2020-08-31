Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6DDC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2194206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK3/iUlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2194206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCewh-00042W-V6
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kCew0-0003QD-V4
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:13:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kCevz-00040O-AT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:13:00 -0400
Received: by mail-wr1-x444.google.com with SMTP id h15so4933752wrt.12
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ekJfKK+wFfDYlSJyBPkFQnu9AkCGZ4kEzzzczfNIQLI=;
 b=hK3/iUlrl1ytLBRQiOIQb2kW4QfkwtMDJ0vZu/Q/UTCgkyT0jdH30MZ60lUYN85FvH
 U3xTQtZG2Ygt8sxauhl9X9xPDWkb8e8srQG4pXmsn/+/auDileZ/K/3wTp/gBNlZ+C/O
 vIdbI6rjywWm5TYObb74BRX6uWgmLJk50veJom8YmjSnj/QeN6UxsTDhHoefbkq4TjHo
 XINHB0N0ncjsroUSHQn/feOR4NZ68muHf/K6NYCD4HRuksSxNf77plg27CPXyU4NYNuT
 /43B7RyA3scLBgBeSHTpA00KIsz+TW8NorGIi5zrJexcZfguv8B5EOmgHK2ivTJusbMw
 ZHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ekJfKK+wFfDYlSJyBPkFQnu9AkCGZ4kEzzzczfNIQLI=;
 b=GAVCObEw+/RwhKNqaUlyOchQRJcIXABI9OljAMN3Cpl2725FInlBtgSKP2qTbmjcej
 5IZbT9U4quJADvYKLSVhvl+VOXWhYUiXMYoYflL9tq2mKBQHFWk7e4VO3kD80m78/gra
 HmcgINYzTZWl30RRFpPDbqrgGbtJwfWU6OKDbmxbsMfD1yt6iHH960jJzCaWpUukHAZs
 Iwo8Lzn1Dr1hWsdTTvIfDTic4woevqgJhJJ0lG+6HV6nxwO2/ETihDr0ndJuSDQa4LEb
 yJlTFGGMYu2L2UO3MV/jnPReb534C5iUTc2P5QbTRUL/yavHOQusl9qG04y5509jVM/J
 gC9Q==
X-Gm-Message-State: AOAM533lMBQLh3NahZ87Eyxk/2ugGgzU8hlyfcgdMVCo6kd5sEBo+0wC
 R/iGRLba+AEHG1c9C9wbis0=
X-Google-Smtp-Source: ABdhPJwM8sQ+dCJMB+khkHxWT/UGXvnGvJQVwpM/Zwk17nZdHM0LCdTDpMUD9aCHF2gpFZKegvSvqA==
X-Received: by 2002:a5d:6caf:: with SMTP id a15mr499126wra.344.1598861576974; 
 Mon, 31 Aug 2020 01:12:56 -0700 (PDT)
Received: from [192.168.15.15] ([195.200.173.126])
 by smtp.gmail.com with ESMTPSA id z13sm7789229wro.97.2020.08.31.01.12.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 01:12:56 -0700 (PDT)
From: "Emmanuel Blot" <eblot.ml@gmail.com>
To: "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: Meson build on macOS: undefined symbol treatment
Date: Mon, 31 Aug 2020 10:12:55 +0200
X-Mailer: MailMate (1.13.2r5672)
Message-ID: <764F294F-6A6F-4E1E-B8C1-5FB6D9BC9F33@gmail.com>
In-Reply-To: <9b3f88da-ec74-96d0-41a4-8fd89b845a6f@redhat.com>
References: <E79B1486-1C3C-4271-9B76-62B2C4B8BCA7@gmail.com>
 <24ac4d35-ff2b-4381-ab1b-1a8f31ba36fb@redhat.com>
 <9b3f88da-ec74-96d0-41a4-8fd89b845a6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; markup=markdown
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=eblot.ml@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30 Aug 2020, at 11:35, Paolo Bonzini wrote:

> This is done by "b_lundef=false".  I think it was added for modules, 
> but
> maybe it's not necessary.  Emmanuel, can you try removing it (line 3 
> of
> meson.build) and seeing if --enable-modules still works for you?

Removing this option does restore the regular behavior on macOS (link 
stage fails whenever some symbols are missing), and QEMU still builds ok 
with —enable-modules option, but I have not actually tested this 
feature - I did not know it even existed. Do you want me to test some 
specific use cases?

Thanks,
Emmanuel.

