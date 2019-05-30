Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B6C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83032257E9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQdi69P2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83032257E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIyC-0008IG-L3
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:11:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWIwi-000762-G4
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWIwh-0008Ia-FX
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:10:08 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:37338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWIwh-0008Fz-8f
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:10:07 -0400
Received: by mail-ot1-x32a.google.com with SMTP id r10so5213376otd.4
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pH8kocDYZxjOMuokBI80h+ATttjteuqhrn/3sBZ7Hxc=;
	b=EQdi69P2e17sCAEB7YmCSiDOKQmrT9SIrW6LgfyXGSw7JXi77qVyJo/Q7/CCrTgwrw
	llvxrqhiyN2QjMifyve1PhAEtes+iUYqTM1StbTnOUUCV2d4u38L/puUQ/KiORCWyeTf
	U0rmnuykToecfi3euhK52DIeURkMph/rBNKLBbbaG7EycNXunj4KuVve0h3CgSOabYZ1
	VcaoUyCyFcpv9SpqeJsIz4Vb2Zmhvr40uIaoqJDct27R/XRhYps4os54xXojSRgaJdg8
	/92zbVQNnb/SyW41eJxHN6wLaV7S4G2f8SQpkW7G7RmoxoDH9IYFpHbW6hwkEN76IJMc
	Ssqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pH8kocDYZxjOMuokBI80h+ATttjteuqhrn/3sBZ7Hxc=;
	b=uD5Ve3Hs6uTypw0faEJxevUvTzROA24iDd3jcribsEY0taTbnZbLPxZC60R/roG0ts
	z++3GfkgE4X2LAyvZCsi42Bxt1BVMefq8RMf2DcaDYoltmJ0x6doHn17zxfme9qydeu+
	0s9RTiIy49GK/gMIrjqfICfHZBOi9sX0fRp4b4QcGU6kxZ6ZdTbTTkmoTDYkkkLi0IpW
	TeWxOhEtnC15Aj1G2PWAF8sWdHKmzK9MWaOXIqL/RrnH1zZQ+PSazKgxggFU2/I6GXeP
	6G204MRuqV+SOfz6q/smP06qlMPCBPVL47rN4APCXgnDuJL8obimtMuAp1oktYgUJrlo
	ubcw==
X-Gm-Message-State: APjAAAVkWetvf84vVtLQF2f4h5//oFYzDms9y2gZfJ/Mefbe4eqDT41H
	V9wMSv7XIFaaX++hDNs6MQiN2rZ3wygQBN1zx63PWw==
X-Google-Smtp-Source: APXvYqxCv3ueD6Z/ViJt2r3vpcYSsf3ptkv9yvtxcrXdD9YSW/yUGcwKYp2cZeeqyQ+IJ+noIJnr32CktXNLpAx++sU=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr2178647otq.232.1559214606299; 
	Thu, 30 May 2019 04:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190528192847.2730-1-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 12:09:55 +0100
Message-ID: <CAFEAcA_EKhy7aGPPWdS6vfdckkEpDFtsGEt3GZMLKSx-aYajNw@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32a
Subject: Re: [Qemu-devel] [PULL 00/21] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 at 20:28, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-05-28
>
> for you to fetch changes up to a2d665c1bc3624a8375e2f9a7d569f7565cc1358:
>
>   blockdev: loosen restrictions on drive-backup source node (2019-05-28 20:30:55 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - qcow2: Use threads for encrypted I/O
> - qemu-img rebase: Optimizations
> - backup job: Allow any source node, and some refactoring
> - Some general simplifications in the block layer
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

