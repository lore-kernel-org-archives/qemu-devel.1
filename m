Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BACDCA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB6B222C9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLjSUk+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB6B222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60347 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO072-000330-Tg
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNzvo-0007Uc-FC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNzvn-0000W2-1g
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:47:07 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNzvm-0000Va-SH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:47:06 -0400
Received: by mail-oi1-x242.google.com with SMTP id o205so1641333oib.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WgnQD5uzuWnKVqKeyejWlUu8vJaeKmq9xJPO3LyNe/c=;
 b=CLjSUk+r+Zt9D8eBA04kR2Nxqi/92EWg+AorPxeuy7DHuZU/UCNNuYKzTOdvS4hqkE
 PvEv7Az0EPUJlsyf9+DPwFSluCm7SrrHH1qa4qP+BXbDgIpixeErjAa67p0208hVUQ6h
 gTp5rFJq5v+Y9C9f6+aYVx43mAoqHGDsS5+P/meHPW0z/Py6J4jHE4LYdbHZbdKFr0Nj
 EEOMKnNOPLHYAqWHeS4W8YaqjQM9l6VX7szkbi7m2taM0fM5cTi7Fl/LRPRjuRFDAKWr
 sJOxmiiVb1/H1QMTC10bDrh5Jszlkl1PES+l8OkN2ifhhONGQ2tmGGQtCvxNzNZIfD8P
 hFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WgnQD5uzuWnKVqKeyejWlUu8vJaeKmq9xJPO3LyNe/c=;
 b=uC73CfE+uV090AKzNObcQ10+JJXw6zOfVj0RvLECUARgpTau7BnW33ao1I0d7Sc5YE
 +efCtneAQwxiTziX+9iIgayA9pCxVZCxX1ljehfdkWmdX2YEIgFRyd2+CgYom+ViBBwe
 lvPFAyVA1Jv5kVsCHkqevoP6+f1MMeTsbI6YdcUwJHk0T4rPJJUBq3wplYDQ53Z57t8E
 kz9WSUjQlYGFy+YSNSFuN63jw3DtWm7rCGjD8KJGEHHAbuwlgEAerKhMDmarKv2FlGr6
 z4l64I3K1mZyEvmeMz/OMRHQSB3OJ3JkCOfXINdh0CBJbYSrGWwNorMcEarymLRVVo+g
 y2pw==
X-Gm-Message-State: APjAAAWquosRff96VFLq8qtlvR6f186D4Rm2kmEG39dF0u2Srh5BNa6m
 /hxs8FuNSoPpHSw8thjuS4d0X0ZaTOuK7nG1XoJ/2Q==
X-Google-Smtp-Source: APXvYqzxk5jTRVZhdk96fm8TYCik6x9ttBFX3mNWkBU0jJBVzqpEB1upQnIUo5eg9rq3gFGKCMVtHY9+tka9AoIdiko=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr3006428oia.48.1572011225636; 
 Fri, 25 Oct 2019 06:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191025095849.25283-1-mreitz@redhat.com>
In-Reply-To: <20191025095849.25283-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 14:46:54 +0100
Message-ID: <CAFEAcA8Y8fGKC3DkdM+wkU5Oe6ACZMtvWjpry9qFgPJc5KYjdA@mail.gmail.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 11:09, Max Reitz <mreitz@redhat.com> wrote:
>
> Hi,
>
> It seems to me that there is a bug in Linux=E2=80=99s XFS kernel driver, =
as
> I=E2=80=99ve explained here:
>
> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.html
>
> In combination with our commit c8bb23cbdbe32f, this may lead to guest
> data corruption when using qcow2 images on XFS with aio=3Dnative.

Have we reported that upstream to the xfs folks?

thanks
-- PMM

