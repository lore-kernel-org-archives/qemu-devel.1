Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075AC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEADD20678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBagUF5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEADD20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomZD-0005rF-UV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iolMx-00055c-Pe
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iolMw-0002QL-D6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:41:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33852
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iolMw-0002Pu-9I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578390105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFPXBN/1uuYladgUMQcjVL2NCUO5aw8OYL069tuw8z0=;
 b=RBagUF5LZb4jknc7Sojh8UdZgOqdvwQfYcMGdBx4rfRdU4w/lHNZSC91lnL0hc6Kxj6FVP
 83ZxftzuAXHVQux52ncR3yCtMbGQfdAau6DM2YJ3+WMfM/UKzejxizqvL05K7//BK4cYLX
 RiyNpDbRk04ddZFuYzn6KHOMYal+P2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-3DmucBHWOGy3pf0uFtTtbQ-1; Tue, 07 Jan 2020 04:41:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B60A800D41;
 Tue,  7 Jan 2020 09:41:43 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-126.ams2.redhat.com
 [10.36.117.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA26260BEC;
 Tue,  7 Jan 2020 09:41:37 +0000 (UTC)
Subject: Re: [PATCH 1/3] roms/edk2-funcs: Force softfloat ARM toolchain prefix
 on Debian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200106184601.25453-1-philmd@redhat.com>
 <20200106184601.25453-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6698fcbb-3fd2-45c1-309f-4e6bed14406a@redhat.com>
Date: Tue, 7 Jan 2020 10:41:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200106184601.25453-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3DmucBHWOGy3pf0uFtTtbQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/06/20 19:45, Philippe Mathieu-Daud=C3=A9 wrote:
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
> For various reasons documented in [2], the EDK2 project suggests
> to use the softfloat toolchain (named 'armel' by Debian).
>=20
> Force the softfloat cross toolchain prefix on Debian distributions.
>=20
> [1] https://www.debian.org/ports/arm/#status
> [2] https://github.com/tianocore/edk2/commit/41203b9a
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: fixed s/hard/float/ typo (Laszlo)

s/float/soft/, but OK otherwise :)

Thanks
Laszlo

> ---
>  roms/edk2-funcs.sh | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
> index 3f4485b201..cd6e4f2c82 100644
> --- a/roms/edk2-funcs.sh
> +++ b/roms/edk2-funcs.sh
> @@ -112,6 +112,9 @@ qemu_edk2_get_cross_prefix()
>       ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] ); =
then
>      # no cross-compiler needed
>      :
> +  elif ( [ -e /etc/debian_version ] && [ "$gcc_arch" =3D=3D arm ] ); the=
n
> +    # force soft-float cross-compiler on Debian
> +    printf 'arm-linux-gnueabi-'
>    else
>      printf '%s-linux-gnu-\n' "$gcc_arch"
>    fi
>=20


