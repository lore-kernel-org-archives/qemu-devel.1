Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB863C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DADD2339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DADD2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VYU-0008Kx-Rg
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5Uyr-0006My-7I
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5Uyo-0002bO-NH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5Uyo-0002ap-El
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:05:46 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 670A07FDCD
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 13:05:45 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id o5so11881170wrg.15
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 06:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fxBZFrGNxB6UA1dzDCg26b850GRrWGqouDelqdymkN4=;
 b=WofyYML30M54f7pi8spYR08c/hMZkj5z1GCEaWKiYplGNlqN36N1Ynzj5+fWGBKFCH
 Nw8CoHZ2nqSIrfaCO05E88xUNhPEqrd/OxOc5xrvb3Up4u5YB8piFKcWi+FM1o88UVgt
 w/Avhx2H7SCiIHVDUV12zeP2zJAB/Z/EIisxqjBygdtF2H+2qDe7bJdW3YXTQWNMenMV
 IxO+JPaQ54dKIl2exU//UrzT6Mtqxbb4S1HL237OaRfGcBUykETgPx+DAOBHOG/vQTGe
 D4awptyza8eVg8p2k4p2mY8qHqgeKXFlgEnL5fft9y3cwRZRTrxezwb7TORfa+/hhppF
 sWzg==
X-Gm-Message-State: APjAAAXEE01x0dzwHS3gloqfDpt8bRrI1W2jJVgXGX97sJNmu7bucGze
 wVFVzTSoHN/xI7+bqdCLfLZA7cD/4mQFYvhNBTBYmzcJrYsn2mdd3Lwb/L7KsIaXlYF89qYNedB
 pVGC9XnzQCId7KXE=
X-Received: by 2002:a1c:7dd1:: with SMTP id y200mr4146834wmc.59.1567602344063; 
 Wed, 04 Sep 2019 06:05:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyA8ss0IErpKbG1zPmt8l962PKBbZ/GZnMo4JoeutSjp3iiPKM+J2CEqb+cFh5g1/5TWSGnGQ==
X-Received: by 2002:a1c:7dd1:: with SMTP id y200mr4146816wmc.59.1567602343758; 
 Wed, 04 Sep 2019 06:05:43 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id g3sm28202091wrh.28.2019.09.04.06.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2019 06:05:43 -0700 (PDT)
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904005218.12536-1-crosa@redhat.com>
 <4fab585b-3fc0-9add-534e-0f477370b074@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2e1719a3-014a-70c4-5219-5c9a4ddc9a61@redhat.com>
Date: Wed, 4 Sep 2019 15:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4fab585b-3fc0-9add-534e-0f477370b074@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 2:36 PM, Wainer dos Santos Moschetta wrote:
> Hi Cleber,
>=20
> On 09/03/2019 09:52 PM, Cleber Rosa wrote:
>> The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
>> from tests/acceptance/linux_initrd.py, is currently failing to fetch
>> the "vmlinuz" file.=C2=A0 The reason for the failure is that the Fedor=
a
>> project retires older versions from the "dl.fedoraproject.org" URL,
>> and keeps them in "archives.fedoraproject.org".=C2=A0 As an added note=
,
>> that test uses a Fedora 28 image, because of the specific Linux kernel
>> version requirements of the test.
>>
>> For the sake of stability, let's use URLs from the archived and
>> supposedely ever stable URLs.=C2=A0 The good news is that the currentl=
y
>> supported versions are also hosted on the later.=C2=A0 This change lim=
its
>> itself to change the URLs, while keeping the fetched files the same
>> (as can be evidenced by the unchanged hashes).
>>
>> Documentation and the "vm tests" fedora definition were also updated.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 qemu-doc.texi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
>> =C2=A0 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++----=
------
>> =C2=A0 tests/acceptance/linux_initrd.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 +++--
>> =C2=A0 tests/vm/fedora=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 4 files changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index 577d1e8376..37795f86fb 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -440,15 +440,15 @@ of <protocol>.
>> =C2=A0 =C2=A0 Example: boot from a remote Fedora 20 live ISO image
>> =C2=A0 @example
>> -qemu-system-x86_64 --drive
>> media=3Dcdrom,file=3Dhttp://dl.fedoraproject.org/pub/fedora/linux/rele=
ases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
>>
>> +qemu-system-x86_64 --drive
>> media=3Dcdrom,file=3Dhttps://archives.fedoraproject.org/pub/archive/fe=
dora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,re=
adonly
>>
>> =C2=A0 -qemu-system-x86_64 --drive
>> media=3Dcdrom,file.driver=3Dhttp,file.url=3Dhttp://dl.fedoraproject.or=
g/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-=
1.iso,readonly
>>
>> +qemu-system-x86_64 --drive
>> media=3Dcdrom,file.driver=3Dhttp,file.url=3Dhttp://archives.fedoraproj=
ect.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desk=
top-x86_64-20-1.iso,readonly
>>
>> =C2=A0 @end example
>> =C2=A0 =C2=A0 Example: boot from a remote Fedora 20 cloud image using =
a local
>> overlay for
>> =C2=A0 writes, copy-on-read, and a readahead of 64k
>> =C2=A0 @example
>> -qemu-img create -f qcow2 -o
>> backing_file=3D'json:@{"file.driver":"http",,
>> "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/=
Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",,
>> "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
>> +qemu-img create -f qcow2 -o
>> backing_file=3D'json:@{"file.driver":"http",,
>> "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux=
/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",,
>> "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
>> =C2=A0 =C2=A0 qemu-system-x86_64 -drive
>> file=3D/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=3Don
>> =C2=A0 @end example
>> diff --git a/tests/acceptance/boot_linux_console.py
>> b/tests/acceptance/boot_linux_console.py
>> index 2504ef0150..8a9a314ab4 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -76,8 +76,9 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
arch:x86_64
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
machine:pc
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://download.fedoraproject.org/pub/fedora/linux/'
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 'releases/29/Everything/x86_64/os/images/pxeboot/vmlinuz')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '/vmlinuz')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_hash =3D=
 '23bebd2680757891cf7adedb033532163a792495'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D=
 self.fetch_asset(kernel_url,
>> asset_hash=3Dkernel_hash)
>> =C2=A0 @@ -250,8 +251,9 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
arch:aarch64
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
machine:virt
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://download.fedoraproject.org/pub/fedora/linux/'
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '/vmlinuz')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_hash =3D=
 '8c73e469fc6ea06a58dc83a628fc695b693b8493'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D=
 self.fetch_asset(kernel_url,
>> asset_hash=3Dkernel_hash)
>> =C2=A0 @@ -271,8 +273,9 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
arch:arm
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
machine:virt
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://download.fedoraproject.org/pub/fedora/linux/'
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 'releases/29/Everything/armhfp/os/images/pxeboot/vmlinuz')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> '/linux/releases/29/Everything/armhfp/os/images/pxeboot'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '/vmlinuz')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_hash =3D=
 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D=
 self.fetch_asset(kernel_url,
>> asset_hash=3Dkernel_hash)
>> =C2=A0 @@ -318,8 +321,9 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
arch:s390x
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
machine:s390_ccw_virtio
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://download.fedoraproject.org/pub/fedora-secondary/'
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 'releases/29/Everything/s390x/os/images/kernel.img')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D ('https://a=
rchives.fedoraproject.org/pub/archive'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> '/fedora-secondary/releases/29/Everything/s390x/os/images'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '/kernel.img')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_hash =3D=
 'e8e8439103ef8053418ef062644ffd46a7919313'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D=
 self.fetch_asset(kernel_url,
>> asset_hash=3Dkernel_hash)
>> =C2=A0 @@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
arch:ppc64
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
machine:pseries
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://download.fedoraproject.org/pub/fedora-secondary/'
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D ('https://a=
rchives.fedoraproject.org/pub/archive'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> '/fedora-secondary/releases/29/Everything/ppc64le/os'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '/ppc/ppc64/vml=
inuz')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_hash =3D=
 '3fe04abfc852b66653b8c3c897a59a689270bc77'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D=
 self.fetch_asset(kernel_url,
>> asset_hash=3Dkernel_hash)
>> =C2=A0 diff --git a/tests/acceptance/linux_initrd.py
>> b/tests/acceptance/linux_initrd.py
>> index 23be5a63aa..c61d9826a4 100644
>> --- a/tests/acceptance/linux_initrd.py
>> +++ b/tests/acceptance/linux_initrd.py
>> @@ -54,8 +54,9 @@ class LinuxInitrd(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU has suppor=
ted up to 4 GiB initrd for recent kernel
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Expect guest ca=
n reach 'Unpacking initramfs...'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D ('https://m=
irrors.kernel.org/fedora/releases/28/'
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'Everything/x86=
_64/os/images/pxeboot/vmlinuz')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> '/linux/releases/28/Everything/x86_64/os/images/pxeboot/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vmlinuz')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_hash =3D=
 '238e083e114c48200f80d889f7e32eeb2793e02a'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D=
 self.fetch_asset(kernel_url,
>> asset_hash=3Dkernel_hash)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_size =3D 2 =
* (1024 ** 3) + 1
>> diff --git a/tests/vm/fedora b/tests/vm/fedora
>> index e8fa5bf0d2..7fec1479fb 100755
>> --- a/tests/vm/fedora
>> +++ b/tests/vm/fedora
>> @@ -23,7 +23,7 @@ class FedoraVM(basevm.BaseVM):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D "fedora"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch =3D "x86_64"
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 base =3D "http://dl.fedoraproject.org/pub/f=
edora/linux/releases/30/"
>> +=C2=A0=C2=A0=C2=A0 base =3D
>> "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/=
30/"
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link =3D base +
>> "Server/x86_64/iso/Fedora-Server-netinst-x86_64-30-1.2.iso"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repo =3D base + "Server/x86_64/os/"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 full =3D base + "Everything/x86_64/os/"
>=20
> Currently it has just a few test cases that boot a Linux kernel. At thi=
s
> point maintain the urls to fetch the files across a few source file is
> manageable but it can get complex as it increases in number of tests.
> While ago I started to work on the introduction of a "kernel provider"
> mechanism to replace this "fetch a kernel" boilerplate. Unfortunately I
> didn't time to complete its implementation, now If you think it is
> valuable then I can manage to resume the work. Find the draft
> implementation here:
> https://github.com/wainersm/qemu/tree/acceptance_boot_linux

I remember and liked it, maybe you should start with a post asking the
community if the effort is worthwhile and would be useful, and what
combinations (distrib{name/version} kernel{version} arch
profile{debug,lpae,...} ...) are expected.

>=20
> An alternate approach would be to extend Avocado by mimic the
> avocado.utils.vmimage module [1], but rather have kernel providers.
>=20
> [1]
> https://avocado-framework.readthedocs.io/en/71.0/api/utils/avocado.util=
s.html#module-avocado.utils.vmimage
>=20
>=20
> Anyway, the changes proposed on this patch looks good to me.
>=20
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Ditto:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

