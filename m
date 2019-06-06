Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F9AC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9086920684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9086920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYoeM-0006Ji-LV
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:25:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYocu-0005QN-HN
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYoct-0006fJ-D4
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYoct-0006bT-6j
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:24:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CCB87EBC1;
	Thu,  6 Jun 2019 09:24:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DCF078199;
	Thu,  6 Jun 2019 09:23:55 +0000 (UTC)
Date: Thu, 6 Jun 2019 10:23:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190606092353.GE14300@redhat.com>
References: <20190531192429.GH22103@habkost.net>
	<20190605154403.GH8956@redhat.com>
	<20190605181308.GX22416@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605181308.GX22416@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 06 Jun 2019 09:24:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Deprecation policy and build dependencies
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 03:13:08PM -0300, Eduardo Habkost wrote:
> On Wed, Jun 05, 2019 at 04:44:03PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> [...]
> > Thus to answer your python 2 question, we should ask which of our bui=
ld
> > targets cannot support python 3 ?
> >=20
> > Obviously we know the answer to that is RHEL-7. Except there is some
> > fuzziness in there because it depends on what you define "RHEL-7" to
> > be. There are several possible answers
> >=20
> >  a. RHEL-7 covers only the stuff in the basic yum repos
> >  b. RHEL-7 covers packages in any yum repos shipped by Red Hat
> >  c. RHEL-7 covers packages in any yum repos shipped by Red Hat or EPE=
L
> >  d. RHEL-7 covers packages in any yum repo available for use
> >     with RHEL-7,  provided by any vendor
> >=20
> > The platform support policy has not documented which of these possibl=
ities
> > we're targetting.
> >=20
> > If we consider it to mean (a), then there's no way to use py3 with RH=
EL-7.
> >=20
> > With (b), (c), or (d) it is possible to get py3 available on RHEL-7 b=
y
> > enabling suitable repos.
> >=20
> > Personally I think it would be fine for use to consider (b) or (c) to=
 be
> > our intended interpretation for platform support policy.
>=20
> (c) sounds like the best option, to me.  Do we have any
> reason to prefer (b) instead of (c)?

Depends how flexible we want to be. Some enterprise organizations will
not allow use of 3rd party repos, even EPEL, only permitting to consume
software provided by Red Hat official repos.  I'm not too bothered though
as I doubt it will be a major problem with likely QEMU contributors. Thos=
e
restrictive organizations are not likely to allow developers to be involv=
ed
in upstream communities in the first place, nor consume releases direct
from upstream.

IOW, I think (c) is fine to allow maximum flexibility for upstream.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

