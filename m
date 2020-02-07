Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A0C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59831214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7yZO2wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59831214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izz9T-0000RS-HD
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izz8q-0008Ch-5h
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izz8o-0006YV-99
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:37:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29227
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izz8o-0006Y5-5E
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581064653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=n9ZZpCiIpfFBxUlp3D2UDr3SaIpNH+T9eBjcAIfdGGI=;
 b=T7yZO2wxohn38/Jh0ow57XBtq4XNfd2rOuA2ts7Hez/PwiyoZVih9hY/Sq8T1AVubxB5Ki
 pujuTwp5OqObJoCYPW9x2+3susxowUf1PSu1UoaWwBv4ZtiBfTEJPmXyAG7DOvQpYCEIBX
 qNITJGhPNbMNIDKR9eeSFNB4k0NJVgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-I0IlzcufN2GUIvU6K1khuw-1; Fri, 07 Feb 2020 03:37:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6E1818A8C83;
 Fri,  7 Feb 2020 08:37:21 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-143.ams2.redhat.com [10.36.116.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21844790F8;
 Fri,  7 Feb 2020 08:37:17 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
Date: Fri, 7 Feb 2020 09:37:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200203032328.12051-2-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: I0IlzcufN2GUIvU6K1khuw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 04.23, Cleber Rosa wrote:
> This is a crude and straightforward mapping of Peter's
> "remake-merge-builds" and "pull-buildtest" scripts.
>=20
> Some characteristics were removed for simplicity sake (but eventually
> will), including:
>  * number of simultaneous make jobs
>  * make's synchronous output, not needed because of previous point
>  * out-of-tree builds
>=20
> This covers the "x86-64 Linux with a variety of different build
> configs"[1].  I've personally tested all of them, and only had
> issues with the "notcg" job[2], but it seems to be a test specific
> issue with the nested KVM I was using.
>=20
> [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
> [2] - https://paste.centos.org/view/1dd43a1c
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .gitlab-ci.yml | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)

Thanks for doing this! The patch looks basically fine to me, but some
comments below...

> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d2c7d2198e..eb4077e2ab 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -2,6 +2,8 @@ include:
>    - local: '/.gitlab-ci-edk2.yml'
> =20
>  build-system1:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>   before_script: &before_scr_apt
>   - apt-get update -qq
>   - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geni=
soimage
> @@ -17,6 +19,8 @@ build-system1:
>   - make -j2 check
> =20
>  build-system2:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>   before_script:
>    *before_scr_apt
>   script:
> @@ -31,6 +35,8 @@ build-system2:
>   - make -j2 check
> =20
>  build-disabled:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>   before_script:
>    *before_scr_apt
>   script:
> @@ -47,6 +53,8 @@ build-disabled:
>   - make -j2 check-qtest SPEED=3Dslow
> =20
>  build-tcg-disabled:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>   before_script:
>    *before_scr_apt
>   script:
> @@ -67,6 +75,8 @@ build-tcg-disabled:
>              248 250 254 255 256
> =20
>  build-user:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>   before_script:
>    *before_scr_apt
>   script:
> @@ -78,6 +88,8 @@ build-user:
>   - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
> =20
>  build-clang:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>   before_script:
>    *before_scr_apt
>   script:
> @@ -92,6 +104,8 @@ build-clang:
>   - make -j2 check
> =20
>  build-tci:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>   before_script:
>    *before_scr_apt
>   script:

Question to Peter/Alex/Stefan/Howevermergespullreqsinthefuture:

Should the above jobs really be skipped for pull requests, or would it
be ok to include them there, too? (in the latter case, the above changes
could just be dropped)

> @@ -111,3 +125,105 @@ build-tci:
>   - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/qtest=
/pxe-test
>   - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
>     ./tests/qtest/pxe-test -m slow
> +
> +ubuntu-18.04.3-x86_64-notools:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n22

Line 22 currently seems to be disabled, so I think you could drop this job?

> + - ./configure --target-list=3Darm-softmmu --disable-tools --disable-lib=
ssh
> + # There is no make / make check in the "pull-buildtest" script for this=
.
> + # Question: should it at least be built? Or dropped?
> + - make
> +
> +ubuntu-18.04.3-x86_64-all-linux-static:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n25
> + - ./configure --enable-debug --static --disable-system --disable-gluste=
rfs --disable-libssh
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n36
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n45
> + - make check V=3D1
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n48
> + - make check-tcg V=3D1
> +
> +ubuntu-18.04.3-x86_64-all:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n26
> + - ./configure --disable-libssh
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n28
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n37
> + - make check V=3D1
> +
> +ubuntu-18.04.3-x86_64-alldbg:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n27
> + - ./configure --disable-libssh
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n27
> + - make clean
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n29
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n37
> + - make check V=3D1
> +
> +ubuntu-18.04.3-x86_64-clang:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n31
> + - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++ --enable-gt=
k --extra-cflags=3D'-fsanitize=3Dundefined -fno-sanitize=3Dshift-base -Werr=
or'
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n33
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n39
> + - make check V=3D1
> +
> +ubuntu-18.04.3-x86_64-tci:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n33
> + - ./configure --disable-libssh --enable-debug --enable-tcg-interpreter
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n34
> + - make

I think "make check" should now work with TCI, too, there was a fix for
it some months ago (commit 2f160e0f9797c7522bfd0d09218d0c9340a5137c).
At least it's worth a try to enable it...

Alternatively, I think we don't urgently need to introduce this job -
there is already "build-tci" in gitlab-ci.yml which should cover
--enable-tcg-interpreter already and does some testing, too.

> +
> +ubuntu-18.04.3-x86_64-notcg:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rem=
ake-merge-builds#n35
> + - ./configure --disable-libssh --enable-debug --disable-tcg
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n35
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pul=
l-buildtest#n39
> + # Question: check is disabled on the original script, because the machi=
ne
> + # is said to be running VirtualBox.  Should this be dropped or should t=
he
> + # machine be tweaked or substituted?
> + - make check V=3D1

Without TCG, you definitely need a host that can do KVM for running make
check.
Question for Peter: Would it be ok to drop this job and simply always
use the "build-tcg-disabled" job that is already available in
.gitlab-ci.yml ?

 Thomas


