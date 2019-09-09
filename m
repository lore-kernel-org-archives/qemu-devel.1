Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544FCC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F792086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F792086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JYJ-0007Ex-7H
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i7JVk-0005PI-Gp
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i7JVj-00030X-2i
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i7JVi-00030E-UB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CA5718F3518;
 Mon,  9 Sep 2019 13:15:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8D16608C2;
 Mon,  9 Sep 2019 13:15:12 +0000 (UTC)
Date: Mon, 9 Sep 2019 14:15:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190909131510.GG24509@redhat.com>
References: <20190829165036.9773-1-berrange@redhat.com>
 <20190829165036.9773-2-berrange@redhat.com>
 <15ffac7c-e7f2-17e4-f4e5-e54500ae3ecb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15ffac7c-e7f2-17e4-f4e5-e54500ae3ecb@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 09 Sep 2019 13:15:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/4] docs: convert README,
 CODING_STYLE and HACKING to RST syntax
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 09, 2019 at 02:57:08PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 8/29/19 6:50 PM, Daniel P. Berrang=C3=A9 wrote:
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  CODING_STYLE =3D> CODING_STYLE.rst | 121 +++++++++++++++++++--------=
---
> >  HACKING =3D> HACKING.rst           | 123 +++++++++++++++++++++------=
----
> >  README =3D> README.rst             |  47 +++++++-----
> >  scripts/checkpatch.pl            |   2 +-
> >  4 files changed, 191 insertions(+), 102 deletions(-)
> >  rename CODING_STYLE =3D> CODING_STYLE.rst (72%)
> >  rename HACKING =3D> HACKING.rst (79%)
> >  rename README =3D> README.rst (84%)
>=20
> This change broke the NSIS build:
>=20
> (cd /tmp/qemu-nsis; \
>          for i in qemu-system-*.exe; do \
>            arch=3D${i%.exe}; \
>            arch=3D${arch#qemu-system-}; \
>            echo Section \"$arch\" Section_$arch; \
>            echo SetOutPath \"\$INSTDIR\"; \
>            echo File \"\${BINDIR}\\$i\"; \
>            echo SectionEnd; \
>          done \
>         ) >/tmp/qemu-nsis/system-emulations.nsh
> makensis -V2 -NOCD \
>                 -DCONFIG_DOCUMENTATION=3D"y" \
>                 -DCONFIG_GTK=3D"y" \
>                 -DBINDIR=3D"/tmp/qemu-nsis" \
>                  \
>                 -DSRCDIR=3D"/tmp/qemu-test/src" \
>                 -DOUTFILE=3D"qemu-setup-4.1.50.exe" \
>                 -DDISPLAYVERSION=3D"4.1.50" \
>                 /tmp/qemu-test/src/qemu.nsi
> File: "/tmp/qemu-test/src\README" -> no files found.
> Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
>    /oname=3Doutfile one_file_only)
> Error in script "/tmp/qemu-test/src/qemu.nsi" on line 122 -- aborting
> creation process
> make: *** [Makefile:1083: qemu-setup-4.1.50.exe] Error 1
>=20
> I'll send a fix.

Doh. If we care about NSIS, we really need to have it being tested by
some part of our CI system, and by pre-merge build tests.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

