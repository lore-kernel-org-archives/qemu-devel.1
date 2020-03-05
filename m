Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51451C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1D12073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNy0h/Yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1D12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nmY-0005GP-4g
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9nlR-0004Fm-RJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9nlQ-0001ir-Qw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:30:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9nlQ-0001hm-NG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583404200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84Rp/0VvGOnNm3aSLNjsi4wglR0EmoGt8NV29+DCaJ8=;
 b=dNy0h/Yh5U8S2QU1OYuMJvWFQBYnMlLt6ABPYaU1pXlTEMfLNmMZLyPnTYHL19ft7YCdTY
 4EogcLXLUXSmo0yoNgnyXw2gbAf5HuW9kn7OVU2W/HWAUARdDfZiBYK1JNtxgjnVDTzDJv
 +PTklFLFPzfZIY4ewuf7Ia/PCckH1Rk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-sfurYYEjNgqTEHoRBiqQLg-1; Thu, 05 Mar 2020 05:29:58 -0500
X-MC-Unique: sfurYYEjNgqTEHoRBiqQLg-1
Received: by mail-ed1-f71.google.com with SMTP id u12so4017791edb.20
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8wdwpcKqsLZQtklQNbXobNZ1F/td5Rl93G4ZFgaHNrs=;
 b=kWbwpNDec94BrSyCUHepTeS2Gqz+Qas3QOqEgClNiPfExchYsGz6nvfERARVsawXJI
 MFCstjZ1MiT5Go52bpTmbFct58IBIbJkdoeRXXeVaB3YT69ZfI6JcCS9wVTd7nux4biu
 wRx9vo/Yxhrx4anA7Ebv5MlxzaTROIGKGscC5P/K9n9hgPDBtc60UrkFQMc0d/MkYvK+
 KsnK2iYsTPafRLQWyl8rFISsTMhf8EaU5r1qaTbIdDuw+qgNVvwBwFhAbGpe6zNAi4pZ
 oI7sOn1IY7nOAj7x6710PpJX8hH9jnrYkt3iGkRcr0jkJwoe2JV8K0FlupmwpdTQ9zP2
 +9yw==
X-Gm-Message-State: ANhLgQ01YP/jspIv0Qo2MQ2JPYE8cJxIykpYlIJ1VQk20d9rLZj1/tlM
 PjBrzOtQxBpKTApvm25bDn0MjvOd1+Dml9JTFf3NdrfdV/2wYyCCvZO4Y1P6F/wwL7O2IK+IJaw
 lUH2FLJfh7hiBUnc=
X-Received: by 2002:aa7:c84f:: with SMTP id g15mr7487487edt.251.1583404197169; 
 Thu, 05 Mar 2020 02:29:57 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsUK0ghbfj6OvQ7HN0PUIPBFM0dSZ3ZTWKcWijOsFqG0M6seylP6srJ2nGAuYbrWzeswyYhzA==
X-Received: by 2002:aa7:c84f:: with SMTP id g15mr7487469edt.251.1583404197010; 
 Thu, 05 Mar 2020 02:29:57 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id rv13sm1290960ejb.81.2020.03.05.02.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 02:29:56 -0800 (PST)
Subject: Re: [PATCH 0/3] tests/docker: Fix linking with VirGL
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
References: <20200212202709.12665-1-philmd@redhat.com>
 <8b511e74-b965-dc42-be6d-fa70d752cf29@redhat.com>
Message-ID: <fb494baa-33ef-addf-0866-f3ef5befefd3@redhat.com>
Date: Thu, 5 Mar 2020 11:29:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8b511e74-b965-dc42-be6d-fa70d752cf29@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Dave Airlie <airlied@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping ping?

On 2/24/20 1:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/12/20 9:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> We link with VirGL in our debian-amd64 (cross-host) docker image.
>>
>> This series includes few fixes to keep testing it.
>=20
> ping?
>=20
>>
>> Philippe Mathieu-Daud=C3=A9 (3):
>> =C2=A0=C2=A0 tests/docker: Update VirGL git repository URL
>> =C2=A0=C2=A0 tests/docker: Remove obsolete VirGL --with-glx configure op=
tion
>> =C2=A0=C2=A0 tests/docker: Update VirGL to v0.8.0
>>
>> =C2=A0 tests/docker/dockerfiles/debian-amd64.docker | 6 +++---
>> =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>>


