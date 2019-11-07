Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88628C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5339021D6C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBfQ+pr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5339021D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjPK-0002Lf-I5
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iSjOh-0001th-6T
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iSjOe-0004LL-Hx
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:08:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iSjOe-0004Km-E9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573139306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtdGNC5y9g+dJXsfznI7cN1F7IVgsCOi8J2YTu9nJcc=;
 b=hBfQ+pr2xUBWUC4BywUDPLGbw+cfbC7B0Q0I3C1HF2Mt8YTIxyKhvQjNAHL5ubB3GVIYJ2
 /Yiw7/9hmg5lXIYJmc5qYcVx4yvdLBarIhBVoi5y9Tc3XjaO0SPix1Blp3TLmhCFpO+ju+
 rJfiSwaLoRQwMHNFTWrAF8kRmWwykB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-0qExMumrMxa6nRfVfAh1Sw-1; Thu, 07 Nov 2019 10:08:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AF851800D6B;
 Thu,  7 Nov 2019 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-91.gru2.redhat.com
 [10.97.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B3461001B3F;
 Thu,  7 Nov 2019 15:08:17 +0000 (UTC)
Subject: Re: [PATCH 2/2] Acceptance test: update kernel for m68k/q800 test
To: qemu-devel@nongnu.org
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
 <20191029232320.12419-3-crosa@redhat.com> <87h83p8n1e.fsf@linaro.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <d9b0f847-642a-cda7-88a6-df986c4b2e63@redhat.com>
Date: Thu, 7 Nov 2019 13:08:16 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87h83p8n1e.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 0qExMumrMxa6nRfVfAh1Sw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Willian Rampazzo <wrampazz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/31/19 3:08 AM, Alex Benn=C3=A9e wrote:
> Cleber Rosa <crosa@redhat.com> writes:
>
>> There's an updated version of the Debian package containing the m68k
>> Kernel.
>>
>> Now, if the package gets updated again, the test won't fail, but will
>> be canceled.  A more permanent solution is certainly needed.
> At least for open source blobs can't we do something similar to the
> firmware and host a blob mirror on our infrastructure as a fallback?

I support that idea. Some of those kernels used on our acceptance tests=20
are moving targets.

- Wainer

>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   tests/acceptance/boot_linux_console.py | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/b=
oot_linux_console.py
>> index c439fd90fc..8f676d8e92 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -385,14 +385,14 @@ class BootLinuxConsole(Test):
>>           :avocado: tags=3Dmachine:q800
>>           """
>>           deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m6=
8k/main'
>> -                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.=
udeb')
>> -        deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
>> +                   '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.=
udeb')
>> +        deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
>>           try:
>>               deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_ha=
sh)
>>           except OSError as exp:
>>               self.cancel(exp)
>>           kernel_path =3D self.extract_from_deb(deb_path,
>> -                                            '/boot/vmlinux-5.2.0-2-m68k=
')
>> +                                            '/boot/vmlinux-5.3.0-1-m68k=
')
>>
>>           self.vm.set_machine('q800')
>>           self.vm.set_console()
>
> --
> Alex Benn=C3=A9e
>


