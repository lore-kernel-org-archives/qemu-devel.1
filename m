Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C5EC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9A620640
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGM0E32d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9A620640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPPj-00013R-9X
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKPOd-0008RG-5Z
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKPOb-0000e4-Lp
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:10:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKPOb-0000dQ-Cx
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:10:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id o44so17398531ota.10
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D9/LD6gXU73ozWnDM7iabvucHWxAZrWPqL4as4o0KQI=;
 b=uGM0E32dO7GxuQXQhlNVLomNoUu/DVUNKdgbPWHkqbPJNjc1PHHPGWsWwjOLRotv4E
 4SlJIjEoiUiNJElyfikALyo9F72jMMTOL+5K8ck4PxI5q4LiV8AHTH3447pHTv+2rtu9
 ELkWitdB8Pg0sZlFT0xGQTCjmWJlUNJYjPiTwHfer8xazzSzYz1HEX1gR86RDHTOsS6E
 bMiX4GAsAz+RrVXC41Pojez9wvxoA306c6QUSeYEcAUACdO8fiXMIOB97z+Ke5pL3+vj
 6RBgeMZIXpO/BOafHDWNktLL0BNYV9oaLnGGfVj28hOi89SQhxm8jC5f4c9NFUW8vdaa
 MyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D9/LD6gXU73ozWnDM7iabvucHWxAZrWPqL4as4o0KQI=;
 b=Q1VFzIx3AlryrW00OdEW59XhA2LflhK1xqvKcLyJogcsUYmI4s9isVhHsPmKDjqc90
 dnPd9eRnupYJKUHzvdEmLkP/yOFEaIheF1NHh5wiEj2iGLFe3zJeSxSIlHQQrFihgM2F
 gbyPWMgEMAV5U9OzwPjEMXhHCVYf22Lt1RHUCaPgHFzsD8tw2OMAHqmgcLJXznHHppv2
 GHu85fn46hJfg8SDg7uBSNemxBepxuGrr19XUsS7xmChZePyZhuqXe5LlD12EL53bePl
 THPvd2LnGEzdXogORUL4MXc+UM8BnwYU/Sf1372exAWQFkzEbJbbZ5seAF7IqGqAr1E8
 lS+A==
X-Gm-Message-State: APjAAAUOG3UMkNyArZgT0FBABi55RG1zZ7erzSg/EXOEo0ADDB7bCa0B
 Ui6HgP7rPej3PVhXquLmd5IGgZRkssFvMKvfukRPWA==
X-Google-Smtp-Source: APXvYqzStmD93r0kusq63jEra5b3TXIvrVH+omXI5JDMc+ULEMgYhl18DAr/S4PgMUoFoJoEg17OUeDFusFZS0iSw/E=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr29852273otj.135.1571155800581; 
 Tue, 15 Oct 2019 09:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191014160343.8211-1-kwolf@redhat.com>
In-Reply-To: <20191014160343.8211-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 17:09:49 +0100
Message-ID: <CAFEAcA_9GK1JXyqLuTWuX-o_rpYng-Sqhu0SnBHL2xyaR6gL9w@mail.gmail.com>
Subject: Re: [PULL 00/15] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Mon, 14 Oct 2019 at 17:03, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 22dbfdecc3c52228d3489da3fe81da92b21197bf:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20191010.0' into staging (2019-10-14 15:09:08 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to a1406a9262a087d9ec9627b88da13c4590b61dae:
>
>   iotests: Test large write request to qcow2 file (2019-10-14 17:12:48 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: Fix crash with qcow2 partial cluster COW with small cluster
>   sizes (misaligned write requests with BDRV_REQ_NO_FALLBACK)
> - qcow2: Fix integer overflow potentially causing corruption with huge
>   requests
> - vhdx: Detect truncated image files
> - tools: Support help options for --object
> - Various block-related replay improvements
> - iotests/028: Fix for long $TEST_DIRs


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

