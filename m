Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A1C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBAF208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1CdRMcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBAF208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAer-00064N-5X
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kQAan-0001pX-LK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kQAal-0004nF-18
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602081534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D7DqiWwtlPgyI4TMpWNlRQBpxsyPz4B7Gk7InmRaKAE=;
 b=T1CdRMcsREwH1QQzL4Y33pLoJ3iX2TaEkigIKmLSYhCRTMaEWjwCJ4B9O9FxvOgHnz1dOm
 GmDuGBuAxJOG+x3CmBh84K1GWVpgDTnrC+kCHSNhQRnmdbmv+ei4VUmZbC3yE9iznprdSL
 d2rWA31FSAjpvgvQdJrB2k5YNJuHmWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453--8y8u11TN_is56nEzet3hQ-1; Wed, 07 Oct 2020 10:38:52 -0400
X-MC-Unique: -8y8u11TN_is56nEzet3hQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E296B420EA;
 Wed,  7 Oct 2020 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1B515D9DD;
 Wed,  7 Oct 2020 14:38:49 +0000 (UTC)
Date: Wed, 7 Oct 2020 10:38:48 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: acceptance-system-fedora failures
Message-ID: <20201007143848.GG240186@localhost.localdomain>
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
 <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2020 at 07:20:49AM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 10/7/20 1:07 AM, John Snow wrote:
> > I'm seeing this gitlab test fail quite often in my Python work; I don't
> > *think* this has anything to do with my patches, but maybe I need to tr=
y
> > and bisect this more aggressively.
> >=20
> > The very first hint of an error I see is on line 154:
> >=20
> > https://gitlab.com/jsnow/qemu/-/jobs/776334918#L154
> >=20
> > 22:05:36 ERROR|
> > 22:05:36 ERROR| Reproduced traceback from:
> > /builds/jsnow/qemu/build/tests/venv/lib64/python3.8/site-packages/avoca=
do/core/test.py:753
> >=20
> > 22:05:36 ERROR| Traceback (most recent call last):
> > 22:05:36 ERROR|=C2=A0=C2=A0 File
> > "/builds/jsnow/qemu/build/tests/acceptance/avocado_qemu/__init__.py",
> > line 171, in setUp
> > 22:05:36 ERROR|=C2=A0=C2=A0=C2=A0=C2=A0 self.cancel("No QEMU binary def=
ined or found in the
> > build tree")
>

One very bad aspect of this output is that the test outcome (a test
cancelation) is determined by an exception handler by the runner, and
the "ERROR" prefix is indeed very misleading.

But yes, in short, it's not an *error*, but the test getting canceled.

> Last year the Avocado developers said we could have a clearer
> log error report, but meanwhile this verbose output is better
> that not having anything =C2=AF\_(=E3=83=84)_/=C2=AF
>

With the new test runner ("avocado run --test-runner=3Dnrunner") that
just made its way into Avocado 81.0, there's a much better separation
of what happens within the test, and within the runner.

The next step is to post the QEMU and "Avocado >=3D 82.0" integration, so
hopefully this will improve soon.

> >=20
> > Is this a known problem?
>=20
> "No QEMU binary defined or found in the build tree" is not a
> problem, it means a test is skipped because the qemu-system-$ARCH
> binary is not found. In your case this is because your job
> (acceptance-system-fedora) is based on build-system-fedora
> which only build the following targets:
>=20
>     TARGETS: tricore-softmmu microblaze-softmmu mips-softmmu
>       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu
>       sparc64-softmmu
>

Right.

> Now I don't understand what binary the EmptyCPUModel/Migration tests
> are expecting. Maybe these tests only work when a single target is
> built? IOW not expecting that the python code searching for a binary
> return multiple ones? -> Eduardo/Cleber.
>

`avocado_qemu.pick_default_qemu()`, if not given an arch, will try to
find a target binary that matches the host.  The problem with picking
any (first available?) built target is the non-deterministic aspect.

BTW, with regards to how `avocado_qemu.pick_default_qemu()` will get
an arch, it can come either from a test parameter, or from an "arch"
tag.

Cheers,
- Cleber.

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl990vUACgkQZX6NM6Xy
CfNBJA//a8pfr9CObPnB3eprL5sU0O4mLYEVxH4PAt9C48JamN7Hvcn3n2UWoJsR
aPNxDvLSBuyilnR+OYmOBEu3gTQZ4jmVvRJMVCFazewNUNSt8X8y395KMWV+cI7M
92HG5KpsOpSbBCByeWpoUUleMUEUniGR/qNjzuYO+tVsVqaFAF34kLAFcIKqi90h
q0JPTMz+o50WWmDojNT93jmz3AdhcVPUUNNKgMraxLgT2QUUkx8dWVnXizqKJTC7
s4e8DYfqn4+Y9IJj1h1w+r6U+y91E+vIflcL/r2wtQYLzTWZo36NoumEKEMV2JQH
wgmoMdEmOr1J/Q8k2jr/+o2n4HGrVchFz7zAhUFWGVnJmIs1Ca6Txv/ovSDHmYWL
dEaJaj6214MgoU/r3s/Il+5EeXI+Qx4rIGSxdgo9qYUOO7bqImLh3cUwN4xzsLnm
dgc+L/Ii8JyXbvm+zU7sEUrmGRJkmXJNJHmuA7dfr++c4I7Xi3SgjumCRNH5oKWY
NxsXb8CvluRqfgETek64Ov3W8Kb8Rmfnx9YTnHbDVHGWhuBXE9PRpJPkEMHb3zex
OYDiIm61McfoPOE6Kw5J2HwmpaUL79ZASX8hhwtOxSKpAALgoHuHgb789PT1xPzJ
vDGV0CsvHQSKRSynDjoQofJcWIvrx8r5PAX8zT3CA/5s3vlkJxw=
=SQXj
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--


