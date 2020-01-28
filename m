Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD52C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7242467B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifwOkuL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7242467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwNFE-0007c6-9r
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iwNEZ-00074j-U6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iwNEY-0003I3-JG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:32:35 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iwNEY-0003FW-Ce
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:32:34 -0500
Received: by mail-oi1-x242.google.com with SMTP id z2so9674304oih.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 01:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Cgm2LVkWdI0MgfVRfsoA6xBdhzQnTxBEhmmqV9vFb4=;
 b=ifwOkuL4OcHgaXvmLSrp8hmNy03KaHW4A8j/JOG5cMpP54d+0Tz53SKWrz8b7UchLG
 mWFMyD5ZX5DEbmE1ll0lCvBDAXBXtVynG9UpDyCJx8xdckvm/4519k/FZ1RMbovXz2Xx
 EUVX6Am3moY7sG6z8I0kolYVxirPKe5phjSDS43Bivg+RhWiwNQOxTkMXi03YiU4SfLn
 JjC+aNarvAVZ01v7t8TsLCpgLEk5gGKIFmHhA4g9l/ZNb36vJwMk8HzOl0Arv2zGYAZO
 aJWXb6wYamriOmZpMEfc3Vqj12i8NleQsqK9ZSmL6RGi0LJjjTTiDPApr3kKrrYDwMiD
 7pjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Cgm2LVkWdI0MgfVRfsoA6xBdhzQnTxBEhmmqV9vFb4=;
 b=gGWsI1YZcNpaLTXbdTmMbPNYJ4Yk3h91ZYIAXqHMgpTYx9qBjMPVCTDkGpQX1rgsBl
 62nt3VA7f6Mu16XmSQeiAIcBN3TRH7xQmn9+J78Rly/Qk0Hh8VZZCsSu+HwpqOK3g369
 zdLa2XbXli9p812lvndMtsnUIPgKSo8L9Pdc+D31V0IVsMdEMuA6NCvJqlDQdhafWgUf
 lc79r+wgLoN1mRQr5+Ich2HtJI5QVINeO6n80Eljo3QYuS/vgRugibMdyghQAOIYnFT/
 7k6xEtLqAyiJVpwy4sU+VurXPUx3khi6zDA+AYRwutoImC3GIEEulwdcQWCHQrzuLQMm
 l3gw==
X-Gm-Message-State: APjAAAWm9W2eoGmVW6OYWmBD8U0uk41wxLPVYYAgKJ8MW7eeMKJKqUmx
 yag01L6gRhouGcKriNdupNgLMYF4NeOdrtlh13fwuQ==
X-Google-Smtp-Source: APXvYqw1t9MI6fkQ98GWqazm9xoR8nsqrGDHyC/oeUufE8JQR6b8v60zQiQt0+owWgPWaNxL0/V7prGG1eXOd+tPauQ=
X-Received: by 2002:aca:f484:: with SMTP id s126mr2169065oih.48.1580203953422; 
 Tue, 28 Jan 2020 01:32:33 -0800 (PST)
MIME-Version: 1.0
References: <20200127175559.18173-1-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2020 09:32:22 +0000
Message-ID: <CAFEAcA_rsVARS16J0nDrhJeSyyb8tYu8eRCrnhfyyjJ0Kz-QWw@mail.gmail.com>
Subject: Re: [PULL 00/13] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 at 17:56, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a79364c:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127' into staging (2020-01-27 13:02:36 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 5fbf1d56c24018772e900a40a0955175ff82f35c:
>
>   iscsi: Don't access non-existent scsi_lba_status_descriptor (2020-01-27 17:19:53 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
> - AioContext fixes in QMP commands for backup and bitmaps
> - iotests fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

