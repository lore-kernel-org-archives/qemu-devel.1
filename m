Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80999FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551BA206BA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551BA206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7lP-0000p1-QM
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT7jR-00073c-Ub
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:07:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT7jQ-0001Xh-1S
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:07:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT7jP-0001XE-Ok
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:07:31 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7003DC057E7B
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 17:07:30 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 199so3408997wmb.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 09:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xw/FtypxzJMBjKUiU55I6eUnrTKhLd2CUCx7XUb7MNA=;
 b=h4Yw7yht1/e5w10CQI2++aFOGD9+eOVK0gJ5+3/22DDypijPVDCHU1m0K7LDSEDM/p
 eflM12EcQ2GT5zyVlACWLfenqQZeCXDMPTCzciHehQWjtbnRvpztDWq2giSb8OxdKrxr
 UxHzQYBwapP3nLTsCydRO5pOkiwQSvn71Dw2AzWZ7LD2VFqnnaDKW0r5GNa8ki7LTtCb
 GF/+FMayxXJVTcjHbJ5FOm6jC5+OM6WnQ+A5DWjCMiOal+10bKCk+GleBDucGLAsAGgV
 CwHxgum3lXGGxYhrDb+4wlz+xa/SnYVE1MzKqJk2rlHeJVT/b1BoFnE5ZTwK6ZOW35N/
 EC0g==
X-Gm-Message-State: APjAAAXV8AbmQg1hdNeFMUiF1RS1Volq5+PF5ubzdrellyZxafBF5Fvx
 1lQq/t6bCecVtHo4Q06FZRcTwzd7mW1itctBD73OWZgmOWAfc4J6KTbY2zLYZ/1gj+Ozm3JMr1k
 OWpw5q2TBT5pkX1g=
X-Received: by 2002:adf:aa92:: with SMTP id h18mr6993814wrc.150.1573232849196; 
 Fri, 08 Nov 2019 09:07:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyF5qqaQewT8ccdYkPJJBVUqsZA2qZotzxd6Mfo31ZFMujH5abXTKW/A88sv0MGqY1NNcS5uQ==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr6993770wrc.150.1573232848885; 
 Fri, 08 Nov 2019 09:07:28 -0800 (PST)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id m3sm6298292wrw.20.2019.11.08.09.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 09:07:28 -0800 (PST)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
 <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
 <00cca0a5-7a51-f2d1-5120-821c335954b8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51f9b2d9-b196-c30e-dc67-988e29b5df47@redhat.com>
Date: Fri, 8 Nov 2019 18:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <00cca0a5-7a51-f2d1-5120-821c335954b8@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 4:43 PM, Eric Blake wrote:
> On 11/8/19 5:01 AM, Laszlo Ersek wrote:
>=20
>>>
>>> Add a check in ./configure to warn the user if bzip2 is missing.
>>
>> We've come full circle. Let me explain:
>>
>>>
>>> Fixes: 536d2173b2b
>>
>> So this makes me kinda grumpy. If you look at the v3 posting of the=20
>> patch that would later become commit 536d2173b2b:
>>
>> =C2=A0=C2=A0 http://mid.mail-archive.com/20190321113408.19929-8-lersek=
@redhat.com
>>
>> you see the following note in the changelog:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 - compress FD files with bzip2 rather than xz=
, so that=20
>> decompression at
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "make install" time succeed on ol=
der build OSes too [Peter]
>>
>> So I couldn't use xz because that was "too new" for some build OSes,=20
>> but now we also can't take bzip2 for granted because that's "too old"=20
>> for some other build OSes? This is ridiculous.
>>
>> To be clear, my disagreement is only with the "Fixes" tag. For me,=20
>> "Fixes" stands for something that, in retrospect, can be proven to=20
>> have been a bug at the time the code was *originally* committed. But,=20
>> at the time, taking "bzip2" for granted was *not* a bug. The=20
>> conditions / circumstances have changed more recently, and the=20
>> assumption about bzip2 has been invalidated *after* adding a=20
>> dependency on bzip2.
>>
>> Nonetheless, thank you for adapting the code to the potential absence=20
>> of bzip2. Can you perhaps go in some details in the commit message,=20
>> near "not included in default installations" and "freshly installed=20
>> systems"? If we can, we should identify the exact distro release where=
=20
>> this problem has been encountered (and I wouldn't mind a link to the=20
>> BZ or ticket under which people agreed to remove bzip2 from the=20
>> default package set).
>=20
> bzip2 is no longer a favored compression.=C2=A0 If we are trying to pic=
k a=20
> compression that is most likely to be present on any system, go with=20
> gzip.=C2=A0 If we are trying to pick a compression that packs tighter a=
nd=20
> uncompresses faster, pick xz or zstd.=C2=A0 But bzip2 does neither: it =
packs=20
> slightly tighter than gzip but has slower performance in doing so, and=20
> thus is no longer used as a default compression.

The problem was with OpenBSD 6.1 which hadn't xz available.

In commit 12745eaa02 Gerd updated the VM to OpenBSD 6.5 and we now have=20
access to xz. IIRC OSX supported versions also provide xz.

If we want to revert Laszlo's patches and apply his first version (using=20
xz), we should do that during 5.0 dev cycle, now it is too late.
I'd prefer we simply fix bzip2 for the next release.

