Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A4C742A7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 15:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCFD204FD
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 15:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCFD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmK6c-0008Og-FX
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 11:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35501)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pmathieu@redhat.com>) id 1hmK6S-0007zb-E0
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1hmK6R-0008UC-H4
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:38:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hmK6R-0008TX-BN
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:38:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so1004159wmc.4
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 08:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lg+JrveXNFGtbcf35gyENFZLG4up4GiqxiUvQ2bBtSw=;
 b=L7D1m/7X5o59UPJt62pY03MGrgUH4j6iFPUEalf29SJDd4m5XhvLzVgHj3qHTf6+PV
 OiGhu1/cspaitvcsPWUD+7HAgsYKAsFliVgZzFUAg1/Yc/qbobcH1BuJ+JVzL3XhnT4M
 ovLKQuCh6btwV1lv240Rqa7dUwnFsLGMsi+EuJ2OdELlw4ZvgRVPaOjD8asVCA5aGP8M
 IBNkUn7u+TeDhKniUk1qATpQwKTDkeHq8AYQs7d09BqcEZyPDmlyQ5N3/exf9rHumRuq
 k85pusJRuJEe67RL6ZsRmfg60lEY8J6pqFS/FvtltOSdQob4k1iTqaeUJ26EkD2Cwg3r
 JPWA==
X-Gm-Message-State: APjAAAXFpQ/PTELrnOHKuK57LHwH95W5L9c8Fry7m/3ZFOG1++mzJaM/
 ldykOvOvzkJlWMcGf7RHdFGXtHNm4qnULKogVKgT5Q==
X-Google-Smtp-Source: APXvYqxNTgghDcySGvTcamKVa07UZt+Jtlcnmfj3CWdcohps+rWOcDrTliIzgc8DfDPR1VG0z6IvpDh15G8kJc+yhLA=
X-Received: by 2002:a1c:407:: with SMTP id 7mr16012252wme.113.1563032301248;
 Sat, 13 Jul 2019 08:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAChFQ9RDi+VK_EERZsPB6UK_DpL-LDs97A6VivYSbuk=0VKP7A@mail.gmail.com>
 <CAFEAcA9gvX_9HDadd1VaC214CLDg7w1dOdCaKXuG5PXxC+-quA@mail.gmail.com>
 <20190128145642.GA3437@redhat.com>
 <CAFEAcA9cDvq3VRaQfAgEvc-sKA4TYEC9PuFX_Vofo18bSbip=Q@mail.gmail.com>
 <20190128151128.GB3437@redhat.com>
 <CAFEAcA_ZKNPd+m695jueEjoHUWLv88U_NcpVZwqiCD2HmUHsbg@mail.gmail.com>
In-Reply-To: <CAFEAcA_ZKNPd+m695jueEjoHUWLv88U_NcpVZwqiCD2HmUHsbg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Sat, 13 Jul 2019 17:38:10 +0200
Message-ID: <CAP+75-UuTQw1njK7W_rVeEf57L9iG+w5-KVuNHQx-AgaTU2haw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] Building nsis installer - cross compile for Windows
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
Cc: Adam Baxter <voltagex@voltagex.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 28, 2019 at 4:18 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On Mon, 28 Jan 2019 at 15:11, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > On Mon, Jan 28, 2019 at 03:03:34PM +0000, Peter Maydell wrote:
> > > Though something
> > > doesn't seem quite right here, because the sdl2.c code is
> > > looking for icon files in a hicolor/ subdirectory that
> > > doesn't exist in the source tree.
> >
> > That directory is the standard icon installation directory for
> > application icons. The QEMU icons are placed there by 'make install',
> > but in the source dir they are in a flat layotu.
>
> There doesn't seem to be any code to handle the flat layout,
> though. (Contrast os_find_datadir() which looks in several
> places for any particular file.)

FWIW this bug is still present in QEMU v4.1.0-rc0.

