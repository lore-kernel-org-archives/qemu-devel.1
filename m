Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD3DC3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB19206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zx4SAKXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB19206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9HVs-0001yK-TL
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 19:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9HVB-0001Rb-Vg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9HV9-0008Lg-Rk
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:03:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25296
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9HV9-0008Kd-ME
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583280183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=frTeHMxlvCSSD01b51VFkfTvwqmEtFDucsKun+RWOzc=;
 b=Zx4SAKXMamkKWFKKe2H3H5wa2OAHrvPAKIVFek6FRbpspw0vy0uwztfJNQZwh9bA3k5esk
 LmZOF2oX11GZnep+QC9W0CrR9eNc+tK5qDJDzA+6NxTGbjm4SUZUKx8XZaW0Oa1nXZk/Dt
 scduP0nTzo0wqa808ZCeSa2dqjbbOiA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-rAu1JWOuOxyGcpBoqVjdMg-1; Tue, 03 Mar 2020 19:03:01 -0500
X-MC-Unique: rAu1JWOuOxyGcpBoqVjdMg-1
Received: by mail-wr1-f70.google.com with SMTP id w18so110729wro.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 16:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZIxGtezaTcPNx26Prou2EXapdT1+MmTPoDRU8/l73Jw=;
 b=XTFK7GtPZ7K2tnB+jclNUwbDtJICX/MvZn6aQZGkNbYx7ew9rk3cAXj91+bi+vbYzq
 nheQyXmwiwSgBdmoQ2bzAx+6pwbQnFpOOMuie7J0+wTcAqHzUC+o5Bbg675BUD7osCHp
 zdAZlSOcNR+khRe16XyZYEEbZzEHly0r7gIb1eQC4Vjw6ZH6bjb2wKRucXAuYRHrOioG
 9tNmu6pxbd7pP2hS+BvnzxsLUa9JWVM521pqXIuGqEJp5KP696OUYvWPKR3DVkEmtWjb
 +w2GeEXK6XSx32C/WH5RIsKNO4Qdv/MrqsX0InW0SBU7qIT2MqNKvsEswFWk0cVgU6Jr
 XEyA==
X-Gm-Message-State: ANhLgQ2VBacbjxGBknVmtFOz5ABjg7fuRiBJ68rww6nWsQ3XFCYnFlJC
 Tp0w3uieeCXg0fJwH0q0MNAiOfEDTgzY7uVAI7KPTqsqlht8qoCEsBvBhImOvYVucjawsVjKmE7
 WeV3996wH4EiyEKw=
X-Received: by 2002:adf:ce06:: with SMTP id p6mr497808wrn.134.1583280180142;
 Tue, 03 Mar 2020 16:03:00 -0800 (PST)
X-Google-Smtp-Source: ADFU+vukZj4/QTWH+v5NcT/Nm1AfayGxMKDp9Q0e0spfDaSaTfE3rDcCYOyEzqWYvbhp6py7LWCk6g==
X-Received: by 2002:adf:ce06:: with SMTP id p6mr497791wrn.134.1583280179902;
 Tue, 03 Mar 2020 16:02:59 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b10sm1114971wmh.48.2020.03.03.16.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 16:02:59 -0800 (PST)
Subject: Re: [PATCH v6 7/9] iotests: ignore import warnings from pylint
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-8-jsnow@redhat.com>
 <02d688f5-2104-ff45-e174-c61b1c25d7cb@redhat.com>
 <590ac875-bf9d-afbc-e029-f66050d33344@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <76a0567c-9f96-7b55-8a25-ee0933d796a0@redhat.com>
Date: Wed, 4 Mar 2020 01:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <590ac875-bf9d-afbc-e029-f66050d33344@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 8:57 PM, John Snow wrote:
> On 2/27/20 9:14 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 2/27/20 1:06 AM, John Snow wrote:
>>> The right way to solve this is to come up with a virtual environment
>>> infrastructure that sets all the paths correctly, and/or to create
>>> installable python modules that can be imported normally.
>>>
>>> That's hard, so just silence this error for now.
>>
>> I'm tempted to NAck this and require an "installable python module"...
>>
>> Let's discuss why it is that hard!
>>
>=20
> I've been tricked into this before. It's not work I am interested in
> doing right now; it's WAY beyond the scope of what I am doing here.
>=20
> It involves properly factoring all of our python code, deciding which
> portions are meant to be installed separately from QEMU itself, coming
> up with a versioning scheme, packaging code, and moving code around in
> many places.
>=20
> Then it involves coming up with tooling and infrastructure for creating
> virtual environments, installing the right packages to it, and using it
> to run our python tests.
>=20
> No, that's way too invasive. I'm not doing it and I will scream loudly
> if you make me.
>=20
> A less invasive hack involves setting the python import path in a
> consolidated spot so that python knows where it can import from. This
> works, but might break the ability to run such tests as one-offs without
> executing the environment setup.
>=20
> Again, not work I care to do right now and so I won't. The benefit of
> these patches is to provide some minimum viable CI CQA for Python where
> we had none before, NOT fix every possible Python problem in one shot.

OK I guess we misunderstood each other :)

I didn't understood your comment as personal to you for this patch, but=20
generic. It makes sense it is not your priority and it is obvious this=20
task will take a single developer a lot of time resources. I am=20
certainly NOT asking you to do it.

My question was rather community-oriented.
(Cc'ing Eduardo because we talked about this after the last KVM forum).

>=20
> --js
>=20
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  =C2=A0 tests/qemu-iotests/iotests.py | 1 +
>>>  =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/qemu-iotests/iotests.py
>>> b/tests/qemu-iotests/iotests.py
>>> index 60c4c7f736..214f59995e 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -30,6 +30,7 @@
>>>  =C2=A0 from collections import OrderedDict
>>>  =C2=A0 from typing import Collection
>>>  =C2=A0 +# pylint: disable=3Dimport-error, wrong-import-position
>>>  =C2=A0 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '=
..',
>>> 'python'))
>>>  =C2=A0 from qemu import qtest
>>>  =20
>>
>=20


