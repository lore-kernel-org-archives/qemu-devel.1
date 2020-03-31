Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA099C2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B716620A8B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo5M3CGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B716620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBoO-0004be-Ta
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJBni-00045p-AF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJBng-0002GW-VY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:59:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJBng-0002Fz-SJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585641547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJZ1Ic/yYUGecnR1Zw62tx9g0ixMagdTB3nXYrYlt6Y=;
 b=Oo5M3CGZeGWznQNPd6ES4SLgWj+8Z4JveaBv38Oirwk8yncLpGBn88FR7By85SydHRPBM5
 U3abQvNWkyvprLYGn7d2Z4FYJkoL+/aWssaSn+ug7cEp/3vdBr+ftfoZzhdIgBF4U+qk/S
 60Z5h0O9WJVb4+isVfSjUtvdPN08qRw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-LVDHKLsbOJmxIUs0jHG_6g-1; Tue, 31 Mar 2020 03:59:05 -0400
X-MC-Unique: LVDHKLsbOJmxIUs0jHG_6g-1
Received: by mail-wm1-f70.google.com with SMTP id v8so731042wml.8
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 00:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EXY8/aXm2nVUxU2lQSLb0kPwUykPuwFSp3zhRGuIDYk=;
 b=CuJQEU+7fKp4BpaAbAXmVzlidYYMWY/nyncEnlnj4wPTY1GqwiIcHIu5VED3S4Fo0/
 JoBabfnQLHyiO9kdwMXhMq8omzXV21Jun+/a9zS04zkiyaIZ65PpLpbWGhOsA40lzMF8
 G4uulV8JD9ci1Ie4uVfkxbeL/08B20GMS+I3Pmv4cQLPz7qtjEF3Xk4kVkZWehslk7cw
 9Pas0TsYHujwgqMlayYgS/zuMzu+XLUol837vSz86/Ev7R0JL/MOZ+q9EYWl0Sl4ZU/R
 cHfteZN63DjbV8MO7HXpJto+l10QWvcCLnU4OIwENfsJtOW1GRnCbny/tL56a+Z4sIfe
 Rm8A==
X-Gm-Message-State: ANhLgQ3KoHrZCCJZaMnNbXQ6FShvMcf9ovDFxPI3VTCgzQTVVpXx8mBE
 Af42JOx8GCEBzlFW3tv6aCPDLlS9Rc+oxPzETdw9ppraDiNAIIUPITmjuv5S+2hPC579ADxl7Pi
 J+Mmxq4k+CC5YmkY=
X-Received: by 2002:adf:9b96:: with SMTP id d22mr20279093wrc.249.1585641544354; 
 Tue, 31 Mar 2020 00:59:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvOteHDFgIQYty5Nl3MoxCHo/47yAgGiM9+wK27a9yVBbHxNdVjL7SdsJOp+FlUsoswhT172g==
X-Received: by 2002:adf:9b96:: with SMTP id d22mr20279073wrc.249.1585641544124; 
 Tue, 31 Mar 2020 00:59:04 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b11sm25558672wrq.26.2020.03.31.00.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 00:59:03 -0700 (PDT)
Subject: Re: [PATCH] hw/vfio: let readonly flag take effect for mmaped regions
To: Paolo Bonzini <pbonzini@redhat.com>, yan.y.zhao@intel.com,
 qemu-devel@nongnu.org
References: <20200327111934.71066-1-yan.y.zhao@intel.com>
 <11c90e84-6c0c-9411-0d6c-7955136413c6@redhat.com>
 <c4eb2313-96b3-7e76-f48c-0059a40eabf7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9fddfb1f-2ab2-1b67-9e52-e0e522b0aca3@redhat.com>
Date: Tue, 31 Mar 2020 09:59:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c4eb2313-96b3-7e76-f48c-0059a40eabf7@redhat.com>
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
Cc: alex.williamson@redhat.com, Xin Zeng <xin.zeng@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 5:17 PM, Paolo Bonzini wrote:
> On 27/03/20 11:51, Philippe Mathieu-Daud=C3=A9 wrote:
>>>  =C2=A0 diff --git a/memory.c b/memory.c
>>> index 601b749906..4b1071dc74 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -1313,6 +1313,9 @@ static void memory_region_ram_device_write(void
>>> *opaque, hwaddr addr,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *mr =3D opaque;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_memory_region_ram_device_w=
rite(get_cpu_index(), mr,
>>> addr, data, size);
>>> +=C2=A0=C2=A0=C2=A0 if (mr->readonly) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> Shouldn't this be in memory_region_dispatch_write()?
>=20
> No, in general you want memory regions to get writes, so that they
> become for example a machine-check exception of some sorts.  However,
> memory_region_ram_device_write should probably be changed to a
> .write_with_attrs operation, so that it can return MEMTX_ERROR.
>=20
>> Please split this patch in 2, this (generic) hunk as first patch, then
>> the VFIO more specific change.
>>
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (size) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 1:
>>>
>>
>=20
> No need, I can just add my Acked-by for Alex to pick up the patch.

Having 2 different fix in 2 different patches helps when cherry-picking=20
(bisecting, backporting...) and reverting. My 2 cents anyway.


