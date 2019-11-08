Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB50C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B252178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B252178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1jt-0001ny-Bh
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT1j9-0001Et-T9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT1j8-0005WH-Ka
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:42:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT1j8-0005Vz-BM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:42:50 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF7F383F3B
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 10:42:48 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l3so2954088wrx.21
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 02:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bF9XiTb3l7F/4Vr4HJRGCu1lBZTzU09e/cNUwj1ZvhY=;
 b=owKhNvjU2MLxqwFBv6WJSEZg9IaexaY9EcsaJLhX+QnNu4TFcQ2Jzwsfkj206q6O41
 3UMaO+zV56YuTDGiXIfZyIgN4FaNsQZcucP5hB1aJvt8MMCo7AKIIBQ2iTBMO7NTk4Ks
 /eB//MKg8sRKktMe0xAFDUqaf93ylWa0KH/IFuJgrnORSsae0r7zLvuSXqlhUJbKVNBq
 qzBiavOEj3nd8pxvQJZtmefu2hrHt+NZ8bkJ6D89z2Y1mnsxYSeAnVPOLDHrkkG9iv5Q
 NnClv1VCsCAx7n15XTxkOs6oayw5YYaueWRmvM9j+SlGq58slT5dY5v+k0FNO0OzDbB7
 FwsA==
X-Gm-Message-State: APjAAAVTLrTE/mmbgjj9pDWc3dPMRoQXdWoEjFARAXqOke8NkIltj4lm
 J2uQ1reaI7AyF5wE3e9/wbRTy7rm1MMeQrgMlJ7hb2uci3J1MpTkn7JTSJ+TQd9fnrByuWQ7g1C
 pSr0P5+MEmUng4YE=
X-Received: by 2002:a1c:9646:: with SMTP id y67mr7381851wmd.79.1573209767683; 
 Fri, 08 Nov 2019 02:42:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1YVfR/38o6ndI33XJOc9yyAz5auD6RlMMfsP1b4YJa6/oFkUplT7vTvOJ/q9sbVcsdABTmg==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr7381828wmd.79.1573209767466; 
 Fri, 08 Nov 2019 02:42:47 -0800 (PST)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id a11sm5863253wmh.40.2019.11.08.02.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 02:42:46 -0800 (PST)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
 <b6005d59-c5d2-1844-db94-a67e258c2867@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d0cf0f78-a0c9-e0fa-7959-ecdebf27f912@redhat.com>
Date: Fri, 8 Nov 2019 11:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b6005d59-c5d2-1844-db94-a67e258c2867@redhat.com>
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

On 11/8/19 11:34 AM, Thomas Huth wrote:
> On 08/11/2019 11.28, Philippe Mathieu-Daud=C3=A9 wrote:
>> The bzip2 tool is not included in default installations.
>> On freshly installed systems, ./configure succeeds but 'make'
>> might fail later:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>> =C2=A0=C2=A0 /bin/sh: bzip2: command not found
>> =C2=A0=C2=A0 make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd=
] Error 127
>> =C2=A0=C2=A0 make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd=
'
>> =C2=A0=C2=A0 make: *** Waiting for unfinished jobs....
>>
>> Add a check in ./configure to warn the user if bzip2 is missing.
>>
>> Fixes: 536d2173b2b
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> =C2=A0 configure | 7 +++++++
>> =C2=A0 1 file changed, 7 insertions(+)
>>
>> diff --git a/configure b/configure
>> index efe165edf9..9957e913e8 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1851,6 +1851,13 @@ python_version=3D$($python -c 'import sys;=20
>> print("%d.%d.%d" % (sys.version_info[0]
>> =C2=A0 # Suppress writing compiled files
>> =C2=A0 python=3D"$python -B"
>> +# Some firmware binaries are compressed with bzip2
>> +if has bzip2; then
>> +=C2=A0 :
>> +else
>> +=C2=A0 error_exit "bzip2 program not found. Please install it"
>> +fi
>=20
> It's only required for the edk2 binaries, isn't it? So should this mayb=
e=20
> also check whether we build any of the i386-softmmu, x86_64-softmmu=20
> arm-softmmu or aarch64-softmmu targets and pass otherwise?

I have this on my TODO somewhere, because we extract the edk2 firmwares=20
even if we only build MIPS/PowerPC.

