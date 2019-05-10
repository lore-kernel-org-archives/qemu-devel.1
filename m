Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E679C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EE0216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EE0216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP1LB-0003FT-6v
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 04:57:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP1K0-0002SU-Rz
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP1Jz-0001k4-Je
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:56:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hP1Jz-0001jo-EB
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:56:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A9993079B82;
	Fri, 10 May 2019 08:56:02 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DFE7646BA;
	Fri, 10 May 2019 08:56:01 +0000 (UTC)
Date: Fri, 10 May 2019 09:55:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190510085558.GE7671@redhat.com>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
	<20190510012458.22706-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510012458.22706-3-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 10 May 2019 08:56:02 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 06:24:36PM -0700, Richard Henderson wrote:
> We will shortly need this in the user-only binaries, so drop the split
> into system and tools binaries.  This also means that crypto-aes-obj-y
> can be merged back into crypto-obj-y.
>=20
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile             | 12 +++++-------
>  Makefile.objs        |  8 ++------
>  Makefile.target      |  4 ----
>  configure            |  9 +++------
>  crypto/Makefile.objs |  5 +----
>  5 files changed, 11 insertions(+), 27 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index a971247cac..7c9c208207 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -410,7 +410,6 @@ dummy :=3D $(call unnest-vars,, \
>                  block-obj-y \
>                  block-obj-m \
>                  crypto-obj-y \
> -                crypto-aes-obj-y \
>                  qom-obj-y \
>                  io-obj-y \
>                  common-obj-y \
> @@ -446,7 +445,6 @@ SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_=
RULES))
> =20
>  $(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
> -$(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
>  $(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
> @@ -502,7 +500,7 @@ Makefile: $(version-obj-y)
>  ######################################################################
>  # Build libraries
> =20
> -libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
> +libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y) $(crypto-obj=
-y)

The main reason for a separate crypto-obj-y variable was that it was only
built into some pieces of QEMU. Since we're building into libqemuutil.a
now, we might as well just add all the crypto object files directly
to the util-obj-y variable & drop crypto-obj-y entirely.

That said, what you've done here is fine, so don't feel this comment
is mandatory. Its just an idea for a cleanup if you need to repost
again for another reason.


Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

