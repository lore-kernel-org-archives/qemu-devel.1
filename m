Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE94EC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAFC20656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zP7wIP4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAFC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4mSc-0008PY-TJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4mR5-0006o7-IU
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4mR4-0000sW-50
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:04:15 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4mR3-0000rk-Se
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:04:14 -0500
Received: by mail-oi1-x244.google.com with SMTP id a142so27603766oii.7
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nVITewOqmwPFmSRX/IvpAQuYl3ewl3lh9hYMJNPbXGA=;
 b=zP7wIP4q4hpJ6W8xzwCfVZ6mXCZHXG9vPoJZFL/s77y40GThVhEoe9qfJzE4lbk81m
 W/P9lwdyzySmm8Ot1r/yb3RWtP+nPKz8GXM4qIz4ubS6k5kJs1QWGXW7+yhLWdxrQw9m
 hrgJwy3JhftXQmxIfpoYnuz7Kn6len21eJmEXzbwc6HtCnYt7cEAdOnqHsRKvqW9+3Rj
 LchmEKDSqV1MjiQ9J3FwVzBIY3YSAv0RYFF6i0ZlGjfj1P4TXWVnfrhC7Wf9jALQRB/S
 5XRiImTGzSM9TZ/Sa0yxFeikWb6Q/04L4A6Wlby/sSpiOzO47N7cCDkNiD8DUSnb+/mS
 JgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nVITewOqmwPFmSRX/IvpAQuYl3ewl3lh9hYMJNPbXGA=;
 b=hP4gOQiGYCnu0VHu1ntFxVWnawBcLcBLg1xgwibOyyjgRx/Zv+k7j8Eb4UVJW90W9C
 FVcxNqze0RFfTPgft2FqMOe7zn7SwTIdUtTGc/Ow+E3rLq4YDV2XL5NtTPxAIyhqpI5p
 uO8JCMJqNsl8wzU4azHgXWiwpnPvqb/++dSa4LVlONnqStIVMzvbTc47XrCRjr4jnWks
 s73da/MFBBL2ji34SeH+6Xecp9+1WD2ALbRp1fBAljqGF6PxksG1Krmt5p5tb7w4bkkG
 +ojJMCTlFAaO9kk3dwRGS3f2EsNg/aNRw2fZTLmGjNifo6awEQ+FXmWmFyT4Gr4dq8TV
 Aa4w==
X-Gm-Message-State: APjAAAU26MYjYMEkjmCKCfA62c2wKT+Tz5z9rKM8Mkqm0fkn0EwtaIbF
 Z0GXd0CAAIzp8OQiGmklcrNQXWUR3CyM+Chq8du7VA==
X-Google-Smtp-Source: APXvYqwZd8fajcGBfu1HUmB7Czyyu5mx6OaMY7vQXVb9G6RVkvGVQ25aXsHkjDtk2rItAuK6eDbZsgxA4VHaras1wTQ=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2035015oie.146.1582207452925; 
 Thu, 20 Feb 2020 06:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20200218140722.23876-1-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 14:04:02 +0000
Message-ID: <CAFEAcA8n8eLGp1mSbddspitbyeTkZpwxm-afJuOh8JtueEhKvg@mail.gmail.com>
Subject: Re: [PULL 00/36] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 14:08, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 6c599282f8ab382fe59f03a6cae755b89561a7b3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-02-15-v2' into staging (2020-02-17 13:32:25 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to c45a88f4429d7a8f384b75f3fd3fed5138a6edca:
>
>   iotests: Check that @replaces can replace filters (2020-02-18 14:52:16 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix check_to_replace_node()
> - commit: Expose on-error option in QMP
> - qcow2: Fix qcow2_alloc_cluster_abort() for external data file
> - mirror: Fix deadlock
> - vvfat: Fix segfault while closing read-write node
> - Code cleanups
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

