Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99ABC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1782E206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mmmuj3sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1782E206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcSh-0002yV-73
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kZcRd-0002RP-GL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:12:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kZcRb-0006ig-KL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604333550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1LGVF7RvKSYCsbRfBNpYuojOvVveAb1QVOu49WXKKc=;
 b=Mmmuj3sVEe8lrlHji04oConR23ujq8QKpJ+mDIQnzytEB/MNDhWJi7QBHsKolGqYX2/52E
 8oMH6vE+Ip5EcuDdsugxQDJ4fXdE6GXjXZZiORf740f/sQojkmzbU1qMlIZ9cwgrh/dmeP
 V+tXnyIuMQmAjHjXIupzyxgFzaCFuEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-s2x4-DXdOBOzWJ19BxpeEw-1; Mon, 02 Nov 2020 11:12:26 -0500
X-MC-Unique: s2x4-DXdOBOzWJ19BxpeEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37DC11006C9E;
 Mon,  2 Nov 2020 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCACB5B4A9;
 Mon,  2 Nov 2020 16:12:17 +0000 (UTC)
Date: Mon, 2 Nov 2020 11:12:16 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH-for-5.2? 4/5] tests/acceptance: Only run tests tagged
 'gating-ci' on GitLab CI
Message-ID: <20201102161216.GA3021311@localhost.localdomain>
References: <20201102144245.2134077-1-philmd@redhat.com>
 <20201102144245.2134077-5-philmd@redhat.com>
 <f40e30a8-7be3-3f02-352a-9e5f60446d25@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f40e30a8-7be3-3f02-352a-9e5f60446d25@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, Fabien Chouteau <chouteau@adacore.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 03:59:12PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/2/20 3:42 PM, Philippe Mathieu-Daud=E9 wrote:
> > To avoid breaking our CI each time a test is added, switch from the
> > "run all but disable some" to "only run the tagged tests on CI".
> > This way we can add a test to the repository, and promote it to
> > 'gating-ci' once it is proven stable enough.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >=20
> > TODO: where to add documentation?
> >=20
> > - docs/devel/testing.rst (too big, split?)
> > - tests/acceptance/README.rst
> >=20
> > ---
> >  tests/Makefile.include | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 3a0524ce740..f39ba760c17 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -126,7 +126,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) g=
et-vm-images
> >              $(TESTS_VENV_DIR)/bin/python -m avocado \
> >              --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_R=
ESULTS_DIR) \
> >              --filter-by-tags-include-empty --filter-by-tags-include-em=
pty-key \
> > -            $(AVOCADO_TAGS) \
> > +            $(AVOCADO_TAGS) -t gating-ci \
>=20
> This doesn't work as expected, since we have:
>=20
> AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter
> %-softmmu,$(TARGET_DIRS)))
>=20
> And avocado '-t' works as logical OR, not logical AND.
>=20
> OTOH it seems this variable predate the auto-skip feature
> (when a binary is not present).
>=20
> So I'll test this instead, which is simpler:
>=20
> -- >8 --
> @@ -90,7 +90,7 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
>  # Any number of command separated loggers are accepted.  For more
>  # information please refer to "avocado --help".
>  AVOCADO_SHOW=3Dapp
> -AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter
> %-softmmu,$(TARGET_DIRS)))
> +AVOCADO_TAGS=3D-t gating-ci
>

But you can *add* to the resulting list with the arches, and then you get a
logical AND.  So it'd end up as:

 -t arch:x86_64,gating-ci -t arch:aarch64,gating-ci [...]

To avoid having only "gating-ci" tests running on other environments that
call "make check-acceptance", we can look at the environment variable that
GitLab CI sets and optionally include the "gating-ci" tag.

Regards,
- Cleber.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+gL90ACgkQZX6NM6Xy
CfOzGQ/+NHrQ8+9cYrL48uxExVv4BYYs2U2KNGFFl2BMwm+tvh7o3YSDDjMQKUgj
oNaVUb7GuMRXrBJZ0GqsXwtYgMYzeL085O7tjQ7qmoCzA5zCohMOYhfJCxHtIgez
kOooeyNXk099hkVCf1js6Y9In/9jpbN/VoKr+Fst6EEk0UaHQaSiNqpEmJ8njzxT
qpZR55EO2AzshK8na5vV/RQp5Pdm6EQngyc5P2vuAVakqYXc7uARmfTBsaUTa/oR
fm/51L2RO6PBhrK6xqC5AyoTQ/Ihl4OsSJfHgvqYa6/RkBpUuXHagDpoDyMpqHW/
U5beZX/TawPUYw/ShnA7OVa4DJpVvWMX9M+3pynum+ycPMj6r+dNfi4lEFPnrGBO
D7uUOfdn6BJKnrl0iTdxiQn9SVr1QCJ1ykPK7D+bnpUY1G2THDNqtQV3YBJyqHIm
6e5KNoB3hbP+41/7hiGp9X05VQh29fPYd/66mysXk0DmSQyAZB5ewtC5hFspsi51
Kf3uk2FVBhIrVGibE84HWJns3DJdosJNAY9y0rCoKeEsNkltXCn/bqG7GPjghUs2
KL3QAyNGJZuMlWS6mfbAFuMj5HxrHAmBoBnhUw1889XpPrt07iJOyQNJ5f6ko0nS
65M1bLhfHwwYk+GZb+ZFQIe/jDRxy9Rx4n7GsbV+I1KxwK9ik18=
=RkQD
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--


