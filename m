Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA82DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9505215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9GIlQ9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9505215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGTLG-0004vd-Pr
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 15:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iGTJe-0003yL-By
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 15:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iGTJd-0006zE-Bw
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 15:32:38 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:43373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iGTJd-0006yt-5M; Fri, 04 Oct 2019 15:32:37 -0400
Received: by mail-ot1-x32c.google.com with SMTP id o44so6227478ota.10;
 Fri, 04 Oct 2019 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IYMIOIhvntg3tcLbX2iW051KXHbzQJHlFJfjdc5/4T4=;
 b=a9GIlQ9Tvyro1QAQU3v3YDIMoEQ2WxpX3ElHFl+NOx8laqy0hwiLRQ732LNC2TlOGL
 +jThqHrYAV7KNa2Gf+MdRzrqqaPyuntQSmHCWhtoD3NJ6mfOqzxsZJ3hBBQZ1wYi37nf
 jJPIh2W17YYkhT+y0jVdtKmYpU1qkuQYVIx4RXba8tIH9rrtNMClB5dWuP7VYRc7SeUV
 IKOKleBmIBMY0BQpe/Z9O/hU1uouM5V0z0eiGE8byDE0C6y6N0D7vK58ipE7x+58uE9Z
 SydpQfwjtWrL1PN6EhtHNUPXjbaQaASMyi3ah9DBJIhviPPr9JWJ4Q16WSOV/68Qr2WA
 vERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IYMIOIhvntg3tcLbX2iW051KXHbzQJHlFJfjdc5/4T4=;
 b=l7o9gg1H8ME0/NBQMb4Rb5ALeiN19us5axmMvoyzvFE7/O2YtoNyFdXsygZjm1HGJS
 9Z++gT4XlYGemeGZhAQCejP4drHT3WhFyqks35kzQz8NTYZmWKnIiPpp9U7JL1Ls8eUF
 +AyY+bqV5jauTKnmpENi/5LUZ5iahbNHQSihC9FRoPoZ9IIi/VQGI73GOSwfy79PwDyV
 kAXnAS/TF8EIu6+2VoQWr1GVDVuT4SN//AnEkknng6cGBrIBt6FC6yhSlOPE04h2GMp/
 pD8g/IWUtqCgNROULF9LKLFHvGSWF3zszR2S934QFjhOvltjl9yqTgSPQZbwXjPEg9Nz
 Amgw==
X-Gm-Message-State: APjAAAXogtFWX1cJri7y0SaNpvTPAGeIX/b98b+UXArD/1kZ4zTSDLoO
 bVTmy8KaGzqgPgYnp3D5k/IqS6XFOVlFepDmFxg=
X-Google-Smtp-Source: APXvYqyItUJm3PkL0li54S8LV5bi+35+3Rkab0QCcfCK8kKpu7Ja7PxWDg0/cEnp7oZFI1h3DmfFaWAPyuTeUFXjPYk=
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr11730755otr.306.1570217556013; 
 Fri, 04 Oct 2019 12:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
 <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
 <c9679b01-91c3-3d69-fb38-dfef1602dcf4@ilande.co.uk>
 <87v9t7jbep.fsf@linaro.org>
 <5f80d547-3027-2315-bb98-221283b9df2f@linaro.org>
 <22cc1b49-189d-95b6-ad83-e32ead2df7fe@us.ibm.com>
In-Reply-To: <22cc1b49-189d-95b6-ad83-e32ead2df7fe@us.ibm.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 4 Oct 2019 21:32:25 +0200
Message-ID: <CAL1e-=hJueGPvE_V7S1NFgy4qEpwkwyShEgcZVFTF9RGsM5V0g@mail.gmail.com>
Subject: Re: Re: target/ppc: bug in optimised vsl/vsr implementation?
To: Paul Clarke <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Brankovic <stefan.brankovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
> In comment #9 in the bug (https://bugs.launchpad.net/qemu/+bug/1841990/co=
mments/9), I note that the issue was produced in running the test suite for=
 the Power Vector Library project (https://github.com/open-power-sdk/pvecli=
b), which makes productive use of dcbenq.
>
> Maybe that could be adopted or adapted to suit?
>
> PC

I will leave adoption/adaptation decision to Alex and others, but just
want to tell you that I took a brief look at pveclib code and
internals, and I got an impression that this is an excellent peace of
software, that required incredible meticulousness in order to
implement, all kudos.

Aleksandar

