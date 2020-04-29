Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54156C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA322063A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aj2FopJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA322063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTssH-00023o-8u
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:00:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTsrb-0001T5-EZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTsra-0003zH-IL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:59:23 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:37343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jTsrZ-0003z0-VO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:59:22 -0400
Received: by mail-ot1-x32e.google.com with SMTP id z17so2834253oto.4
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=It8ZsE6PKzdACaONdbqfZznzyn2SV9pXTINa9v5tSbw=;
 b=Aj2FopJBRBDk185pnHPzPwssfc3731DZf/FANFW1qpg2keQUIwSSzSavcJbOdLRZbL
 Swhpdy8SO8toKgxGnftv/eAKALO8WQCve29Az7OnWfGIQT7wCrktr22SQ8LvgJX9dSb/
 BiT56FbP1yR2k+0QlgXGRvRDJ1w6frEvRUJ2W50IFxsC9ZN6U5Fadn+gVFhZ65lJUSAQ
 1Rc8hlHnwQrV2fW1oXnl9AX50xRigSOYfuD4BEvfgAAK49b4vNZJqBwK4ENmfHTblBft
 VA5Oz4519FmJs4Ze16qEDMR3kc5iaR1K8+1EgGgNEM4d50476qTyBysB/6HMB2hnnhWQ
 TuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=It8ZsE6PKzdACaONdbqfZznzyn2SV9pXTINa9v5tSbw=;
 b=NwCoIcxjxN6kIlgLbA1Kb/7GKUfTLifEFVSEtlkkEqi+PBoWU3B1vu1WWnoaNTD925
 EO3kKjOBR0hyzSTO0P5qM2nnBkCicoGspXjx1x3d7P/6DrHfqjz0hs4yDF1Tg0ys0a2w
 8Zh8ui7DcWQ6pXLxBppATh23usAN5SM8rUbo6kVmA5tGg2uUMCgha0V9OXPQog5eG6/1
 EKJjWVmrlPWcSa5e2NuVFdYGf+fB63ZbhajsV2xZkwJA7KJdERYJWORwxZfrttyT5haA
 kbhXu/uC/1Z+FirzoxRUAAt8BBGAGIYe/xv/Q7gdUt5S3qc24Ydd7NlDFB6HLmeNP5+K
 QUAQ==
X-Gm-Message-State: AGi0PuYV3o6FIRjWby6KBp+lnYhQAHQ0IpnYh/8ldxWSsY+1gKbv47ri
 Mcfr4zF4wvx8PYzXuk3vDQBRTi1Up0d+yHiCBOlBuQ==
X-Google-Smtp-Source: APiQypKL+0r9Nn27LznQq1oGVBnRjdmSWi+r4d9Hzry652PFIs3JkRsQ3/ME7cEThW2qOatLOvdnPutUPGzeR5W1f34=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr28441163otb.135.1588190360064; 
 Wed, 29 Apr 2020 12:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200429072048.29963-1-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Apr 2020 20:59:09 +0100
Message-ID: <CAFEAcA8SduCWU4Js8jQRJDJE0m=TCazMbrOUALQdX7vwvfA1iA@mail.gmail.com>
Subject: Re: [PULL 00/32] Miscellaneous patches for 2020-04-29
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::32e
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

On Wed, 29 Apr 2020 at 08:23, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit fdd76fecdde1ad444ff4deb7f1c4f7e4a1ef97d6:
>
>   Update version for v5.0.0 release (2020-04-28 17:46:57 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2020-04-29
>
> for you to fetch changes up to 8ef3a4be27efccd791d05e74b7b17d918f511a76:
>
>   qemu-option: pass NULL rather than 0 to the id of qemu_opts_set() (2020-04-29 08:01:52 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2020-04-29
>
> * Fix CLI option parsing corner cases
> * Fix bugs on (unlikely) error paths
> * Fix undefined behavior for silly option arguments
> * Tidy up bamboo and sam460ex reporting of funny memory sizes
> * Clean up error API violations
> * A bit of refactoring here and there


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

