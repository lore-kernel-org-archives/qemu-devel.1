Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCEDC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111182064B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoG2Cgy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111182064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id648-0006zY-7I
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 00:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1id63M-0006a3-JA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1id63L-0001Am-4h
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:21:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31227
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1id63K-000188-U7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575609678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jT90sBLlV2LhZf44WIZ1ypJkEpF+FPUSUN90SftE4vQ=;
 b=JoG2Cgy/T3OWsWIEDTV/hYzJOFnPanWqTWMIkbfHQ9NrXZqHBXsZGdXXqgdofEH4a3SR0c
 9atKwVBYprhxBeE3Jvc7YT0pmVBhCOs73nbPjA7EZDjqsp42YXgtZidx+gvjTC8x27/a1P
 IcCM7n+9Eemq1tL4lROrdvn97or9/J4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-ILu2GK8OMOSmLEaXwVcwrA-1; Fri, 06 Dec 2019 00:21:16 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so2622056wrp.8
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 21:21:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LhEW5Yas0ftAkK5B8QiiUCRaCujGHE6Q4ZuDr19H8HI=;
 b=n92RKTFNineDxXrE2zbxfzS4j+p/QPQG/Zj+i/YDGkfAxVCzEDRVkVrr56xD+HK7Fl
 0wOa+r4yXSw4cis/ikdG8rPGmi1PlkpyYTjUkmMPbDAp+SOlzK3ZFOQIwIh/BttVzp4O
 cBYYQXBNE8ZF4jVqSfJX+mmqxH3M8CuI7RPO+FsxNXwwUlNmL3usKw+4EuSvqQ7kFyvc
 sJFskS15hdSljwjkYRkI0DI/ZcHZRqcmAln8FgmBT9D9GKCEKsPwJujRJrBCVAO31cfv
 IVZ0hY2ZAQa8eDKWcckUJ8K1aSEMQaN1/a/Hmh3qYOWSAq94/sHtnC7QnQQp6shxXAPE
 3bNQ==
X-Gm-Message-State: APjAAAWjovySwuI0b0u5CeQomqnSUgHmIUuazl8DShJ+dhuXxPreqlxq
 Z7o8g+r/EprBbtLFexieWPp4RaLityo8hvzq6vfOd0wwG3NL1x7F/l/yI12VmQqhRlBwOMWV7DS
 fgNBg31vjvwMqlCE=
X-Received: by 2002:a7b:c956:: with SMTP id i22mr8386008wml.65.1575609675720; 
 Thu, 05 Dec 2019 21:21:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPFmankEv03Xb8V+5ZY+KieYP1HwsuIate+lX+AAwBIiCnnU5UBb60wNEmtAgYfmSlP0beuQ==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr8385996wml.65.1575609675479; 
 Thu, 05 Dec 2019 21:21:15 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id w17sm15228427wrt.89.2019.12.05.21.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 21:21:14 -0800 (PST)
Subject: Re: [PATCH-for-5.0 v2] roms/edk2-funcs: Force softfloat ARM toolchain
 prefix on Debian
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20191205190006.19352-1-philmd@redhat.com>
 <8df56910-6a2b-ccab-0d45-d5c64a56f3e1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c31c6b70-918f-ded4-4338-796c7f7e8607@redhat.com>
Date: Fri, 6 Dec 2019 06:21:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8df56910-6a2b-ccab-0d45-d5c64a56f3e1@redhat.com>
Content-Language: en-US
X-MC-Unique: ILu2GK8OMOSmLEaXwVcwrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 1:19 AM, Laszlo Ersek wrote:
> On 12/05/19 20:00, Philippe Mathieu-Daud=C3=A9 wrote:
>> The Debian (based) distributions currently provides 2 ARM
>> toolchains, documented as [1]:
>>
>> * The ARM EABI (armel) port targets a range of older 32-bit ARM
>>    devices, particularly those used in NAS hardware and a variety
>>    of *plug computers.
>> * The newer ARM hard-float (armhf) port supports newer, more
>>    powerful 32-bit devices using version 7 of the ARM architecture
>>    specification.
>>
>> For various reasons documented in [2], the EDK2 project recommend
>> to use the softfloat toolchain (named 'armel' by Debian).
>>
>> Force the softfloat cross toolchain prefix on Debian distributions.
>>
>> [1] https://www.debian.org/ports/arm/#status
>> [2] https://github.com/tianocore/edk2/commit/41203b9a
>=20
> Ah cool, this answers my earlier question -- "the GCCx toolchain targets
> can use either when building for ARM".
>=20
> Still not sure if this is a "recommendation" for using soft-float, but
> if it works, I'm OK with it.

I'll use "suggests" instead.

>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   roms/edk2-funcs.sh | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
>> index 3f4485b201..abd6bbe1fd 100644
>> --- a/roms/edk2-funcs.sh
>> +++ b/roms/edk2-funcs.sh
>> @@ -112,6 +112,9 @@ qemu_edk2_get_cross_prefix()
>>        ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] )=
; then
>>       # no cross-compiler needed
>>       :
>> +  elif ( [ -e /etc/debian_version ] && [ "$gcc_arch" =3D=3D arm ] ); th=
en
>> +    # force hard-float cross-compiler on Debian
>=20
> The comment has not been updated; it still says hard-float.

Oops.

> With the comment updated:
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!

>=20
> Thanks,
> Laszlo
>=20
>> +    printf 'arm-linux-gnueabi-'
>>     else
>>       printf '%s-linux-gnu-\n' "$gcc_arch"
>>     fi
>>
>=20


