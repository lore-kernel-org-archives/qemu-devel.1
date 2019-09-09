Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A61C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB4621924
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB4621924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NTG-0008Ag-D4
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7NST-0007ia-EV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7NSS-0002QS-E2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:28:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39275)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7NSS-0002Px-6e
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:28:08 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6771064047
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 17:28:07 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r1so140531wmr.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ymdppCKp+emJn60sFR0nVJaUM0f0rLSa3Vq9VeULMQk=;
 b=QGMwWxyHwQro/bIrM0+RuvRAaKGeVOvKrP2Eo5wCQarq9fBHq4no8/uHr9zcRJkx8u
 fkXnurYqYTfpGE2u9IFZ+aYdETkUIeqDPsmYTk6jIf6HDTMvFKLD1XktUf7nGxMfDcbm
 hU9K1Ju0xnOwat7JeKgkVAoOY+Xvf9sgCnaU/e4m3MtSQvU/a+QYy1n7K1PeO1MNd4Yb
 nAvrVkBPnWd5Sqs82zxhfepJGiWLJOKgUv9Z7it8GNRec8ed23DeNW3hxbUuq6/XNFlC
 ZSiRtP+vTnlH/yAOBwjC+2BGh+/az3oV9L455+GQoNmVjeXWyEP3QZfR0mcHAdVs+QUF
 JhRQ==
X-Gm-Message-State: APjAAAVJHmMh/QixvmKVIpZP1F7SUhS5MXCO2BPSxYufxHp/vignmR03
 IssUn5wB8qq3MempiY1XU+XpxwwYrqTMqO3y6moNrWcUVs+V73rqkHNZNB6oodh+8Lc5doUn2c1
 QF1yDvYWrexmwRn0=
X-Received: by 2002:adf:fb4b:: with SMTP id c11mr18682658wrs.176.1568050086120; 
 Mon, 09 Sep 2019 10:28:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwPsKlsStzP389wcS9fpvxFl9TtoJm1J0e8lX2HELbufwCOL+9Io4yzi6ap62ILPDVhOLDv1g==
X-Received: by 2002:adf:fb4b:: with SMTP id c11mr18682638wrs.176.1568050085885; 
 Mon, 09 Sep 2019 10:28:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4580:a289:2f55:eec1?
 ([2001:b07:6468:f312:4580:a289:2f55:eec1])
 by smtp.gmail.com with ESMTPSA id a7sm17640404wra.43.2019.09.09.10.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 10:28:05 -0700 (PDT)
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
References: <1563374298-17323-1-git-send-email-mark.kanda@oracle.com>
 <277b5916-4e46-1aef-6368-a414de4d2149@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b450afbc-df72-bb86-2bc9-7f156f3a9a9d@redhat.com>
Date: Mon, 9 Sep 2019 19:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <277b5916-4e46-1aef-6368-a414de4d2149@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v2] Only enable the halt poll
 control MSR if it is supported by the host
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
Cc: mtosatti@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/08/19 19:22, Mark Kanda wrote:
> Gentle ping - I would like to confirm this patch is acceptable.

Yes, it was squashed in Marcelo's patch (commit
d645e1328726b38b3c79525eb57842ce29c1df7c).

Paolo

> Thanks/regards,
> -Mark
>=20
> On 7/17/2019 9:38 AM, Mark Kanda wrote:
>> The halt poll control MSR should only be enabled on hosts which
>> support it.
>>
>> Fixes: ("kvm: i386: halt poll control MSR support")
>>
>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>>
>> ---
>> v2: Remove unnecessary hunks which break migration with older hosts
>> (Paolo)
>> ---
>> =C2=A0 target/i386/cpu.c | 1 -
>> =C2=A0 1 file changed, 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index a8bafdb8b9..543bc25f64 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2838,7 +2838,6 @@ static PropValue kvm_default_props[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "kvm-asyncpf", "on" },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "kvm-steal-time", "on" },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "kvm-pv-eoi", "on" },
>> -=C2=A0=C2=A0=C2=A0 { "kvm-poll-control", "on" },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "kvmclock-stable-bit", "on" },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "x2apic", "on" },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "acpi", "off" },
>>


