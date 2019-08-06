Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7730C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9141D20C01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVnSpHSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9141D20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huwSc-0005pZ-In
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 06:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huwSC-0005Ew-T7
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huwSB-0003XC-R0
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:12:28 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huwSB-0003Wc-KE
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:12:27 -0400
Received: by mail-oi1-x241.google.com with SMTP id w79so65794446oif.10
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Z9Om+d8fi9rWFQtI3/ghspW4hJyTJRNoq+eILtrl3s=;
 b=TVnSpHSWsq6YwgE986/1GwkwmlQo4w9PQ9jSbccyTu5LURK4GpHiszAKfm2GxjAp+l
 pjVpY5fYIvkNdUVZc2hv10zz9+SzVLqODcthHpOXOVYmwXnNe3KzFKHP/qJqrJbcGM4i
 yM1BvjQt1SUnKXiuiFqm4kkXgOA83MIIcD0dkHveSaZvfSXe2wCBigNuZzSdn7GvPefF
 O3xjG2gXYmeEwqXVCWIrut27dUvT3Qoo+JCDHfh2Y73LUuYlmHYrY49UDwDTXwECnYBu
 VkULEUPwiQs05/zSBnP5eU7hlK4UF5oCkVowV58jTAO9xEHwM+7L/kOCsxiBpyrsABtA
 dkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Z9Om+d8fi9rWFQtI3/ghspW4hJyTJRNoq+eILtrl3s=;
 b=cqeBlqeo6ioZHViicd/FRQtTkJbaD0t7U6m8TRFS5zhc5sD5G5MMTvXP/UeLkSzNxP
 HbMmm9VgY20u3m6MauGn8NcgpLWWcamfKe/TzzBUDnmfBlEBdBBHyNiUP1BpEnvue2tJ
 +6LfmMaOUBEkvIcEFpPLYjS3sLGz449UhI3KNp5fCFCpiSyoVLbjT4STYlqzgPGJXT/p
 8Lvr/n9lAYaseD1ySd2bUd/GTheCoJBY0BsxLehmIPG72T6rJ7umY76kf9w+zJ1w4zXi
 psr84YG3nIrLGKP4zrGpmN9aSvXstbcpypoardsHPd5KnsXUXB55f0XCYjWH1/o7ZGG1
 4wHA==
X-Gm-Message-State: APjAAAXQoVq90haczcrE4AtrZFJe5zrEe6+yUnwrmpOQN0JV2cF17Mg9
 Eztk89V4e4Co5mukpanXWaRWEkV6LJOgcJtGJMcZMQ==
X-Google-Smtp-Source: APXvYqx4EoZpEnv4VQv32Gc4yxdsPIZ1S4mWbZqSEuHzGB0tSZABFudghkL6vX6QndSHYzfPwqHK5KoemFusk0abj34=
X-Received: by 2002:aca:6185:: with SMTP id v127mr1256524oib.163.1565086346510; 
 Tue, 06 Aug 2019 03:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190805163740.23616-1-mreitz@redhat.com>
 <d7a1adf8-d0a2-dead-b8d5-2576d9b05f47@virtuozzo.com>
 <3a38f834-7759-fe3b-c5e7-d6232dc04e56@redhat.com>
In-Reply-To: <3a38f834-7759-fe3b-c5e7-d6232dc04e56@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 11:12:15 +0100
Message-ID: <CAFEAcA9yBJWkg7a-4LJx-xOFrVON=5y5Tp+OOdf2pwCBkbWjXg@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 18:01, Max Reitz <mreitz@redhat.com> wrote:
>
> On 05.08.19 18:59, Vladimir Sementsov-Ogievskiy wrote:
> > 05.08.2019 19:37, Max Reitz wrote:
> >> The following changes since commit 9bb68d34dda9be60335e73e65c8fb61bca035362:
> >>
> >>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20190803' into staging (2019-08-05 11:05:36 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://github.com/XanClic/qemu.git tags/pull-block-2019-08-05
> >>
> >> for you to fetch changes up to 07b0851c592efe188a87259adbda26a63c61dc92:
> >>
> >>    block/backup: disable copy_range for compressed backup (2019-08-05 18:05:05 +0200)
> >>
> >> ----------------------------------------------------------------
> >> Block patches for 4.1.0-rc4:
> >> - Fix the backup block job when using copy offloading
> >> - Fix the mirror block job when using the write-blocking copy mode
> >> - Fix incremental backups after the image has been grown with the
> >>    respective bitmap attached to it
> >>
> >> ----------------------------------------------------------------
> >> Max Reitz (5):
> >>    backup: Copy only dirty areas
> >>    iotests: Test backup job with two guest writes
> >>    iotests: Test incremental backup after truncation
> >>    mirror: Only mirror granularity-aligned chunks
> >>    iotests: Test unaligned blocking mirror write
> >>
> >> Vladimir Sementsov-Ogievskiy (2):
> >>    util/hbitmap: update orig_size on truncate
> >>    block/backup: disable copy_range for compressed backup
> >>
> >
> > As I understand, this all should go to stable too? CC it.
> Ah, yes.  Thanks.

Are you planning to send a respin with the CC:stable tags?
(I did a test merge of this version which all passed OK.)

thanks
-- PMM

