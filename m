Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A4DC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AE62072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYREmZ93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AE62072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3h9C-0003uX-Dx
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 09:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3h8d-0003Mg-GJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3h8c-000301-9f
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:12:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3h8c-0002zU-3S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581948760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zco+X8liO9yslCxFNbJ2dkSgt2zO4xSDRj0SLK+IxS0=;
 b=gYREmZ93/qc7kA5NgL0mMhUryjxVA25fQBFOplmfj5tsbzW5JtOiMvb7bpvckI96HtL5pJ
 8m5hV3/7I+lxxjeMPbpYvxqrk88DIvBlAV/Ttsw4vlMQeKFHBuTfc7j3dG4PF3vJ+oIRjZ
 u9JDBLJUfF19poiCuypEpwXx5MMTeto=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-bpJqnRKQOayNL0Si5nLUgg-1; Mon, 17 Feb 2020 09:12:38 -0500
Received: by mail-wr1-f72.google.com with SMTP id a12so9015263wrn.19
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 06:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vYVOhEO0cnXInBF8hqbAPus9mF8zm+x+lszYmp05zbk=;
 b=rVT/7CSnZRxHj1ihKwGfuv0LCM1GDWpMM74eyqeo3Fs6vUrGpPppZxHFoEUKWPtm2X
 o3BLuO1UlUnkTKTB/ocHwbIw/QuiKENLohmHmQ9t8yrbmBnpe68mdFgu0agwYw3JuTom
 OQGT/I5ZUWLlGT+ZR9wfbpjJ0wmrWK7rcL9FJG75t35s4xOo+vZ1Onb2LyjQxtcIuzrD
 koUNzosuEBK7L+OMD/NPU3XXGTmKDHYuDa78s10RbzTeZSMOGz0YINej2XlhkNVAocbT
 VGMy/08cqVv8le8C88Iku9ybnIUjUvAIlko+6ucV6jxOTYvU6btJIYprd0T7BMFaBhaB
 vqCg==
X-Gm-Message-State: APjAAAV3jxylG0laI3/9pZEt42VClDEwDtX0Sdnmhz0XCWP49N6/x/Q7
 n8tPhJSaQb5SosqODZUYZhVyewhEln5vdkJ3aEjTOj4n4DD+YOVr0KUl7WEW/RvGadiBcUWwVG0
 HkwfWYG+fogilgjA=
X-Received: by 2002:adf:e74a:: with SMTP id c10mr23710287wrn.254.1581948756955; 
 Mon, 17 Feb 2020 06:12:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqySocTMBN+g1MXUSqjvvYT+0PzxGnsPU2pGHaLCHnaEMBX+9OzUMQtlFhBu617v6KXBDerxpg==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr23710265wrn.254.1581948756772; 
 Mon, 17 Feb 2020 06:12:36 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o77sm810728wme.34.2020.02.17.06.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 06:12:36 -0800 (PST)
Subject: Re: [PATCH v2 1/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200217094240.9927-1-philmd@redhat.com>
 <20200217094240.9927-2-philmd@redhat.com> <20200217113708.GG3434@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6650d0b0-0374-61e2-3dbf-206e7cb985f5@redhat.com>
Date: Mon, 17 Feb 2020 15:12:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217113708.GG3434@work-vm>
Content-Language: en-US
X-MC-Unique: bpJqnRKQOayNL0Si5nLUgg-1
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
Cc: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 12:37 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> Fix warning reported by Clang static code analyzer:
>>
>>      CC      tools/virtiofsd/passthrough_ll.o
>>    tools/virtiofsd/passthrough_ll.c:1083:5: warning: Value stored to 'sa=
verr' is never read
>>        saverr =3D ENOMEM;
>>        ^        ~~~~~~
>>
>> Fixes: 7c6b66027
>> Reported-by: Clang Static Analyzer
>> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Thanks, you might want to snd that to the upstream libfuse
> (different context); it looks like it's the same there.

Done: https://github.com/libfuse/libfuse/pull/501

>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!


