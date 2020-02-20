Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE2AC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B0A2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yyt6vRdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B0A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4o21-0000M0-Fu
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4o10-0008EU-Ra
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4o0z-0003Uk-Ez
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:45:26 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4o0z-0003Uc-8a
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:45:25 -0500
Received: by mail-ot1-x343.google.com with SMTP id z9so4066642oth.5
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mdR+N/IRKxB9ME0WApoqyFVwV7ifMuxhDHnWt63WviA=;
 b=yyt6vRdtGsROEk+RQzDVur2wuMsIVcYmZ2yY4gqQ1Q40tYw76+iXsBv3nZll+Gu7G1
 WzXDWZQO+bZ+v6fMDVbz9WCYd9Jwi01rE7XEZmLy6zFOA/r0H1ZUh1vGNj1Ns/xEinbD
 oSu+ClY3BkoDMVJ29mKyAzzRNLYjPFy+NSBQtGhDKVccN9+E+TLfZ3ooBaXB4dQvau+r
 hJXw/Px6IKenRR/tleMOHUXn4eBV4JB/bhuTGThjoczGoQdh9Q0cXdcqgm1pcOB9uutM
 y8fFq/Uv//mVHaw5GMsCJG48BlG51+i8NLED8OZsTtyYfbpS4g20MXYUkPHHZkB35uK9
 fYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mdR+N/IRKxB9ME0WApoqyFVwV7ifMuxhDHnWt63WviA=;
 b=s5Nbc18eEhiVCjE0BzCUXbwhgHPfuSVxdqtUghxKylMztxAU/EciW321cLHHEy83Tz
 yqX69ZdFtWOkvPiYFL3Zmf4gMHMO0pbkUe4Vn6cSdLCtFOvHsozl5Bc+GS4YwQmVjp1c
 TRGj/DhLBU0eRIsD19/XhdRBd+3iI7mKDMUDCM9GEVJk6QkOZArhj54abEHIsjKxhVtC
 xpNsTFQnLEPc0x/hQwb/M4q41t29pNNPpiNgiByq6LKHBVYyHbkCqXJc9aFsngZpmDPQ
 iJhBfw/MHAGs/iw49oTxpW51HqRjloohQoCAeLR9wAOv8LnxYl8Z1aZnd8QI+OBFH6Fs
 HZxg==
X-Gm-Message-State: APjAAAXDWIokYdFM5Euh7eph0M4mWMWTyDjM1kElKj2L4eq/YNj+SmGf
 cXl1MlQMf3UML6Ps3Vytm6fXQg3dYQSyeaIAnF0wdA==
X-Google-Smtp-Source: APXvYqwvTPOtGlKqQ7Opem0F3Fgf/XXiRIqW5NrsuAX3gE+LV2KIcwlY1SHYGn/I4+eWNNEYf9F+bLWCMYrAhWt+Y3E=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr22916293otq.221.1582213523880; 
 Thu, 20 Feb 2020 07:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20200220142001.20774-1-kchamart@redhat.com>
 <20200220142001.20774-3-kchamart@redhat.com>
 <4c3f3d85-9499-2e48-124b-18cc0dc36c8a@redhat.com>
In-Reply-To: <4c3f3d85-9499-2e48-124b-18cc0dc36c8a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 15:45:13 +0000
Message-ID: <CAFEAcA_C0pmCgKNhw73q=RcQDQOdaQ9KCeTnEK_usN5K3eX-pA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] qemu-cpu-models.rst: Document -noTSX, mds-no,
 taa-no, and tsx-ctrl
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 14:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
> ... refer to Intel's `deep dive into MDS <...>`_.
>
> (I don't know what the trailing underscore is for.

It's because the external-hyperlink syntax is a complication
of the simpler format for within-document references. Inside
a document, you can have a simple link like this:

  This is a link to the target_ defined below.

  .. _target:

  This is where the link target defined above goes to.

So trailing underscore is for words that go to somewhere else,
and leading underscore for words that come from somewhere else.

Syntax complication 1 is that instead of word_ you can
say `some phrase with spaces`_ if you want the link to
span more than one word. (The docutils spec calls these
"phrase-references").

Syntax complication 2 is that instead of having to define
the target of an external URL separately from the place
you wanted to refer to it, like this:

  .. _target: http://somewhere-else.org/

you can directly embed it inside a phrase-reference:

  Go to `somewhere external <http://somewhere-else.org/>`_

which is more convenient if you only wanted to use the URL once.
But the _ is still there because it's still the markup that
indicates "this is going be a link to go somewhere".

> I reaffirm my definition of rST as the Perl of markup formats).

Not going to argue with that :-)  But like Perl, there's
usually some kind of a rationale lurking under the surface.

thanks
-- PMM

