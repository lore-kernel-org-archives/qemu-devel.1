Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22C1C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AE320732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXHqun0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AE320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6CYu-0005i0-RV
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6CYK-0005Gm-At
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6CYH-0005qM-Fr
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:09:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6CYH-0005q5-Bq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582546172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMwIO6uf6lxo9sZukPhM2e0wvfCVk5riptUMSIfFE6Q=;
 b=ZXHqun0uixkiMzfFaRg3Ff+IOQMNwiZaImi00qSJW4deIKiWMWfJrllg72KpMYN6PE5ehQ
 6QaPUPYcB6vAhxGcpZxHmuyxQ7VQgZ3a1REcVC1kk4GOY6khA43I5QuwZISgHjlhXub1yC
 TYo/A4l0ZV8tBhP6hPeccsKD3pVE41k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-OlbaIPixMOqMbfGB-cOqHw-1; Mon, 24 Feb 2020 07:09:30 -0500
X-MC-Unique: OlbaIPixMOqMbfGB-cOqHw-1
Received: by mail-wm1-f72.google.com with SMTP id m4so2303284wmi.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+MnTXHMNunhpzHXGNfZ2754FeM2y0F3ilfLhqg63SY4=;
 b=QIwISx0x4SP3WwLYqfZaWq3gbzUvk66+6OnwIuKHTIwM9oXqF393cz+gPCaowavrd3
 4KE/AlaK5YSzixXGLnUMD+9wlfKy9ihqEo8ljZGYCujlKwSlHo4PR/ldvmZWGHhHjyfO
 YPEMe9aiPRhQ8ET/6/feYgsPfh9UjFUwr9EOUTRF/+j0j0ZPz6vmbllQ0z2vXznPrlW4
 F98J70qWbzbBgT3BLsowC69UTkPj22lcb3C16qJcaCNzg4rSQg0c2YdFDlDmfDWxZi45
 0//on8p9YEzZbDT9eEua/VrePf6JHpS4yYJeSCob1j5JEor6fn5AFuvcuFgmJn7pB8XG
 wDfA==
X-Gm-Message-State: APjAAAXtXD6U5IkbUs41snP1giYZ7m7NrUFWBn0PjmhFzjBwztIpHU55
 9nLUWwPvatpIuIf+zaV3aOTu0kUQcQYZhZPzEy1KE7S5352NHcSP9mQZTlWwRXLafstw3a9QObI
 aUkCgyiyKYneC6SA=
X-Received: by 2002:a05:600c:149:: with SMTP id
 w9mr20817708wmm.132.1582546169138; 
 Mon, 24 Feb 2020 04:09:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9tWJYdcqJgcL57/nHU8dG5jtgTc3wAJrMqS++AHfqQIeeJVoFejA0VD23lyFYU9N72rFjZw==
X-Received: by 2002:a05:600c:149:: with SMTP id
 w9mr20817680wmm.132.1582546168895; 
 Mon, 24 Feb 2020 04:09:28 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a135sm17135170wme.47.2020.02.24.04.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 04:09:28 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Reactivate MIPS KVM CPUs
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1582545058-31609-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1582545058-31609-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <e4c57474-090c-6409-a087-b8b0e21a32b0@de.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a82ac9bf-2be3-a753-a79b-bfe1894a3f4e@redhat.com>
Date: Mon, 24 Feb 2020 13:09:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e4c57474-090c-6409-a087-b8b0e21a32b0@de.ibm.com>
Content-Language: en-US
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
Cc: James Hogan <jhogan@kernel.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 12:55 PM, Christian Borntraeger wrote:
> On 24.02.20 12:50, Aleksandar Markovic wrote:
>> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>
>> Reactivate MIPS KVM maintainership with a modest goal of keeping
>> the support alive, checking common KVM code changes against MIPS
>> functionality, etc. (hence the status "Odd Fixes"), with hope that
>> this component will be fully maintained at some further, but not
>> distant point in future.

My only worry here is, do you have hardware to run tests?

>>
>> CC: James Hogan <jhogan@kernel.org>
>> CC: Christian Borntraeger <borntraeger@de.ibm.com>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>=20
> I talked with Aleksandar several times about maintainership and I
> think he is the right person for the job stepping up as maintainer.

Agreed.

FWIW:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Acked-by: Christian Borntraeger <borntraeger@de.ibm.co>
>=20
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b0728c8..9cc55d5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -365,8 +365,8 @@ S: Maintained
>>   F: target/arm/kvm.c
>>  =20
>>   MIPS KVM CPUs
>> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>> -S: Orphan
>> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> +S: Odd Fixes
>>   F: target/mips/kvm.c
>>  =20
>>   PPC KVM CPUs
>>
>=20
>=20


