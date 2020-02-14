Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B7C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BCE20675
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVhpa8hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BCE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2aGq-0005pM-Lu
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 07:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2aGA-0005M1-6g
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2aG8-0000II-Vq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:39:53 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2aG8-0000Fp-Q9
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:39:52 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so9248055oie.8
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 04:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OUIy/1mNKrX0gJzgi53pMF6QUaKyVtq9r6kLIjfnF+U=;
 b=vVhpa8hdtYKsjsu/VnMsfRsHdr29ovxHpiqIvl7GTp9hWqwWi1GFL084QwI6jrjHd5
 HbP0n4Ck7d/mcd+XmspIj6QSo/CudQBnjtIOYptULoc452026mudX3Q8fqHHnjVRnmQy
 oxj9Cy/ei/Pb3CDgXv4p5FK+ESE8i713RMRzSgrsiGuMLk1cKGpAds3x150YWkdVmENY
 2UuwDS56DOJ7lrME4zV88xYSWgVGdflrDpU87WkkkGuMnmB4iZzbJ0GDMn/MEEu1ZOwH
 AiU0g6q2GnOSszM7NPS1gt+3Wf8ZqyW1cZDwA0O4my5D9It9JRRUQf2gxRGzo4DiU6Rb
 v5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OUIy/1mNKrX0gJzgi53pMF6QUaKyVtq9r6kLIjfnF+U=;
 b=kzjgr9erUcN8r8tPQJzuvOlyJrgUwFIVT5RL6ewMsQBlLqfk2IWoJJzuEyBSE/K5y1
 QnMbRGJZOkTCmo4BD3Ye1X2ayWUop1vcXZUANk/o4TuxEgoEyq7eAgPFL1LZHffYWDiM
 CNzpXctY7upB/RQac11scB8fUjkVk2u/qsNo9lh1CZcUmqIkja42xzHK9x5kew1JFrFa
 FD8GvrC4GfaM2XBwgbcgUEiW0Rr849RvQtZWZoYoVaTmPHQhCNPOSSz7NQz+HlirehDO
 oDgnOKdBXsdxwrZGqiprQM+LcNw/2hK1uX7HiaWMVdmEFeaW1BrwIlElD3F5pNKcNlPR
 whJA==
X-Gm-Message-State: APjAAAVBPNdQDY54ZXx/DrbnoN8Djk1UljMIJkkyCgTUslTTdt/GuWur
 2xHAWLhR3zfMdQp5lHrW2+0GtAu78KZKdheZfNBKBw==
X-Google-Smtp-Source: APXvYqwATXE/Y/0aJLUSzIeIGy8Q0cy6gcKlzJA9qTJ4i8vAbXYfP53BymVLAaDFr01EpxHFsyoayj8SARS7iIRIbcU=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr1647913oie.146.1581683991668; 
 Fri, 14 Feb 2020 04:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-2-peter.maydell@linaro.org>
 <87v9o91xvv.fsf@dusky.pond.sub.org>
 <CAFEAcA8ZPrkfzzyxe-im609GQAxEqRz_z3Ar2EFdcFqzyN4p1g@mail.gmail.com>
 <87d0ahxsv1.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0ahxsv1.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 12:39:40 +0000
Message-ID: <CAFEAcA9ZQfeKA7Nb4FSmk8G3JmCFQa4VsMYLQmE2-UBj7YVeuA@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] configure: Allow user to specify sphinx-build
 binary
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 12:20, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> >>  # Default objcc to clang if available, otherwise use CC
> >> @@ -4803,7 +4816,7 @@ has_sphinx_build() {
> >>      # sphinx-build doesn't exist at all or if it is too old.
> >>      mkdir -p "$TMPDIR1/sphinx"
> >>      touch "$TMPDIR1/sphinx/index.rst"
> >> -    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
> >> +    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
> >>  }
> >
> > This change isn't related to trying sphinx-build-3 --
> > did you actually need it ?
>
> If the for loop finds nothing, $sphinx_build remains empty.  Quoting the
> variable seems cleaner.

Oh, I see. Anyway, yes, happy to have quotes here.

thanks
-- PMM

