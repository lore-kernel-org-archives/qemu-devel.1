Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC7C606AA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0344B20651
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0344B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQkX-0002vP-6m
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 06:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hkQk4-0002RU-8H
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hkQk1-00089B-Fx
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46124)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hkQk1-00088W-9O
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:19:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 85B2C308620E;
 Mon,  8 Jul 2019 10:19:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0DF85C46B;
 Mon,  8 Jul 2019 10:19:21 +0000 (UTC)
Date: Mon, 8 Jul 2019 11:19:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190708101919.GF3082@redhat.com>
References: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
 <CAFEAcA9KjJUE7R0OYfM9AT=Ydu8eXBYJR=sGoGog25xrpRMZig@mail.gmail.com>
 <914f608a-5128-87a5-1c08-e20db88ad216@ilande.co.uk>
 <CAFEAcA9=KKtbR624rV77cu41zUTyu2N8-+1Gjmg-rQwdS1htuw@mail.gmail.com>
 <20190708094107.GD3082@redhat.com>
 <28ca7c60-5795-31ff-1d71-1fac477ad996@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28ca7c60-5795-31ff-1d71-1fac477ad996@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 08 Jul 2019 10:19:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Parallel make build fails on fast machine
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 08, 2019 at 12:17:12PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 7/8/19 11:41 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Sat, Jul 06, 2019 at 09:35:30PM +0100, Peter Maydell wrote:
> >> On Sat, 6 Jul 2019 at 11:28, Mark Cave-Ayland
> >> <mark.cave-ayland@ilande.co.uk> wrote:
> >>>
> >>> On 06/07/2019 11:16, Peter Maydell wrote:
> >>>> If you just do 'make' rather than 'make install' does it fail the =
same way?
> >>>
> >>> Interesting. A quick test shows that "make V=3D1 -j2" works fine, i=
t's just "make V=3D1
> >>> -j2 install" which is failing.
> >>
> >> Mmm. I suspect most people just do the plain make (with the make ins=
tall
> >> phase either never or as a second command afterwards), so missing-de=
pendency
> >> bugs between the install targets and the build targets are probably =
more
> >> likely to lurk around. We should stil fix them, though, assuming we
> >> can track them down...
> >=20
> > The main 'install' target depends on 'all':
> >=20
> > install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-=
localstatedir \
> >=20
> >=20
> > but I think still allows 'install-doc', 'install-datadir' and
> > 'install-localstatedir'  to parallelize wrt 'all'. I guess the fix is=
 to
> > make each of those 'install-xxx' targets depend on 'all' instead.
>=20
> I'm not sure I follow, are you suggesting this as a kludge for this
> release, or you recommend this as a default?

I think it is the right solution in general.

> Apparently only 'recurse-install' depends of 'all'.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

