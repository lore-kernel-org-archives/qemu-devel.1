Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F84CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5929B20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAAZh8L5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5929B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioW2B-0003fh-Gl
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioVzy-0001wy-MT
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioVzx-00015f-ED
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:17:02 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioVzx-000157-9M
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:17:01 -0500
Received: by mail-ot1-x342.google.com with SMTP id r27so72527101otc.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Edq6LBKbuEUkVplSckBaeEYD1hTN6Nww1y6Fk9AWehs=;
 b=RAAZh8L5Od1ka1ePbvXBRgxvggFYE7qtpxJnGVuMAFhZVER8ZTeBNk95YjhViQiktw
 0ZDzg8Q+QxWKyqBma+/z4QD4XVLHOcVDcu8+/YkOmd6dlMnY2ggXZ8C5stvycl8dboeE
 12AseeCCgmwMqZpFZRvbsgElnvdVR+wqBb/HSpV1MaYYVq/Y88VirhFAUNPdW3o7KRzF
 R2XWDDnanOeX9XQFlLIJoGdlgr6+Yaq0tEND2vUbplKDT/ACmaVN5xdHb68i/jx3Zb6z
 3w/hwmedevxmxJqaCrKEyw6rXd9tpn0S5TxL2o1FbFohgjVGPiSUkGVJ1YMIZf3Oqz4+
 EzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Edq6LBKbuEUkVplSckBaeEYD1hTN6Nww1y6Fk9AWehs=;
 b=GJEjkQ0hSKabGpbjhZ5IiNWv6GZr9FDHTM50qADGo0JLnRtq+pGeMEOFBtJlZCGRfJ
 vp3fE3Qmz8V+yVOzu+ID9kFPegBRO6nHdsOOozxO4gBifFslFuUBfuk6mQJD61Wia7k5
 8l/SSDJbef/VTgJJ+fARrXGxsaC424RLmOorNd/ThllkvtqKQn8al3C0k4TGj0l/IyNV
 Lfz5IN2tBoXIB45PaqSSyC6afuZfc+GuMvSl6U9zCUdLvQ+c2dlyGDcB72vsB8UU8YVP
 AsrpEGsnPoxhSM6hf4k2rh7YsezqLwEcwtrLTHCtNKU6SoEgLa3mp3iCAfltLtAWEz+j
 2BFg==
X-Gm-Message-State: APjAAAXZbsASKJcx0udldfkYkxGftBJFJa945BAmeME2JvKIGDKuFgnZ
 xnA+Jdmtl9JDW273nqANW7hArUDkI4KY0g78FeCrRg==
X-Google-Smtp-Source: APXvYqyObqvOd/9WVOL2n9YMwrkhQUk9Gw81gZt+lI3doEyFi7Q164hnfb3WAQ1qnTuj3n4HGL+b8Xc3O1CHOcuEMHk=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr117794451otd.91.1578331020524; 
 Mon, 06 Jan 2020 09:17:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576658572.git.alistair@alistair23.me>
 <dad8d8d47f7625913e35e27a1c00f603a6b08f9a.1576658572.git.alistair@alistair23.me>
 <20200106175650.0ddc9bf2@redhat.com>
In-Reply-To: <20200106175650.0ddc9bf2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 17:16:49 +0000
Message-ID: <CAFEAcA_VmuxuCWydF-ryi9dAF9_kGFYM2Co1fvMRosdDzTSXOA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] hw/arm: Add the Netduino Plus 2
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 16:56, Igor Mammedov <imammedo@redhat.com> wrote:
> I wonder if we should make user provided '-m' a hard error
> for boards that have fixed RAM size. And make '-m' or forthcoming
> "-machine memdev" optin feature for boards that explicitly ask for it?

Maybe. I bet that there are users out there explicitly
specifying the ram size anyway, though...

>
> PS:
> (I suspect that the most boards with fixed RAM size do not really
> care about numa, mempath/prealloc and other features memdev provides)

Yes, almost nothing cares about NUMA and all that stuff,
whether it has a fixed RAM size or not. Ideally that
would be opt-in stuff so the 99% of board models which
aren't x86 PC or arm virt could ignore it :-)

thanks
-- PMM

