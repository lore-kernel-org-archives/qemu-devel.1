Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216F2C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB82620693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nGF4koiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB82620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVD9-0000da-6U
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 12:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsVCP-00004t-PS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsVCO-0005mY-I1
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:42:05 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsVCO-0005lv-Bj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:42:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id w79so48428701oif.10
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OfafEYSPfzAyOBXdbB1n/j4rOF8gCfb1ntDDy8rwbIA=;
 b=nGF4koiv+oDd3rnl/K2HD/M7kQBlUWRoHIPwUayluI93qFFG5QOs/lyqiwkz7mEx/b
 fjBPKvWcmg/15Zi/n3mvsuVC6/L3Qmx4MlM3QRbRSPwGSRiYE7ADnZrbo+NWDmgSs8U1
 AnmK2IkVcCDr7nDVROblItMTtCD2bCb6O64vd0M8oxVz45LmW3nujgy6Z1v4YscSjV0E
 VrKl06/xKuvkroT9kKNYPLnDxY8qm1w59Tx9FlFdB+HcI0MSIevyCKqrYfLSjLk3FS8O
 pdepQLkF/rjWjcFo0xWkUJFq81HV4efG+i65uEIMyInT14vAo7aJ8CtRVGrMWKUBS24b
 r7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OfafEYSPfzAyOBXdbB1n/j4rOF8gCfb1ntDDy8rwbIA=;
 b=HVOJOHPmyBJ5MVa46R1mihsuVs959zdFphqAyNfoIG+sQkSfBtaPy4AAn1EhjMFrnd
 U9HQOkdN3po3OEQhfXdx+pqc/jlUZPoXc/zOwzYzHvSUalDSHoyu3NuClbQFgjvtNY0U
 rqMIwePtiu8reZa92Vxjikpc4rb1uq9eeRUxMHXTMYe+btqKZCkjQ4NgXsVt7kHf2EeR
 3mG8PTlVcPvcUSR5I895P2lyqqNQMJQ07sirvYYP0YIIuwxiD3f44CVa5T+j5rtXAa02
 YWbIAUBUJ+3I87fAy/u1Uu3w8S14MsiLcsM6jQT7VSfI3IsKWJ3dwZ/VgM6YpN3e6Lvp
 ZtkA==
X-Gm-Message-State: APjAAAVS/PsU8EwpMruoGa0Oic7neLN01KJEeoIXsInAArTUCI7w7Zm0
 cdCOLaKurpyeYkTuyGv7NiV4ZV2OEIaIxMQ76QF4PQ==
X-Google-Smtp-Source: APXvYqyeLfRy7iSI8pYbVvXOhB/uWLvBLzQeX/BgOiojfOYMaFtPKKoSrmlvsegEZk3sCxVnijqI07GqrseBLRY5K8M=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr55474571oij.98.1564504923200; 
 Tue, 30 Jul 2019 09:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190730132522.27086-1-peter.maydell@linaro.org>
 <c8d89a39-a711-a416-b069-5710d672b4e7@redhat.com>
In-Reply-To: <c8d89a39-a711-a416-b069-5710d672b4e7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 17:41:52 +0100
Message-ID: <CAFEAcA_5+tYKyMO5A2h-YRe4h25VrGS0wm1G=yTY4OLX4Q4XMQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for-4.1?] target/arm: Deliver BKPT/BRK
 exceptions to correct exception level
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 16:31, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 7/30/19 3:25 PM, Peter Maydell wrote:
> > Most Arm architectural debug exceptions (eg watchpoints) are ignored
> > if the configured "debug exception level" is below the current
> > exception level (so for example EL1 can't arrange to get debug exceptio=
ns
> > for EL2 execution). Exceptions generated by the BRK or BPKT instruction=
s
> > are a special case -- they must always cause an exception, so if
> > we're executing above the debug exception level then we
> > must take them to the current exception level.
> >
> > This fixes a bug where executing BRK at EL2 could result in an
> > exception being taken at EL1 (which is strictly forbidden by the
> > architecture).
> >
> > Fixes: https://bugs.launchpad.net/qemu/+bug/1838277
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > At this point in the release cycle I'm not sure we should put this
> > into 4.1 -- it is definitely a bug but it's not a regression as
> > we've been wrong like this for multiple releases, pretty much
> > since we put in the debug handling code I suspect.
>
> The fix is quite trivial, and the user reported using a release, so
> having it in the next release would be nice.
> Or as usual, wait for 'last-minute-bugfix-that-postpone-another-rc' and
> squeeze this fix in.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

OK, people seem to think it's worth putting in, so I've applied
it to master.

thanks
-- PMM

