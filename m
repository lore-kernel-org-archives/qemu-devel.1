Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F2C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F252173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F252173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP2I4-0006rD-0D
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:58:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hP2HH-0006WD-MA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hP2HG-0003pw-H7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hP2HG-0003pK-9i
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:57:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CE423082137;
	Fri, 10 May 2019 09:57:17 +0000 (UTC)
Received: from [10.40.205.9] (unknown [10.40.205.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C79635D962;
	Fri, 10 May 2019 09:57:16 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190510012458.22706-1-richard.henderson@linaro.org>
	<20190510012458.22706-3-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <0aa9a93d-ae2c-d993-c241-bbbee82f2d15@redhat.com>
Date: Fri, 10 May 2019 11:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190510012458.22706-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 10 May 2019 09:57:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 02/24] crypto: Merge crypto-obj-y into
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

On 10/05/2019 03:24, Richard Henderson wrote:
> We will shortly need this in the user-only binaries, so drop the split
> into system and tools binaries.  This also means that crypto-aes-obj-y
> can be merged back into crypto-obj-y.
>=20
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
> index a971247cac..7c9c208207 100644
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
> =20

There is a remaining crypto-aes-obj you should remove:

$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
         $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))

except that:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Thanks,
Laurent

