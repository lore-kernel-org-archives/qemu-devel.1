Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16316C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEDB20644
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEDB20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4iFC-0008Jd-0J
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i4iES-0007uu-Vr
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i4iER-00089l-FK
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i4iER-000895-9R
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:02:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 073BB8980E5;
 Mon,  2 Sep 2019 09:02:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00A7D60C18;
 Mon,  2 Sep 2019 09:02:33 +0000 (UTC)
Date: Mon, 2 Sep 2019 10:02:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Message-ID: <20190902090230.GC30123@redhat.com>
References: <20190831153922.121308-1-liq3ea@163.com>
 <156726640099.4971.12196429235488580695@5dec9699b7de>
 <CAKXe6SKO60x5MGW22iDQuKh=JLByQVULJpwD+0DffpzeG231xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXe6SKO60x5MGW22iDQuKh=JLByQVULJpwD+0DffpzeG231xw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 02 Sep 2019 09:02:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vnc: fix memory leak when vnc disconnect
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
Cc: Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?5p2O5by6?= <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 31, 2019 at 11:52:47PM +0800, Li Qiang wrote:
> <no-reply@patchew.org> =E4=BA=8E2019=E5=B9=B48=E6=9C=8831=E6=97=A5=E5=91=
=A8=E5=85=AD =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Patchew URL:
> > https://patchew.org/QEMU/20190831153922.121308-1-liq3ea@163.com/
> >
> >
> >
> > Hi,
> >
> > This series seems to have some coding style problems. See output belo=
w for
> > more information:
> >
> > Type: series
> > Message-id: 20190831153922.121308-1-liq3ea@163.com
> > Subject: [Qemu-devel] [PATCH] vnc: fix memory leak when vnc disconnec=
t
> >
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > git rev-parse base > /dev/null || exit 0
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > ./scripts/checkpatch.pl --mailback base..
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > Switched to a new branch 'test'
> > fb52b49 vnc: fix memory leak when vnc disconnect
> >
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > ERROR: spaces required around that '*' (ctx:WxB)
> > #118: FILE: ui/vnc-enc-tight.c:355:
> > +        data =3D (uint##bpp##_t *)vs->tight->tight.buffer;          =
      \
> >                                ^
> >
> >
>=20
> Hello Paolo and the Checkpatch maintainers,
>=20
> I also see this error in scripts/checkpatch.pl.
> However when I add sapces around '*". I got following error:
>=20
> ERROR: space prohibited before that close parenthesis ')'
>=20
> #124: FILE: ui/vnc-enc-tight.c:355:
>=20
> +        data =3D (uint##bpp##_t * )vs->tight->tight.buffer;           =
    \
>=20
>=20
>=20
> So I'm confused how to make checkpatch.pl happy.
>=20
>=20
> Any one has suggests? Or we need a patch for checkpatch.pl?

Either ignore this patch warning, or figure out how to fix
checkpatch.pl though the latter quite be quite hard


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

