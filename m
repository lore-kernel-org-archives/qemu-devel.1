Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8494C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BD9208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/5Sefvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BD9208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqN9-00020G-FV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iopiy-0003S1-5Q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iopiw-0000st-NY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:20:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31343
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iopiw-0000sK-KW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578406845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBdAeLFsny/SUnsG+PdA8Cy0rH4j0ekxpkkOhBCPpzU=;
 b=e/5SefvzOtxGaqsN+jUUvW66H9/JHtElE7wF+av0OPasuRlj7j+mNyKbDBLO4PsceVIqf2
 OTDehN0gIrfzmEMA47RtXx2ah1tQ25MGzvnTiy9aRhJ7tpISM9nqIQ9HFfO66avle6Amfh
 4d4/pZ7pE+la4YdGelloeCg6x5N7AJ4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-v1Lv76zFP6SHU23GZxbtIw-1; Tue, 07 Jan 2020 09:20:44 -0500
Received: by mail-ed1-f70.google.com with SMTP id f11so392180edy.22
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a4DOAkQHlJGmeRSbJNEMmlviKTONF4AgS6lebGEPryA=;
 b=MFtp9nRldlb3J/UveEKyzPeQougj/7WECZhX+/+8suZ+U7D/qVV+Qdtt4tLcJ5NZIW
 Dk28vw+8PrndihLNeSb8/DDxop8Ye91eW41HvtvfIiZJ0k/gNFczltlDCDPGiXEVp1QX
 ZqfA2gk4LljMGm/pP1Jq9QsRqdWRogLrh/pSrG+AxFyBNafd6UiOucD2T62cWgObJXew
 W/++JBD3ZkZjShzP8IatQXBdtRU1p0YQp7d/gZ2kdIgd6Vk6x1inxdn7ZtduF6s/GopL
 x+x1x6FmRJfNGgMvXEiXX8dTROIfAGVjwvGVg917pEprB2jonVjIyD/W5tS0B8Sablt4
 x0mQ==
X-Gm-Message-State: APjAAAX2I443GGh1cZmU51+U4BNsTlvt1D6bDzjzhj4DpTeEhAkTetAu
 9JfU4Ctsvh7HWsOSuFGmGQeQScQt26hYfNIquc/VWnQiSY950V9KYUAGY3EnGW6g4NG+XkqADAb
 WBKCX8Z21O8Qr59E=
X-Received: by 2002:a17:906:20c5:: with SMTP id
 c5mr116103842ejc.330.1578406843030; 
 Tue, 07 Jan 2020 06:20:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKipKRI96XmZtuVM04ZElLRe2Gu/5MIxzjs7m7Cf0rE9Fpa02GibkmXI35sE0pW+aAmTz5jw==
X-Received: by 2002:a17:906:20c5:: with SMTP id
 c5mr116103816ejc.330.1578406842797; 
 Tue, 07 Jan 2020 06:20:42 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id d1sm8136972ejy.3.2020.01.07.06.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 06:20:42 -0800 (PST)
Subject: Re: Priority of -accel
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2ae2dee3-cd16-a247-971b-4b3482e596a5@redhat.com>
Date: Tue, 7 Jan 2020 15:20:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3241dff4-6223-404f-55d4-846991763046@redhat.com>
Content-Language: en-US
X-MC-Unique: v1Lv76zFP6SHU23GZxbtIw-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 3:14 PM, Thomas Huth wrote:
> On 07/01/2020 13.54, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Jan 07, 2020 at 01:23:18PM +0100, Paolo Bonzini wrote:
>>> On 07/01/20 13:18, Thomas Huth wrote:
>>>> I don't think we need a separate priority parameter here. But IMHO it'=
s
>>>>   really rather common practice to prioritize the last option. So whil=
e
>>>> it might be more "self-explanatory" to a CLI newbie if the first
>>>> occurrence got the highest priority, it might be rather confusing
>>>> instead for a CLI veteran...?
>>>
>>> Prioritising the last certainly makes sense for a choose-one-only
>>> option, but I'm not sure it's the same for a choose-best option.  After
>>> all it was -machine accel=3Dkvm:tcg, not -machine accel=3Dtcg:kvm...
>>
>> IIUC, the main use case for specifying multiple accelerators is
>> so that lazy invokations can ask for a hardware virt, but then get
>> fallback to TCG if not available. For things that should be platform
>> portabile, there's more than just kvm to consider though, as we have
>> many accelerators.  Listing all possible accelerators is kind of
>> crazy though no matter what the syntax is.
>>
>> How about taking a completely different approach, inspired by the
>> -cpu arg and implement:
>>
>>      -machine accel=3Dbest
>=20
> Something like that sounds like the best solution to me, but I'd maybe
> rather not call it "best", since the definition of "best" might depend
> on your use-case (e.g. do you want to use a CPU close to the host or
> something different which might be better emulated by TCG?).
>=20
> What about "-accel any" or "-accel fastest" or something similar?

'any' is a russian roulette, you don't want it to return 'qtest' ;)


