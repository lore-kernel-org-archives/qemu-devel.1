Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA0D214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkdrzwRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA0D214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZAu-00052K-OD
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixZ9Y-0003LN-L3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixZ9V-0004Yr-91
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:28:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixZ9V-0004Wz-5N
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580488096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rd5l0AL2ORaBLKoSRY3RUpowzD+VxFagUvE4QNJTQHI=;
 b=XkdrzwRGntEAj6KrQu/ocr4euF/dFGX25sHMqEhGtnl/fAsw2NWKG7vUIok4ALSkUgVINm
 hXZwre8wl3LdKTZa5r/Eji5qF1lpPIqBFATxshfigqHX1cL+Le+C2N2BrdxqVBqgxNziiP
 4VWgWbIAatqHGavgVTfxfNcE+D2CPWA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-puoq0gcoMIulHkAvOttTdQ-1; Fri, 31 Jan 2020 11:28:14 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so3624231wrw.9
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 08:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=luEsyN6xCsANO1LSDvJnqhB7jUYD5MQO5wVhneyj3Do=;
 b=O1ZDjjOhF0/rhFWbC4NiOCoUoaX8KqDjFYUPuRgloDFHIQIpOXlv1nvb03B7/z8sxG
 jmwOmspuUDBis8UyWDmlmXzshJjgSVRcsAIFuCSaltLaLcVVvre/QGFzArO2VGvtkrwI
 2FxgK6czxjJaOG0vS+SByYw3BEOoO9Qo/Uto7SJSGiy58wm4LQMJG57g8j0ERzSvS6Xt
 MaZbrmf+/Mzv0UYHPApAVpfsogTMmKuLEHtZw0VnaEwq47BY0TItGo8j+S4eIe6ytgV3
 zlAlmPPbdr82jgJv8bypNYmSb9OLRGRd6uQZmuYw6PwKjtd8KvdAiIyJklxtt52+IpW0
 63Aw==
X-Gm-Message-State: APjAAAW6NgXNeqjukKj8yi9wi65SPQ1nSqSYJlZIc5QmTUzq5shlsIYE
 rGyDXfbrO7FJm+4U9voW/OZWTYCOUVWogEmdKqGep7Lwo8r6gbKuBpI88LryGJbfV+bHh4eidTU
 W1wBOuKwH4QKw3U8=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr8370901wrq.51.1580488093446; 
 Fri, 31 Jan 2020 08:28:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqhXP2eyi0UQBsPIqvlVl1sv9o9seRTYSFgOVtToZfcppFpWdHFo2nEycvZ7LxWcagN0ubcw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr8370879wrq.51.1580488093201; 
 Fri, 31 Jan 2020 08:28:13 -0800 (PST)
Received: from [192.168.42.35] (93-36-46-135.ip58.fastwebnet.it.
 [93.36.46.135])
 by smtp.gmail.com with ESMTPSA id 2sm12333731wrq.31.2020.01.31.08.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 08:28:12 -0800 (PST)
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
To: Christophe de Dinechin <dinechin@redhat.com>
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org> <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <0a626b76-1b45-991f-ebf9-d6dec2a84ffb@redhat.com>
 <17767A47-BB66-40D6-9BC6-03B56FB198CA@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5dbb4bd1-34ab-f4c7-868b-05e7f4837c90@redhat.com>
Date: Fri, 31 Jan 2020 17:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <17767A47-BB66-40D6-9BC6-03B56FB198CA@redhat.com>
Content-Language: en-US
X-MC-Unique: puoq0gcoMIulHkAvOttTdQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/20 16:37, Christophe de Dinechin wrote:
>=20
>=20
>> On 31 Jan 2020, at 08:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 31/01/20 07:11, Markus Armbruster wrote:
>>> May I present you Armbru's Comment Trust Levels:
>>>
>>> ACTL2: The comment may be overly terse or incomplete, but the
>>> probability for it to be outright wrong is low.
>>>
>>> ACTL1: Treat as helpful guidance (with gratitude), but trust only the
>>> code.
>>>
>>> ACTL0: It is a tale Told by an idiot[**], full of sound and fury,
>>> Signifying nothing.
>>>
>>> Most comments in decently maintained code are at ACTL1.
>>>
>>> Around the time initial QOM development solidified, object.h's comments
>>> were ACTL2.  The neglect that is now clearly visible there makes me
>>> downgrade to ACTL1.
>>>
>>> Paolo will have a more informed and possibly different opinion.
>>
>> I think around initial development it was ACTL3, now it's around 1.8.
>=20
> Interestingly, the initial doc suggested ACTL to be an whole value betwee=
n
> 0 and 2. Now it=E2=80=99s fractional and value 3 has a meaning you can gu=
ess
> to be =E2=80=9Cabove 2=E2=80=9D=E2=80=A6

I won't say if this was accidental or not. :
Paolo

> How fast this happened tells you everything you need to know about
> documentation/specifications and actual implementations :-)


