Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB1CC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8DD20836
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1YtUJcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8DD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxVO-0007Md-4n
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVxD9-00075k-73
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:02:12 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVxD7-0003qG-W1
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:02:10 -0400
Received: by mail-oi1-x244.google.com with SMTP id o7so1854124oif.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nQkzQ5UhlJxsB/jDLaQrvHMImlRiNxKG0mTa0xROE/o=;
 b=e1YtUJcZdwnM+4DPRSqo9utI4Z/0N0Gwaq95cAADCTWklZ0/oWHeFL3tU6S5HV/KUY
 SACucR0y7d2kODYck9bRZ2w3n0tc5lPPW1pH3Yachwe/y9RT6aF4TrRT4YRNOpIiNn55
 NluL6Ye1iUJiobTb9eTEECK7sGUlWsvMyHllaW2JyOaAvTQhzqzU8y347mhbpqj2STS7
 873CNEDf2tTim0HCPqJP1dTPoM0zMGi55vI66V8ZkL18wCX5taGaA2WzngIqlLVNlr+M
 Dho+Wqnu2l5I/WmKnHt3aF/3FYOnyr7upl/LR0KOerRvRJeDhWCBSJ7MaTWDgC5jyR4J
 P5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nQkzQ5UhlJxsB/jDLaQrvHMImlRiNxKG0mTa0xROE/o=;
 b=LEZ92XWn+DZf033TWdwYFZ/1NB1ztd2MXO6bdKPpiaRtASSTif+UlNvudjq/gZjGSm
 re2oH2V4ExLS4W9CRwyDoQrElR4DFquK4w/ZyrCDzExXQ2AI5xUy6iI9/F2RIEksxyic
 uqmrjSiTnwg6DNnhcLx5+vJbwFBctXOFalCSlYP83xRzFiO5qO1wDwx6LqLNsbxrQLgr
 WmnmeYi7sntWMnejRnNV6dv4pm4sOz26u1tu6GBbzO1FNEkhiL9sOnD+YsGA5HeLvb3p
 u0ezE2q509PRmQmG2LK/ZE1NAGaH+8m++iwQFAkxsQCCOUWGvozpjNNICVb0uR0GQDYX
 M8yA==
X-Gm-Message-State: AGi0Pub/9bjr4onhU1a4KBX5FXvozQFB/lC7GIddZZmAihTRE3ZndGzb
 gVvvKGOHUvmHN7a+fx/GPD85zKVF+6zYX/YNQjkNdw==
X-Google-Smtp-Source: APiQypJMBBxK4v/IHO4VTx7Iezmk3+/2Lz+4rIakCrY1ZFsu2lc06c0GIRWkLh4+MtC8u0qQ/5kN7MFqtgJTNSktWzw=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr2154121oia.48.1588683728500; 
 Tue, 05 May 2020 06:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200504151438.362702-1-stefanha@redhat.com>
In-Reply-To: <20200504151438.362702-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2020 14:01:57 +0100
Message-ID: <CAFEAcA_hFCiKNGGhBsRc4Gjd6awKb+MFKep6q9ue2iJgguX+_g@mail.gmail.com>
Subject: Re: [PULL v2 0/4] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 16:15, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 9af638cc1f665712522608c5d6b8c03d8fa67666:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200504' into staging (2020-05-04 13:37:17 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 08b689aa6b521964b8275dd7a2564aefa5d68129:
>
>   lockable: Replace locks with lock guard macros (2020-05-04 16:07:43 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Fixed stray slirp submodule change [Peter]
>
> Fixes for the lock guard macros, code conversions to the lock guard macros, and
> support for selecting fuzzer targets with argv[0].
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

