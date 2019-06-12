Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A95C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B0E20866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlCEHlDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B0E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb3w6-0005iX-Qy
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 10:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hb3iS-0006YT-35
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hb3XQ-00011j-5u
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:43:41 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:40062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hb3XP-00010x-PG
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:43:40 -0400
Received: by mail-oi1-x235.google.com with SMTP id w196so11702577oie.7
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4o0L3z2wH+Ou8v+gUGiBLKcFXNl6G+vFe+39clMs+oU=;
 b=LlCEHlDEF370/Q02E/N+Lh5O1q3UlY4StEItY2UZkKuYMS2fAXXbw7GvJbB1OdGqIT
 juTbNu8xSid3CgJvi9/Gl0nI5lTCzhnAvjllGP4W8eWj0gAF7829K1N2b0wtCepgqUwV
 SCEJjAzF4eV7Js/bD0cdghAFiKR4aq79iXbnuobhw5dyqz8LZmciPZg9hRH7jy29UZRX
 qSGFJwu+y+LwZzzwWHfpas2JjEdbTpC7kTJ+cImoVut8iqPdzk/SNlwGUGpbos4A7Swc
 mE7LGDvZi4ZAnGVHiypYBb8dy02PeAsjSr6NGvD5of3hTY4ZkfLOb2bi3Ow0GgH+Cd+e
 bLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4o0L3z2wH+Ou8v+gUGiBLKcFXNl6G+vFe+39clMs+oU=;
 b=cfgXZ9i9fJbXmzGkWF8V2OVs7zNeH2x6h/Uk857wkERNFG5WAyej0oBxjXAQnP14+G
 /T0zzuLtub36GKWuyHz/B9jVTUOZrZcLrZQbzU7xQchT/wFKVsyanax6JIVsVFBq8roh
 mFyPTtywGwi2iOKp1/OHM+i6ui3j/cOkzT2juRl0hFCPdkaG3+lb1uEVKTAx8qad4VLJ
 u+GK/hTemNMp+IgRa5mkItA1W12bYPwkL8Vj5XvywaxuvyVMHZtwGcb6ZTYiGt2xdiJ8
 rkVE6fnnNEYkhSNdtr13m7rVc+7WJKICkUPakP2e8XOudUX+iemmxOE+fOuR4r61DtOL
 fqXQ==
X-Gm-Message-State: APjAAAXFR2ECHZmJckW0cWvxTdZVIuaEpeXvUKEMcgKP7zkaW2g1Qv3O
 kkuMUWbjKB27LCEGFWch2w39nA1RQ6MzxobHHIDK/A==
X-Google-Smtp-Source: APXvYqwtGvs7ZwR9U2oy4YTzF8tmwj9cSxTYvtoE01u846XBIE5vfmq3pd0qn7cOBdp955hDbb11H30TdZlfWmerq3g=
X-Received: by 2002:a05:6808:8f1:: with SMTP id
 d17mr19412112oic.170.1560347018688; 
 Wed, 12 Jun 2019 06:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190612112747.16374-1-armbru@redhat.com>
In-Reply-To: <20190612112747.16374-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jun 2019 14:43:27 +0100
Message-ID: <CAFEAcA-kZzAkthuQZjRV0eajXRpQTsu33yw4adWt4Zp8tQ=wwg@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [PULL v3 00/12] Miscellaneous patches for
 2019-06-11
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

On Wed, 12 Jun 2019 at 12:36, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit a578cdfbdd8f9beff5ced52b7826ddb1669abbbf:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190610' into staging (2019-06-10 16:09:19 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-06-11-v3
>
> for you to fetch changes up to 84995ea21935403cc9d57b6cb7dddcac5fa02c1c:
>
>   MAINTAINERS: Polish headline decorations (2019-06-12 13:20:21 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2019-06-11
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

