Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E64C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7739820714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S32Zzl4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7739820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDjr-0004L3-KC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEDiJ-0003H1-Ki
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEDiI-0007Dc-79
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:01:03 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:35237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEDiH-000793-4l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:01:01 -0400
Received: by mail-ot1-x332.google.com with SMTP id k26so21998907otr.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9WTit7bS5scSYISq/UBUCBuRC40ZcIznCWuZhc9v37w=;
 b=S32Zzl4stwhnds7jyBr80yuKHgi2h+J/+8Hvnf/ZyQDfgug+FvGIm4CRzUYJrbngFX
 v04SgZXKcHp0y11+d6l/rSzVpEvtoaB/vNZmDjS8RGrk3o4fjOYDl0iGgvZ6ITW7twTV
 7/rp60tz29+IxaZfs71M1xPabaAZ60xn5iVKtVbHLphGPpGwqXlWZhvXBO7VZw7oA2l+
 BQzN0JLeRGvcMYABoIyxnPouoEDROXBen3Zt+z4hXdCBUDkgr7bFRphsjQPZBFhlG3LY
 9rbgsy7geiIH78LMi70GpkCsZhWVq+RURG2ywsygUO60xkaZJ61AZF9Ha8nRe9SqTHYm
 5zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9WTit7bS5scSYISq/UBUCBuRC40ZcIznCWuZhc9v37w=;
 b=L2evzt8yqUaV0qJCf9dS6nOCwII6OVVQ52uDd0r2c94kisghVRnj25klgqpXZisSDN
 BJuP73PLflkOo/tE0UtIQbMLmiIcSDjvTBRf3BkeEixifWeQru50RXO5XkCTzod9/xrj
 1x9Zr/qQNjW1hOeCdhVhvq2Fp19U2PolXr1RF+LOCNeQgmp6zcerNBLSJNFhQcmxfg/y
 N0Wtq5633o7T0gYcY8GeGYCcVSgcYhJTlBfHy8juPGT/0zwLXbQHHwGjxeYKiv9R+24+
 NTZU8gpxzxPPK3AM/SAQn2/LcietNNALTMhIy+vPfsgCJeNWO9IuUFXmEpoKicybMnFX
 AN/A==
X-Gm-Message-State: ANhLgQ0q5b0RqOKSYUXMV+enUoGyAqFuD8eb2JsTNT0+wZiOGtQJ31F/
 sW9DxZOj1Yqo484J3xcG3IbegZ1AYFRTTmw3mnnSYw==
X-Google-Smtp-Source: ADFU+vtiEof53bqs82SFmJz1uDZpwGU04QZr2kWYZ5/9s0iPNaNx59Gr9GerHWkXCO45KCxlEKDpFkYHE55JRUXPumQ=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr4034450otm.91.1584457260127; 
 Tue, 17 Mar 2020 08:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200317043819.20197-1-jsnow@redhat.com>
 <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
 <5805273e-0a2f-850a-a07a-97dac0d7211e@redhat.com>
 <20200317145703.GH2041016@redhat.com>
In-Reply-To: <20200317145703.GH2041016@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 15:00:48 +0000
Message-ID: <CAFEAcA9-YLNcZPPsHsdLB0O2Ac4WKPspMe=Re2S7tyTZu=kwFA@mail.gmail.com>
Subject: Re: [PULL 00/10] Bitmaps patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 14:57, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> I don't feel like -Wno-unused-function looses anything significant, as
> the GCC builds will still be reporting unused functions which will
> catch majority of cases.

The most interesting difference is that clang will catch unused
static inline functions which gcc does not.

thanks
-- PMM

