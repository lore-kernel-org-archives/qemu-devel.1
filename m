Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D07C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12CA20665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrBX4mrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12CA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3DV-0000si-Pz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 16:48:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhyf1-000631-Rf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhyex-0003kA-7h
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:56:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhyew-0003gl-Vw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:56:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so13980997otn.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7dDgztrAvYNsHPfOeD93UlTDOaXp/xJd2TN5nfAXZLg=;
 b=BrBX4mrCEjd+UlHh+Q9RPIslZ16z6nTQqByUM73TIPmE5bFJEvhwimggh9W9dwJt1F
 2bcvfFiGAcd5bWR0q3gDQGxzJOFe9dl+pKB1I1Rbx8i2szuwB8c7GOuX1V6lq38KJM5A
 mYfXUhRDdLIS2jsKWXpS2NP1Rb1GTLUqOVwb3JsUSNk6ISE4nvYmO58OPXi2wSM6udaR
 /M0CrMEDP8wTauyCPiPJTEdxKgiu8GYsZny+jfvgimp7BMq2y0Gmn9+RBZ670Zt+XPo6
 5pxntywGCsI8xZyy87JrsJqPvGczcQ/Bu3KCtNzXv1LLjUKBlZXU4K546YYt5gmuNFGf
 gsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7dDgztrAvYNsHPfOeD93UlTDOaXp/xJd2TN5nfAXZLg=;
 b=nuhpU2FrsRQcKKFCDEIQ4pJ6v5iXN8G4XMv9/jvpbVDG8+Aw8z5jOkiQRdFGZY6fyY
 LYNqBLkMt4DHIhMJaHoNLNZmT4z1m1lEh0oZS79MRtmk98elvwmJqOt88SFQqJSARTB7
 fb10JZ05orTOCKieWudG7I7D7TZemP1lhp2ql9iIfTMfinUxWAIWNQn7g0lWLf6A4Lea
 an+NRidLzBMpe95jpze/j32j1D0CaTcj/IwnPpJDF43V4/dxo7N0OtQvSfIpR2vXnS+b
 rXo0OSW6E/+R0+oGsjqjiUiHl7Kw0zAtAsF7gvLIh1ReDeSAx5GWlDN85/hf8nE5V1I6
 mNwQ==
X-Gm-Message-State: APjAAAXvYHVMY2ShpxbtVLpeDjUn9WYXvGVRRIP2C1orr4Wuac+JP3OM
 dCQlpngn5w9PBDl+42k7SJ44wV0yv5DIesQ8D/CNdw==
X-Google-Smtp-Source: APXvYqzfwzdeRTZa92yCBVDkc8e51nZ/eqTYeosQaHoZlkKT/TscfOMz4KK6VN8dFigtSKnJ/rha5WZr34GQ9kbzjSY=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr20864974oti.91.1561996560441; 
 Mon, 01 Jul 2019 08:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190701132516.26392-1-philmd@redhat.com>
 <CAFEAcA93x6zkbHe1hdg0c8cbo9ErSByP+g6UvwZefxn-6346zg@mail.gmail.com>
 <6222de8e-5b4e-db05-a453-ae4920c2002a@redhat.com>
In-Reply-To: <6222de8e-5b4e-db05-a453-ae4920c2002a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 16:55:49 +0100
Message-ID: <CAFEAcA9p24JkGJoETp3tOR-DyZMi8wJ5U9iqU7=wRPNc7+_=Hg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
Subject: Re: [Qemu-devel] [PATCH v3 00/27] Support disabling TCG on ARM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 16:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 7/1/19 5:41 PM, Peter Maydell wrote:
> > I have applied to target-arm.next:
> >  1-12
> >  14-17
> >  19-21
> >
> > I had comments about 13 and 18. 22 has a conflict when I try to apply i=
t:
> > I think this is just accidental because the functions it's moving are
> > next to changes in patch 13 so there's a minor textual conflict, so it
> > would be fine with a fixed-up version of patch 13.
> > 23-27 are still RFC status so I think best left for the next release.
>
> Thanks a LOT!

I've pushed my current target-arm queue to
https://git.linaro.org/people/peter.maydell/qemu-arm.git target-arm.next
if you want to try to rebase the remainders of the series on that.

thanks
-- PMM

