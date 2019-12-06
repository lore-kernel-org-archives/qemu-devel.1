Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE3C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 00:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1343D2245C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 00:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvJzuuG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1343D2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id1N8-0000Oy-5o
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 19:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1id1LJ-0007jf-0D
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 19:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1id1LG-0003r2-2q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 19:19:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1id1LF-0003oQ-Sz
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 19:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575591569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cgvyMvvjLPQRwQE9kcHLKhPOO1SWPRDcun2dpOsJPj4=;
 b=BvJzuuG4sU8PnyDyPise/EQMGOdOIsCFKFxEYQvH8BUPxmI8fVyN1PocIvveVCP2sI7xQP
 f53hTTlCUG1SIUMhDX5VjuyoVDEaqH30BY+p+JMMMCywjUecR9rkNyHlJrHYBEQruqDb4M
 +iLHOwKHneOLxIhrtxZVn+1NMl0txnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-CjA0JuYjOlSqHUckAqWPyQ-1; Thu, 05 Dec 2019 19:19:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CFCA1005513;
 Fri,  6 Dec 2019 00:19:26 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AE5860F88;
 Fri,  6 Dec 2019 00:19:23 +0000 (UTC)
Subject: Re: [PATCH-for-5.0 v2] roms/edk2-funcs: Force softfloat ARM toolchain
 prefix on Debian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191205190006.19352-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8df56910-6a2b-ccab-0d45-d5c64a56f3e1@redhat.com>
Date: Fri, 6 Dec 2019 01:19:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191205190006.19352-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CjA0JuYjOlSqHUckAqWPyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/19 20:00, Philippe Mathieu-Daud=C3=A9 wrote:
> The Debian (based) distributions currently provides 2 ARM
> toolchains, documented as [1]:
>=20
> * The ARM EABI (armel) port targets a range of older 32-bit ARM
>   devices, particularly those used in NAS hardware and a variety
>   of *plug computers.
> * The newer ARM hard-float (armhf) port supports newer, more
>   powerful 32-bit devices using version 7 of the ARM architecture
>   specification.
>=20
> For various reasons documented in [2], the EDK2 project recommend
> to use the softfloat toolchain (named 'armel' by Debian).
>=20
> Force the softfloat cross toolchain prefix on Debian distributions.
>=20
> [1] https://www.debian.org/ports/arm/#status
> [2] https://github.com/tianocore/edk2/commit/41203b9a

Ah cool, this answers my earlier question -- "the GCCx toolchain targets
can use either when building for ARM".

Still not sure if this is a "recommendation" for using soft-float, but
if it works, I'm OK with it.

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  roms/edk2-funcs.sh | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
> index 3f4485b201..abd6bbe1fd 100644
> --- a/roms/edk2-funcs.sh
> +++ b/roms/edk2-funcs.sh
> @@ -112,6 +112,9 @@ qemu_edk2_get_cross_prefix()
>       ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] ); =
then
>      # no cross-compiler needed
>      :
> +  elif ( [ -e /etc/debian_version ] && [ "$gcc_arch" =3D=3D arm ] ); the=
n
> +    # force hard-float cross-compiler on Debian

The comment has not been updated; it still says hard-float.

With the comment updated:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo

> +    printf 'arm-linux-gnueabi-'
>    else
>      printf '%s-linux-gnu-\n' "$gcc_arch"
>    fi
>=20


