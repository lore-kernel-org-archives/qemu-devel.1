Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47336C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EE824691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og2ck7V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EE824691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Mx2-00029f-9z
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7MwM-0001aw-JM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7MwL-0000yW-H6
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:27:14 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7MwL-0000wF-Aa
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:27:13 -0500
Received: by mail-oi1-x243.google.com with SMTP id q84so4106661oic.4
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=m9GJkvOTFPmF5ByiAdPJ3FRuMQFMw48QSAuhngnrSXo=;
 b=Og2ck7V5aMwa1z894SWLCSUKSDxMHxKk+gZ3tFOqy0sv8DronlEcSapPOVvDNwnj+7
 CtWvVqGObibgJ5rNBCZi7sdB/f+DEY/9m1B8yx8hYh6FrHTxqn3raVjG5fCfyMvYGsZ3
 nUMmLA9lPOjYEpu4idqpSMNrSDsOEZxtx3dg+CKQPvqPH7kvIsG3za1DX9ac12EjpoY2
 3rRLB/1HIk8kIxH49VTtYhJu6ICdzfuKKVtXbaQjicosueFtoMklnUyPm67sDv8jz4Rx
 lqyMwKqqGs/WsCNEhpy8ijkdGzlCABQgS4UdwMqMg3SxwkVN2qb5/3c8e7wp1Gn3ZUt1
 rDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=m9GJkvOTFPmF5ByiAdPJ3FRuMQFMw48QSAuhngnrSXo=;
 b=PXeWiJySgQI0NTn8eG/b5W6TdU1wcqtJFVp1+988HgQAUVl8RDbqY+e1oR+D9oLtZ7
 ih87oxUqqDUDN2k/iR3aVU/OjbgMWoKl9HMkrmeZ4sYLqNjr5+O90qCRLQfk8ZTvCbF7
 SEPNJHZYX2DYYVdAXGXCK8xDUvcFl9cvzQpoPZORSxq+8Y0kEGD875NFaBORaKDbpTD0
 yXM/yFEIlQgoZ7cYhosVNO6AJa/MjfhHXTdUgywdNKz2abdMdwJqpsIaFRy+aUtzjoaH
 EEpBdwPSXmj7AEnklr02Lxn3L/jOWcOqfwS28oj+Qhat6koNxUeKu5RusWEbE8GedxPt
 JR1g==
X-Gm-Message-State: APjAAAUlMmtyd5PPMPbXKr2/FJtyAXDP/Y3a5lWeCbbVkGJouMAJUkbP
 qPw1lhxV853r5Exc5zCb7CyscvQkh+fAujG7a8FfNQ==
X-Google-Smtp-Source: APXvYqxI+42Qv63LSyl5MxHHQ4otO9wwBXpiQdjCqMMKmhM2Db0/PP+fFPjdsejRmyz5kRV3pplv/MQqRO+5gwtvOeI=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr91087oiy.170.1582824432519;
 Thu, 27 Feb 2020 09:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20200225143923.22297-1-peter.maydell@linaro.org>
 <87v9nuxv9t.fsf@linaro.org>
In-Reply-To: <87v9nuxv9t.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 17:27:01 +0000
Message-ID: <CAFEAcA8LvupcqdsXudKpPyARz52jCJ0C9P2Cc7JeECv_mej0PA@mail.gmail.com>
Subject: Re: [PATCH RISU] aarch64.risu: Add patterns for v8.3-RCPC and
 v8.4-RCPC insns
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 20:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Add patterns for the new instructions in the v8.3-RCPC and
> > v8.4-RCPC extensions.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This is what I used for testing the RCPC QEMU patches I sent out
> > the other day. Did I get the @ section syntax here right?
>
> Yep ;-)
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks; applied to risu master.

-- PMM

