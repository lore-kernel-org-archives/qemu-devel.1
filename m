Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC34EC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE6320658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuqhQFUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE6320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9r6-0004bc-N4
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jE9nK-0007He-IA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jE9nJ-0007Yz-A1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:58 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jE9nJ-0007S5-1R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:57 -0400
Received: by mail-oi1-x244.google.com with SMTP id y71so21183476oia.7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5jebkakv2QsVGKK+gf+7wsIdub0gn7LKnI+hJ3xjhFk=;
 b=UuqhQFUt4+g6xdeiRdCFqb0HYKcOD4viudiBqX0UkqxmeItOHVbVYjLHB3o6fQXCAK
 0UKWNFEs+ixDwQIHnTViDZ420k9qdqCqZsQWi3xc4xcKGl9P7OkoAktqAGsNlUhg+9zR
 Ax0xkzo17IysqmNTXmQyAkg3iAVqyUcBWjPgBs1tu3l0jmpmZvXb9jwoTgV+qATb2UHd
 l6sbnTahsHTVoj+e9Vd9E0LevP5MD5kee81cWhB/AI4bOOrRSHFQpC6W696rhNCJV5Tl
 h6w7riHYJGaBHNQuIh2TFHCnvempr1pVYKnKUgGEbuSIjPceY9hM9+Cf/lzG9Wx69m23
 n0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5jebkakv2QsVGKK+gf+7wsIdub0gn7LKnI+hJ3xjhFk=;
 b=IFxa+tOgDVkPf30lMM1u1na5a/TJq/yAxeUeqGfVLC+Lqkc1WvDC5IAQuq/qSu3G49
 Pq2Q0UsNU3puXmk9GuagQFVUeJR6AerP9uOhznqkbNeJhfLzXcS9Goz2UpI/5sTg48zY
 Mwc2kQkFHdygaRelZO7dong6ObP6qCco5ax5GG1rEQ+yXN52ReZHbmAgiYj5qyT7woUK
 5snFbrxdgMpcSE7MSyxBFD3RTR3SK4TifXLe5fp4/VCSoD2WJ5WKSf91tcaZS/5juLYA
 MaoSohzgeiVDDcMbZnrgnn6ox5HqjE2+VCYbj681hz9AF8Gaoxab1/X2EQryo6gnMEh5
 DhbQ==
X-Gm-Message-State: ANhLgQ1xJ0cCEbdcHwFm5UiW7DF/blC9YKDw3S7DJb+5IXDAJ+dq28FE
 oWKPtFRcMrWkFjBdQ1Ya/znbZkpm8ysW82TvRBFEIg==
X-Google-Smtp-Source: ADFU+vsDyWNYKItBscndIPy44LE4AYtwfJ1XjsMzN7693uDS+5wfYPNtlgpICh0HYyxdO9Ps6SY/ABY2NrBI+p0tm5M=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr2866202oib.146.1584442195840; 
 Tue, 17 Mar 2020 03:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-25-alex.bennee@linaro.org>
 <3d01f357-eeb6-7fd7-1895-feae05beca99@redhat.com>
 <CAHiYmc5CtAH-zs38YmyLkrrp2DnxzLUWNKBTcL+oyFNEiCsV8A@mail.gmail.com>
In-Reply-To: <CAHiYmc5CtAH-zs38YmyLkrrp2DnxzLUWNKBTcL+oyFNEiCsV8A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 10:49:44 +0000
Message-ID: <CAFEAcA8FSwVeOVDWT8qRO_EL2OncxdgGZbNHH8VhaaoKuwS7_w@mail.gmail.com>
Subject: Re: [PATCH v1 24/28] tests/tcg/aarch64: add SVE iotcl test
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 10:45, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> I think it is also a little problematic that tests like this reside
> and belong in tests/tcg - since they deal more with elements
> of kernel interface (system call prctl()), rather than TCG.
> Still, I see there are many other similar cases in tests/tcg,
> so probably (at this moment) one should't bother about it in
> the context of this patch. However, in general, the location
> /tests/tcg for all these cases seems wrong to me.

Well, the only reason we have the test at all is for testing
our TCG emulation. Generic tests of syscalls don't live
in QEMU at all, the best place for those would be the
Linux Test Project's test suite.

thanks
-- PMM

