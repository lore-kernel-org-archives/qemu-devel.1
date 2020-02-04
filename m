Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AE5C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A234820730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5ijIHoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A234820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0lc-00073D-Rv
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iz0jW-0003JZ-IS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iz0jV-0005j8-92
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iz0jV-0005hi-5Q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JL0tyFt4JXlZu1RoZGON/MdNKF7juj8keEP/I/M62U=;
 b=A5ijIHoiYAzaS6+sQ9P3JJ8NgSMUY75NGWpSDUfeGY043uQpYEmJhL2R7MlP0vzpFZOK4c
 PwyZ/CvM9DWqdjNWTQYtFUQnT9QGwsKP4jMTlVNFf2BL4d/x9wmeV3n6lmrb/QZ8woWiWk
 iDIY5B9OyjCy6qYU5pMHyaL3MsHpX8o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-SxJ2dYB6MVqIVKk4sXME6g-1; Tue, 04 Feb 2020 11:07:08 -0500
Received: by mail-wr1-f69.google.com with SMTP id 50so9673073wrc.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YT1Yg69Hs7fpMDkHDugwzot+L+qcfOSDB59XGsXgja4=;
 b=rgTj7VOfTAVOrZLHZGMpDPPaX9HcD9SreduOC77L665DXyp6ZfjidZGhmhAL43wnb5
 5PjOmlB0bImGuRukrpEF1Cf6AiOvs/Bfy92wBW5T8dEvwqioXFOmR56NYDCyoPQDuiCJ
 XCAQi9F3lQS/NleL+ZQnxrLHktTztkTbbuTUKrrDPP6TTnlbu91pHI5MdVm8kVLdT01O
 z1No8mu3gfZ8niS1Y8KneA3T98OhRrD1pcH2CJyODGf44k7pQMCAXxVJoWpvvvuuflc1
 vgXhtN+SSNMQtzipPn/F0VxqVqw33WADy6DmT5jHG6ra/Zw5ytdKxmRx5YCSLWLpNly/
 Uigw==
X-Gm-Message-State: APjAAAWGf6PtmY2OD0J8gounfG4TgSk7lL21QBDPY/H5wSlrBhoycnCx
 ZaexYcVwlH1klSggzYMhemeFjBdWo/otCqMBuBspwxmGCPaeg6F+QQ6KYEVKZmP/JyRnUzSw4sh
 2Hg2rEUVKTxGvOwU=
X-Received: by 2002:a5d:4446:: with SMTP id x6mr22432815wrr.312.1580832427125; 
 Tue, 04 Feb 2020 08:07:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzg64relmWw0hdzTYxsG+uX2Pl8hemkFCwrU18P0xjznjO+m47rhJGKaI10qzZucz929Wvbxw==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr22432792wrr.312.1580832426867; 
 Tue, 04 Feb 2020 08:07:06 -0800 (PST)
Received: from [192.168.178.40] ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id l29sm7205430wrb.64.2020.02.04.08.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:07:06 -0800 (PST)
Subject: Re: [PATCH] scripts/signrom: remove Python 2 support, add shebang
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200204160028.16211-1-pbonzini@redhat.com>
 <a1940860-ff53-ee17-bb28-bfae85bc4b98@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca7a1e44-8a8f-2e45-e6c3-37541648231d@redhat.com>
Date: Tue, 4 Feb 2020 17:07:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a1940860-ff53-ee17-bb28-bfae85bc4b98@redhat.com>
Content-Language: en-US
X-MC-Unique: SxJ2dYB6MVqIVKk4sXME6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

On 04/02/20 17:02, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/4/20 5:00 PM, Paolo Bonzini wrote:
>> Based-on: <20200130163232.10446-1-philmd@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 scripts/signrom.py | 12 ++++--------
>> =C2=A0 1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/scripts/signrom.py b/scripts/signrom.py
>> index 313ee28a17..9be5dab1cf 100644
>> --- a/scripts/signrom.py
>> +++ b/scripts/signrom.py
>> @@ -1,3 +1,5 @@
>> +#!/usr/bin/env python3
>> +
>> =C2=A0 from __future__ import print_function
>> =C2=A0 #
>> =C2=A0 # Option ROM signing utility
>> @@ -44,14 +46,8 @@ fout.write(data)
>> =C2=A0 =C2=A0 checksum =3D 0
>> =C2=A0 for b in data:
>> -=C2=A0=C2=A0=C2=A0 # catch Python 2 vs. 3 differences
>> -=C2=A0=C2=A0=C2=A0 if isinstance(b, int):
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum +=3D b
>> -=C2=A0=C2=A0=C2=A0 else:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum +=3D ord(b)
>> -checksum =3D (256 - checksum) % 256
>> -
>> -# Python 3 no longer allows chr(checksum)
>> +=C2=A0=C2=A0=C2=A0 checksum =3D (checksum - b) & 255
>> +
>> =C2=A0 fout.write(struct.pack('B', checksum))
>> =C2=A0 =C2=A0 fin.close()
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Also, applied to my python-next tree:
> https://gitlab.com/philmd/qemu/commits/python-next

Oh, good.  So I've unqueued your series on which this is based.

Paolo


