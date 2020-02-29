Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA4C3F2CE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 11:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C963246AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 11:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+vgKNKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C963246AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j80ep-000379-BZ
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 06:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j80eF-0002iU-HR
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 06:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j80eE-0007PS-7I
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 06:51:11 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j80eE-0007OK-2E
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 06:51:10 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so5640218oic.3
 for <qemu-devel@nongnu.org>; Sat, 29 Feb 2020 03:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j+k+WqwiAagv6JjYOx4NVvjYSUHDiShi+0+mQgNmdkw=;
 b=D+vgKNKUqD7ZAVcuvriy6qQ1nZg86JpBZIWUbS9K2qRIrihPQWrtpZuV1KSPZpyxKd
 m9c1R8LqbHTzTKeHo8PTV04eLjMx78PTGXHxEijxk1vNmbTlFjjtWGtidrKFCydLtQLx
 8zO2TtuetfRpWOyNccBjoVJtA+rrPD5owEKHN9r4Ae8IRt1tv4+MzwFzlxsAW7rzBM3c
 g32d9TVlTW/5ARW2oNXYuDvpIExs685pf7HfUL3P8Dnd+lNfDdEGY83oJlTY8P16cvZM
 Ui6XsgNJ05Aup6xHdYxIb+790duRdLidUzM0hVROZ0RCMQD7OGhXcjMP/Pc7qK4gsb8D
 tSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j+k+WqwiAagv6JjYOx4NVvjYSUHDiShi+0+mQgNmdkw=;
 b=JYEpibXxGpk7XabAsjGNXRFO9oioRWHUoHsLQgcn9qac4h3r73KV9EHiTXlaOlqCgE
 yvrvzt5cLvtl3XRwpXSnXOLpOOCHGfIlnQIISoOkQQ2+0RsBOhWRW/80HQ8nmLiwbnrj
 AgTBr6i2m2UApxFQf3DU9qW4esipmu1PhJyAzRgHL/D28uKKGONlA9hFaHJPRavLm2sA
 Kwv9vrZ8Htzpu1LMZtpeR9p+vtCGJGxlE6Ltqkw1Bxxj3b3mf4eHweRgWusC3cCD78mP
 LK5kWuY8sYSiR9VqrbbnKE9GF8z0Yeqy6XfE0Kei43Cc3c/KzteAMQ6cEqA1t6kJHsnA
 iVAA==
X-Gm-Message-State: APjAAAVN8E4OeR/xqXdMxfX5TwEu7F8RmXKg3wsOx+QPEUtmfj52VhBk
 FlPPPcp3JW3dWmFJnxdQH4ISQkWANUBO0xnY4z+QAg==
X-Google-Smtp-Source: APXvYqwr5uQ3mADel05rRN7L8kBvRLtVhyCckA44Jdnn0ywETKn4bCtd+FZ7kVz30aygoNUrZE7EnFCLeNxQEaxgKDM=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr6122167oif.163.1582977068563; 
 Sat, 29 Feb 2020 03:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <CAFEAcA_nURkAfum3AxbN2S1DDy3YETuuewOiZ8+RLgbH7OFuAw@mail.gmail.com>
 <53c37de3-7a06-e41c-85f0-0c66282eafdc@weilnetz.de>
In-Reply-To: <53c37de3-7a06-e41c-85f0-0c66282eafdc@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Feb 2020 11:50:57 +0000
Message-ID: <CAFEAcA-pK=XP1cKpr9nSQsXFUP9oSZw=7At+8O+NiPvhhPj6cQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Convert qemu-doc to rST
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 at 21:20, Stefan Weil <sw@weilnetz.de> wrote:
> Maybe it is sufficient to update qemu.nsi after that series was merged.

If you're happy to do it that way round I think that would certainly
make life easier in trying to get this series merged without too
much delay.

> Do you think that all documentation should be part of the Windows
> installer, although it is also available online? Too much documentation
> can be confusing, because it makes it more difficult to find the right
> entry.

I don't have a strong opinion here, but:
 * the contents that were in qemu-doc.html will now be in the
   various Sphinx manuals, so if we want to install any
   docs locally at all then installing at least the system/
   manual would be the equivalent of the old qemu-doc
 * is there a strong reason for the Windows installer not
   to just install the same set of HTML docs that the Linux
   'make install' does?

Three possible choices:
 (1) don't install any docs locally at all (rely on the online docs)
 (2) install just the 'system' manual (this will catch most of the
   documentation relevant for Windows, but misses a few bits
   like the guest-agent docs which might still matter for Windows users)
 (3) install all the manuals (this will include some manuals or sections
    definitely not of interest for Windows, like the linux-user manual)

thanks
-- PMM

