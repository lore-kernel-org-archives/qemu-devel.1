Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C97C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66BF204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66BF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNw1a-0007NE-VO
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:04:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hNw0W-0006yc-Q8
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hNw0V-0001gd-Bx
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hNw0V-0001es-4p
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:03:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37B7F5D68A;
	Tue,  7 May 2019 09:03:26 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E3C61001DDE;
	Tue,  7 May 2019 09:03:24 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-3-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5f6eaa15-4a36-37c2-3199-0084178e9cfb@redhat.com>
Date: Tue, 7 May 2019 11:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506173353.32206-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 07 May 2019 09:03:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 02/24] crypto: Merge crypto-obj-y into
 libqemuutil.a
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/2019 19:33, Richard Henderson wrote:
> We will shortly need this in the user-only binaries, so drop the split
> into system and tools binaries.  This also means that crypto-aes-obj-y
> can be merged back into crypto-obj-y.
>

This patch breaks linux-user statically linked build on Fedora.

Fedora doesn't provide static version of nettle and gcrypt, so the=20
configure fails.

You should update the configure for them like you did for gnutls in PATCH=
 1.

Thanks,
Laurent

> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   Makefile             | 12 +++++-------
>   Makefile.objs        |  8 ++------
>   Makefile.target      |  4 ----
>   configure            |  9 +++------
>   crypto/Makefile.objs |  5 +----
>   5 files changed, 11 insertions(+), 27 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index d372493042..09c8591805 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -410,7 +410,6 @@ dummy :=3D $(call unnest-vars,, \
>                   block-obj-y \
>                   block-obj-m \
>                   crypto-obj-y \
> -                crypto-aes-obj-y \
>                   qom-obj-y \
>                   io-obj-y \
>                   common-obj-y \
> @@ -446,7 +445,6 @@ SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_=
RULES))
>  =20
>   $(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
>   $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
> -$(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
>   $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
>   $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
>   $(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
> @@ -502,7 +500,7 @@ Makefile: $(version-obj-y)
>   #####################################################################=
#
>   # Build libraries
>  =20
> -libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
> +libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y) $(crypto-obj=
-y)
>   libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
>  =20
>   #####################################################################=
#
> @@ -511,9 +509,9 @@ COMMON_LDADDS =3D libqemuutil.a
>  =20
>   qemu-img.o: qemu-img-cmds.h
>  =20
> -qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-o=
bj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> -qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-o=
bj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> -qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> +qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(io-obj-y=
) $(qom-obj-y) $(COMMON_LDADDS)
> +qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(io-obj-y=
) $(qom-obj-y) $(COMMON_LDADDS)
> +qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(io-obj-y) =
$(qom-obj-y) $(COMMON_LDADDS)
>  =20
>   qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
>  =20
> @@ -524,7 +522,7 @@ qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-gen=
erate.o $(COMMON_LDADDS)
>   fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev=
/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
>   fsdev/virtfs-proxy-helper$(EXESUF): LIBS +=3D -lcap
>  =20
> -scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(aut=
hz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> +scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(aut=
hz-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>   ifdef CONFIG_MPATH
>   scsi/qemu-pr-helper$(EXESUF): LIBS +=3D -ludev -lmultipath -lmpathper=
sist
>   endif
> diff --git a/Makefile.objs b/Makefile.objs
> index cf065de5ed..0ce429c1af 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -3,6 +3,8 @@
>   stub-obj-y =3D stubs/ util/ crypto/
>   util-obj-y =3D util/ qobject/ qapi/
>  =20
> +crypto-obj-y =3D crypto/
> +
>   chardev-obj-y =3D chardev/
>  =20
>   #####################################################################=
##
> @@ -21,12 +23,6 @@ block-obj-$(CONFIG_REPLICATION) +=3D replication.o
>  =20
>   block-obj-m =3D block/
>  =20
> -######################################################################=
#
> -# crypto-obj-y is code used by both qemu system emulation and qemu-img
> -
> -crypto-obj-y =3D crypto/
> -crypto-aes-obj-y =3D crypto/
> -
>   #####################################################################=
##
>   # qom-obj-y is code used by both qemu system emulation and qemu-img
>  =20
> diff --git a/Makefile.target b/Makefile.target
> index ae02495951..ce02924ffb 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -179,8 +179,6 @@ dummy :=3D $(call unnest-vars,.., \
>                  block-obj-y \
>                  block-obj-m \
>                  chardev-obj-y \
> -               crypto-obj-y \
> -               crypto-aes-obj-y \
>                  qom-obj-y \
>                  io-obj-y \
>                  common-obj-y \
> @@ -189,8 +187,6 @@ all-obj-y +=3D $(common-obj-y)
>   all-obj-y +=3D $(qom-obj-y)
>   all-obj-$(CONFIG_SOFTMMU) +=3D $(authz-obj-y)
>   all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
> -all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
> -all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
>   all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
>  =20
>   ifdef CONFIG_SOFTMMU
> diff --git a/configure b/configure
> index daadfe9ad4..0099e85a03 100755
> --- a/configure
> +++ b/configure
> @@ -2792,8 +2792,7 @@ if test "$gnutls" !=3D "no"; then
>           # At least ubuntu 18.04 ships only shared libraries.
>           write_c_skeleton
>           if compile_prog "" "$gnutls_libs" ; then
> -            libs_softmmu=3D"$gnutls_libs $libs_softmmu"
> -            libs_tools=3D"$gnutls_libs $libs_tools"
> +            LIBS=3D"$gnutls_libs $LIBS"
>               QEMU_CFLAGS=3D"$QEMU_CFLAGS $gnutls_cflags"
>               pass=3D"yes"
>           fi
> @@ -2860,8 +2859,7 @@ if test "$nettle" !=3D "no"; then
>           nettle_cflags=3D$($pkg_config --cflags nettle)
>           nettle_libs=3D$($pkg_config --libs nettle)
>           nettle_version=3D$($pkg_config --modversion nettle)
> -        libs_softmmu=3D"$nettle_libs $libs_softmmu"
> -        libs_tools=3D"$nettle_libs $libs_tools"
> +        LIBS=3D"$nettle_libs $LIBS"
>           QEMU_CFLAGS=3D"$QEMU_CFLAGS $nettle_cflags"
>           nettle=3D"yes"
>  =20
> @@ -2888,8 +2886,7 @@ if test "$gcrypt" !=3D "no"; then
>           then
>               gcrypt_libs=3D"$gcrypt_libs -lgpg-error"
>           fi
> -        libs_softmmu=3D"$gcrypt_libs $libs_softmmu"
> -        libs_tools=3D"$gcrypt_libs $libs_tools"
> +        LIBS=3D"$gcrypt_libs $LIBS"
>           QEMU_CFLAGS=3D"$QEMU_CFLAGS $gcrypt_cflags"
>           gcrypt=3D"yes"
>  =20
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 256c9aca1f..a291bc5b9a 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -34,8 +34,5 @@ crypto-obj-y +=3D xts.o
>   crypto-obj-y +=3D block.o
>   crypto-obj-y +=3D block-qcow.o
>   crypto-obj-y +=3D block-luks.o
> -
> -# Let the userspace emulators avoid linking gnutls/etc
> -crypto-aes-obj-y =3D aes.o
> -
> +crypto-obj-y +=3D aes.o
>   stub-obj-y +=3D pbkdf-stub.o
>=20


