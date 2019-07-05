Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E05C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCC0218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="On2OFvW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCC0218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjM8h-0005MG-2I
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 07:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35312)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjM6j-0004Bb-V0
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjM6f-0008Hw-7x
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:10:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjM6b-0007sP-O6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:10:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id a15so8448956wmj.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EV2OdtWOJs6us3ChpZKULR2+ahbHmgR3nerIxTWnQ6Q=;
 b=On2OFvW2CZHrRRdK2uHEk+VODz+lgy49iNwaamwfTStQjTHWa7nD3qOmMgDFspl2Nc
 B9fd5WMgtx9yr34vi8Gj94H2OKbdh6qb2RbpSdy5uYgwFBBKUraC/bBHRDS01WmVeb71
 lLV3+mPWsLvh5RDNOx1tGAJF6YhEpoAKTW2N5Ot+aQPjadqW5r1Wy9ok6rRUGG6yxVpK
 FyxGHfEBIRf+OsRdTytg6tIEbHuDym742DZHosyQRZNoK3hEEWhvfp1L9PPi+PoPu8sG
 YFPGU7cbC8LPMxu7biiqVv76xPz2pwA7WVS/RHX38YxsSzsjpRJMA2LbW56GV4yMXiUP
 hPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EV2OdtWOJs6us3ChpZKULR2+ahbHmgR3nerIxTWnQ6Q=;
 b=LiZ1h5qYEycClAlDfNB6jNqColoNsklayIaHRX531idYO/PVbOfCb47yDc1WEa83b1
 Tn85hBBjioy5FyEbwqDczr4vuR561OwZm1iGk/H4PP2C1vps+fHQbpjYov2+F9wTYjSL
 AfKlR2DofEp84X6a+QYtSlpUg5BHHiOsNN1D3Adg/Fr0YN6ItozD8VjlpyRduxr5O1ZG
 GlLFw9NeHyHIB65jhdk4ckId4L3jNY7NGKtoQLNCGrlleDmz/RkFOxjg4wL/EYHBcZcm
 K0vPb6zTRm6Y8H2ZSWpq2yZO4HC2KxiFjafxmOyfKGhXpwZ3JFsJixZfXpBARiXw18mD
 phfg==
X-Gm-Message-State: APjAAAWpKSZkVdnO+hX2cBly/615kZ+W4wMb6d0fdPRlJDA9zXEUDv0g
 /2ot8zxGm2YaDgeiZz3KunixHg==
X-Google-Smtp-Source: APXvYqyWlYiCMLKPdZ8k0ntKhxwAVYoNy5tboyHGWWTb74vB1/+1CG3vMlkZ49Rsw/TJDPdhf5DDBw==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr3096127wmf.162.1562325014852; 
 Fri, 05 Jul 2019 04:10:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j16sm5453168wrt.88.2019.07.05.04.10.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 04:10:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A18731FF87;
 Fri,  5 Jul 2019 12:10:13 +0100 (BST)
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com> <87zhlsvkx1.fsf@zen.linaroharston>
 <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
 <CAFEAcA9yGCXB0XTNeZwzKyX+WtMNjG2s-RPRSc6GSOLN0nh6fQ@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA9yGCXB0XTNeZwzKyX+WtMNjG2s-RPRSc6GSOLN0nh6fQ@mail.gmail.com>
Date: Fri, 05 Jul 2019 12:10:13 +0100
Message-ID: <87y31cvisq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kamil Rytarowski <n54@gmx.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 5 Jul 2019 at 11:43, Kamil Rytarowski <n54@gmx.com> wrote:
>>
>> On 05.07.2019 12:24, Alex Benn=C3=A9e wrote:
>> >
>> > Gerd Hoffmann <kraxel@redhat.com> writes:
>> >
>> >> Instead of fetching the prebuilt image from patchew download the inst=
all
>> >> iso and prepare the image locally.  Install to disk, using the serial
>> >> console.  Create qemu user, configure ssh login.  Install packages
>> >> needed for qemu builds.
>> >
>> > I've had to drop this from my v3 PR as Peter was seeing a very
>> > slow/hanging install when running his merge tests. I've tried to
>> > reproduce and I see it stall while installing packages but nowhere near
>> > the delay Peter has seen.
>> >
>> > Any pointers on how to debug gratefully received.
>> >
>>
>> Does it use virtio? There were performance issues with virio disk device.
>
> The symptoms I see with this patch are that the VM appears to
> completely stall, rather than progressing but slowly.

which is odd given we are both testing on the same machine (hackbox2?).
I wonder if there is a environmental issue? Possibly the host file-system?

> (I do also see on the current NetBSD tests/vm setup that sometimes
> 'make check' runs pretty slowly, but in that case it does make
> progress, it just completes much slower than either the openbsd
> or freebsd VMs. 'make check' is not particularly IO intensive,
> certainly not compared to the actual compile phase, though.
> And sometimes the initial "wait for VM to boot and ssh in"
> phase just hits our 6 minute timeout.)
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

