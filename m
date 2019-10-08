Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A67C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF5D206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orlgcU3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF5D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtfZ-00048U-Hf
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHtB3-0002LE-L3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHtB2-0004Cd-IT
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:21:37 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:43828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHtB2-0004CK-Bx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:21:36 -0400
Received: by mail-ot1-x32f.google.com with SMTP id o44so14689561ota.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TLjkqf9SpFpb97CVRwxlScyAMeg6SxMTa5nj5s7xdGM=;
 b=orlgcU3NMZM6t1KU7pS2xugvaY4RzHvOipcOtQjsh93tamxfcuuTySJqrT7lFtx6C3
 wPR3cdyM3wMqcoxIWdXpclUrGSSUzbFosWd7sHcLgBpOCj4aBVGU3oiw/PkzxGAXEv1T
 H6WduJNMSF8py/g2fTcIZ/4KsarBh+TBxlpIRSE+UCirUNyv2NPr3yearpse1x/WwK0O
 7Dok0cGk6P2qxBR0niSb/rCwtW9MVWJy9c4qOmSgksd8v1Fdr3aQaGbCDEGUIrp6A44k
 TFVCsTCbRU09kjiIZreGF9kCkS0lCEWZGFqfKXf56mWYyvBIfDZ7lp6vU/8FP9IkPKoY
 M7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TLjkqf9SpFpb97CVRwxlScyAMeg6SxMTa5nj5s7xdGM=;
 b=PRaV+fMH6jwI3ZcqnbaLbZcdCGCy1Wb9aCgRL2+z/OJfZ/Oe8Qte9e1RXP49JACIKo
 +W7HuS2iHZHRFUm3PWZpABGzP7kMTG/pRctADvktBQCaARi5qW6tTzWef9pkNP+inLaI
 LoLn+hTZjW2nTb1VsmfKQHDUQ1gcDflcaek+E3OT31eIRB81+serNfTG90SGH/6DDGG+
 We6q8iWYMCz0GuX+YEg/8dadZxI5wfj02RpcklGp5aunR37gvBznuncCKUgUd3W836kS
 JZp83bk8/Lj7dTYZE5IIH/Rq3lPr5miqZ/3jv6VgQV3g6lirXBM5zj9UxxQvY+ReNKz/
 hFkA==
X-Gm-Message-State: APjAAAXsC3G7zlPrnk/CsNFD1tpys3B6n20gGZVIjrwo4QBQUmnA/DSh
 141EuXBmxkAktr5OmpiuZpv4vgf3vmFhwZIWbw7wyw==
X-Google-Smtp-Source: APXvYqxU9/VRhpO1Get+UOSPnTOmpQMoEqllRbaWXB7MpCtJKP2F5W4Lpgw/ZIIKWh76kfETQ25JAfBeN0Mgb2WtVwE=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr26322809otq.91.1570555295393; 
 Tue, 08 Oct 2019 10:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191008145505.3641-1-stefanha@redhat.com>
In-Reply-To: <20191008145505.3641-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2019 18:21:24 +0100
Message-ID: <CAFEAcA99UC=V2NzFbfdq13QbbGKKdXDVsGKhH5diZx8dmUhJoA@mail.gmail.com>
Subject: Re: [PULL 0/4] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 at 15:55, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 560009f2c8b57b7cdd31a5693ea86ab369382f49:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-10-07 15:40:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 4d804b5305ffb4d5fa414c38d4f1bdfb987c8d0b:
>
>   iotests/262: Switch source/dest VM launch order (2019-10-08 14:28:25 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> This pull request also contains the two commits from the previous pull request
> that was dropped due to a mingw compilation error.  The compilation should now
> be fixed.
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

