Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2108C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968D926CA5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968D926CA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46580 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkuH-0006qA-QU
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:01:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1hWknH-0001zu-0l
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1hWknF-0001Zi-Nm
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:54:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mrezanin@redhat.com>)
	id 1hWknC-0001WG-Lj; Fri, 31 May 2019 12:54:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D279281F25;
	Fri, 31 May 2019 16:54:09 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BD0031001925;
	Fri, 31 May 2019 16:54:08 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 72F7F3F6E4;
	Fri, 31 May 2019 16:54:08 +0000 (UTC)
Date: Fri, 31 May 2019 12:54:08 -0400 (EDT)
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
In-Reply-To: <947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
References: <20190531154735.20809-1-philmd@redhat.com>
	<CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
	<947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.40.204.19, 10.4.195.19]
Thread-Topic: target: Build with CONFIG_SEMIHOSTING disabled
Thread-Index: vbSVI98EzWnZENu1t63TP56joihEsg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 31 May 2019 16:54:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Rob Bradford <robert.bradford@intel.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> To: "Peter Maydell" <peter.maydell@linaro.org>
> Cc: "QEMU Developers" <qemu-devel@nongnu.org>, "Paolo Bonzini" <pbonzini@=
redhat.com>, "Miroslav Rezanina"
> <mrezanin@redhat.com>, "Richard Henderson" <richard.henderson@linaro.org>=
, "Aleksandar Rikalo"
> <arikalo@wavecomp.com>, "qemu-arm" <qemu-arm@nongnu.org>, "Aleksandar Mar=
kovic" <amarkovic@wavecomp.com>, "Aurelien
> Jarno" <aurelien@aurel32.net>, "Alex Benn=C3=A9e" <alex.bennee@linaro.org=
>, "Samuel Ortiz" <sameo@linux.intel.com>, "Rob
> Bradford" <robert.bradford@intel.com>
> Sent: Friday, May 31, 2019 6:40:30 PM
> Subject: Re: [RFC PATCH 0/2] target: Build with CONFIG_SEMIHOSTING disabl=
ed
>=20
> On 5/31/19 6:21 PM, Peter Maydell wrote:
> > On Fri, 31 May 2019 at 16:47, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> > wrote:
> >>
> >> Amusingly Miroslav and myself hit this issue at the same time.
> >>
> >> Currently there is no way to pass a CONFIG_X to sources in target/,
> >> except via a Makefile rule (and filling with stubs).
> >>
> >> Paolo says this is on purpose, CONFIG_X selectors are meant for
> >> devices and we try to avoid having config-devices.mak in
> >> config-target.h.
> >=20
> > ...but some things in target/ are devices (like the Arm CPUs,
> > which inherit from TYPE_DEVICE).
> >=20
> > Is there a way we can have a Kconfig fragment that expresses
> > "if you asked for an Arm CPU then this should 'select SEMIHOSTING'" ?
>=20
> Yes, but inversely, we can also deselect a feature, and all features
> that requires it get deselected. My guess is Miroslav is building a
> KVM-only QEMU, but upstream does not allow to build ARM without TCG.
>=20
> I'll see what happened to Samuel series "Support disabling TCG on ARM"
> and see if it can be salvaged:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html
>=20
> I suppose in this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05641.html
> you refer to this series (not yet merged):
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03137.html
>=20
> I'll try to figure what "KVM injection of interrupts" is.
>=20

What about CONFIG_ARM_VIRT - can we use it to introduce dependency on
CONFIG_SEMIHOSTING or is there valid scenario of qemu build with CONFIG_ARM=
_VIRT
enabled and CONFIG_SEMIHOSTING disabled?

Mirek
--=20
Miroslav Rezanina
Software Engineer - Virtualization Team Maintainer


