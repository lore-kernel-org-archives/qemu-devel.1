Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A6AC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CBF20B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CBF20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huype-0001Bv-F7
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 08:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49658)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1huyp9-0000kw-Rq
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1huyp8-00015N-L4
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:44:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1huyp8-00014F-EG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:44:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEF283D962;
 Tue,  6 Aug 2019 12:44:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1EBC1001B02;
 Tue,  6 Aug 2019 12:44:11 +0000 (UTC)
Date: Tue, 6 Aug 2019 13:44:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190806124408.GE14887@redhat.com>
References: <20190713165856.29883-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190713165856.29883-1-philmd@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 06 Aug 2019 12:44:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.1] Makefile: Fix the NSIS Windows
 builds
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
Cc: Fam Zheng <fam@euphon.net>, Adam Baxter <voltagex@voltagex.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 13, 2019 at 06:58:56PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> The qemu-nsis.bmp file was not listed with the other blobs, thus
> not installed in the ${BINDIR} location.
>=20
> This fixes:
>=20
>   $ make installer
>   [...]
>   (cd /tmp/qemu-nsis; \
>            for i in qemu-system-*.exe; do \
>              arch=3D${i%.exe}; \
>              arch=3D${arch#qemu-system-}; \
>              echo Section \"$arch\" Section_$arch; \
>              echo SetOutPath \"\$INSTDIR\"; \
>              echo File \"\${BINDIR}\\$i\"; \
>              echo SectionEnd; \
>            done \
>           ) >/tmp/qemu-nsis/system-emulations.nsh
>   makensis -V2 -NOCD \
>                   -DCONFIG_DOCUMENTATION=3D"y" \
>                    \
>                   -DBINDIR=3D"/tmp/qemu-nsis" \
>                    \
>                   -DSRCDIR=3D"/home/phil/source/qemu" \
>                   -DOUTFILE=3D"qemu-setup-4.0.90.exe" \
>                   -DDISPLAYVERSION=3D"4.0.90" \
>                   /home/phil/source/qemu/qemu.nsi
>   File: "/tmp/qemu-nsis\*.bmp" -> no files found.
>   Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...]=
 |
>      /oname=3Doutfile one_file_only)
>   Error in script "/home/phil/source/qemu/qemu.nsi" on line 122 -- abor=
ting creation process
>   Makefile:1077: recipe for target 'qemu-setup-4.0.90.exe' failed
>   make: *** [qemu-setup-4.0.90.exe] Error 1
>=20
> Fixes: https://bugs.launchpad.net/bugs/1836453
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: 20190713163558.13204-1-philmd@redhat.com
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03204.html
>=20
> $ file qemu-setup-4.0.90.exe
> qemu-setup-4.0.90.exe: PE32 executable (GUI) Intel 80386 (stripped to e=
xternal PDB), for MS Windows, Nullsoft Installer self-extracting archive
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

