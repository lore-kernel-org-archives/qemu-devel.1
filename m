Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B6BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAD62075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1f6qyqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAD62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZK1J-00019M-BD
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 14:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZJzw-0000gD-6Z
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZJzv-00081U-5o
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:26:12 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:43098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZJzv-00081L-1f
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:26:11 -0500
Received: by mail-oi1-x229.google.com with SMTP id l20so14195612oie.10
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 11:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=R8UdyerKgGCLjs5SBvp0RH55Yc2p2geg9QYk/aTuQjk=;
 b=Q1f6qyqMoIRkg+Tc5CXBeYjBCEvNpdts1ilk+1KW4YA251gf4WrsCTm/X2wUbBfJUm
 A6MwgHuvY65Yp5o2/KE1dXSWY5Qtglq15WCumESKpB15ICvv+SvjGmTuMbBrFCCwPvT/
 Hd0IDYQtXXDjeC+qlxCKaC4/8R15pgsyXCnePT9TqSAt2+MiRhGH/IRFBjZzOHWpJjm1
 Xb6aUd1rwwFo1bQ4FETWuRX/QtniBQvYfurJ2ya2A3kFuzJfa0+OqLSuEKdREMskKOyt
 MoYPuKB8PDsCDRu5T16kmii1SQ2fMv5XpOYTdYbwPf8spHPr1J5as1AGmC/Btjtf1hQG
 Q/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=R8UdyerKgGCLjs5SBvp0RH55Yc2p2geg9QYk/aTuQjk=;
 b=JoyIPF6h3yrqIHETv9S8ry1jxYPMDsO7WLFL/W7u2i5Iq+BU2eNja7IhBXJ5mJdd5s
 dMQp3wl11oUBVdB/oh07PkCndeLdGmhw+03utxSgFVrqV1FZhLDy9GawjysKOTYLvBsg
 Lz19IIHBClYnttsV+UKhMQw9ArhzaCwB2K+Ms5mkut+Qyxft8U/twwXf3bGcAvd19PqG
 Oe/GtLYq8voK5ayUdbqxX+ASB13YBzT6S8QPqMrkAo+vcqeTu2VHsWCLqqn8SvuR/iF2
 9s3UL8ZjjGR7UgOHzT2XQUgAL6kWayP+XMU33RF7YkId5soZPWuSZZudyKo2MjAoh09d
 uvjw==
X-Gm-Message-State: APjAAAVmfM/mgnygxHXcFUVATC8syAT86mdhaD+xJmdZWvG86BtFi4au
 zgX86SRd7XMSAFmbjHEjncRHme0rD9iG9XdvM5A0jZvP
X-Google-Smtp-Source: APXvYqw89IzsCFSQ6VwxOYtgVS2izhqdfAoJNk5js3eNJzFx4tCfeMFGNfYVMeUVqNhAOm6Pk6WOVHTEtfSsLeNNhYs=
X-Received: by 2002:aca:6287:: with SMTP id w129mr387629oib.106.1574709969956; 
 Mon, 25 Nov 2019 11:26:09 -0800 (PST)
MIME-Version: 1.0
References: <CAL1e-=gmaimCBh5NBBYFp6Z1ci4ZheQtXpyjU9Uexqi4zSHh2A@mail.gmail.com>
In-Reply-To: <CAL1e-=gmaimCBh5NBBYFp6Z1ci4ZheQtXpyjU9Uexqi4zSHh2A@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 20:25:59 +0100
Message-ID: <CAL1e-=i-u5eR7Fk_Muobbe0-Viim0iPceHoEGtJWCq7L1o9teA@mail.gmail.com>
Subject: Re: [QUESTION] What is the best license option for new files
 introduced in QEMU?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 6:49 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> I read LICENSE file, but I read also recent contributions, and it is
> not clear to me what version of GPL is best/recommended for new file
> just being introduced to QEMU:
>
> * GPL 2.0
> * GPL 2.0 (or later at your option)
> * GPL 2.1
> * GPL 2.1 (or later at your option)
>

Thomas pointed to me that I mixed up GPL and LGPL - which is true.

Still, the question remains with these options:

* GPL 2.0
* GPL 2.0 + wording "or later (at your option)"
* LGPL 2.1
* LGPL 2.1 + wording "or later (at your option)"

The context of my question is that I am reviewing a series that came
with files with different license preambles (or without it at all), and I
want to advice the submitters on the best option.

Sincerely,
Aleksandar

> or something else. (The rest od wording of license preamble is clear
> to me.) Please somebody explsin snd clarify.
>
> Thanks,
> Aleksandar

