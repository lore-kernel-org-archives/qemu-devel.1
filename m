Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A6FC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2212081C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2212081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2cu-0002rB-Ro
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:08:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT2bK-0001xj-8e
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT2bJ-0008Qo-2u
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:06:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hT2bI-0007Zr-U7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:06:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FE5888309;
	Tue, 21 May 2019 11:06:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-26.ams2.redhat.com [10.36.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E84127841F;
	Tue, 21 May 2019 11:06:03 +0000 (UTC)
Date: Tue, 21 May 2019 12:06:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190521110600.GJ25835@redhat.com>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<CAFEAcA8bs0M4Ofdq1tt8uZvWHK49PNRFz3SQhxEHT_uPGmBHOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8bs0M4Ofdq1tt8uZvWHK49PNRFz3SQhxEHT_uPGmBHOQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 21 May 2019 11:06:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 10:43:04AM +0100, Peter Maydell wrote:
> On Tue, 21 May 2019 at 09:54, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > Hawkmoth seems pretty attractive in its output format, but doesn't ap=
pear
> > to be part of either Debian or Fedora distros, so we would have to bu=
ndle
> > it in QEMU I expect.  My big concern there is that there have only be=
en
> > 2 contributors to Hawkmoth in its entire 3 year existance, which make=
s
> > me fear for its long term viability if the main author gives up.
>=20
> The dependency on clang 6 and the python bindings to it might also
> be awkward for bundling it with QEMU...

Requiring a second C compiler to build docs is rather unappealing :-(

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

