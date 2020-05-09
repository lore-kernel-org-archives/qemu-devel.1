Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8587AC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF32217BA
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="or2pU5Vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF32217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPRB-0007fM-BE
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jXPN1-0004Ma-TC
 for qemu-devel@nongnu.org; Sat, 09 May 2020 09:18:23 -0400
Received: from mout.web.de ([212.227.17.12]:33805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jXPN0-0007Xl-B4
 for qemu-devel@nongnu.org; Sat, 09 May 2020 09:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589030296;
 bh=QcPqjEJ/q8mdqpxeK10SK9JBHS7hiYgodOdqwBySo50=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=or2pU5VnUnuwhhmTX1KBSTHnSQOjtm26PYC/q75WGqcXmLidIgad+DWRkTE47nYo0
 gfNkkZTfwaztWfV6EC9pk1OXnzmU4OpjHZP/2Rr8mNfd8GlTkfby4cyreS6sq5Cecl
 lIvnWpfETgRktTm8p5vQq+65tgUuMpAb2PxlE5g0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.119]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lnj7L-1iuVFA40Vz-00hvYD; Sat, 09
 May 2020 15:18:16 +0200
Date: Sat, 9 May 2020 15:18:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/acceptance/boot_linux: Skip slow Aarch64 'virt'
 machine TCG test
Message-ID: <20200509151801.780059c3@luklap>
In-Reply-To: <20200507162235.1790-1-philmd@redhat.com>
References: <20200507162235.1790-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GS4RLMFaWIA=F3yFTnAi4j_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:YR3+YUrz5A3dOxYtz2OxrazPv2d0F1KEsCZ26CUckfic8OIohko
 DB3SBZlJHtVE1fUbUdpYi08fuvFsXhvllfj3sf7LYYnZ6l8QsMeM8wwW4d2gh2QwepYpUTD
 dgoEf14jkPOde3R92rBwkbT17WnvAVaricttuGoARVfg+/ShP2suk+RBTaRTwhUt/nx6Tng
 GtDv0fffiKfcamniv0qzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P698mWZ/sco=:QYPG2p0PMn9MMovDdZfM2p
 4BWTL11cASDl/TkhFYF7N+pRvYhNqY2TkkkpFF3WevarZ909OaM0GR4YCd39FqVCsh+YvMhTI
 3nJExiGgcYTZITbfdp/Wp5I8t+9+bkrQVfpN+eaUaQkwX4PX2zILezAaleVVWA4oSWaOIGygE
 R1HnMdbm6MjQQs1GWrRZziiR8ffN2JbU6GHsdP5TlqAvg6Mu+k2LpHBiRiUhlO55+x+jj9f+8
 kYNIgrahZoIjlTTrAaB5yYZuVEKt/NG0QNJ9CS5TwreXVT1BeEl30UWGM2g5KpkH8YUMBM/Wz
 W+z2bKusiBMgTfguXjzN65P9JkZw+14IH8cMx5i4i07Oi519vw+mQvblj5nn+U+lM0NXoavO2
 XQnyBC8MZEgLVBDmqW2GBFI9K8oT6H7e798NMZ4RmNulOqziiskrhMhV24X82wrI2Wg9LyDYf
 UYZiM9z1SpDTrD/IaSXh5XmyJtx5egIcpMKHyCoabdDGdIR4pxEzFE4OkODtiHMjcrgXyZ9rE
 unnT+j3UkZXzYpJB2gE3TrV53PVE4t5N+c/MX2f0IdNPQJ/XBrqLn6AJyq+lZEaDHU0ucFcg0
 t4/L1Ieu+tQTk7bTF9re02WByj0ln4cmqkE1Iq7C+1Q0wsK+W48lFkjwJHCZXtyBe++4hW9F4
 ZfIhJZpHolaQFurhauQr0vDpH0o/BVk7XvrVJeY+DkJmsArSHzm9ChU7qz6Ud2+gy/kHj5dKk
 AUy8/Spe08Tx+E6hoI3bknnawRC7V1+fdXL/0yGp0yOJXlKY6OcLjmEDLcVKBGEN6yNNP81lU
 DHW1gkB+SYCs9dLW/jnIYLEhGN+U/7SXnl1VibM8QCbMpjvHaWEvvvqZoeSRjAcYQpsgwRMzZ
 wsGB+MBE75Atuu/+/nvT5D4Bz99+byo9EztsliorKrSLXGBpTUdXLW8814nTVpBeq7Zrj+pdq
 QwrficEmHB8r/Hi3OrTtteiKqvSM5k/VLRqNI6K5Plz87eGtL6PYAH4a6TUvxhkbhSvTqOosf
 KT3epTGyNv9/oT+2Emv00L/wpSdzUlf9Z0Xc1xfB8cmrcNx/03DbATWYYK4QroNbAA5b2MeNW
 S0pWCrBjGTmguTCmGdmogtMwqFxt5W1U5WzoIM3/Hm51sORm70IVhKt0olFBgs57hsOnZMjrJ
 2ulxhwtSM7egHtq+kvLEXbNe983fvXwDWwFhtrJYa2/4SUJK3auQK06c1ERZVzrVf6pNcugFE
 QPL4M4LCXen4fjfXO
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 09:18:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/GS4RLMFaWIA=F3yFTnAi4j_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  7 May 2020 18:22:35 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The BootLinuxAarch64.test_virt_tcg is reported to take >7min to run.
> Add a possibility to users to skip this particular test, by setting
> the AVOCADO_SKIP_SLOW_TESTS environment variable:
>=20
>   $ AVOCADO_SKIP_SLOW_TESTS=3Dplease make check-acceptance
>   ...
>     (05/88) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg=
: SKIP: Test takes >7min
>   ...
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/boot_linux.py | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
> index 075a386300..a8df50d769 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -15,6 +15,7 @@
>  from qemu.accel import kvm_available
>  from qemu.accel import tcg_available
> =20
> +from avocado import skipIf
>  from avocado.utils import cloudinit
>  from avocado.utils import network
>  from avocado.utils import vmimage
> @@ -159,6 +160,7 @@ def add_common_args(self):
>          self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
>          self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/de=
v/urandom')
> =20
> +    @skipIf(os.getenv('AVOCADO_SKIP_SLOW_TESTS'), 'Test takes >7min')
>      def test_virt_tcg(self):
>          """
>          :avocado: tags=3Daccel:tcg

Hi,
Why not simply add slow tag to the test. Like:
:avocado: tags=3Dslow

The slow tests can then be skipped with
$ make check-acceptance AVOCADO_TAGS=3D'-t -slow'

Regards,
Lukas Straub

--Sig_/GS4RLMFaWIA=F3yFTnAi4j_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl62rYkACgkQNasLKJxd
slhofg/+KoZUN+w4ZsDIMna0PtTpMfR7SxhNqMR1oMZvOPorDismlEUNbRGvgzSd
UAOV8i51xaOQCFcvOUnR+T2GiRoUdJHq3HuOQdOwyyNSA9sTAMCL9wUh8Gyqx1Nu
3VQEpJvcYavpHtLbW5RRLECIFgF6Gy9BthN1AshY664kVE8uQfmg1BH+/YB9w+H8
DZzecSl0NCO0lZnjRIK3+Gdwfwq5FLuAJkdy7mBPF9K+NBUDF9EjZLR13i9wvJAc
6F09JhZbXcvXREOkkNcfUxTFrjB9IT2oBbnPyJG5Zd+Kx0SfyDh4uFXX5BsWF22t
MGkhEzZZFJzzsUXwqDPIE6UVmFGmVldD8Ddi65MBe0kKTGvPfG03nzTAmgdAFywt
aVU0qkN7eyC1nnCWIkGuPeT+2JHUfyT+piUsovzuJ1uGBLTyx2bGbk5dtrT2ok1n
S5KvvYeSYK2wFrb8I0HAHMdpaC84Lke5v6mUnxArjBcT03QbgXiv0myBCa2dCiiv
Om6K7sjcsfDLxiVxBWO2yofK9UqiB+WzH1IHEl3A4H7nsH4J16aIJaYl6p+Jndvh
NLIw3l6yacBYR7kR0vqyQ2Q6amzTVKFOhgYRwbws8bDo0K8WYzph1vUSS4nglwFg
VVG/g+PqSh+qAxCsmGdt4USiaYP99HunlEYAzGRqfUAvoMMuBxU=
=jstU
-----END PGP SIGNATURE-----

--Sig_/GS4RLMFaWIA=F3yFTnAi4j_--

