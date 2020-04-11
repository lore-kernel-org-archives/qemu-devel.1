Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46417C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 16:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8402075E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 16:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="deZAyjvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8402075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNJQD-0007oW-A5
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 12:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNJPF-0007B8-KS
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 12:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNJPE-0008Dv-Ct
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 12:54:57 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:44055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNJPE-0008DY-4e
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 12:54:56 -0400
Received: by mail-ot1-x32c.google.com with SMTP id a49so4825235otc.11
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=92N+Cx1NjmrVN05pcIHsYhbdHnAtHGwofbT1psX5KaQ=;
 b=deZAyjvKgEtiExCxuSgTuCnZ8vZuWfW/WmdRI0UZMCohiYbNSajOH5HsvvSugOMopz
 BNVtiim+Huari7e8q01BqTrnM/7IS9n9wbtsKggQDxZMxleL0wCMio1ixhNgqNpL6x2t
 WCkPRpjrhekMdtT9uXBqPY9wW603s3tubRqBlngUgmyrdhFWcI4IS84yhVydVTHer6lI
 t79llumBoWhvWfHbu807Q1uX7xYxGKI3Un2glnoRfOFFvqE0/yhVw2UymUyf2gbnh4Sj
 RK5SBv0nbI/xVldNvXJk6SWIkdJUjwVhQ+wEVdzyDlcWBpPRUekH/eTToOtUrRPdCKK2
 FApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=92N+Cx1NjmrVN05pcIHsYhbdHnAtHGwofbT1psX5KaQ=;
 b=SK+8ekQh2QfJP8AAzmD9ng0LsvXJeT6x97BcUk0sEroSDoJwJzSqSKzox8KV9WUa2x
 qiQriyalkdzPzGPnsDAY+NWxTvfsX1zDPbYSWCEEmKM4m4Wbj9bytpWCXrcrf0z5lkBN
 elmbqJylq0ABOVfjYG4UnnwCWhAIgU/UAxd4ePOp1DN0kh0kEovOwCEMALghoeQaZwP9
 k7vmBvk7vMlER9qofoAlbZ/e/OnZ1M0SWpz20eQ1asV/4L2rWnKlI8LuqiITj9nHipzr
 hF/SKYG35Q+jqe7GcCaTSTw+PyFK7Y8V/nU7KvBLu8TShrixhUd/b6Z2+CrM5WwbUryY
 yekw==
X-Gm-Message-State: AGi0PubnSwyFULg0RIP0lTRRHBLtwAkx6Xhta8cKofkXVnOWonicdFbJ
 iDgRWQfo2yaSXr54a7/7BGHr0O1quW4st7YPGL7rqQ==
X-Google-Smtp-Source: APiQypI4FfgDIR7ymWDvZcICse9uuzyx0UAQIkHLYoG/mCbHNgF+/pjJF9ZMfVAH7VCMQdo+5v/hp0ocx//5qvsM/ow=
X-Received: by 2002:a9d:7349:: with SMTP id l9mr7999460otk.221.1586624094977; 
 Sat, 11 Apr 2020 09:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200411130330.1993-1-pbonzini@redhat.com>
In-Reply-To: <20200411130330.1993-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Apr 2020 17:54:43 +0100
Message-ID: <CAFEAcA-d9Cm85Lnw_WvOrUwy3go=P04-Qhy1zwMCsTkAZtrWgQ@mail.gmail.com>
Subject: Re: [PULL 0/8] Misc patches for QEMU 5.0-rc3
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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

On Sat, 11 Apr 2020 at 14:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200406' into staging (2020-04-06 12:36:45 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8c12bd8e32faf8c483cd96c1557899120bc67eea:
>
>   module: increase dirs array size by one (2020-04-11 08:49:26 -0400)
>
> ----------------------------------------------------------------
> Bugfixes, and reworking of the atomics documentation.
>

>
>  docs/devel/atomics.rst               | 507 +++++++++++++++++++++++++++++++++++
>  docs/devel/atomics.txt               | 403 ----------------------------
>  docs/devel/index.rst                 |   1 +
>  docs/devel/rcu.txt                   |   4 +-
>  hw/i386/pc_piix.c                    |  19 +-
>  include/exec/memory.h                |   4 +-
>  roms/SLOF                            |   2 +-

It looks like this roms/SLOF change is bogus (it's in your
"atomics: update documentation" commit) and it makes git
complain about the merge attempt:

Failed to merge submodule roms/SLOF (commits don't follow merge-base)
Auto-merging roms/SLOF
CONFLICT (submodule): Merge conflict in roms/SLOF
Removing docs/devel/atomics.txt
Automatic merge failed; fix conflicts and then commit the result.

thanks
-- PMM

