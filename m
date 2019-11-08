Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE9FC6194
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B538F21D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B538F21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2rg-0001V6-Sk
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT2qb-0000hA-Ch
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT2qZ-0006Uf-O4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:54:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT2qZ-0006Rl-Fn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:54:35 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8790DC05A1C0
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 11:54:33 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l3so3037660wrx.21
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 03:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qoHHFp27QCoKJi7zxBFxqvdlONyTQg5hMym7LWiqpDQ=;
 b=JPMFmzYU92viQixNVKz6aNs4cP6afVsoazsagaV5Op5m2UFKvDb6kMINmi2u7RZ0x4
 fXIZEX0EHYm/G8EAsB+FG1NKQHNFH+Qn0eOBXdAwLmxV/F6ahQw4ESPz3BDqw3B0ra42
 oZWGtk6p+M39MkuZVuKqaxbtT7SbhF3TEmZZSqQuk7m57ewiAD+0Clx6ociIIeKa0+v6
 ru74tl7GfOzgtaRdccUDBAjr3fvUV0hFxAr//cUIrGdCjopJX4fCb9Qphdw3dox/xTKP
 vWXsgdsOLiNHkG3IPfm6/+fF+p3xuRPo9DLuM+IAPpwF+IRgGITVOnmVxSJmIlB3RhVn
 hYGw==
X-Gm-Message-State: APjAAAUGk7tA6GOYPvKDliLoDzkyYxl1/fYoTnuCs4WtvJc6DkfNlJWN
 ChENx6X/0MHApFDMlCnVFAGcz88Uxwcena/NH+DZ7CEMe2ooQh6QntpdGePTDlso/oS2qhcXfDi
 MzjI+Qy/FKvmsSK0=
X-Received: by 2002:a1c:2048:: with SMTP id g69mr7886694wmg.121.1573214072219; 
 Fri, 08 Nov 2019 03:54:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYunfdxdfO/zwmLhRHWU/6O4QaZy2+AcNIE3dwd8WtU6LeCXG+1D+TeD6s/Zm5VTJmz8pzFQ==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr7886677wmg.121.1573214071952; 
 Fri, 08 Nov 2019 03:54:31 -0800 (PST)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id j15sm6746784wrt.78.2019.11.08.03.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 03:54:31 -0800 (PST)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
 <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7bfff1ec-927e-fb75-645f-7b0bb0ffd916@redhat.com>
Date: Fri, 8 Nov 2019 12:54:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 12:01 PM, Laszlo Ersek wrote:
> On 11/08/19 11:28, Philippe Mathieu-Daud=C3=A9 wrote:
>> The bzip2 tool is not included in default installations.
>> On freshly installed systems, ./configure succeeds but 'make'
>> might fail later:
>>
>>      BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>>    /bin/sh: bzip2: command not found
>>    make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 12=
7
>>    make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>>    make: *** Waiting for unfinished jobs....
>>
>> Add a check in ./configure to warn the user if bzip2 is missing.
>=20
> We've come full circle. Let me explain:
>=20
>>
>> Fixes: 536d2173b2b
>=20
> So this makes me kinda grumpy. If you look at the v3 posting of the pat=
ch that would later become commit 536d2173b2b:
>=20
>    http://mid.mail-archive.com/20190321113408.19929-8-lersek@redhat.com
>=20
> you see the following note in the changelog:
>=20
>      - compress FD files with bzip2 rather than xz, so that decompressi=
on at
>        "make install" time succeed on older build OSes too [Peter]
>=20
> So I couldn't use xz because that was "too new" for some build OSes, bu=
t now we also can't take bzip2 for granted because that's "too old" for s=
ome other build OSes? This is ridiculous.
>=20
> To be clear, my disagreement is only with the "Fixes" tag. For me, "Fix=
es" stands for something that, in retrospect, can be proven to have been =
a bug at the time the code was *originally* committed. But, at the time, =
taking "bzip2" for granted was *not* a bug. The conditions / circumstance=
s have changed more recently, and the assumption about bzip2 has been inv=
alidated *after* adding a dependency on bzip2.
>=20
> Nonetheless, thank you for adapting the code to the potential absence o=
f bzip2. Can you perhaps go in some details in the commit message, near "=
not included in default installations" and "freshly installed systems"? I=
f we can, we should identify the exact distro release where this problem =
has been encountered (and I wouldn't mind a link to the BZ or ticket unde=
r which people agreed to remove bzip2 from the default package set).

I am just reading this and already sent a v2.

I can amend these details. Thomas, what distro release were you using?

>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>=20
> Thanks
> Laszlo
>=20
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   configure | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/configure b/configure
>> index efe165edf9..9957e913e8 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1851,6 +1851,13 @@ python_version=3D$($python -c 'import sys; prin=
t("%d.%d.%d" % (sys.version_info[0]
>>   # Suppress writing compiled files
>>   python=3D"$python -B"
>>  =20
>> +# Some firmware binaries are compressed with bzip2
>> +if has bzip2; then
>> +  :
>> +else
>> +  error_exit "bzip2 program not found. Please install it"
>> +fi
>> +
>>   # Check that the C compiler works. Doing this here before testing
>>   # the host CPU ensures that we had a valid CC to autodetect the
>>   # $cpu var (and we should bail right here if that's not the case).
>>
>=20

