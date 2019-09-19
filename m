Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3243C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797D221924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797D221924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAv5t-00075f-MH
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iAuyM-00055K-Lj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iAuoz-0003Wn-6O
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:42:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iAuoz-0003WZ-19
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:42:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 227CAC04B940;
 Thu, 19 Sep 2019 11:42:00 +0000 (UTC)
Received: from redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C1A45D6B2;
 Thu, 19 Sep 2019 11:41:54 +0000 (UTC)
Date: Thu, 19 Sep 2019 12:41:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Message-ID: <20190919114152.GK20217@redhat.com>
References: <20190919105932.19412-1-philmd@redhat.com>
 <04454c37-ad8b-b69b-3f40-bb78f0c20ef2@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04454c37-ad8b-b69b-3f40-bb78f0c20ef2@weilnetz.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 19 Sep 2019 11:42:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] testing: Build WHPX enabled binaries
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
Cc: Fam Zheng <fam@euphon.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Justin Terry <juterry@microsoft.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 01:18:57PM +0200, Stefan Weil wrote:
> Am 19.09.2019 um 12:59 schrieb Philippe Mathieu-Daud=C3=A9:
> > Add a job to cross-build QEMU with WHPX enabled.
> >
> > Use the Win10SDK headers from the Android Project, as commented
> > in https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03842.htm=
l
> >
> > Based-on: <20190918121101.30690-1-philmd@redhat.com>
> > https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03844.html
> >
> > Philippe Mathieu-Daud=C3=A9 (2):
> >   tests/docker: Add fedora-win10sdk-cross image
> >   .shippable.yml: Build WHPX enabled binaries
> >
> >  .shippable.yml                                |  2 ++
> >  tests/docker/Makefile.include                 |  1 +
> >  .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++=
++
> >  3 files changed, 24 insertions(+)
> >  create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.do=
cker
> >
>=20
> Please note that the required header files are part of the Win10SDK
> which is not published under a free license, so I am afraid that they
> cannot be used with QEMU code to produce free binaries.

Can you elaborate on why you think that is the case ?

Looking at the 3 header files used, all they contain are struct
definitions and integer constants, fortunately no functional
code in macros or inline functions. As such, it is questionable
whether the headers alone can be considered copyrightable material.
Any compatible implementation that follows the WHPX API/ABI will by
neccessity be the same, modulo code style.

Further, from a GPL POV, these headers should fall under the system
libraries exception, as WHPX is core low level operating system
functionality.

There's a valid legal question as to how to we got access to the
files in the first place. Assuming they are freely distributable
though, given their hosting on Google Android downloads.

So the fact that the headers are not under an open source / free
license doesn't look like it should impact the ability to distribute
the resulting QEMU binaries.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

