Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2A1C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E05206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrZTaa0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E05206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEsvo-00079u-GA
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEsvC-0006lI-EQ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEsvA-000698-Pm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:01:06 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:42341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEsvA-000693-K0
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:01:04 -0400
Received: by mail-oi1-x233.google.com with SMTP id 13so2183550oiy.9
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9oKh/7Pzz5o6SdIf5l5EW49jhF0kYkLgrVowTWNDu5M=;
 b=KrZTaa0CWeg8zCvCcLJ+ofLvVC081sdSDuHVAM+5qVcXKZZMmCsgUiBLPHjQdiUumi
 X91V3s84m5J6RAk3CgK7oEIdfw572Dy4UiDQ6FDvxDqlb1Pt0VHl8Ji5BjaOaZfmy59e
 Xqz417D+x0BQ0zSldZL8IQ0+TDK04fOUVHfvDBa2va2g/uPzPTZm0nGHpNDHaTcdzUVj
 mnExtwxY07Ib4iSZS0hkBEOb8erDll6oQ0aXvRqhSKUvpP38DpRfq0jdm6RXRZK8ZdFY
 XFHjos9/dywXX4SBrQwss+CT70kOoWZTZoZI1+O2yWYx69fpLDl+auomCm0AZcXZSLRo
 mjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9oKh/7Pzz5o6SdIf5l5EW49jhF0kYkLgrVowTWNDu5M=;
 b=iim2A1KxqTI5QqTureagwQdCSH38hH3TT0YZflxrOK7XvsMrskMy5+4fiKo73DWv8t
 m1AqPzgUVsQ//6BlzHng7DjMxlVjgpihYtNidxVLZDf78ziluEj0dL6z34y4yfUHx3Vw
 vWmG1W/7ISPSg0IvjPBww4Dl3ILz6WDfTnwlv69eCF0GdzBI4VyqOTePJ7VyWdRg8IcO
 A6b4ev+bUX6IAe9vb1Jn8J8nR1TpKLk9KfIK9IS+D/zFrKEWRCrQw2zRP66catrZ8BRO
 NCsEw2Dob7wqfHx54uUeoe7npTmskF2M/qZ3kcNSZiWnu01uZt04XKFhE3DfmYBV63sS
 RGhw==
X-Gm-Message-State: ANhLgQ2mRzmOtYsrGiDCsAWfQgoo5FsqWrEH5t76VdsJ553V5hf1+LUm
 iSJoNWWYFQUSKvPom0eLGd/c7la6tvCb0e8PhE7j6w==
X-Google-Smtp-Source: ADFU+vvOUy6KQv2dIUjXEM+2+QYlmQ7xTJ8hvc1HES8WwwfATjuhd2H/0t1bS+FNB619C8GL4knY3qOPQqr+SovW75Y=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr1782963oib.146.1584615663664; 
 Thu, 19 Mar 2020 04:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200317210115.8864-1-armbru@redhat.com>
In-Reply-To: <20200317210115.8864-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 11:00:52 +0000
Message-ID: <CAFEAcA_15UA8WtdAsNRj4cM9sZEHNm3L5ACABYEBanUJUHer0Q@mail.gmail.com>
Subject: Re: [PULL 00/30] QAPI patches for 2020-03-17
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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

On Tue, 17 Mar 2020 at 21:06, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 40c67636f67c2a89745f2e698522fe917326a952:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200317-pull-request' into staging (2020-03-17 14:00:56 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-03-17
>
> for you to fetch changes up to 0d2ff4a9adfdac37495f04441d0dc3100804abae:
>
>   net: Track netdevs in NetClientState rather than QemuOpt (2020-03-17 21:44:02 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2020-03-17
>
> * Fix documentation of deprecated features
>
> * QMP unit test improvements
>
> * QAPI schema language
>
>   - Documentation improvements
>   - Support feature flags in more places
>
> * Expose deprecated syntax in query-qmp-schema
>
> * Fix netdev_add
>
>   - Don't ignore arguments dnssearch, hostfwd, and guestfwd
>   - Don't exit on "type": "help"
>   - Drop undocumented and unwanted argument ipv6
>   - Fix type checking
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

