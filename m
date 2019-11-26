Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44874C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 18:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB222080F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 18:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B08ir5qE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB222080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZfkB-0000ZS-8s
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 13:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZfif-0007yd-R9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZfid-00060D-LR
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:37:49 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZfid-0005zA-Ek
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 13:37:47 -0500
Received: by mail-ot1-x344.google.com with SMTP id m15so16804885otq.7
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qpCSyw2qmn8BwYwSDCVvcIZLliFZldzXehTfpB7nKys=;
 b=B08ir5qETzG/2I/0vJfTxvg8lB361RUC4mZ/kPZrz2NZvXnB6IIiVzC4kltVjEGc1m
 jTcgeXPzkumrtXQqVXdXXYW5SveBqBR8n+gMUNoZYh0QwHGyY0MQ0+ofvGOcvA3aWX+/
 neuBmLl/wUin/WUnxns3j4eVhiaQx81FFcIMzU2fkzfl00lM4pssf1N0/UmIcJDtLglJ
 rgW0M9Fe/MZCJHg4J5uz5T9RSo4OaGHdYm6OADCwzvkyKI12Bmv7yxHFXi9TVphfUdH7
 Dvl4+LqSXq5rVzJE5WcjsqxZPhW1pmFwyShfSUeu6g5Z4DVNeFZf37JveCLnefhjY1O4
 xuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qpCSyw2qmn8BwYwSDCVvcIZLliFZldzXehTfpB7nKys=;
 b=KVPyR0CxsDUIWYUHHo6wl8NZQoU5DycQGk2U+CfumEZWp5z5uET/JmZ+E+/43NpBSU
 3URT/Yp6oR84ahlzcvlN2B9Q184b2qEA91Qd6G5n7F5lQhb3L2w2wIwFMwAG7rGqw4yc
 N4GKsbeFQXBNy2kRFlVH3dUnM7p8vpumI/x7EcQaL2O7OTPR6RvuSaQz9WE9QS+oQfKj
 rM9CLru79GV61UD5PGKF9faObSiWdZfTGIv4X6tREn5AF+nAguGJizhe8bh9nZwITlcc
 K7r16kxMVIk8sNqsqqIAru8jZNCe1VBju2Yhguz/EO/suLzVhKu+dHU/C5nKGR5ajQwB
 n++g==
X-Gm-Message-State: APjAAAXk9RIPWG93HjhGMrotXNNYfrsHEyoG3bJkbmVjs1u6UJF/U5yu
 DiWo/GooSm7vqT3cCxrz31WR0kQzdrtnFaxJZMVI0A==
X-Google-Smtp-Source: APXvYqyKGaqeU9bTxsqwIyhXAJ0Y9vM1Btu2g4i5YuLd07hp68JKLDGJ5UCwrHbBXtoRMR6tx0tJHg2dd43a66oCbqU=
X-Received: by 2002:a05:6830:1583:: with SMTP id
 i3mr294976otr.221.1574793466387; 
 Tue, 26 Nov 2019 10:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20191126132936.1141588-1-mreitz@redhat.com>
In-Reply-To: <20191126132936.1141588-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 18:37:35 +0000
Message-ID: <CAFEAcA8D3Rh29a_th114jTEvpzcf_+hW4Rcu7s0pUfLfVcSHBg@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches for 4.2.0-rc3
To: Max Reitz <mreitz@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 Nov 2019 at 13:29, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 4ecc984210ca1bf508a96a550ec8a93a5f833f6c:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-4.2-rc3' into staging (2019-11-26 12:36:40 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-11-26
>
> for you to fetch changes up to d8130f4c420acafbf15a59436fa47199b82dc00e:
>
>   iotests: add new test cases to bitmap migration (2019-11-26 14:18:01 +0100)
>
> ----------------------------------------------------------------
> Block patches for 4.2.0-rc3:
> - Fix for shared storage migration with persistent dirty bitmaps
>
> ----------------------------------------------------------------
> Vladimir Sementsov-Ogievskiy (2):
>   block/qcow2-bitmap: fix bitmap migration
>   iotests: add new test cases to bitmap migration
>
>  block/qcow2-bitmap.c       | 21 ++++++++++++++++++++-
>  tests/qemu-iotests/169     | 22 +++++++++++++++-------
>  tests/qemu-iotests/169.out |  4 ++--
>  3 files changed, 37 insertions(+), 10 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

