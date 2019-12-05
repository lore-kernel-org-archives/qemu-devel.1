Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE587C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7903A24659
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmS6m3Po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7903A24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icxbw-0000my-89
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 15:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1icxFH-0007xd-CM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1icxFE-00022t-TL
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:57:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1icxFE-0001zi-MW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575575818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rakeQeoYRJ/SUbgWpGcOrkqCokXjCMxMzBjlySJ1scI=;
 b=BmS6m3PozNvXmplm87+KgyOAelWsMyvxwXjg5iEUOjvwDzLjQruL7DeBfG7QtQN8TFqq84
 1o4oKH/WtUhvg0rjB82TRMejGEV5MjJEp3svyAdHRoos1lZ/iGP3+HpaZYFRzaaNbyZ/OL
 q31kwyGHpaP7e5u/SeUISQ+UN+IUehY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-0Ym2bVskNWqnIww1kfUhXg-1; Thu, 05 Dec 2019 14:56:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69755183B700;
 Thu,  5 Dec 2019 19:56:56 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1AEF5D6A3;
 Thu,  5 Dec 2019 19:56:52 +0000 (UTC)
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs: Force armhf toolchain prefix on
 Debian
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191205180913.15263-1-philmd@redhat.com>
 <CAKv+Gu_DqSD9K3Ajsj0q2yQ_AT=pjfhSitn2t-irYXoW662jOg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <80925eef-1081-4c5d-49e9-b4d25970efac@redhat.com>
Date: Thu, 5 Dec 2019 20:56:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_DqSD9K3Ajsj0q2yQ_AT=pjfhSitn2t-irYXoW662jOg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0Ym2bVskNWqnIww1kfUhXg-1
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/19 19:17, Ard Biesheuvel wrote:
> On Thu, 5 Dec 2019 at 18:09, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>
>> The Debian (based) distributions historically provides 2 ARM
>> toolchains, documented as [1]:
>>
>> * The ARM EABI (armel) port targets a range of older 32-bit ARM
>>   devices, particularly those used in NAS hardware and a variety
>>   of *plug computers.
>> * The newer ARM hard-float (armhf) port supports newer, more
>>   powerful 32-bit devices using version 7 of the ARM architecture
>>   specification.
>>
>> The EDK2 documentation suggests to use the hard-float toolchain.
>>
>=20
> We should probably fix that.

OK, I'm confused. What case are we talking about?

(1) Without this patch, "roms/edk2-funcs.sh" fails to select *any* cross
compiler on Debian, and the build just croaks.

--> insist on armhf in this script?
--> insist on armel in this script?
--> pick whichever is available, because either works?

(2) Without this patch, "roms/edk2-funcs.sh" selects the "armel" flavor,
and it fails to build edk2.

--> insist on armhf in this script?

(3) Without this patch, "roms/edk2-funcs.sh" selects the "armel" flavor,
and it builds edk2 just fine -- but that's not the flavor that the edk2
documentation suggests.

--> drop this patch, and fix the edk2 docs?

Thanks,
Laszlo

> tools_def.template mentions
> arm-linux-gnueabi, and while it does not really matter in most cases,
> if you are using Clang, you actually need the armel binutils (see
> 41203b9ab5d48e029f24e17e9a865e54b7e1643d for details)
>=20
>=20
>> Force the armhf cross toolchain prefix on Debian distributions.
>>
>> [1] https://www.debian.org/ports/arm/#status
>> [2] https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if=
-cross-compiling
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  roms/edk2-funcs.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
>> index 3f4485b201..a546aa1d11 100644
>> --- a/roms/edk2-funcs.sh
>> +++ b/roms/edk2-funcs.sh
>> @@ -112,6 +112,9 @@ qemu_edk2_get_cross_prefix()
>>       ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] );=
 then
>>      # no cross-compiler needed
>>      :
>> +  elif ( [ -e /etc/debian_version ] && [ "$gcc_arch" =3D=3D arm ] ); th=
en
>> +    # force hard-float cross-compiler on Debian
>> +    printf 'arm-linux-gnueabihf-'
>>    else
>>      printf '%s-linux-gnu-\n' "$gcc_arch"
>>    fi
>> --
>> 2.21.0
>>
>=20


