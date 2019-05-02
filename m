Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70CDC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 13:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8972075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 13:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsFVGL3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8972075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMBp6-0004QF-VH
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 09:32:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMBoC-00045P-0F
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMBoB-0003zT-0s
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:31:31 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:46453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMBoA-0003vX-Sb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:31:30 -0400
Received: by mail-ot1-x32e.google.com with SMTP id 77so2009860otu.13
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=jqztuM9ZH266yLmIYBprEW+hzUjQWl59mgE0gdQsvuM=;
	b=JsFVGL3yT3uCa25JoCi4LubEuGG8DoYopSo5R26rqyJSF2EOY9glH0b7vzQCMK12QO
	/gv5r64gVZQ8JeVK5BV4yhrM97aTnz+96jUgkGJqYZTdlsoSz4WyBq1+ODnmy5ufyM0L
	MI+L9ci1jwexxTZyUS8YMiqVsWN58grp2uZ8X9HxEpMBsdgwrl9cQnUlwAQiQv2jqqIV
	nERwiCHVwpMJwMxPm0RMgu7kAYaad8yYKa1sJZhcjh+nSv1Hly5otVQ99okNlZI9wwTY
	ZbqhX2aAVZiEO3lE9bqcOG9cRAIxLCP3uREHWDwsVNd1zsyARx0iPd0nf4uk02mkyD3Z
	0HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=jqztuM9ZH266yLmIYBprEW+hzUjQWl59mgE0gdQsvuM=;
	b=H3FnfJvcmhFiiXC60cVBPIHcp2gzNc+2iVU06tdNsxXVaGEFK1e+N3YW3GA/P9C2ge
	HKaKgaPHZLnDvjqqQOjgIZQNQcYtlCzV98Tth6TKWJDXNnzfqXQzJsuu73Dmk+Lvfapm
	mZEwYatau1ZrEgR/ck6bWfdf6wKWqrRn942x89dc908q9EJs5yyjV0iaJH4Ncwbye7lO
	YTqxsJ0RusEvDPJEtXuH5EUx3H6dK3QZjQbYJ2CcKzj+5UG9IiXK2omrD/bPS/dBU8JW
	CFgz2r2Wzo9huZjcMyYrLEAIqbatmS9jJd8Sz5ARFrQFLWSoMmsCOwKcP3Rd0PO0uWQL
	YOlQ==
X-Gm-Message-State: APjAAAV58eXo9R238twVufCXtQsUDtvgV4nmpVljXdET5RaIZFis9Zho
	QAfNovvdPokitwc7CltjylPFt/5w7Zd85YLbfUCbww==
X-Google-Smtp-Source: APXvYqzNNCTYyMY6VWmyjTOXqrGiQ+ltQEuIyAHiD82SmfgpvYvKJKnqOsCd1TSGMJnaSyzOtU7RbzFe+h7Q5qxbd5Q=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr2386360otk.363.1556803889443; 
	Thu, 02 May 2019 06:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190502073543.4391-1-kraxel@redhat.com>
	<CAFEAcA-OyrwAqp1Kwt-sFJY3xj=0mUszGtF3RewwLs25vOhNLg@mail.gmail.com>
	<20190502132105.qkudeunhcueadka7@sirius.home.kraxel.org>
In-Reply-To: <20190502132105.qkudeunhcueadka7@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 14:31:18 +0100
Message-ID:
 <CAFEAcA-85EsCJGOPZ1ugZwa9GHQBYoGVi-im8kt2yjrSY+HJow@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/7] Usb 20190502 patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502133118.FCQbzw3u2ZNQbFSCkm_ngy2G0hIiiOVjJkpgEIUgo2Y@z>

On Thu, 2 May 2019 at 14:21, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > Hi -- I'm afraid this failed to compile on one of my systems:
> >
> >   CC      hw/usb/hcd-xhci.o
> > /home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c: In function
> > =E2=80=98usb_xhci_realize=E2=80=99:
> > /home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3340:66:
> > error: =E2=80=98%d=E2=80=99 directive output may be truncated writing b=
etween 1 and 11
> > bytes into a region of size 5 [-Werror=3Dformat-truncation=3D]
> >              snprintf(port->name, sizeof(port->name), "usb2 port #%d", =
i+1);
>
> Which system/compiler is this?

x86-64 Linux, gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0,
non-debug build.

thanks
-- PMM

