Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDC5C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE3A21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/BNld0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE3A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8fa-0006p3-4s
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:46:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8S5-00045h-Q6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8S4-0005bZ-Sd
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:32:53 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:47016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP8S4-0005aj-Kl
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:32:52 -0400
Received: by mail-oi1-x244.google.com with SMTP id 203so4937144oid.13
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8cZGTcLmscMd4H9XexQ5d3094/QqXT+RRvWEAig6Xis=;
	b=u/BNld0WvkO5/OlvluVnbm00GumqOA0lS3UV6SR7ngKY0ZM+X++mCruvNFY0nhBtJd
	nQKxs+K8d3YghcCIskyYfBOPi+5IqVSgpguhFi+HetanJi8KdGex6G5WwdNwxjpKcq1n
	qOY4RbXfkIc5mhCxk46Qrrp7T5RMeYD44kWU0on2gHncZJ3V1mDkKyzgEf2e13QsSrxD
	WIBmLXmS2LOpxd2HMI4E3KsebVWHixcJVOsUHeTVxbLbYBC8k0WMsiIpPIdXnyF97hL8
	Iz0h+WPCKxoo+CcDUHwIKJrNmx/Jwv620PhNwsoFmpKTQBZlxHADT1FDAsF3juUTm9Pn
	w4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8cZGTcLmscMd4H9XexQ5d3094/QqXT+RRvWEAig6Xis=;
	b=fMw/pQbqPxqLBPORhkI024LDbWSR2HAogArJ83O1VCkcioJIVOSI/5Vxxnr2Hc4Eq9
	V5X+TPTzj5wMwpIHn5XWo6+DBZkDQbDempigfGL3lxS2TGGcVVU/Wo++8eYFYOKidwrS
	4lDEbMEBhHhsnBmbLLgFOIieBNBY7iM39w5jYb/9bKAJXU9N0GiBzQOq6Xrdoi+beegC
	ac37nF0sgy0tOnsktNR65JQ/pXtGuyGhhxQRMUbMx/vRCGIwvAeBx6r/ZUQAxjKomhej
	Y4ilXIk09sjaJL/h7arZxXq6fkbRvf7HWfT18wlhH+ZA41rgKNVgRvB2u7W5oTuyWNYV
	X0qg==
X-Gm-Message-State: APjAAAU7gL5YVBYim8wqmn02bSxBpNw9O8Oo8m3m6T8asoY3/QmxhoXT
	ppR+h3zhu2urSNWbstp2hROt0ebRIRyXb4m7+YZCcQ==
X-Google-Smtp-Source: APXvYqxrfsy9fUxj+v8x5h+uoHO56qozzbv6ghO6x8hE736FPs/EoHn0I9KlAsL+UaBEHQ56uux6iP2LPa5JEh/Su8w=
X-Received: by 2002:aca:b783:: with SMTP id h125mr5720244oif.146.1557505971501;
	Fri, 10 May 2019 09:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190502185835.15185-1-laurent@vivier.eu>
	<CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
	<87sgtv4wjo.fsf@zen.linaroharston> <87imulaude.fsf@dusky.pond.sub.org>
	<87tve53sy7.fsf@zen.linaroharston> <87zhnw58pa.fsf@dusky.pond.sub.org>
	<CAFEAcA-s0UYr0VW3ccG07r=BiGCVtDHkRb6yW0X_ev-zAkOxvw@mail.gmail.com>
	<87o94amjud.fsf@dusky.pond.sub.org>
	<CAFEAcA8h8ry3XiT1dUOZknTYK78_W=_b3R4CzfFNnS_Z1G9Bww@mail.gmail.com>
In-Reply-To: <CAFEAcA8h8ry3XiT1dUOZknTYK78_W=_b3R4CzfFNnS_Z1G9Bww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 17:32:40 +0100
Message-ID: <CAFEAcA_WNeY_jLHzyJn1qfU=6-omUFi2Hw67YGeOrRSZd68qnw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 17:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 10 May 2019 at 16:05, Markus Armbruster <armbru@redhat.com> wrote:
> > I tried to reproduce on a ppc64 box in the gcc compile farm, no dice.  I
> > double-checked config-host.h has #define HOST_WORDS_BIGENDIAN 1.
>
> On s390:
>  git clone git://git.qemu.org/qemu.git qemu-tmp
>  cd qemu-tmp
>  mkdir build
>  cd build
>  ../configure
>  make -j3
>  make -j3 check V=1  # passes
>  wget https://patchew.org/QEMU/20190313162812.8885-1-armbru@redhat.com/mbox
>  git am mbox
>  make -j3
>  make -j3 check V=1 # fails

For completeness, the commit I got from git clone was efb4f3b62c69383a7308.

thanks
-- PMM

