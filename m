Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF897C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B46B208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDhHAUmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B46B208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0NH-0003qU-8l
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kO06y-0007rs-6q
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kO06w-0005Np-AB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601564589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6pHo6/p7ls3k2v3o1+/1YRfa3d3G/pQvsEsvEB6kuD4=;
 b=VDhHAUmHSFx+NO+268X7XYu6LbrjN5XZ6QpzGqtzsqdGOyRVCzKLYCzyHNI9XSxTmjsQsE
 zGtwDWzfCWr1wwFNBGUEHiwclnQPOJajZu3zy4gljyY+ids4QOgipm0O1D1Xj10heCK7rJ
 NIZ3cpvO1nlsILb6J6TyaACIuUgiAME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-xrlnRW9CN-eyva9rtkG7sA-1; Thu, 01 Oct 2020 11:03:03 -0400
X-MC-Unique: xrlnRW9CN-eyva9rtkG7sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079251021230;
 Thu,  1 Oct 2020 15:02:50 +0000 (UTC)
Received: from localhost (ovpn-115-144.ams2.redhat.com [10.36.115.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4003E34813;
 Thu,  1 Oct 2020 15:02:49 +0000 (UTC)
Date: Thu, 1 Oct 2020 16:02:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/17] Block patches
Message-ID: <20201001150248.GB559957@stefanha-x1.localdomain>
References: <20200930101305.305302-1-stefanha@redhat.com>
 <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 12:23:00PM +0100, Peter Maydell wrote:
> On Wed, 30 Sep 2020 at 11:13, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > The following changes since commit b150cb8f67bf491a49a1cb1c7da151eeacbd=
bcc9:
> >
> >   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into sta=
ging (2020-09-29 13:18:54 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> >
> > for you to fetch changes up to bc47831ff28d6f5830c9c8d74220131dc54c5253=
:
> >
> >   util/vfio-helpers: Rework the IOVA allocator to avoid IOVA reserved r=
egions (2020-09-30 10:23:05 +0100)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > Note I have switched from GitHub to GitLab.
> >
> > ----------------------------------------------------------------
>=20
> This produces this error message on ppc64be Linux:
>=20
> make: Entering directory `/home/pm215/qemu/build/all'
> make[1]: Entering directory `/home/pm215/qemu/slirp'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/home/pm215/qemu/slirp'
> Generating qemu-version.h with a meson_exe.py custom command
> Generating qemu-options.def with a meson_exe.py custom command
> Generating block-gen.c with a custom command
> YAML:1:83: error: unknown enumerated scalar
> {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
> "BreakBeforeBraces": "Custom", "SortIncludes": false,
> "MaxEmptyLinesToKeep": 2}
>=20
>            ^~~~~~~~
> Error parsing -style: Invalid argument, using LLVM style
> YAML:1:83: error: unknown enumerated scalar
> {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
> "BreakBeforeBraces": "Custom", "SortIncludes": false,
> "MaxEmptyLinesToKeep": 2}
>=20
>            ^~~~~~~~
> Error parsing -style: Invalid argument, using LLVM style
> Compiling C object libqemuutil.a.p/util_qemu-error.c.o
> Compiling C object libqemuutil.a.p/util_qemu-sockets.c.o
> Compiling C object libqemuutil.a.p/util_aio-posix.c.o
> Compiling C object libqemuutil.a.p/util_osdep.c.o
>=20
> The error does not cause the build to fail, which seems
> like it's also a bug...
>=20
> (My guess is this is due to some script implicitly wanting
> a newer version of something or other than the PPC box
> happens to have installed, rather than being an endianness
> issue.)

Please rerun with make -j1 V=3D1 so the full command is printed. I'm not
sure what is emitting these errors.

Thanks,
Stefan

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9175cACgkQnKSrs4Gr
c8g97Qf/VuyfITRJJandKT5R+CteLuqWXMa/0rmsnIXLIQyshS3yZrhLM0j8IOvd
kzyuafsUAASMpdj7VFmquZtEKqU2G4zDlwPY1pJUkOv+T6Gs3zvAEcwFQXzOikMD
iEFMX3wXvEntC4dfBWmbeUDaKp/l6WO8MgiD88SCs+kz1gPyCQYUK24rySc2kPPl
vbTnQmtwBNQxpPOoj6Ri+g+GpaBc/UQjrvV4taOgst6PQE9oqXQwAj2ABZsAfLhg
kgXXg1Zx4dZ8uvnDVodbZ4qt29IrA0cZsL7DyNbwXdQU3xGAaXQOfWiW0dzqH4nm
0PlaC8RJYYQ3Zyvv8sdiwln9hZl6ow==
=RDgb
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--


