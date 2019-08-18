Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19227C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 11:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EC02146E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 11:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsS9E8eK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EC02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzJ1l-0005th-VN
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 07:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1hzJ0G-0005Rp-8l
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 07:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hzJ0F-0002Zp-8X
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 07:05:39 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836]:35180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hzJ0F-0002ZC-4a
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 07:05:39 -0400
Received: by mail-qt1-x836.google.com with SMTP id u34so11085687qte.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=6ZgircBgcZF4dKtjUkElxAMfWsyRyraAVrbjcLqNXgA=;
 b=lsS9E8eKHYLLV/ngKw5Mx+mVjezJyLt4AIQjsZCuleVwiI0sb3vO840ymKSPoEIEgt
 RbnLyFHAohpBliX1ZPKbse5MuBOmrh9a0GoyzRny8FwnbyP2JIS/oo5z28052Kz2jp7Z
 Ras3mwyzht6epVyowxBe0C7rjAEgzwU8bCDZp9w5MEq6/KoUUYtnGpCjXEY/Piokmwww
 X9dMgRnEjze1wn6pkzFr2MoL7o9nfDmNVbDgTsraiJOOWf8F8nWmQroq3e85yshJe4Cu
 iY8gOjaxsO5goP9gSPoEpEqec8zMcETh6jXVDG03dFm+Yw5ZeTXPJsxodQZZIKeF4cai
 itJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=6ZgircBgcZF4dKtjUkElxAMfWsyRyraAVrbjcLqNXgA=;
 b=VWVSS9jOf4KSBnFqvI9qy8yWsXFkaNC02ovMQCUEHpyLsAFUbgwuxK8Jf+ZH+Xt54M
 OoSMP2R61meRNDN01t+kqcaurjNWmzgvvWyPU0EMGmqEK0zaU0wViwtyMHMTPrtgycB4
 6YAGFZL0Awsvu2gt6tHHpOm3Mf8Av+TfBaFpA8+f147Jyww9tLGlB/xsFdfWhiSjq/ff
 lzElxmX7IGAu+8EtcFzBnLRZY+LB5q5jntp8hz8U0HC0xtcfAas27GLX9ivZ3jbkTiQq
 JAPS6iMuqLHZQlTn7+uJ9wVOxlK0cCGYgwtOrDNJ25u9Oxyc/FSTaKtZoqx5fAylQvRC
 bc6Q==
X-Gm-Message-State: APjAAAUz9WKrVuhaWjVv/92T2+UCu8LZNKvXkZqHJkoAzCBCaIqcUJKF
 KNwcGcW83/fz21hPMfxbGnYYh+8H701XwTfvmII=
X-Google-Smtp-Source: APXvYqxUJMYbTW+cyonsdKC0Qza5DtnTTiceid34cDBJ5MmfwQFdsDnD93azwvECNgJ9wOQ1TgqoVbOymonDvNU+4Uk=
X-Received: by 2002:ac8:322e:: with SMTP id x43mr15306074qta.213.1566126338281; 
 Sun, 18 Aug 2019 04:05:38 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 18 Aug 2019 12:05:27 +0100
Message-ID: <CAJSP0QVKV4mv6xJS0Oyx0GZ3QtLM+NhQGhyK24WqpuBFmg129A@mail.gmail.com>
To: Paolo Bonzini <bonzini@gnu.org>, dan@danny.cz
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::836
Subject: [Qemu-devel] Patchew s390 QEMU build issues
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
Peter messaged me on IRC to say that QEMU Patchew s390 builds seemed broken.

Any chance you could take a look?

Thanks,
Stefan

