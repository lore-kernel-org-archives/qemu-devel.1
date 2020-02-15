Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E52C352A3
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 20:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2252084E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 20:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2252084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathieu-daude.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j34VD-00071Q-4s
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 15:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j34UQ-00061e-Hv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 15:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j34UP-00084C-6x
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 15:56:38 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j34UP-00083j-3D
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 15:56:37 -0500
Received: by mail-yw1-f66.google.com with SMTP id h126so6036683ywc.6
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 12:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UVUvQglhafqnRosU0ZvwWFT9G+WmjgAN9XIdZWbHwcE=;
 b=npujrE80KK5sTgJhZhFHlyOBh3JypvirhPeZ84FAH30uaUyI4FJmPyQczSwlxu+AvM
 VuMJj2fVGREBwHrxwd02sBxZObODNfMXnW9o96F4va00AA5FAfnRqT/p2XTASmLz1tFV
 lOlaTBvZf4E3pxGsyWORFVF42V8YUTumqKRO+TtVXidRrrUUJkrFbNT7uL6CSLxZ8IPK
 GQl6SnGsD4P829Rjkxp2FijrTkGcMB3IrfJQspRA/3sQHvrPPCS/w3KqbHzfruuBl2uC
 kp0/8b1ve43T/rQrdLZjs/ovUoMxElX2+uqDQH8hs08YjJAzNSXifycjJfDmhow/TP4W
 gSfQ==
X-Gm-Message-State: APjAAAUrUlLbuhA/UfD29RyU06KDquJUeWEyg7bD6RYqsmuzQ9Vuf/Dz
 bg1jFl423Wj6ROAYGj25nMyonyEZ5jNr611sATc=
X-Google-Smtp-Source: APXvYqwX5aJf8MGXlyTJ7GBwxzoKD+41b7l9S17NT+1IEWjffc2r/Veck6AOA+mpXXPZW+pIODVP/aWRmskL7fSOF9w=
X-Received: by 2002:a81:4f8b:: with SMTP id d133mr7923933ywb.368.1581800196472; 
 Sat, 15 Feb 2020 12:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-8-peter.maydell@linaro.org>
 <CAL1e-=iWXDGat9dVwNEKU1JUYTz1vc-wr2f1pTNiHP-e6zpPbA@mail.gmail.com>
In-Reply-To: <CAL1e-=iWXDGat9dVwNEKU1JUYTz1vc-wr2f1pTNiHP-e6zpPbA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Sat, 15 Feb 2020 21:56:25 +0100
Message-ID: <CAAdtpL6JHhgPJOdwrMxs83qc8=9Q-1t6mrA0yJiyPjMkHSw3Lg@mail.gmail.com>
Subject: Re: [PATCH v2 07/30] qapi/block-core.json: Use literal block for
 ascii art
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On Fri, Feb 14, 2020 at 12:04 AM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> 6:59 PM =C4=8Cet, 13.02.2020. Peter Maydell <peter.maydell@linaro.org> =
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > The ascii-art graph
>
> Just out of couriousity, are unicode characters allowed in rst files?

I remember 2 years ago a blind developer thanked the QEMU community to
still restrict commits to 80 characters, because while 4K display are
available, he and other visually impaired developers cloud still
browse the QEMU codebase with their refreshable Braille display (which
was 80 cels). I don't know how many visually impaired developers are
following this project. A quick google returns " There is no concept
of Unicode in Braille. In that sense Braille is similar to old 8-bit
code pages which represented different symbols in different languages
for the same symbol code."
(https://superuser.com/questions/629443/represent-unicode-characters-in-bra=
ille).

(I'm Cc'ing Samuel who cares about Braille displays.)

>
> The boxes could've been rendered in a much more beautifull way using "lin=
es and corners" group of unicode characters.
>
> Aleksandar

