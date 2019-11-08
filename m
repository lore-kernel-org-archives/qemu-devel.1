Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAB3FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43722207FA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43722207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52879 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2vF-0005MN-Fy
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT2uL-000483-AT
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT2uK-0002KA-3s
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:58:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT2uJ-0002IS-R3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:58:28 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6478A81F18
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 11:58:26 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id y3so3036112wrm.12
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 03:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lDtcoNA1YcT/e930WhhoooBJnhMqdakwlIvwoyvGyf4=;
 b=dfHsEKuCgNNtSrr7DNwCkGmE/tdL07Zyp/n8l0/pIRtEuZIxc/lkP6Un9TyU+uWYwd
 qTE1JrJnwnqWvv/8MSFCTLihkVFBtUq+x6GvQ/IUYLJvdo90p72UcODCLVLGtXXEmZCD
 eKHY2wTh1ME7W6cRyjBFGFa7Hk4QafQ+k9ig/h43WzlvF2OqEIwUWvGVFvDdopYscH9t
 YwImmjhkfqUgpY0xfkP61r39X6YIurWi+cSXOAgCT+0F9XGBVoYI9UqiP2uzNc8HgP+i
 VjOZyflSlfuflnPyPk3x1VFLgNpual4Lc+FNRXrp0Fy0rqqZNKY0Wnm/c2PrfQVCwNdw
 bVeg==
X-Gm-Message-State: APjAAAVrPWqYNX+BvKnJ9VQlRqJQM515NuwqwKtO8KMwwgy4t0bQkqDm
 i2Abjp1gM9eu6G5MRWpCkq+2KuR5itHs5qPNZSzyjlgoUD/kC7iHWyEdJ6uY/g/PuW8RqWI/0SM
 +Su70JAc7449NlXQ=
X-Received: by 2002:a5d:5586:: with SMTP id i6mr7821486wrv.81.1573214305134;
 Fri, 08 Nov 2019 03:58:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxu60k3M8WiCj+qcPI/SYkIPeRvALpvUWWa0AWVcQogHC3KEFEHQ/T1bMEtSd4k1qBMpCpCA==
X-Received: by 2002:a5d:5586:: with SMTP id i6mr7821468wrv.81.1573214304878;
 Fri, 08 Nov 2019 03:58:24 -0800 (PST)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id l2sm6274980wrt.15.2019.11.08.03.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 03:58:24 -0800 (PST)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
 <b6005d59-c5d2-1844-db94-a67e258c2867@redhat.com>
 <d0cf0f78-a0c9-e0fa-7959-ecdebf27f912@redhat.com>
 <f688cac2-d370-23af-27fd-fa1f3c3637f9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55f259eb-aaf9-75ce-5346-9d33f8d2464f@redhat.com>
Date: Fri, 8 Nov 2019 12:58:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f688cac2-d370-23af-27fd-fa1f3c3637f9@redhat.com>
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
Cc: qemu-trivial@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 12:39 PM, Laszlo Ersek wrote:
> On 11/08/19 11:42, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 11/8/19 11:34 AM, Thomas Huth wrote:
>>> On 08/11/2019 11.28, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> The bzip2 tool is not included in default installations.
>>>> On freshly installed systems, ./configure succeeds but 'make'
>>>> might fail later:
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 BUNZIP2 pc-bios/edk2-i386-secure-code.fd.b=
z2
>>>>  =C2=A0=C2=A0 /bin/sh: bzip2: command not found
>>>>  =C2=A0=C2=A0 make: *** [Makefile:305: pc-bios/edk2-i386-secure-code=
.fd] Error 127
>>>>  =C2=A0=C2=A0 make: *** Deleting file 'pc-bios/edk2-i386-secure-code=
.fd'
>>>>  =C2=A0=C2=A0 make: *** Waiting for unfinished jobs....
>>>>
>>>> Add a check in ./configure to warn the user if bzip2 is missing.
>>>>
>>>> Fixes: 536d2173b2b
>>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>  =C2=A0 configure | 7 +++++++
>>>>  =C2=A0 1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/configure b/configure
>>>> index efe165edf9..9957e913e8 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -1851,6 +1851,13 @@ python_version=3D$($python -c 'import sys;
>>>> print("%d.%d.%d" % (sys.version_info[0]
>>>>  =C2=A0 # Suppress writing compiled files
>>>>  =C2=A0 python=3D"$python -B"
>>>> +# Some firmware binaries are compressed with bzip2
>>>> +if has bzip2; then
>>>> +=C2=A0 :
>>>> +else
>>>> +=C2=A0 error_exit "bzip2 program not found. Please install it"
>>>> +fi
>>>
>>> It's only required for the edk2 binaries, isn't it? So should this
>>> maybe also check whether we build any of the i386-softmmu,
>>> x86_64-softmmu arm-softmmu or aarch64-softmmu targets and pass otherw=
ise?
>>
>> I have this on my TODO somewhere, because we extract the edk2 firmware=
s
>> even if we only build MIPS/PowerPC.
>=20
> But that applies to all of "BLOBS" in the root-level Makefile, doesn't
> it? We also install, say, "vgabios-qxl.bin", when only the MIPS/PowerPC
> system emulators are built. The only aspect that's specific to edk2
> binaries is that they are kept compressed until installation time, to
> save space in the git repo and in the source tarball.

You are right, other targets could improve this too.
Since this add quite complexity to the buildsys and nobody complained=20
about that previously, I suggest we clean that *after* we switch the=20
build machinery to Meson.

> I'm reminded of the "external QEMU blob / firmware repo" idea.

Do you mind starting a new thread asking about it? It would be nice we=20
clear this during the next dev cycle.

Regards,

Phil.

