Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4BBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9DF2070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9DF2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBN0v-0004Qs-Oz
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBMz9-0002mT-6G
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBMz7-0001m9-5x
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBMz6-0001lk-V9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:46:21 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC34C3D94D
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 17:46:19 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k184so1562829wmk.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 10:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HFU/Z0a1puQ8Mhyx/IRw8uYfYE4OM4CUGQBmTQZe0y8=;
 b=X/xxV16MBmx0wkur7rL4JJZzFdHK2zA++VHu74KrjfX+OMkErL+BT2mMUYEZzaZW9P
 GHJN0mrVMm78f47MOAP+wwTF9E0gzjS2VTMZXTrfsmNkHzrnsqDXsz3VNQADErhSzFZ9
 gNL8aBlLDHdhSKyXLk4Q1IYLuEFMVJSs/9yvXpSoQF/a6XATiGJzZEJObcwAmb48oxAq
 isaKm7970JOeli9GT3Bdm11VqKis6TNyg6ejfbG3KKBEy2xtl9v9/Xp1IETJlCLqoY1j
 9rmXZXZo1zmTnI9zaq8GHaGY1f4FwM2LV3T/EVpAgd/JDp60bNzKwqFOmWX96ltokD2S
 c78A==
X-Gm-Message-State: APjAAAWGk758uxq9qoljpV+pblg5q1cjybR5E5tqnvlhcDaZv8zhcasH
 n82mdFs3/05uuQh3M+rxYwIJUvs2/gW8vfp/8jiCZ0OpAShDOf63r0ibN0qH8EeA/L9x1aGTfAb
 F59Y2ea/8II8PpNQ=
X-Received: by 2002:a5d:618a:: with SMTP id j10mr1117610wru.168.1569001578377; 
 Fri, 20 Sep 2019 10:46:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwyOTtV3M9Xb+35C3mZ0//FIg6vVzkaikfSRJG7NPs4DSlxtnw3v69FK3Wy7a+7Tyq9wDgmcg==
X-Received: by 2002:a5d:618a:: with SMTP id j10mr1117598wru.168.1569001578207; 
 Fri, 20 Sep 2019 10:46:18 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id k9sm5059466wrd.7.2019.09.20.10.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 10:46:17 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: Test the release tarball
To: qemu-devel@nongnu.org
References: <20190920174219.22005-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2348be05-0e20-2a18-483e-7c280b2af5e4@redhat.com>
Date: Fri, 20 Sep 2019 19:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920174219.22005-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Laszlo Ersek <lersek@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Bruce Rogers <brogers@suse.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 7:42 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a job to generate the release tarball and build/install few
> QEMU targets from it.
>=20
> Ideally we should build the 'efi' target from the 'roms' directory,
> but it is too time consuming.
>=20
> This job is only triggered when a tag starting with 'v' is pushed,
> which is the case with release candidate tags.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This job is quick enough: Ran for 15 min 32 sec
> https://travis-ci.org/philmd/qemu/jobs/587583631
>=20
> Based-on: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
> "Fix tarball builds of UEFI/EDK2 firmware"
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02734.html
> ---
>  .travis.yml | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index d0b9e099b9..a21f99d22d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -339,3 +339,25 @@ matrix:
>          - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64=
-softmmu,alpha-softmmu"
>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +
> +
> +    # Release builds
> +    # The make-release script expect a QEMU version, so our tag must s=
tart with a 'v'

*sigh* I forgot to commit my stash.

This is simply a change in the comment:

-- >8 --
@@ -342,7 +342,8 @@
     # Release builds
-    # The make-release script expect a QEMU version, so our tag must
start with a 'v'
+    # The make-release script expect a QEMU version, so our tag must
start with a 'v'.
+    # This is the case when release candidate tags are created.
---

> +    - if: tag IS present AND tag =3D~ ^v
> +      env:
> +        # We want to build from the release tarball
> +        - BUILD_DIR=3D"release/build/dir" SRC_DIR=3D"../../.."
> +        - BASE_CONFIG=3D"--prefix=3D$PWD/dist"
> +        - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-softmmu,arm=
eb-linux-user,ppc-linux-user"
> +        - TEST_CMD=3D"make install -j3"
> +        - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +      before_script:
> +        - command -v ccache && ccache --zero-stats
> +        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> +      script:
> +        - ${SRC_DIR}/scripts/make-release ${SRC_DIR} ${QEMU_VERSION}
> +        - ls -l qemu-${QEMU_VERSION}.tar.bz2
> +        - tar -xf qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${QEMU_VERSI=
ON}
> +        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && =
exit 1; }
> +        - make install
>=20

