Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F9C2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E6F2075E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7TqZg/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E6F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLtkI-0007Ur-Nw
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 15:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLtj8-0006TV-Jc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLtj7-0006Ic-Kh
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:17:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1jLtj7-0006I9-Fc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:17:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id d17so2194107pgo.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NsUchHCX5ty8+J0HpbFC3rcBey9bYlOQ17MlgmxEXyw=;
 b=A7TqZg/SXsdISc6Z86MbnPm0mDRRsI2YnQNIhekF4Pp3Zjxkihpvhsfdi94EUklL4n
 k95pf+hFESZKPnM4dLxb9F97wNw2f/kChENeQzCOoUDvj+XwQS8jY4wF/34HqddHTWoX
 v2hiARxh9D1ugYptgubRvF6oB83L6FOVZ32PP6otbnT+C5ayenY5mFqcRtrRm2K5QpiW
 Bkw3FWLJxbpLw3SNYNmHtqBRq08fekjiCiF4ZdFIoZbDGXTmLMzzqbVntp03mqCeVOn8
 d8bDzsnI3iNwfHBbBpttPhnRVzWN6SLcMiqDm/KlprrOYbGmk9neFiE30Px/aW7MuoDe
 9rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NsUchHCX5ty8+J0HpbFC3rcBey9bYlOQ17MlgmxEXyw=;
 b=ZL731XI6gCxzEqh7OlJVP5pFzRD2xgIwkiOjNt2u7GxJuz2Yj1sDlK3CZlUZJyAV34
 RmUp20ORXa/xD5Mco3Wg8KO6Xoh6X1y8e8OJB+ppuGM5JacbEmidlU4+etu+TeR+Bkff
 5z6/PAD6nW9f8n8rWVQ7W6zqt6MHWYDPAq0I7wOL9L+GI1HpERyLuHf59DZgZzrn1UXo
 iIkNC2NCL+OBn809VqURQyoXB3GAY1qgF+0KlW2OsONRNVHs8RS/DRCr5vrDcz9t13lE
 stb2BT5fM5eKY7+mDMJsGTEDYKgHIAVnUzHJtcPmNp9x75NMl0yC9efIkv2df+91s4ny
 qhXA==
X-Gm-Message-State: AGi0PuZtMNzBw7hLZrLREWcULRVf1EEuTl4PF0X/CFkVtDZzH3yXS0Sw
 Lmlseq/q6/MpEarRYOw4Kb7u9f+zmdVrntXeJGo=
X-Google-Smtp-Source: APiQypLlPEtjJKXD5NTmSwCkdcjnll8FDOpIy/L11GIvTqZAPEZ3i80OGm2hp3yu/ExxYc0Y83gTM+ZLDpxtdNO4Fio=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr3881757pfj.130.1586287056461; 
 Tue, 07 Apr 2020 12:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200407190738.15162-1-richard.henderson@linaro.org>
In-Reply-To: <20200407190738.15162-1-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 7 Apr 2020 12:17:25 -0700
Message-ID: <CAMo8BfKzHNPNtRJEdkg4hDTVT5B+GhAQNn5PjOw5uShURqZxJw@mail.gmail.com>
Subject: Re: [PATCH for-5.0? v2] target/xtensa: Statically allocate
 xtensa_insnbufs in DisasContext
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 7, 2020 at 12:07 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Max Filippov <jcmvbkbc@gmail.com>
>
> Rather than dynamically allocate, and risk failing to free
> when we longjmp out of the translator, allocate the maximum
> buffer size from any of the supported cpus.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> [rth: Merged the fixup in Max's reply to his original]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/cpu.h       |  3 +++
>  target/xtensa/helper.c    |  1 +
>  target/xtensa/translate.c | 18 ++----------------
>  3 files changed, 6 insertions(+), 16 deletions(-)

I've re-posted it almost at the same time (:
Should I take it, or do you have another plan for it?

-- 
Thanks.
-- Max

