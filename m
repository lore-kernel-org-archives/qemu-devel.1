Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B12BC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639942186A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW2ODjDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639942186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2e7y-0003Qu-IY
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2e7A-0002yD-6T
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2e79-000663-5c
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:14:36 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2e78-00065b-VA
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:14:35 -0400
Received: by mail-ot1-x32e.google.com with SMTP id o101so19178894ota.8
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mCxnHygmuC9NVcJouefNbLAPjb5svalC9+ZawDjazks=;
 b=XW2ODjDYJaeHP1ZvWsjc2EjDKMXdzugOHgNN36Pb2UVioYhtnbRtHNufqlVy3lGaCd
 QAye9WsgDwC8uVrMCCLM6tYPlXeosaSDlBDi1IylXVoIeamomdxvyo6Ir7Z7J4oTHLzD
 EjEUnbXpW2nu6aau9FFTmOgTeWJyHI3hJQqrF+s4J30d4tyume9Sm2maSqphk4uiUrll
 E0npns+hIaja5app8FoK7DAdj1IR++sdfzQq8THoU9eYT6JXWKgfeRv7J9sSFnuQwsiA
 5BxDwNB7u71qhbVe5RrhF2KTsCm4AxjcHVmzeQ+KjFyXUeYgbgFeJ4dYovitSAVvbW4u
 TD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mCxnHygmuC9NVcJouefNbLAPjb5svalC9+ZawDjazks=;
 b=Z53APRiNi9dW8oFhHFU/MwjrxN6QXuppNg2py9fXV3ziu7gsSOwPPDyYoovJ43mSYL
 GopB9deR3RmbjT5iQLpOjSznFgPbw3wjkvyQk4OdenD/Z231+Wt78doM2l8xKHjVWzKW
 8Dw0Tws2ZFUeNTlbRipdASfBF4P6STPPmQ7lhZtBVvhd01cEC6wjMCdOP2aAs46hvJhs
 PEPp0tQJfT64EXt7OcjQFWjt43i3NYQFdtUnAmvWAidMt4kAPaMIH9JPtE2PSP5ujC6H
 p7yJZi2iUC79/xfhRE2goqDUrX5IicfOl8p37Lud/W/DDl3tbgbraizxsSeWTtaXU6Le
 Bg+w==
X-Gm-Message-State: APjAAAXmr/m5fppTeq0ChJnVy1vjTlAwG+Mn4RjxLXqx318VbJg71zyo
 T5OMMiT/tZoNt/UAAbWvNgrK+n7l9+qxbBcLwkE7qQ==
X-Google-Smtp-Source: APXvYqx5lPeVYhPVDbZsGzuuQdfLK0tKp2pcPVnQ6CLNTyxH8cqdhZONBgYfY0x4YdJPXlxdAosZK7HKaJrbP1iH2Yc=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr284595otp.232.1566922473942; 
 Tue, 27 Aug 2019 09:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190827133259.32084-1-anthony.perard@citrix.com>
In-Reply-To: <20190827133259.32084-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 17:14:22 +0100
Message-ID: <CAFEAcA86rs-61W=NPi1373HaiBweRtyv2xc8ovXAfwR2wtydUw@mail.gmail.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/4] xen queue 2019-08-27
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
Cc: "open list:X86" <xen-devel@lists.xenproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 14:33, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit dac03af5d5482ec7ee9c23db467bb7230b33c0d9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190825' into staging (2019-08-27 10:00:51 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190827
>
> for you to fetch changes up to 705be570941b38cd1cbebc68f7f671ce7532ecb0:
>
>   xen-bus: Avoid rewriting identical values to xenstore (2019-08-27 14:18:28 +0100)
>
> ----------------------------------------------------------------
> Xen queue
>
> * Fixes for xen-bus and exit cleanup.
> * Build fix.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

