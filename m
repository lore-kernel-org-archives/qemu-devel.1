Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC2AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5959E2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ni4OnYLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5959E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWhP6-0004VI-FI
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 08:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhNw-0003wt-C9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhNu-0005dG-5C
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:48:08 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWhNs-0005cJ-Bs
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:48:04 -0500
Received: by mail-ot1-x32d.google.com with SMTP id l14so14509509oti.10
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 05:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sLlSMWMdhDJMDBDNvYUqg9ICNBsGUDvkmLeZtA0eye0=;
 b=ni4OnYLRGJAlLO2sB5byNTLnaUFCVCSdaPzPUkgBs+pBOtS2EFgCNtmiKKeHNAPxaC
 o1nTG6svfhtvDbWWxSyap1de1QUMQMmTyDVT0hOdfBAC7Dx/bsggDWf1E9oVB07CvLfo
 bIqqRbbc1d4jBJ4rC7dYwnQslfQp/iStB90dZG2+rrl5ZnLPuN+VYKnT/syZyrlPfddO
 yRCEV+v/+VC/Jx3h9C7GcbadAtVjf3vf6AHdYpht39kxbr5+fFLFfmc9wq0G2sB2zQRA
 5w9csBZrJcwfDma3eORrxfQH4GkPJmRrwz63fUfsOt+eBmyxCkgcNJvzvCfvF8hgRwtA
 NvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sLlSMWMdhDJMDBDNvYUqg9ICNBsGUDvkmLeZtA0eye0=;
 b=UREcN5P8oVgAbjFQy6euj1QEPjhedhT8RCOZzYfWmJbIiuS55rQYE8MXx/IwUuctDN
 9h+NmwzLTKpot4MxVnb8naa5qYhWDbOovcjLQZ/POpLPbFEiHYSTbRulYbCR+HBR6EO4
 BuzTjf40X49aDI/SWPKbyV9sTP0KzX4dY34j2KANGBjJDuwXDHVpINBnRuzaffVE2fS1
 7R0BfdEl5vwOF8mY7fOdcg5X4ckOBipMrh+Fj+QWVaJe5RhVAI9L/UmOFKin6EMn4VYy
 ZUKpVaUD79B045olPzgrfEjmalKIlxr67mGfQO0WzC6IBPES7Hc2U2MVSUqu6rheEE0h
 R9pA==
X-Gm-Message-State: APjAAAWCCOgm7bLvPAQ7ZoHWNbVmFpT9oM4F4dt7Tx+Ga+Rb1UAHzfEj
 PjpYj/cySj2DcmRA2/ucXlrof/rW0q7lyF5A9Lr9aQ==
X-Google-Smtp-Source: APXvYqwrEum5/7KXHYMQRPaf00kbgAKkm4vAzlTMQho4nQaTGrrOPz7MX+4DmcVwSvUja82oD09I6SjQ6bMT6lCsTxk=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr23215478otg.232.1574084882983; 
 Mon, 18 Nov 2019 05:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20191118105319.7658-1-lvivier@redhat.com>
In-Reply-To: <20191118105319.7658-1-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 13:47:52 +0000
Message-ID: <CAFEAcA_LuhBishjDMKoyMu9BOdNCBu7T1mtmQ6v77j+oNniarw@mail.gmail.com>
Subject: Re: [PULL v2 0/6] ppc-for-4.2 queue 2019-11-15
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 10:54, Laurent Vivier <lvivier@redhat.com> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/vivier/qemu.git tags/ppc-for-4.2-pull-request
>
> for you to fetch changes up to cd8843ff25d62a0af747517289a4f330b1ae2a6e:
>
>   mos6522: fix T1 and T2 timers (2019-11-18 11:50:49 +0100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-11-15
>
> Several fixes for 4.2.0-rc2:
>
> fix mos6522 performance issue,
> xive/xics issues,
> fix /chosen device-tree on reset
> and KVM default cpu-model for all machine classes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

