Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE12206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUb36d+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE12206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJjL-0005n2-T0
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixJig-0005OC-Le
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixJif-0004Dc-EO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:59:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixJif-0004Bq-Ap
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580428772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tsg9KCjj4vgqWriG8dS4lCgBD6Q8LWbjHvl71MnCYfQ=;
 b=fUb36d+rDkAhVWFun7Y5XKyGjiq0w7i7PaNvIIpUWMW3n5Ghb6b+RwiOrFGG5yqqe4HuBZ
 TIA8vi4zAjODVC7Ijl1WQ8BkUR56v6FV1nZVZMe/CQsyQ/GrL1CO+ke1wmYEv7LxC21e3P
 y0lWk80KmfkbjFWRE8O8r4bQ7GY6xtI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-tblfiezYMz-pvsZYp1tYPA-1; Thu, 30 Jan 2020 18:59:17 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so2966108wmi.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=udvqNyiVKcnM0KfBscocux2BMChJzC3Jx544aR/7Qi4=;
 b=C2Db41rd1okx0x+N4qyBHiOHbCr4MQCrxXrCW2L6xyswjOZtlE9FYkygDIhVIS9B8V
 pQmFN47ei1+KU5aeUtP9H72GJtYijuddQT/PT01cDOeyMSkD9xy6rzs0Io00pWGjbb+J
 wvktLAidlZYgwG0znMyaksP57n1+aYpk+zJm47LXFu78GRrIu4CA+53jfrBDn/HGMR+B
 WqPj78SWvEgiTbuMccpbIDDbiXrR/SjjpUrho6CtesIkHxzWM2mUTLVae/f2D9+UnQxw
 qXA++8uGzYjxUXZD1inuFHunPVML3R/5XvC96FwBz61zaER4MPom82beVEkrNVK3w4iA
 g6gw==
X-Gm-Message-State: APjAAAVOeiaEx+Q0t1IlqRIINKJ9gPaTrANwayUJb6kMKgO1L81nXJhg
 NpWTpoA01tyLRwHbd3plRVHgGYQjh3WZJyUsYNYNTVA1SLgKHxU9md1Dq7NctEpSrjlRXX7nWDG
 t2n/1kGO1iWUPcLc=
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr8387071wme.21.1580428756274; 
 Thu, 30 Jan 2020 15:59:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4cri5I5rTizWNeh04Ve1a3EjY1iojMPc+BEjNoH6sP+5k9a9EbdwhARmeRujKiNR+CrTMwg==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr8387041wme.21.1580428756050; 
 Thu, 30 Jan 2020 15:59:16 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id h8sm9734349wrx.63.2020.01.30.15.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 15:59:15 -0800 (PST)
Subject: Re: [PATCH 5/6] tests/boot_linux_console: add extract_from_rpm method
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-6-git-send-email-liam.merwick@oracle.com>
 <20200130120506.mq6tejv5i2k776k5@steredhat>
 <f60513b8-b974-a46b-f829-993e45a0cff9@oracle.com>
 <d6bed079-9e79-5e64-f7e2-76499f24454c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <682e74ce-32ef-e472-833c-855cd1d626dd@redhat.com>
Date: Fri, 31 Jan 2020 00:59:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d6bed079-9e79-5e64-f7e2-76499f24454c@redhat.com>
Content-Language: en-US
X-MC-Unique: tblfiezYMz-pvsZYp1tYPA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: fam@euphon.net, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 8:19 PM, Wainer dos Santos Moschetta wrote:
> On 1/30/20 1:34 PM, Liam Merwick wrote:
>> On 30/01/2020 12:05, Stefano Garzarella wrote:
>>> On Mon, Jan 27, 2020 at 04:36:33PM +0000, Liam Merwick wrote:
>>>> Add a method to extract a specified file from an RPM to the test's
>>>> working directory and return the path to the extracted file.
>>>>
>>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>>> ---
>>>> =C2=A0 tests/acceptance/boot_linux_console.py | 14 ++++++++++++++
>>>> =C2=A0 1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>>> b/tests/acceptance/boot_linux_console.py
>>>> index 43bc928b03a2..6af19ae3b14a 100644
>>>> --- a/tests/acceptance/boot_linux_console.py
>>>> +++ b/tests/acceptance/boot_linux_console.py
>>>> @@ -51,6 +51,20 @@ class BootLinuxConsole(Test):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.wor=
kdir + path
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 def extract_from_rpm(self, rpm, path):
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Extracts a file from a rpm=
 package into the test workdir
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param rpm: path to the rp=
m archive
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param path: path within t=
he rpm archive of the file to be=20
>>>> extracted
>=20
>=20
> Might not be obvious to users that `path` should start with '.', and if=
=20
> he/she doesn't do that then extract_from_rpm() will silently fail to=20
> extract the file. So could you document that?
>=20
>>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :returns: path of the extr=
acted file
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cwd =3D os.getcwd()
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(self.workdir)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process.run("rpm2cpio %s |=
 cpio -id %s" % (rpm, path),=20
>>>> shell=3DTrue)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.workdir + '/' =
+ path
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Is the extra slash needed? (just because the e=
xtract_from_deb()
>>> =C2=A0=C2=A0=C2=A0=C2=A0 doesn't put it)
>>>
>>
>>
>> Yes, I needed to put it in there because the 'path' passed in for
>> processing by cpio is a relative patch unlike the deb arg so it
>> couldn't be just appended to 'self.workdir' which doesn't end in a '/'.
>=20
>=20
> It is a good practice use the `os.path` module methods when dealing with=
=20
> filesystem paths. So that can be replaced with:
>=20
>  >>> os.path.normpath(os.path.join('/path/to/workdir', './file/in/rpm'))
> '/path/to/workdir/file/in/rpm'

With Wainer suggestion addressed:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Thanks,
>=20
> Wainer
>=20
>=20
>>
>>
>> Regards,
>> Liam
>>
>>
>>> Anyway this patch LGTM:
>>>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>>
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def do_test_x86_64_machine(self):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=
=3Darch:x86_64
>>>> --=20
>>>> 1.8.3.1
>>>>
>>>
>>
>=20


