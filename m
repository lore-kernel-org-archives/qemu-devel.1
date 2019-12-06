Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E7C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BF524676
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfwUBfAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BF524676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id62W-0005zI-43
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 00:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1id61M-0005WL-BT
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1id61K-00054A-OQ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:19:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1id61K-00051W-FC
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575609553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QNgOFpbcNv61Y1H/o6VhIBgwCP97ZnIMR7iVKUf5Zo=;
 b=dfwUBfAlUH0SbLuKggZ4VdsPBHVaC5I0LavL8m4FjpYy6R90AJlzLEDK72AFM2/X+ITNTY
 h56Jqn0nreBlbtz+U7d1IuyyVdXD+pT9XvHVEI8cqLWk+wsdXU1Lti/P7xeUGufn7SCxc0
 Uq58oHQBwNxUMgTfVSozky+Dyd/bhHE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-S7bz1fbjOV2Mz7nzsaZRuw-1; Fri, 06 Dec 2019 00:19:12 -0500
Received: by mail-wr1-f70.google.com with SMTP id u18so2615180wrn.11
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 21:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=goDu9dwW+SX9BaMr2YndXULUc0FIthtqpYfR44cnNMU=;
 b=Y0cbkNSlt+0rOIouLYWAy1KnHHLa0adlk188OFoKmaQm5b1ngUNCWOQ9j1x75Cmc8f
 dasWdnfXWdSnrojMOz+TM1UDddpA8uSdFyRefXTWcktkon65+ZhE6TjkkKK+H3BTnqNh
 tB6x6+6c6B3oYWVr2ZFwozwsE0rGCSPp6O5j7cGvJKX5Qh/dmE0ugTQn08qmJ8M5ML2X
 x3WfHuxTtkFG+zdMsa6vHGpbUnsWSj/msLQtiX5ssKeA4zbbJAe0OdruDxHxJSIrNq5O
 HOW/PAyO7HNvbFN+5pF4thtRfwMjVSM77W31Lynd8EPJVXeGJRQSts9BfQSYrO7ZsUlE
 eGWQ==
X-Gm-Message-State: APjAAAUD5NadFDZn7s1jgGnfGMT9jxuen4Z11Lvk2rny6rQkz6yWNFAt
 ZKToMfLn3MAl5df/tedu/9JoAp9E/CaHWmqjtlHpr7B/G/JnacfnH9Fa44D5iB7uocYNtpmI11l
 N2xBbKwmAgxw5XAk=
X-Received: by 2002:a5d:6284:: with SMTP id k4mr13313784wru.398.1575609551134; 
 Thu, 05 Dec 2019 21:19:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqw18LWPZtQY47CtQbAAxUtErLVQLs9Nuk3uctgYi0qdWhovEuapTKh59+2YcXueTU9SIsTWTg==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr13313767wru.398.1575609550926; 
 Thu, 05 Dec 2019 21:19:10 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id u14sm14498125wrm.51.2019.12.05.21.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 21:19:10 -0800 (PST)
Subject: Re: [PATCH-for-4.2? 0/1] roms/edk2: update submodule to
 edk2-stable201911, fixing low severity CVEs
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, Dann Frazier <dannf@debian.org>
References: <20191129104457.1991-1-philmd@redhat.com>
 <9e052d2b-50c9-9370-a279-002987375f89@redhat.com>
 <CAP+75-W4hi7oU636CN9f8d1aqrasxBYywwY7gvcVVSh36jnpOw@mail.gmail.com>
Message-ID: <ac771e22-72ef-fb40-c1a0-9cb1f76ab351@redhat.com>
Date: Fri, 6 Dec 2019 06:19:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAP+75-W4hi7oU636CN9f8d1aqrasxBYywwY7gvcVVSh36jnpOw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: S7bz1fbjOV2Mz7nzsaZRuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Serge Hallyn <serge.hallyn@ubuntu.com>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Steve Langasek <vorlon@debian.org>,
 Bruce Rogers <brogers@suse.com>,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/29/19 1:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On Fri, Nov 29, 2019 at 1:10 PM Laszlo Ersek <lersek@redhat.com> wrote:
>> On 11/29/19 11:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>> I had this commit ready for when the next EDK2 release were go out,
>>> which just happened: https://edk2.groups.io/g/devel/message/51502
>>>
>>> Laszlo doesn't think it's worth the churn to rush to get this update
>>> into into 4.2-rc4: https://bugs.launchpad.net/qemu/+bug/1852196/comment=
s/2
>>>
>>> I agree with Laszlo, users shouldn't use the EDK2 bundled within QEMU
>>> in production, and should rather build it from source. However some
>>> distributions seem to rely on this convenience way to package EDK2,
>>> and few CVEs are fixed in this new release. So it might be worthwhile
>>> to get this into 4.2-rc4. Anyhow distributions don't use QEMU stable
>>> tag directly and backport patches, so if there is no other rc4 patch,
>>> we could skip this for after 4.2, as Laszlo originally planned.

Since I was looking at the Debian packaging, I confirm

1/ Debian builds with -DNETWORK_HTTP_BOOT_ENABLE=3DTRUE=20
-DSECURE_BOOT_ENABLE=3DTRUE:
https://salsa.debian.org/qemu-team/edk2/blob/debian/debian/rules#L32

2/ The CVE fixes were indeed backported:
https://salsa.debian.org/qemu-team/edk2/commit/e6630d57b

>>>
>>> Philippe Mathieu-Daud=C3=A9 (1):
>>>    roms/edk2: update submodule from edk2-stable201905 to
>>>      edk2-stable201911
>>>
>>>   roms/edk2 | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
>> if we want to do this, then the above diffstat is not enough.
>>
>> - please evaluate whether we should do something like 9153b9d7401f
>> ("roms/Makefile.edk2: update input file list for
>> "pc-bios/edk2-licenses.txt"", 2019-06-14)
>>
>> - we need to rebuild the binaries: 3583cb29f28f ("pc-bios: refresh edk2
>> build artifacts for edk2-stable201905", 2019-06-14)
>>
>> - we should update the README file: 541617cad344 ("pc-bios: update the
>> README file with edk2-stable201905 information", 2019-06-14)
>=20
> Oops sorry for missing all these points, I'll do them.
>=20


