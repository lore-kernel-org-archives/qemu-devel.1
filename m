Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44EDC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AC220684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMRbp4Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AC220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYs9x-0004yA-TC
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:10:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYs8j-0004BU-JX
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYs8i-0003RY-IO
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:09:09 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:45771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYs8i-0003My-Bc
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:09:08 -0400
Received: by mail-oi1-x229.google.com with SMTP id m206so1475663oib.12
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XBGRDcxF5+AiCbcSuYbEl6Dap5GQd2eItyPEEed5S2Q=;
	b=iMRbp4BfJjKTOm6IvpdJ4Movsc/Cfctb+LQfpLfDMPEB07cSOJ/J5n8ekvM+xYAl/l
	0k7M+OzLQhUQ+2VFcNLmoVSfjePFbdo4WUXa+oLq9FCZZsyq3t5zokKOL/g2tAZS6zrz
	93PYEDJqAwUeil/o6AsRGvMZ/iP3Nf7vAHT/us7N8ghJ35k5F7neOQnzCXVUNyDwjIXm
	gaehVj8dTdwXJGcITyQexBLk8/SkmEdG9AtNqROxuLznQn4Qe4qavfhs0Z1cYrj6KiNT
	T6seRxZy9e5+aq/z2mgPNZBw+NY9AKzDmh/Jsvuup/YsTgWzQ818nZRlAZvRY4RnUDrm
	McfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XBGRDcxF5+AiCbcSuYbEl6Dap5GQd2eItyPEEed5S2Q=;
	b=stH4AY4/+mou3arf3+1r68CEcU2Sxl7ASJXQ5tm2dKsQpg1MiGxPiSunJ5tslvsjYO
	/Gh+KuRhJ1ZeELtpIY4KbBBwF1YRzYTsr5a7x2ee10J295z7NXL7eD3tBWMgETJIxBuV
	UJQbiMMWQtxxbYoqlCp2AHLa15vlrCC6ijck2WWEYKD6idBAulICpph79ajU8usyk5RI
	sDVn5RLoI3a/VgRJ2IiVMgT9Ovm2NsohQ0kYaYE9OULroR+L8HkD+awIXGUdSOVeAPst
	1hPA4qLcbw3Ioau1o5c+t03Po/OjwDsHwkW9xYvkramCVZZwu15qCWQH0sIzyhrnl+/z
	9PXA==
X-Gm-Message-State: APjAAAUETR/sg6EgmWxKWG/KHrTgil+easO5FV7cR0fI+NOTDFOzHIHB
	sshZvmcykbWgWLDJredCOo15oas4l8oxaGr+sJQhiQ==
X-Google-Smtp-Source: APXvYqx4axXiEfNfDz4FLoyKLTC6GzxvgB/fCK6K2SKaIC54Xmln0sI+rS3XIPWlC8u83sd0N0CIgre57OT2QnEIWGs=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr650748oie.48.1559826547147;
	Thu, 06 Jun 2019 06:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190605195913.12243-1-mst@redhat.com>
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2019 14:08:56 +0100
Message-ID: <CAFEAcA-aJ=QPCKkk+AQXM15ZjDAC32Z_4QK8_s69yYnw2uiV+A@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL v3 00/17] virtio, pci, pc: cleanups, features
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Jun 2019 at 21:00, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 7f36f0930ffec11a551844c0452dbce33f80a525:
>
>   bios-tables-test: ignore identical binaries (2019-06-05 15:54:15 -0400)
>
> ----------------------------------------------------------------
> virtio, pci, pc: cleanups, features
>
> stricter rules for acpi tables: we now fail
> on any difference that isn't whitelisted.
>
> vhost-scsi migration.
>
> some cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

