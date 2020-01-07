Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C51C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA20207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnLSgXB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA20207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iompj-0005sx-J6
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iolqR-0008ND-43
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iolqP-0006cK-8D
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:12:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iolqP-0006c7-3i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIKlIC18EuyvwnJ2pfH5VMHBgfyHNE2VFm0qfK7GFag=;
 b=FnLSgXB5xlJKxd5LGIJE/wd9gdjbNjXFP/yuxPRgIgXz206+UpYtMuh1m9h/V6YbZb+FNN
 RAJQvpaCpA5xMWQqa3IH8n08SmcZP61Bk5bxjvMiONf3vT/FUfCi5qJrVwUvm2sXW/eZ0n
 KSxU4K/ixjZnc03SEXORGsmbIVo5gQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-SRPPA7_6Nr2_CZKiMl-4tg-1; Tue, 07 Jan 2020 05:12:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 951B110054E3;
 Tue,  7 Jan 2020 10:12:08 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-126.ams2.redhat.com
 [10.36.117.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5AB9858BD;
 Tue,  7 Jan 2020 10:12:04 +0000 (UTC)
Subject: Re: [PATCH 2/3] gitlab-ci.yml: Add a job to build EDK2 firmware
 binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200106184601.25453-1-philmd@redhat.com>
 <20200106184601.25453-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <74b5d03a-c3a3-38b8-68cb-192dd04f1802@redhat.com>
Date: Tue, 7 Jan 2020 11:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200106184601.25453-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: SRPPA7_6Nr2_CZKiMl-4tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/06/20 19:46, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a GitLab job to build the EDK2 firmware binaries.
> This job is only built when the roms/edk2/ submodule is updated,
> when a git-ref starts with 'edk2' or when the last commit contains
> 'EDK2'.

keyword "or"; okay.

>=20
> GitLab CI generates an artifacts.zip file containing the firmware
> binaries.
>=20
> With edk2-stable201905, the job took 40 minutes 26 seconds,
> the artifacts.zip takes 10MiB.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .gitlab-ci-edk2.yml | 37 +++++++++++++++++++++++++++++++++++++
>  .gitlab-ci.yml      |  3 +++
>  MAINTAINERS         |  3 ++-
>  3 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 .gitlab-ci-edk2.yml
>=20
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
> new file mode 100644
> index 0000000000..abfaf52874
> --- /dev/null
> +++ b/.gitlab-ci-edk2.yml
> @@ -0,0 +1,37 @@
> +build-edk2:
> + rules: # Only run this job when ...
> + - changes: # ... roms/edk2/ is modified (submodule updated)
> +   - roms/edk2/*
> +   when: always
> + - if: '$CI_COMMIT_REF_NAME =3D~ /^edk2/' # ... the branch/tag starts wi=
th 'edk2'

(1) can you add "or" in the comment here?

> +   when: always
> + - if: '$CI_COMMIT_MESSAGE =3D~ /edk2/i' # last commit description conta=
ins 'EDK2'

(2) ditto

> +   when: always
> + artifacts:
> +   paths: # 'artifacts.zip' will contains the following files:
> +   - pc-bios/edk2*bz2
> +   - pc-bios/edk2-licenses.txt
> +   - edk2-stdout.log
> +   - edk2-stderr.log
> + image: ubuntu:16.04 # Use Ubuntu Xenial
> + before_script: # Install packages requiered to build EDK2
> + - apt-get update --quiet --quiet
> + - DEBIAN_FRONTEND=3Dnoninteractive
> +   apt-get install --assume-yes --no-install-recommends --quiet --quiet
> +     build-essential
> +     ca-certificates
> +     dos2unix
> +     gcc-aarch64-linux-gnu
> +     gcc-arm-linux-gnueabi
> +     git
> +     iasl
> +     make
> +     nasm
> +     python
> +     uuid-dev
> + script: # Clone the required submodules and build EDK2
> + - git submodule update --init roms/edk2

yes, this is needed; qemu users are used to updating top-level
submodules (which is why we didn't try to automate that away in the edk2
build stuff)

> + - git -C roms/edk2 submodule update --init

(3) but this should not be necessary. See the "submodules" target in
"roms/Makefile.edk2".

> + - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
> + - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
> + - make -j${JOBS} -C roms efi 1>edk2-stdout.log 2> >(tee -a edk2-stderr.=
log >&2)

Process substitution is a nifty feature, but perhaps we can do without
it, for simplicity. (I realize this is bash-only; I just like to
minimize the use of non-portable features if there is a portable
replacement that is also simple.)

Redirections are processed in the order they appear on the command line
[1], *after* stdout/stdin is redirected for pipelining [2]:

[1]
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#t=
ag_18_07

"If more than one redirection operator is specified with a command, the
order of evaluation is from beginning to end."

[2]
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#t=
ag_18_09_02

"The standard input, standard output, or both of a command shall be
considered to be assigned by the pipeline before any redirection
specified by redirection operators that are part of the command"


(4) Therefore, the following should work:

  make -j${JOBS} -C roms efi 2>&1 1>edk2-stdout.log \
  | tee -a edk2-stderr.log >&2

Untested, of course :)

Looks OK otherwise.

Thanks!
Laszlo

> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ebcef0ebe9..f799246047 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,3 +1,6 @@
> +include:
> +  - local: '/.gitlab-ci-edk2.yml'
> +
>  before_script:
>   - apt-get update -qq
>   - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geni=
soimage
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8571327881..22a1fd5824 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2346,6 +2346,7 @@ F: roms/edk2
>  F: roms/edk2-*
>  F: tests/data/uefi-boot-images/
>  F: tests/uefi-test-tools/
> +F: .gitlab-ci-edk2.yml
> =20
>  Usermode Emulation
>  ------------------
> @@ -2689,7 +2690,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
>  GitLab Continuous Integration
>  M: Thomas Huth <thuth@redhat.com>
>  S: Maintained
> -F: .gitlab-ci.yml
> +F: .gitlab-ci*.yml
> =20
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20


