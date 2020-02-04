Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66887C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C70B20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4uyG8N4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C70B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0pu-0004vT-Ae
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz0nU-0001as-8i
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz0nS-0007Dm-Gi
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:11:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz0nS-0007Ci-Cr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDpB2ppW+BBB0Ii7NtkXQbKKpMQyhNIz+1zyHoo8rRc=;
 b=h4uyG8N47wz1RuMMWYt0n0cLUjIei9UVHsj0WWM6Z9rcmE8rkaYEEwfFTAEiEnjw44ggOI
 5u0Qdg03yxHm/rmJ8UaRqAsqsQMyNAqQRH7GCktCEOdt5dKBFmfgQuk9QV9IlWfNjJYI6j
 yy3gyAMMJR89pv5gF0nrW/G/AioX6MU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-LDapZWXtOF6bxJdgD-RxHw-1; Tue, 04 Feb 2020 11:11:14 -0500
Received: by mail-wm1-f71.google.com with SMTP id y24so1466432wmj.8
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fnIQPhTliso0rVmx+j5E8JyYeUSU4Es5zn7Q//Mu880=;
 b=p6/BImgtKseFKTUtW7tA9Go5aKP1fxnbuugJxG4hy13eNtQI7dNhMBC8qGacUgQttO
 F/IwuCiK7H4M3dT97TsAv+TmuTVe/TRNo7Ht58aKyjfGI0sLdH253to+iTHpvwX3cgx7
 2eDab2Xv9Ojr7p5jppoNFY4t297RbVxqx9Nr6uizIP/1RwAXf7jepSGBLtLKSsR5cwdt
 CUrDh3L/CyKg/XnnT2DRCLix17SRSjzkwt6mvfVhkjSkXaV/71E/y4EkI0ouk1PYcdoe
 d/7vWsTCwotMFTyg5vtfLOdjnldLLl498sTTB8FMkVF1gqKOMXc/Ukpn6pbhUadSAEjB
 9Xlw==
X-Gm-Message-State: APjAAAVtHPTy5pF9Nq/toVVm5OdglQ5YCJclqYnnLCiEoNrOyBbfnMVI
 ilXXwOaPG87uFs0i3E0K8FcutywhKUrW0LIEYnjzRydPZAHrXy3NOyB2bMiDd2swk4gWSfEUpkR
 EG45GcsiG0LQyvCs=
X-Received: by 2002:adf:a746:: with SMTP id e6mr22841253wrd.329.1580832673189; 
 Tue, 04 Feb 2020 08:11:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWB1anHXSyvamZx01dtS5aA8aRBQu6eINnrioed+BiIEx/ue+gmuzWnHubohXGi3zpFRdOEg==
X-Received: by 2002:adf:a746:: with SMTP id e6mr22841241wrd.329.1580832672965; 
 Tue, 04 Feb 2020 08:11:12 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id 133sm5130187wmd.5.2020.02.04.08.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:11:12 -0800 (PST)
Subject: Re: [PATCH] scripts/signrom: remove Python 2 support, add shebang
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200204160028.16211-1-pbonzini@redhat.com>
 <a1940860-ff53-ee17-bb28-bfae85bc4b98@redhat.com>
 <ca7a1e44-8a8f-2e45-e6c3-37541648231d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d18ae5a-031e-0ffc-01eb-befe0926e216@redhat.com>
Date: Tue, 4 Feb 2020 17:11:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ca7a1e44-8a8f-2e45-e6c3-37541648231d@redhat.com>
Content-Language: en-US
X-MC-Unique: LDapZWXtOF6bxJdgD-RxHw-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 5:07 PM, Paolo Bonzini wrote:
> On 04/02/20 17:02, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 2/4/20 5:00 PM, Paolo Bonzini wrote:
>>> Based-on: <20200130163232.10446-1-philmd@redhat.com>
>>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  =C2=A0 scripts/signrom.py | 12 ++++--------
>>>  =C2=A0 1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/scripts/signrom.py b/scripts/signrom.py
>>> index 313ee28a17..9be5dab1cf 100644
>>> --- a/scripts/signrom.py
>>> +++ b/scripts/signrom.py
>>> @@ -1,3 +1,5 @@
>>> +#!/usr/bin/env python3
>>> +
>>>  =C2=A0 from __future__ import print_function
>>>  =C2=A0 #
>>>  =C2=A0 # Option ROM signing utility
>>> @@ -44,14 +46,8 @@ fout.write(data)
>>>  =C2=A0 =C2=A0 checksum =3D 0
>>>  =C2=A0 for b in data:
>>> -=C2=A0=C2=A0=C2=A0 # catch Python 2 vs. 3 differences
>>> -=C2=A0=C2=A0=C2=A0 if isinstance(b, int):
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum +=3D b
>>> -=C2=A0=C2=A0=C2=A0 else:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum +=3D ord(b)
>>> -checksum =3D (256 - checksum) % 256
>>> -
>>> -# Python 3 no longer allows chr(checksum)
>>> +=C2=A0=C2=A0=C2=A0 checksum =3D (checksum - b) & 255
>>> +
>>>  =C2=A0 fout.write(struct.pack('B', checksum))
>>>  =C2=A0 =C2=A0 fin.close()
>>>
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> Also, applied to my python-next tree:
>> https://gitlab.com/philmd/qemu/commits/python-next
>=20
> Oh, good.  So I've unqueued your series on which this is based.

Aargh I received your "series queued" mail _after_ this patch.

As you prefer, but I have various python patches pending already.
If I keep "Explicit usage of Python 3" do you mind Acking it?

Thanks!

Phil.


