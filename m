Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC55CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E745620856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kReDDaf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E745620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZ6V-0003MA-5O
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNZ5b-0002li-Ex
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNZ5a-00028o-Cp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:07:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNZ5a-00027v-6q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:07:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id s71so7103782oih.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UDo616BZ+C1phhRsTqOfhdcBGtgd8QLcUd2Xek8QHqo=;
 b=kReDDaf0y6EAJa5FqNEcgkdptw+m/Uty4JV9EKzwtnABgCo1HOUR3FkaC7pVX+56wn
 QBry+RRozeLeLM3X1mFVeoUs4XDVruSIeOjYyLsqP0kkYKGXc22O1gGRN+dK2RtUN62l
 lh//sw4hm325SoDB4uFRk+X0kiEsuC3UR2WTzNy9fleariWHQUMMBKuxva1YLzMYZt23
 iHViOHSSbKKZSc9avZaLO/Mvy1R0VQmQv4Mb29dh6EBvz3tzQc68XdJBwhRUyBXgvWl7
 bZEsJzO+NAW7lgJhX7yZPiUU8ZVpdxg+uzsa0CPVe9cBsWjytT+edJXCZnWcT9wsrZJ+
 aJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UDo616BZ+C1phhRsTqOfhdcBGtgd8QLcUd2Xek8QHqo=;
 b=exDz6ez6haTFj3Ygq2YfwR2FiiXTll4y4o/z3jbiUdC6BK7WcCHR4j3wlyMiygXfY5
 w2saSFdodpcxsG5cSuKduWipcbhqRZBNKXTjwzerGpErLnbPfP80F1lpV4xtdGtPusQ3
 tqI3Vq2WJRBtgehH35yiIlXR4eZlKUqhn7Tp9gD6RQhgt2mMcIArjY+I8079skyuOyis
 lhgbJiomUnOek8TUpXjuk250eJKD9g2TnOMz1ZcDZ1R5DvT6XNxpOno1lQypMS5PtRwG
 mHN2bU2QSw8tySVnNulQ6E8UqC2yuPDGoBMHo0Vvm0FW/Gitxmj5q0iHqqdbec8bTrB3
 gucA==
X-Gm-Message-State: APjAAAWu7cZrNdBjBWGazjp7e/xnAX4y368ljunAc4AVb7Kj9Q82vCOW
 HTeF79b7QaIeF+IG7fkV69ruLXkMj1cfMNMKlSdt0Q==
X-Google-Smtp-Source: APXvYqwtRPmhVeU8qASjZxXiFi3+SKXfjx2U+R0mD2YpFB8A+v39eWoYKPDNS0KpwuBalvNpsRX7dKAbHPZ2YhY8nZo=
X-Received: by 2002:a05:6808:608:: with SMTP id
 y8mr3548069oih.146.1571908045162; 
 Thu, 24 Oct 2019 02:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-15-f4bug@amsat.org>
 <c8a8c7758104a1a5fe052743b5a22d3a1353de91.camel@gmail.com>
 <5f1dd044-2909-767d-5a79-8a40d330e129@amsat.org>
In-Reply-To: <5f1dd044-2909-767d-5a79-8a40d330e129@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 10:07:13 +0100
Message-ID: <CAFEAcA9JXbqnKKK+m-7=FThXTa_x_kxRsvtwONWA69C2nb0=FA@mail.gmail.com>
Subject: Re: [RFC PATCH 14/14] hw/arm/raspi: Add the Raspberry Pi 4B board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 at 10:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Hi Esteban,
>
> On 9/29/19 5:53 PM, Esteban Bosse wrote:
> >> +static void raspi4_machine_init(MachineClass *mc)
> >> +{
> >> +    mc->desc =3D "Raspberry Pi 4B";
> >> +    mc->init =3D raspi4_init;
> >> +    mc->block_default_type =3D IF_SD;
> >> +    mc->no_parallel =3D 1;
> >> +    mc->no_floppy =3D 1;
> >> +    mc->no_cdrom =3D 1;
> >> +    mc->max_cpus =3D BCM283X_NCPUS;
> >> +    mc->min_cpus =3D BCM283X_NCPUS;
> >> +    mc->default_cpus =3D BCM283X_NCPUS;
> >> +    mc->default_ram_size =3D 1 * GiB;
> > The comercial models are: 1, 2 and 4 GiB. Why do you choose 1 GiB as
> > default?
>
> Well need one default, and 1GiB is the least beefy :)
> You can start a VM with more using the '-m' switch.

Among other things, a 2GB or more board will fail
'make check' on a 32-bit host, because 'make check' tries
to start all board models, and 32-bit hosts can only
handle up to 2047MB of guest RAM.

thanks
-- PMM

