Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2309C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7120E20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibT3s3l6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7120E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQXC-0006yB-3F
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPQVM-0005eB-O1
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPQVK-0004rG-B4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601904372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2MzxbGwJunPvvvgW6OfcAJT3pFoG0V3JpD47w6Om000=;
 b=ibT3s3l6aMN8dWo2lpwqhxkyen6NkqeWS28+J+BN5BGrUVsM40Kj6bObxSTNJGWiK9H56y
 jiuXVFZX/bd4kzzms1pUqGpISG1pAepCA41vFOZVbNSxhL+RrCOsW4IRvtWJj/h5VF/Ulf
 y4ykORlpHiVIwctAPHx0PczA7l51UXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Y0xD57UnMQ6UFLxObfZIJg-1; Mon, 05 Oct 2020 09:26:09 -0400
X-MC-Unique: Y0xD57UnMQ6UFLxObfZIJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FBAB8014D9;
 Mon,  5 Oct 2020 13:26:08 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19C789CBA;
 Mon,  5 Oct 2020 13:26:07 +0000 (UTC)
Date: Mon, 5 Oct 2020 14:26:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/17] Block patches
Message-ID: <20201005132606.GA5029@stefanha-x1.localdomain>
References: <20200930101305.305302-1-stefanha@redhat.com>
 <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
 <20201001150248.GB559957@stefanha-x1.localdomain>
 <CAFEAcA9JdhSSJesCLB=F+GMc-wK4+ukHQwA18wdU7HaqoPiTfg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9JdhSSJesCLB=F+GMc-wK4+ukHQwA18wdU7HaqoPiTfg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 04:12:12PM +0100, Peter Maydell wrote:
> On Thu, 1 Oct 2020 at 16:03, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Thu, Oct 01, 2020 at 12:23:00PM +0100, Peter Maydell wrote:
> > > This produces this error message on ppc64be Linux:
> > >
> > > make: Entering directory `/home/pm215/qemu/build/all'
> > > make[1]: Entering directory `/home/pm215/qemu/slirp'
> > > make[1]: Nothing to be done for `all'.
> > > make[1]: Leaving directory `/home/pm215/qemu/slirp'
> > > Generating qemu-version.h with a meson_exe.py custom command
> > > Generating qemu-options.def with a meson_exe.py custom command
> > > Generating block-gen.c with a custom command
> > > YAML:1:83: error: unknown enumerated scalar
> > > {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
> > > "BreakBeforeBraces": "Custom", "SortIncludes": false,
> > > "MaxEmptyLinesToKeep": 2}
> > >
> > >            ^~~~~~~~
> > > Error parsing -style: Invalid argument, using LLVM style
> > > YAML:1:83: error: unknown enumerated scalar
> > > {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
> > > "BreakBeforeBraces": "Custom", "SortIncludes": false,
> > > "MaxEmptyLinesToKeep": 2}
> > >
> > >            ^~~~~~~~
> > > Error parsing -style: Invalid argument, using LLVM style
> > > Compiling C object libqemuutil.a.p/util_qemu-error.c.o
> > > Compiling C object libqemuutil.a.p/util_qemu-sockets.c.o
> > > Compiling C object libqemuutil.a.p/util_aio-posix.c.o
> > > Compiling C object libqemuutil.a.p/util_osdep.c.o
> > >
> > > The error does not cause the build to fail, which seems
> > > like it's also a bug...
> > >
> > > (My guess is this is due to some script implicitly wanting
> > > a newer version of something or other than the PPC box
> > > happens to have installed, rather than being an endianness
> > > issue.)
> >
> > Please rerun with make -j1 V=3D1 so the full command is printed. I'm no=
t
> > sure what is emitting these errors.
>=20
> Build tree already overwritten to handle a different pullreq,
> I'm afraid. I can come back and retry later...

No problem. Thanks for pointing out the issue, Vladimir and Peter.

I will send a v2.

Stefan

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl97HukACgkQnKSrs4Gr
c8g61AgArHTPkyoHFlYkuNAhJWdwB/OmDWFOT20lZzw/woSWMtHoff+Gq0IRQLRs
GnZoeK3kiksMKq6PAjt+8Z5M+87C4et+PC2l2H2CUQ13aHtjrdjDAToxs6FqXRkj
UWKEJq5pLFti6EYHMkH3ISFoVLAQ81qWTyUxjJhP9plGyQY+GYZM9JPT8XvgYtbw
/b6CVj+AxF3NmwC7O7tiMSfBHGuf2Q+mGPIhRz9Izuk4E1/ok0+lFMyA3ZPP5wPu
rIuTZP7/k108GZSppFONKesFlRgJ7HcFzMEgqWOqE3/0nOKcFwOhcMzd9kQVqwWT
QSpV1kEey1bROHXgMTyEBY0BvjQWzA==
=hm3I
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--


