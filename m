Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F59C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D153620658
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex3enpEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D153620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixFAr-0006wH-1z
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 14:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixF9q-00062v-0C
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixF9o-0007VE-Fo
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:07:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixF9o-0007TT-Bx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580411235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=NuQYUlfRgGXZ62g96H9J5ms0SDX9rM4hNIqw3XaX3hk=;
 b=ex3enpEcWXsVK5J+/vQFKScBqk93OJ3MQX0M3TM3DeaHGSOQSdGuoZPP71Iq9Li5K321Xi
 gxauoc1Uo8agYAjpYz9PMOiLjXAEMGMhRG/0f9vmqrF+6V8VoOSTcyNBIBRnORIh4yA4Tq
 mIL1pPk0pQbDwuDubp3csAjWGaddsHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-hZChD8PpPti-FVXAMN9t3w-1; Thu, 30 Jan 2020 14:07:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E99DB20;
 Thu, 30 Jan 2020 19:07:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-117.ams2.redhat.com [10.36.117.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9945148;
 Thu, 30 Jan 2020 19:06:51 +0000 (UTC)
Subject: Re: [PATCH v2 08/12] .travis.yml: Add description to each job
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-9-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <79ebc114-fb94-7dee-b57c-b3df7be038bf@redhat.com>
Date: Thu, 30 Jan 2020 20:06:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130113223.31046-9-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hZChD8PpPti-FVXAMN9t3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/2020 12.32, Alex Benn=C3=A9e wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> The NAME variable can be used to describe nicely a job (see [*]).
> As we currently have 32 jobs, use it. This helps for quickly
> finding a particular job.
>=20
>   before: https://travis-ci.org/qemu/qemu/builds/639887646
>   after: https://travis-ci.org/philmd/qemu/builds/641795043
>=20
> [*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-wi=
thin-matrices
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <20200125183135.28317-1-f4bug@amsat.org>
>=20
> ---
> [ajb]
>   - drop [x86]
> ---
>  .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 34 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 7526967847..056db1adac 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -96,24 +96,28 @@ after_script:
> =20
>  matrix:
>    include:
> -    - env:
> +    - name: "GCC static (user)"
> +      env:
>          - CONFIG=3D"--disable-system --static"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> =20
> =20
>      # we split the system builds as it takes a while to build them all
> -    - env:
> +    - name: "GCC (main-softmmu)"
> +      env:
>          - CONFIG=3D"--disable-user --target-list=3D${MAIN_SOFTMMU_TARGET=
S}"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> =20
> =20
> -    - env:
> -        - CONFIG=3D"--disable-user --target-list-exclude=3D${MAIN_SOFTMM=
U_TARGETS}"
> +    - name: "GCC (other-softmmu)"
> +      env:
> +       - CONFIG=3D"--disable-user --target-list-exclude=3D${MAIN_SOFTMMU=
_TARGETS}"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> =20
> =20
>      # Just build tools and run minimal unit and softfloat checks
> -    - env:
> +    - name: "GCC check-softfloat (user)"
> +      env:
>          - BASE_CONFIG=3D"--enable-tools"
>          - CONFIG=3D"--disable-user --disable-system"
>          - TEST_CMD=3D"make check-unit check-softfloat -j3"
> @@ -121,41 +125,48 @@ matrix:
> =20
> =20
>      # --enable-debug implies --enable-debug-tcg, also runs quite a bit s=
lower
> -    - env:
> +    - name: "GCC debug (main-softmmu)"
> +      env:
>          - CONFIG=3D"--enable-debug --target-list=3D${MAIN_SOFTMMU_TARGET=
S}"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug"
> =20
> =20
>      # TCG debug can be run just on its own and is mostly agnostic to use=
r/softmmu distinctions
> -    - env:
> +    - name: "GCC debug (user)"
> +      env:
>          - CONFIG=3D"--enable-debug-tcg --disable-system"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> =20
> =20
> -    - env:
> +    - name: "GCC some libs disabled (main-softmmu)"
> +      env:
>          - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr =
--disable-brlapi --disable-libusb --disable-replication --target-list=3D${M=
AIN_SOFTMMU_TARGETS}"
> =20
> =20
>      # Module builds are mostly of interest to major distros
> -    - env:
> +    - name: "GCC modules (main-softmmu)"
> +      env:
>          - CONFIG=3D"--enable-modules --target-list=3D${MAIN_SOFTMMU_TARG=
ETS}"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> =20
> =20
>      # Alternate coroutines implementations are only really of interest t=
o KVM users
>      # However we can't test against KVM on Travis so we can only run uni=
t tests
> -    - env:
> +    - name: "check-unit coroutine=3Ducontext"
> +      env:
>          - CONFIG=3D"--with-coroutine=3Ducontext --disable-tcg"
>          - TEST_CMD=3D"make check-unit -j3 V=3D1"
> =20
> =20
> -    - env:
> +    - name: "check-unit coroutine=3Dsigaltstack"
> +      env:
>          - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-tcg"
>          - TEST_CMD=3D"make check-unit -j3 V=3D1"
> =20
> =20
>      # Check we can build docs and tools (out of tree)
> -    - env:
> +    - name: "[x86] tools and docs"

Could you please also drop this "[x86]" here?

 Thanks,
  Thomas


