Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4C4C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAE22245C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhXVk1l1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAE22245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHNR-0000HL-8x
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1idFet-0007JG-Dv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1idFer-00089q-Tx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:36:43 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:40839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1idFer-00087u-Li
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:36:41 -0500
Received: by mail-ot1-x32b.google.com with SMTP id i15so6123146oto.7
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=pE72Q/E9qjj4y/yEGTiFceBZZFqhZc8BQV8Of/D6c3E=;
 b=AhXVk1l14iJ02zDBAfn4L8WmxiGcM7Ur+87LxG4sF/dqh2B1nLjl1FT2/7J2foNULk
 SaHKHr8J6YXZN8sfqf33e3iur364l/zT7A9spGIbl/YQ3uxZTTGE156Dk6+u8FRYUJkV
 tXY4JNJYtb04T0vKzHWwb+fiETNR7wVxXueddsFbpn/U4/Omo9viIEbXM4/dpHFjGufa
 UfsJKiJ1SybVkuAIr7oiLaXjhWhwv3tNZyUvo1nhF7P+zw8g2lhuQYCDSxoBptDbco9O
 g2QVvxNOlT6PJcskkYuV1f0+wtUz3jMFumUoQMvoAr6ESp5H4NsdNItYZe5VXk6RbsR7
 P6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=pE72Q/E9qjj4y/yEGTiFceBZZFqhZc8BQV8Of/D6c3E=;
 b=sNlli2y4Q6CNNaO66ew3nROJUghiWImnAhBkN12tD2rDS6TnBy5jzqLEflKCBjXcHv
 Jv0K5TYllfINAgEYsAT7ovzai3sHVwS2xPpFkDbo1RJzrVHPAR5BgJ97oD+pvpSRovT/
 AM/v9456lQmzsddtgMhikqiB3qCvBW/53YYcbU6ZGsFEtiRcwJ3fDoj2QM7uxse78+iN
 kyJwljxrPt+C9d0/4PBibs9asVEErSgV+JHj+NqztS5ONp5ksy+1KYR2qmQQt56s3bV2
 2DxCdiW36UyZGpLDBBd27xp0Qyl0gMvlWNnNTmZzYHSlH94jVW6Tth68NDbINcmRjVmv
 uUAA==
X-Gm-Message-State: APjAAAUtxNqNPJkGDep4fRC1kdSTSKslgwqV75xEDjCJA+Sqwi2RIdBI
 TiLjY0hC+vA4oZHUqR96MXDQks3o
X-Google-Smtp-Source: APXvYqxyooLSSK8iT/6LCwnXxlVBUr1fm6mXc6oQIz5flJAjroTbo+Sm42L/5UQtAiMCsGcG9/62Hw==
X-Received: by 2002:a9d:191f:: with SMTP id j31mr10958719ota.163.1575646600354; 
 Fri, 06 Dec 2019 07:36:40 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id k6sm4696145otb.65.2019.12.06.07.36.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 06 Dec 2019 07:36:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: "Liu, Yi L" <yi.l.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <12B7DFF3-8414-4C26-97BD-DDF772D7433A@intel.com>
References: <A2975661238FB949B60364EF0F2C25743A12875B@SHSMSX104.ccr.corp.intel.com>, 
 <CAFEAcA_A814+1_vvD+QO=cDeiWEXdUJyZgjuBeU2RTXaHYCh+A@mail.gmail.com>
 <12B7DFF3-8414-4C26-97BD-DDF772D7433A@intel.com>
Message-ID: <157564659435.3810.1362054849322205398@sif>
User-Agent: alot/0.7
Subject: Re: about QEMU release schedule
Date: Fri, 06 Dec 2019 09:36:34 -0600
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Liu, Yi L (2019-12-06 09:24:46)
> =

> >> On Dec 6, 2019, at 17:57, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >> =

> >> =EF=BB=BFOn Fri, 6 Dec 2019 at 04:00, Liu, Yi L <yi.l.liu@intel.com> w=
rote:
> >> Hi Peter,
> >> I=E2=80=99m wondering what=E2=80=99s the rule of QEMU version naming a=
nd release.
> >> I noticed there is a v3.1.1.1 released after v4.1.0 was released.
> > =

> > Any reason for not just asking this on the public lists?
> =

> No, I should have cced mailing list, thus other people would learn it as =
well. =

> =

> >> Also, I=E2=80=99d like to query the release plan in 2020. What version=
 would it
> >> be in 2020-July?
> > =

> > For many years we've done major releases three times
> > a year, in April, August and December (roughly).
> > Starting from 4.0, we switched to a naming convention where
> > the major number just increments once a year. So 2019's
> > releases are 4.0, 4.1 and 4.2; 2020's will be 5.0, 5.1
> > and 5.2, and so on.
> > =

> > Further releases on stable branches (eg 4.0.1, etc) are
> > not handled by me -- they're done by Mike Roth. I don't
> > know what the usual pattern is for those or how many
> > branches back we do updates for.
> =

> Thanks a lot for the sharing. =


Re-sending with qemu-devel included:

Generally 4.0.x is maintained until 4.1 releases, 4.1.x until 4.2,
etc. It's not a hard cut-off though, if a release is needed for
something significant like a CVE or regression a month or so past
that then a release might still be made. We just can't keep supporting
every branch forever, but if something is brought to my intention
that's not too far outside that window then I'll generally try to
work something out.

The safest bet though is to target fixes for a major release N,
tag/Cc: qemu-stable@nongnu, and it should get picked up for
a stable release of N-1 if applicable. Anything beyond that, let me
know.

3.1.1/3.1.1.1 were quite a bit later than usual due to delays on my
end and late-breaking CVEs; consider those exceptional cases.

There are more details on the process here:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/devel/stable-p=
rocess.rst;hb=3DHEAD

> =

> =

> Regards,
> Yi Liu

