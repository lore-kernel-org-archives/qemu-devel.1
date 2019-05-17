Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E63C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3792166E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeL6Y3Ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3792166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRhGk-0003bo-M7
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:07:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRhFr-0003B7-LU
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRhFq-0001xo-95
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:06:51 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRhFp-0001wD-01
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:06:50 -0400
Received: by mail-ot1-x342.google.com with SMTP id 66so7576409otq.0
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=HAW1FwZE/zCObPbbvOiiTI/oRfbgDzfCgFfxjknMTyU=;
	b=DeL6Y3FfVPu9o3tNjgdR502QlavkA4teLKI5leb2ClF4w8XN3OIQf/ZTTjeXHVbi9K
	ec83n98UPshD/Bkhj0OnS+d1TkMseWeFicJuB5YLWUwMLeDZ1ejmq5o7QWtVW+fQ8w9U
	LrZXr1tXiOgzA3LnbYF9LcyX+A9STJ5h8bOILPL0lXEMRxhNdPYI7XQ2QjqSwbphZR7z
	bN+NgyYfPk8ikOXDXlygxqc2l723CQJOXCIHDBeLJSvCTBSnNtNohLMxozZuGswFnDVE
	MerJ0uuoArswGY8J+7CBWTH/K/XFjWKBN2WLnFvlZQ0171jOT4beQEdxNmvCqpTVZ0gR
	RQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=HAW1FwZE/zCObPbbvOiiTI/oRfbgDzfCgFfxjknMTyU=;
	b=Z8ArGHIXEOZF7CI47BMICdmKFUDhacbiBZjti1FvwB9toHcWrkPZZBpMx8nDKZcNwH
	iA6LhAS6yi3wYz+6naEaBN2tXj6fBoWBh5jbjIvB6s05d6UaCRJp0fg2/tGx3d4kwsiN
	qLKIU8BaQQi8uZya02VvK2h4PuUt43H2TqAI1U77VWA8HiI+2zfEvbFfxAhqbhAa5EkA
	LP0YkGSoAga6mZ1rk+a7GcsrfL8JEd5poGr+lkClvA/7ot4d8bJEGZc3V5gsi2CWrwg4
	VE/NtBKduKwCjbpnNKQbg7XryGoNEtMz5id17PpkN0Rb+4AXfh1dFIYwRTy0e9suFhDx
	NaSg==
X-Gm-Message-State: APjAAAUYyorJKGM3umYObRJQkBGpr/7wRX5Un05TZp/vV6SjgvWNdzy/
	c9QnybX2936ydvIpScFPhK051LdRbZfcy/5CFbU0vQ==
X-Google-Smtp-Source: APXvYqzXgqDdaha7AvSTBUk+2F3c4Y40H9i+u5rVJoxcr2H7lp7CnnXbGzc3SCq0IpAxxf7bOeOrbMK3yiW7x7fJgUc=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr5073672otq.232.1558116408251; 
	Fri, 17 May 2019 11:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190507163416.24647-1-philmd@redhat.com>
	<cfd72da5-720a-0684-f3c5-e0ea1360bef3@redhat.com>
	<20190517175621.GK4189@habkost.net>
In-Reply-To: <20190517175621.GK4189@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2019 19:06:36 +0100
Message-ID: <CAFEAcA8iGcgBMbtc_XaXKH-j1fExKrS_fzhgCDYy-_AQZJPesg@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 00/16] hw: Use object_initialize_child
 for correct reference counting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	qemu-ppc <qemu-ppc@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 at 18:56, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Fri, May 17, 2019 at 12:32:18PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Eduardo,
> >
> > On 5/7/19 6:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Hi,
> > >
> > > This series looks at Eduardo suggestions from [1]
> > > and Thomas commit aff39be0ed97 to replace various
> > > object_initialize + qdev_set_parent_bus calls by
> > > sysbus_init_child_obj().
> >
> > Do you think you can take this series?
> > Else, via which tree it should go?
>
> I was expecting the maintainers of each architecture to apply the
> patches for their areas.

This in my experience rarely happens, because splitting up
a patchset is effort and there's a coordination problem
working out who's going to take which patches -- it's why it
works better to have several series each of which covers one
submaintainer's area, rather than one big series which then
doesn't have an obvious path into the tree.

(Personally I also tend to treat omnibus patch series as
"somebody else's problem" whereas patch series that are
mostly or entirely arm changes go on my list as needing
to be dealt with...)

> Are the arm, microblaze, mips, and ppc maintainers OK with that?

No objections for arm if the patches have been reviewed.

thanks
-- PMM

