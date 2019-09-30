Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32779C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 11:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF63E216F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 11:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSUZpRhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF63E216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEu5c-0004Jh-4l
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 07:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEu3z-0003DW-Os
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEu3y-0006z3-E6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:41:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEu3y-0006yO-8r
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:41:58 -0400
Received: by mail-ot1-x342.google.com with SMTP id 21so7958546otj.11
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k7kyHwRLGtVLDMErEunJvamrWstC8uYy8LdbeSNBN18=;
 b=jSUZpRhJ52Hh0QYwwp9EEE/de1pDLE3EJWKkwWoicZeubIBQQP5RHGYKVmmw7KSnvF
 6kbZqlPMeQYh3OjRBVbp+xBsE87/l+Tw63CTXmBZrOFcXESkxF762R6fY9iF5Ja/zGM7
 eUvoPzALkkaC7tmVVhKV/ZNIXsq6NOzr/lTV514bpcnUNPyWdQ7oY1tNb74yWxZUgc76
 stbvK/haaNIJ9Ce3CCVXTUb5mP0kolN1p9jUe/Cjm8rV0hYOACy8v3/g7XHJgfayuAwB
 0tBXrldKMjU/KTEq1JqZ5Mn4iqTJguqDamxQKRZoGgxd5wWgx5+ksKXDmCzt/C61GZ70
 Lo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k7kyHwRLGtVLDMErEunJvamrWstC8uYy8LdbeSNBN18=;
 b=Z5magzFI58Je0iyFdfFolXg6POd5vdncogS4ke+FUCfuozvk5/Wg9SRtaA9rz/UaVj
 FzRij0oGZZjbMi4K9Yn9ryR4dXvQklXArMPLaAYBwPZk0/mUarpAZi0Npeyan7ixlWNB
 zWXjfvuImnuNOoiN5ah2pT0OEet0EQ4SPRF6EQ++CvbK9DBMTOlmN7vaS22fHWN6QZfS
 /QYgdHEg2nOB5ruZI1TJzyoMEHWiqGigcmA59vLw9s7UEAIOusfAHhG8N4ZzHpSlorp2
 y7lE16HaGFCPEVdIT6vbhO71v6gwwirsd/GbXJ4Jmh1JIrzXuuacMLPUfwkIiqkWEdvg
 jk8Q==
X-Gm-Message-State: APjAAAV2lWfai3WuvmKyeTr0wRIVXlNuY//vU+NfpUYmLm9/fGuJ6WSU
 01g5WgpsY0KavkFF+RyoPmzH1qpzvtmzU7bvOtPmXg==
X-Google-Smtp-Source: APXvYqykcT9k5Yli/H81QYigJPV+34hZuyK7uNJPr3NKWVgLvpaXMLAEt7jwHSzQnsggsCVaIT25inMhjMgAMIKgaiM=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr12837474otp.221.1569843717181; 
 Mon, 30 Sep 2019 04:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
 <4512b61a-ed82-e628-88e5-f44ef87c2b50@linaro.org>
 <20190930092519.GB11996@redhat.com> <87impakrky.fsf@linaro.org>
In-Reply-To: <87impakrky.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 12:41:45 +0100
Message-ID: <CAFEAcA8_Zt+4RuXh8ww3Xm5=fQT+e_XcjZ6VC2N9k5mzLy0bnw@mail.gmail.com>
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 at 11:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> The int128 support is due to the fact we are going to start to see newer
> architectures with things like 128 bit shadow capability registers and
> they will be a pain to shuffle around in 32 bit generated host code as
> well as requiring writing new extra plumbing for TCG's pre/post amble to
> pass them back and forth between C and generated code. These guest
> architectures may not even be full 64 bit guests so it's not quite as
> simple as saying you can't have 64 bit guests on a 32 bit host.

I think that for int128_t in particular, the ideal answer is
that if the compiler developers want to introduce a new
abstraction like that, they should support it on all targets,
not just half of them...

thanks
-- PMM

