Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE19BC3F2CE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2C12073C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WF6OvrUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2C12073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEA38-00045p-Ti
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEA0h-0000ke-PE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEA0g-0004vi-Ju
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:47 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEA0g-0004nw-E2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:03:46 -0400
Received: by mail-oi1-x242.google.com with SMTP id b17so6281744oic.8
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tLabnBum+qekwyTnn+64Gp0WXqtrQT1ti77DF0uXvWY=;
 b=WF6OvrUuWaIfY1+u8T5qU7VoZq8uo1DV/jeKC6+mPsMvrIRBpz/AEdF3zKhWlVwm8H
 qJrH4DELkXZRVO3/SyWSwMyzm4Jb5hLPZjtei5ygbn8Wn1eWTG2/IRUx9UYvRZYSxTPl
 pU0M9N2GkGtMpoWNUrWaKFswtvQTcNKqMVUKod290Nr/OPSJM8C+o8YVhySST7DctLwk
 GFkwLaKpoh3zCgMPh5BEE+eXbpM9pXlwdTekRLztx37bxJ/HdrUUhBLDcnfAwJRQLfHO
 VvYYwwcad2F1nhbH6hBdZzfL5gCg2fax2t8mwTJhKUeBfuwn/sn5cHp/u4rXtQZ3XPc+
 vU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tLabnBum+qekwyTnn+64Gp0WXqtrQT1ti77DF0uXvWY=;
 b=bzoT0C/sss/9Mkezr+5RkCrR3FqOxvegX5PxDajXgN+vQkDyMX+oX35M5zEErfdGip
 KdRdxukLM67lXxAxv5MW34DFmOrkGYvENRc+hwmiH6S9rEkRXR6X5PHQPvS9JqAXJw+4
 Ga3m2Puh4ILcxDsMJli3cKnCsm/L+oY+QKx7dHe3BtXsTLBEA4GMAJTnLMkxQiS7+er1
 UPqMWDVey6uQ+y5CljL8k9sntps+hnoPe2ICiEamZ64tHARlcYWuxna8zZYWaAEUjopQ
 +924qwzNCw+tUrtQFi/AXowNtr+sllZbYpojFFiOzk+DQBU9uv4K69mLkomakdqkU2u0
 x2pw==
X-Gm-Message-State: ANhLgQ0ST5X1gQpfpFCLmfXuqGpNsJcoSIHwutJnl6O6lviV72JKfGtk
 QJYbpuR6RxOWaHijoqIJnCz71980JrX+UOn6Mkp/Iw==
X-Google-Smtp-Source: ADFU+vsuS7AD357YuZrlkszlfyDFyIyxNWP/uJQg9ptHVaxwlJgKPR14K8B5xpG3iSNXb4+9bdsoAzSjTRovuanS2kU=
X-Received: by 2002:aca:47c8:: with SMTP id u191mr3155551oia.170.1584443025293; 
 Tue, 17 Mar 2020 04:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 11:03:34 +0000
Message-ID: <CAFEAcA-W=7LQyKvy-Pxv7eUh-tLoYu5jLiObTST0-Ee0wrCX7g@mail.gmail.com>
Subject: Re: [PULL v2 00/61] Misc patches for soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Mon, 16 Mar 2020 at 22:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit a98135f727595382e200d04c2996e868b7925a01:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 9d04fea181318684a899fadd99cef7e04097456b:
>
>   hw/arm: Let devices own the MemoryRegion they create (2020-03-16 23:02:30 +0100)
>
> ----------------------------------------------------------------
> * Bugfixes all over the place
> * get/set_uint cleanups (Felipe)
> * Lock guard support (Stefan)
> * MemoryRegion ownership cleanup (Philippe)
> * AVX512 optimization for buffer_is_zero (Robert)

Hi; this generates a new warning on netbsd:

/home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c: In function
'timerlist_expired':
/home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c:197:12: warning:
'expire_time' may be used uninitialized in this function
[-Wmaybe-uninitialized]
     return expire_time <= qemu_clock_get_ns(timer_list->clock->type);
            ^
/home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c: In function
'timerlist_deadline_ns':
/home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c:235:11: warning:
'expire_time' may be used uninitialized in this function
[-Wmaybe-uninitialized]
     delta = expire_time - qemu_clock_get_ns(timer_list->clock->type);
           ^

This is probably just the compiler being not smart enough
to figure out that there's no code path where it's not
initialized.

thanks
-- PMM

