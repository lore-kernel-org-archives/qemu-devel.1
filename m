Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69722CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362DC205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PybseOIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362DC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0TL-0003Bp-WA
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO0Pn-0006Ag-OT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO0Pm-0008Bx-EI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:18:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO0Pm-0008BX-8r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:18:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id o205so1705779oib.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4X0GXSUKWTu4Wara9llUPrzOZUPxl9OR9FGZcMHEgSQ=;
 b=PybseOIERpB8x9rm9/9OdnVCyvLe/m7NV8Eu3me8hb1KiTjQuxJ+9m3BwoHbDeQqjk
 4qfr0N8WgKGWc5COZDQK+b1bL+5jE+spkXHaUTc0UO/zy8aE8iLgeQQJ3KeMJrugIfIu
 n4roc5NprEiOw/74zMaHrvpYctx7OIFg7b3/MTKRH+VLIqufqQ3Wo5rO+zpAepaVbrJh
 RqlMTZSoa788lhEQU6UhMVTsCyblbSxZysbCWTRO3niMrqqazJ8UrKGUvi/kLMAUfVWL
 nAvJmRjN9aExJRTXu9dldj2WsDFo8SjbpcAF+T+ras1eIWBPBXV1OlWQGfQHdPLZlDy9
 PvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4X0GXSUKWTu4Wara9llUPrzOZUPxl9OR9FGZcMHEgSQ=;
 b=mTNHnvUQ9S2SUIB4+uX3EF7KOO9/gDnfqeirVBpE7i8k5ld0ygs7TM/Q0Q3m7l5Ikv
 OGZxCmRgIPfPqBOrTfmaaOVagSp8qPBZD06sBNAU82Oe8EIWeQyI0PaniFKyIUYiXS3Q
 8lJneYm6qHpHDwSFf+RTK+apGftq6nZAPlLFZDknD4WSxKpBoC+/p/7tKALPpYWv6dy4
 /b/QqamlCd96ma+jNENMF63EzfaJxoxHq4WdDNN7dYyh9SfzDDYC4PfIgsWpd/rbLPml
 RElJmIAsNzi2Vl94SpyzCy/0FEpSYieszCd8FkyqW/X0Nl2RqUAydRUy9ah7Xzne6YQY
 /XJg==
X-Gm-Message-State: APjAAAU+irPI6zHMKB6E+H+yIb1tFdjENG99d9jmV0y0gd2f7fIeigSE
 1iGQHJ8gRFeoH0FyZHioipTGuorHl6LmBtUWgx/sCA==
X-Google-Smtp-Source: APXvYqxmOxwMa9izI/YUKPAcJVxZuYIkDFfb3Ea/X/sV0hUSwuUgI1+nRRI6YMj1MmG5rGt2BXHZXqUcNL+mG5fGjJ0=
X-Received: by 2002:aca:2312:: with SMTP id e18mr2233682oie.98.1572013085302; 
 Fri, 25 Oct 2019 07:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191025095849.25283-1-mreitz@redhat.com>
 <CAFEAcA8Y8fGKC3DkdM+wkU5Oe6ACZMtvWjpry9qFgPJc5KYjdA@mail.gmail.com>
 <19d50c64-c07a-3122-dea3-a5d97a2d35da@redhat.com>
In-Reply-To: <19d50c64-c07a-3122-dea3-a5d97a2d35da@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 15:17:53 +0100
Message-ID: <CAFEAcA-3nt69+fUCf4YysVqsWd3z8r1iuURPYAPWUdHcd41p_Q@mail.gmail.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 25 Oct 2019 at 15:16, Max Reitz <mreitz@redhat.com> wrote:
>
> On 25.10.19 15:46, Peter Maydell wrote:
> > On Fri, 25 Oct 2019 at 11:09, Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> It seems to me that there is a bug in Linux=E2=80=99s XFS kernel drive=
r, as
> >> I=E2=80=99ve explained here:
> >>
> >> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.html
> >>
> >> In combination with our commit c8bb23cbdbe32f, this may lead to guest
> >> data corruption when using qcow2 images on XFS with aio=3Dnative.
> >
> > Have we reported that upstream to the xfs folks?
>
> I=E2=80=99ve created an RH BZ here:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1765547

Currently "You are not authorized to access bug #1765547." for
anonymous browsers, just fyi.

thanks
-- PMM

