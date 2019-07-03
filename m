Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCC5C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAB321882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iltls7fF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAB321882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hilVr-0004hn-AY
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 16:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jcmvbkbc@gmail.com>) id 1hilUe-00043O-OX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1hilUd-0003oj-Mv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:04:40 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:41975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hilUc-0003nX-QP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:04:38 -0400
Received: by mail-qt1-x82f.google.com with SMTP id d17so4050634qtj.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qy3unRWrPgfZjagt5v2f6xYgBneUuR7cWBojeeAYCvg=;
 b=iltls7fFW/AkLWbHU4l5YQJmsnKTUOmp0+PXPsN5lZtA7rKtPD1IhbufEienhbt5m4
 33jyQBZY/td8YO/NJ8waanVvOSfc2/T8o8uPjCW7o79ycqjuRo7wNIg0hyLdhpIHHEvY
 4oJryK91MhF+qCUW47QPpElcRTIgRgpaRD613onTdakVzV36zetNV3KGTw9wwNwsqQni
 hixzrvMbG47/XW5Crmp91N5aMhbuW2jOKiIv2EpC7cl9tfnU9li0lygOPm3q67CyCK/l
 qtX6hG9Z8BH4vUoB+kS6ddj3qHKHNFUjQFN05r9DXa1d1uq6CLH4IKTZLVQRO2AOcJNL
 ebow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qy3unRWrPgfZjagt5v2f6xYgBneUuR7cWBojeeAYCvg=;
 b=jhP28uImyRZ3Y4QlMcA/UJWwVXCloGVuImCyczM16HtenfSs198hiVn49kRg8JrEHA
 fMR63yaj+hz6WhUUWKpOaCVy5TcM9viQ1RlPkpq5oZcVXE3hnB2JZP073DItNuEsNa3J
 jq8AcIlm6tFWSPCR7o1PA4Xgf9fCYSkGtoXVyUYOy7q7bOlH4rURXscBWijCa9TftfsK
 6LIh4BqKfS6avxZFwo41cGziXJJCH+fgSArEoysEQyJkLc3xmAEG1JcvjRja58u1wMJx
 MlEYE2ssU82MXGpWj7jGV3TgH3zgbGscOh41HYP9QpRwkUv/0XaogICeEW7+P6hCjB7d
 1dHA==
X-Gm-Message-State: APjAAAUe5qO8xWQbrg79SMht+CJYw0bMbtHhiSepJZAq+kd+UD4P8DmY
 FRX/ej3Ppp9mcO5phOpZFX0VGL4hS7TchahYOJI=
X-Google-Smtp-Source: APXvYqyGu5l5yMLMXvDNTqnJ2k6tNyeyvBdTtLDgGOMXnlWhAG+SjcuFw40HrV6pWN2+b38FQ0BISHQXkpjjzM6Ne8k=
X-Received: by 2002:a0d:fc84:: with SMTP id
 m126mr23016091ywf.501.1562184277407; 
 Wed, 03 Jul 2019 13:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 3 Jul 2019 13:04:26 -0700
Message-ID: <CAMo8BfKhc9vFa_w_zzdGvbC-CTu4qa1JEv7GB8jJZ2uxsLn_nA@mail.gmail.com>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82f
Subject: Re: [Qemu-devel] [BUG] Inappropriate size of target_sigset_t
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
 Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On Wed, Jul 3, 2019 at 12:48 PM Aleksandar Markovic
<amarkovic@wavecomp.com> wrote:
> #define TARGET_NSIG_BPW    TARGET_ABI_BITS
> #define TARGET_NSIG_WORDS  (TARGET_NSIG / TARGET_NSIG_BPW)
>
> typedef struct {
>     abi_ulong sig[TARGET_NSIG_WORDS];
> } target_sigset_t;
>
> ... TARGET_ABI_BITS should be replaced by eight times smaller constant (in fact,
> semantically, we need TARGET_ABI_BYTES, but it is not defined) (what is needed
> is actually "a byte per signal" in target_sigset_t, and we allow "a bit per signal").

Why do we need a byte per target signal, if the functions in linux-user/signal.c
operate with bits?

-- 
Thanks.
-- Max

