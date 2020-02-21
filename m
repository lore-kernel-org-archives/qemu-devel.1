Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C52C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009A224672
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtfSbZci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009A224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59BA-0005S1-4W
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j59AP-0004uy-AR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j59AO-0000qV-0d
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:20:32 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j59AN-0000py-QU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:20:31 -0500
Received: by mail-ot1-x343.google.com with SMTP id z9so2120584oth.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 06:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z82P5upuT/Ke4x5NgDYAYfiddZfgu+f8ap5BpM7WsK0=;
 b=NtfSbZcitj2fmXYO95GxB0hbOnOmhno8LJbss/jrZ4089DHemBQZXPVuGK4utj+DqB
 Z1Jtqo7MUdoN0ikBuXxukOs8orIV35sHkjF9Nmf2wGqCnfUII2mJYAyK9/5y/faI7x/q
 c1EjfW7MLlpbjWoYeUllKaxG1thb/8MNzjDRNXyGneo5YaqLiAgzzEF4wGrDkkGzy1i8
 Df9nuNyFW0KobfWXPhU/+Ec1OXXrCSWIiRVafvjROmFHx9YC0bPIDZqlPEKC8v+NdDwP
 H6OE3e20vSfCiTpgurBySDCCSw7cLEKs/ORsF5FMBXKla/79rbzNmi9poGKVLJN0hPWT
 UJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z82P5upuT/Ke4x5NgDYAYfiddZfgu+f8ap5BpM7WsK0=;
 b=bkeuCxhVr4LEKvUP22jAVyQLtfttuqVrSSOhquOBT/iUUM2kTMB/8CE4/XSLVtgTis
 fsL6JHLWkJzMYOagZWc+UJGhspB19juVlpMFfaAoheKi1nJc9xEginTrKp2BSnwsph7O
 aXCOlspuFwf0RT6Kf0A03t/ZFkQmIP030hYQu023FY0A0kZby0H6lvml6akaR93/3KRc
 0YvwVaYtsrvzaeKSbbKHbOZ9qpQBt5X5NRefZM6Q3Ww/US3F2BuaQGcmfOOG4PEKONox
 Sgr7qOKxxk56MJtSbRVe5KwdYx1OxZT2F0YL3tx0WYpRL5b1BFGr10H8bXjmo1yVntzK
 /t1A==
X-Gm-Message-State: APjAAAXhxCykY00Z7/CjcW5qlLRofJbMTxYPbazqY9Tq2tWp9Nylvg9X
 6z6sEMJvHlL/4HiL9luM/dCMESy9UgRILgXRptt5/Q==
X-Google-Smtp-Source: APXvYqxgXGe/6NKFKqQxnf2NFH3wAygT4Or2MqgTmXypLmMImZHD2DlnenmBYfH7zpPaGMpnUtYUCk2MLVDrbbBm8Kc=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr27007157otq.221.1582294830658; 
 Fri, 21 Feb 2020 06:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20200220160710.533297-1-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 14:20:19 +0000
Message-ID: <CAFEAcA_KXnp9Euvnt_TZicjLF9xNObUmug0=9ydUOttjAzXenw@mail.gmail.com>
Subject: Re: [PULL 00/18] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 16:07, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 672f9d0df10a68a5c5f2b32cbc8284abf9f5ee18:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-02-18 14:23:43 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-02-20
>
> for you to fetch changes up to dff8d44c96f128480430b0c59ed8760917dbd427:
>
>   iotests: Test snapshot -l field separation (2020-02-20 16:43:42 +0100)
>
> ----------------------------------------------------------------
> Block patches:
> - qemu-img convert: New --target-is-zero parameter
> - qcow2: Specify non-default compression type flag
> - optionally flat output for query-named-block-nodes
> - some fixes
> - pseudo-creation of images on block devices is now done by a generic
>   block layer function
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

