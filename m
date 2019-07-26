Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B8CC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1EE2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RowEQ28c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1EE2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvqX-0000LC-OX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqvqK-0008J5-Fi
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqvqI-0001QZ-H8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:44:47 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqvqI-0001Fk-7B
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:44:46 -0400
Received: by mail-oi1-x241.google.com with SMTP id m202so39746827oig.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xqC+SX+j9Dq2f5oljP/11thN99jHt/Y0ae3lWNDylKk=;
 b=RowEQ28ch3y0X9dVkVUIwPaPuLWWBanZnKMDdATHOByq/nk3iyVJ8OGQqaMC/0qvuk
 VJk+5n4u4ezhqB3zaZV4KLAp7QLSvv0DBbPuuSs8ZdHMUVYdWuWmgOmanS66xhW9zlRH
 r6J1W9NwNr/mmk80n3XwXkbzQ88XzY1WfjG2CjOWIjpFhILvzJlvA+wEwPQz0ther5jC
 JCPLpDoiwnDbRgJUdQUDhIeBiFvV/UyrVqx+ZrRPs5xE7qsFB2s1YgAzBDgzKgZwAZCO
 2/sZVJ0GKpBu8Esr9qLOyTVrqALff5aJ7mpEbyja+QYyQeS1nXh3UIZxyz3qnYIIB+7n
 D1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xqC+SX+j9Dq2f5oljP/11thN99jHt/Y0ae3lWNDylKk=;
 b=Et7oRBtzs63KHI2xGwC9cQfYHnpao+0ocBoF3TT9k736/0kis3TKsBtNnQfLKiylF3
 GhHN8I8aDK12qBLwHcxFbsgUrFJPp2Pn2sF0Vz7rtzIsmAbdE33eWwbMujV9/77qgjej
 ddce3n84t0nsGfWkCyo/Z5Qag5yAtcKqa51Sh0i6zCdA9Du+dLAHsxDF3pvU+EEKO1jF
 vCgOBL3pBsfJPvpF/dNxDhI8/WTb+KI2NyjKlD1pyD2IFG8v46KzRpplPWoalHqD5UbR
 D0sB7deq+7a/+tSNfZG7l6/rugMlpngrrSUC/qh/kQD06zdEnnOH9/Khrd04p06qxw3p
 /gKA==
X-Gm-Message-State: APjAAAX/nBQ+gCLi9dOlRrEibM1qy0bcI/Nnscal1VHXiRNMc9kvgoIO
 GiHZSM/2LTXBSU9n1sE1b7S0VSxdIp496KYsKya/Ng==
X-Google-Smtp-Source: APXvYqx+pPnEkj/MZDwFRcxpSAxz5zh9BpKMgR83ckxU5HGVbCcbHefPDEqfj72AyVhLZjKhqRZjFB5BHKiNfDFl/6o=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr44420041oij.98.1564130684218; 
 Fri, 26 Jul 2019 01:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190723113301.16867-1-alex.bennee@linaro.org>
 <CAFEAcA9CP0cUkDR4qOKVgM1b2U1KNot=A-5OPEAOKu3=KpMyuw@mail.gmail.com>
 <8736iti7hn.fsf@linaro.org>
 <CABoDooPYw5JccST8f9gVSmtA8ijeqmaVrqoDcqucbbctt5QvyA@mail.gmail.com>
In-Reply-To: <CABoDooPYw5JccST8f9gVSmtA8ijeqmaVrqoDcqucbbctt5QvyA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 09:44:33 +0100
Message-ID: <CAFEAcA_Lc-EVExMG9=kkCNe_Q4OzisbSdj=aFxsC2kDVhxiNGA@mail.gmail.com>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for 4.2] target/arm: generate a custom MIDR
 for -cpu max
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 08:37, Laurent Desnogues
<laurent.desnogues@gmail.com> wrote:
> On Fri, Jul 26, 2019 at 9:24 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> > > I wonder if we should put 0x51 (ascii 'Q') in the PARTNUM field;
> > > then if somebody really needs to distinguish QEMU from random
> > > other software-models they have a way to do it.
> >
> > Q is reserved for Qualcomm - It would be nice if ARM could assign QEMU =
a
> > code but I suspect that's not part of the business model.
>
> That was my reaction at first too, but that Q is reserved for the
> Implementer field, while Peter is proposing to put it in the PartNum
> field :-)

Yes; I should have been a bit clearer... This is totally ad-hoc,
of course, and I have no idea what other models might be using
IMPLEMENTER=3D=3D0, but it seems harmless enough and it might come
in useful someday.

thanks
-- PMM

