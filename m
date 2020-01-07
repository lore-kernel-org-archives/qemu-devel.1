Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79544C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C7D2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9iIBXtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C7D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ion5g-00019M-Ql
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iolxy-0007P0-6W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iolxw-0002Ue-OQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:20:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23165
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iolxw-0002Tm-KY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578392400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+Yr2/bXyN9lnwWcWTxM2v8w0rpDwaWiPcSxQZOpx0M=;
 b=g9iIBXtZxvJOg+2tNZ1wEWPYFW171BcXervS+FJzKxVXVFIRkFnMW9zbrOJzbs4ljMnrIE
 MjZ6oCYkcsOKl08XIVE5imPNI0P8LMBxTc5b48emEYLvm8ti4VhTnL6GUa3CloG3/OdwGF
 frJax+VNYij4C3SFcK6y6XNzA+ZKAvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-sMBC5PaqO16ZAREDaxnhxQ-1; Tue, 07 Jan 2020 05:19:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31B4F801E6C;
 Tue,  7 Jan 2020 10:19:58 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-126.ams2.redhat.com
 [10.36.117.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB1D77C34A;
 Tue,  7 Jan 2020 10:19:54 +0000 (UTC)
Subject: Re: [PATCH 3/3] gitlab-ci-edk2.yml: Use ccache
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200106184601.25453-1-philmd@redhat.com>
 <20200106184601.25453-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b70f81d0-596d-d867-b722-f9e7aab0e935@redhat.com>
Date: Tue, 7 Jan 2020 11:19:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200106184601.25453-4-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sMBC5PaqO16ZAREDaxnhxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/06/20 19:46, Philippe Mathieu-Daud=C3=A9 wrote:
> By using ccache we reduce the job duration from
> 40 minutes 26 seconds to 32 minutes 6 seconds.
>=20
>   Running after script...
>   $ ccache --show-stats
>   cache hit (direct)                  6604
>   files in cache                     12090
>   cache size                         335.5 MB
>=20
> For now downloading this cache takes 16 seconds, archiving
> it 44 seconds.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .gitlab-ci-edk2.yml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
> index abfaf52874..329ba24f20 100644
> --- a/.gitlab-ci-edk2.yml
> +++ b/.gitlab-ci-edk2.yml
> @@ -14,12 +14,19 @@ build-edk2:
>     - edk2-stdout.log
>     - edk2-stderr.log
>   image: ubuntu:16.04 # Use Ubuntu Xenial
> + variables:
> +   CCACHE_DIR: ${CI_PROJECT_DIR}/.ccache
> + cache: # Use the same cache for all EDK2 jobs
> +   key: ubuntu16.04-edk2-ccache
> +   paths:
> +   - ${CCACHE_DIR}
>   before_script: # Install packages requiered to build EDK2
>   - apt-get update --quiet --quiet
>   - DEBIAN_FRONTEND=3Dnoninteractive
>     apt-get install --assume-yes --no-install-recommends --quiet --quiet
>       build-essential
>       ca-certificates
> +     ccache
>       dos2unix
>       gcc-aarch64-linux-gnu
>       gcc-arm-linux-gnueabi
> @@ -29,9 +36,13 @@ build-edk2:
>       nasm
>       python
>       uuid-dev
> + - export PATH=3D/usr/lib/ccache:$PATH
> + - ccache --zero-stats
>   script: # Clone the required submodules and build EDK2
>   - git submodule update --init roms/edk2
>   - git -C roms/edk2 submodule update --init
>   - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
>   - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
>   - make -j${JOBS} -C roms efi 1>edk2-stdout.log 2> >(tee -a edk2-stderr.=
log >&2)
> + after_script:
> + - ccache --show-stats
>=20

I suggest dropping this patch. (In the first place: thank you for making
this a separate patch!)

I'm not a fan of ccache, to be honest. I've seen obscure failures with
it in the past. Also, the edk2 build system is a complicated beast in
itself; let's not compose that with another opaque thing. I'm especially
not fond of caching artifacts between multiple edk2 jobs.

For speeding up my builds, I used to use distcc instead; it worked
better than ccache (using multiple machines in my home). But I abandoned
even that, after a while.

I certainly don't intend to nack this patch -- if others really like
(and trust) ccache, they are welcome to ack. I'm just not a fan of it.

Thanks,
Laszlo


