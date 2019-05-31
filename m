Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35D5C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD20226C8E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD20226C8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkmy-0001W8-0f
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:53:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1hWkjK-0006TN-V9
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1hWkgg-0003FN-Pg
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:47:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mrezanin@redhat.com>)
	id 1hWkgf-0003DW-BI; Fri, 31 May 2019 12:47:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F8E2309C001;
	Fri, 31 May 2019 16:47:24 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B1D7E905;
	Fri, 31 May 2019 16:47:23 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3A7B518363C0;
	Fri, 31 May 2019 16:47:22 +0000 (UTC)
Date: Fri, 31 May 2019 12:47:18 -0400 (EDT)
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <1635661039.25604600.1559321238712.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA9UGSM_eNFErNHtx4vqosgTyPJ85mQ2t=QnnkpnGN7rDg@mail.gmail.com>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
	<87sgsu51bd.fsf@zen.linaroharston>
	<833530119.25503992.1559302089822.JavaMail.zimbra@redhat.com>
	<874l5aahmx.fsf@zen.linaroharston>
	<627031963.25549126.1559311169316.JavaMail.zimbra@redhat.com>
	<87o93i8zrh.fsf@zen.linaroharston>
	<CAFEAcA9UGSM_eNFErNHtx4vqosgTyPJ85mQ2t=QnnkpnGN7rDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.40.204.19, 10.4.195.14]
Thread-Topic: target/arm: use the common interface for WRITE0/WRITEC in
	arm-semi
Thread-Index: Okq1lp6pyXAlhtQxliyHe5IuBhqJCA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 31 May 2019 16:47:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] target/arm: use the common
 interface for WRITE0/WRITEC in arm-semi
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: "Miroslav Rezanina" <mrezanin@redhat.com>, "QEMU Developers" <qemu-de=
vel@nongnu.org>, "Riku Voipio"
> <riku.voipio@iki.fi>, "qemu-arm" <qemu-arm@nongnu.org>, "Laurent Vivier" =
<laurent@vivier.eu>
> Sent: Friday, May 31, 2019 4:38:04 PM
> Subject: Re: [Qemu-devel] [RFC PATCH 06/11] target/arm: use the common in=
terface for WRITE0/WRITEC in arm-semi
>=20
> On Fri, 31 May 2019 at 15:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> > Miroslav Rezanina <mrezanin@redhat.com> writes:
> > >From: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> > >> OK - so from the upstream source tree CONFIG_SEMIHOSTING is still =
=3Dy
> > >> (but I can see most of them are now =3Dn). Isn't the simplest soluti=
on to
> > >> fix-up your version of the default_config file to include SEMIHOSTIN=
G?
> > >>
> > >
> > > It's fix but it goes against our policy of handling CONFIG options so=
 we
> > > would prefer to have this fixed - otherwise there's no meaning in hav=
ing
> > > config option if you can't disable it.
> >
> > Is that what it means? For my part it means we don't build in
> > CONFIG_SEMIHOSTING for the arches that don't need it (which we were
> > before). Granted it only really simplified the vl.c parsing and dropped
> > support for semihosting for the linux-user targets (except ARM).
>=20
> Yes, that would be my interpretation of it. If we had
> a 'config FOO' stanza for CPUs, then Arm CPUs would
> "select SEMIHOSTING". If RedHat would like it to be possible
> to build Arm CPUs without CONFIG_SEMIHOSTING then they're
> free to submit patches for that, but that's a new feature
> upstream doesn't currently support, not a bug in upstream.
> (Also I'd be a bit dubious because it means that previously working
> guest setups that use semihosting will break.)

I partially agree here - I see difference between disabling
config and omitting it. We are not not disabling CONFIG_SEMIHOSTING,
we just ignore it. So we got error because it is not properly handled.
Proper handling should be either auto-include it as dependency or
successful build with option disabled.

As there's currently no way to auto-include it through dependency,
it would be good to have comment in default_config file next to it stating
that it's required option. This will allow us to see it and
add to our default_config we used instead upstream one.

Mirek
>=20
> PS: if we had a 'config FOO' stanza for CPUs that would also
> allow us to say "building Arm CPUs requires the NVIC" and
> similarly for things which in QEMU are devices but which are
> architecturally tightly-coupled non-optional parts of the CPU.
>=20
> thanks
> -- PMM
>=20

--=20
Miroslav Rezanina
Software Engineer - Virtualization Team Maintainer


