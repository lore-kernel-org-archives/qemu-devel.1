Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E2FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 20:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F357820708
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 20:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnbHczJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F357820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWnp4-0006kh-4O
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 15:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWnnq-0005tP-WE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWnno-00047Y-Rz
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:39:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52229
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWnno-00042g-Oo
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574109555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+UnvLb2il2q4qfOGiJWyz8kIdvyXQUj7C8Hq862OOs=;
 b=QnbHczJ8X+Qy3WBNieGG+4A1VG5FGxTzIlwced6c+IPBF+OBe8aWSeZ+CLANhm3K4XFWIO
 myPSQnTnzzVWW2raRAwYJW/s8dNE2T21MLdlPkzpsiSeOPXKmOvSPN9AMPiwmRAGQj1o8v
 ohmnyU4Y3Gss1F+XaOAd/PnpOMCagPU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-fo9hzEgGMOqwJb06zNxLBw-1; Mon, 18 Nov 2019 15:39:13 -0500
Received: by mail-wm1-f72.google.com with SMTP id t203so687509wmt.7
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 12:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JlPKUZeit3/7iGUBOkANZ4DyJEBGwGomS/W11dX1ClY=;
 b=paekfITf9pLPQwr7kYowdQ94+avFoB/hGfI7IJkttXU9xoWi9ExbEdRC9OPyzmQqVt
 sXihvIn+MScB5iZrGgDJcLi7ZbIvNomBsoXzXvpGjW4eM0NjMpYgYhQjI4Jk9u93hVCV
 nueG1DyhZ3MlNbBM6SBwpQkaoC23tTy/5YLjqf4EGs+/wXwvaWWuY0jHlObCVYvkd0M2
 xKYydLE7eZf3BjzJj+kqBALS+A0jf5b23Nth62sMJJTZMCoktpUFiguJIqGsSYeSICIM
 maBdwIu0Y6Eco+q2587fhbXPFX+Mz8n7vuL+yYU+GltSkSAyDGDWXISB4qOOXC8X7mXO
 nLKg==
X-Gm-Message-State: APjAAAW3Gbwo8SPO2iLty48dDeAnsn0DXV4gFt9WgGGTabWHdfHbYKBd
 my6cr0b2InqjRPXwBUQam4X2fx/ZM8+4Bo9IFy0C0DOKjNcCzws4KI3k6Bj64Nea7YXp4VhtFkA
 qvImeDvN1GvnC7FY=
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr32236202wrj.102.1574109552108; 
 Mon, 18 Nov 2019 12:39:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBAgR/aI9DkqytiLhsCB8azewoBq5yjClsgLkT2gPx+aP/Zqa81nrrhVHe+XdzzPwMMffQKg==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr32236171wrj.102.1574109551886; 
 Mon, 18 Nov 2019 12:39:11 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id 19sm27717933wrc.47.2019.11.18.12.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 12:39:10 -0800 (PST)
Subject: Re: [PATCH v2 1/3] hw/block/pflash: Remove dynamic field width from
 trace events
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191108144042.30245-1-philmd@redhat.com>
 <20191108144042.30245-2-philmd@redhat.com>
 <9e7990b7-87ed-84d4-5256-8397bc25a1f4@redhat.com>
 <dd59a9d2-d5c8-b054-191b-bbbfd9d7b7b1@redhat.com>
 <159b1679-72cf-bb0d-ca2f-0f626adebaf3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6923dbfc-7171-eaa6-e7f3-db560a8b1857@redhat.com>
Date: Mon, 18 Nov 2019 21:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <159b1679-72cf-bb0d-ca2f-0f626adebaf3@redhat.com>
Content-Language: en-US
X-MC-Unique: fo9hzEgGMOqwJb06zNxLBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 8:21 PM, Eric Blake wrote:
> On 11/14/19 3:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
>>>> -=C2=A0=C2=A0=C2=A0 trace_pflash_data_read(offset, width << 1, ret);
>>>> +=C2=A0=C2=A0=C2=A0 trace_pflash_data_read(offset, width << 3, ret);
>>>
>>> Umm, why is width changing?=C2=A0 That's not mentioned in the commit me=
ssage.
>>
>> Previously it was used to set the format width: [1, 2, 4] -> [2, 4, 8].
>>
>> We usually log the width in byte (accessed at memory location) or bits=
=20
>> (used by the bus). When using this device I'm custom to think in bus=20
>> access width.
>>
>> Regardless whichever format we prefer, a change is needed.
>>
>=20
>>
>> Do you prefer using a "-bit" suffix? As
>>
>> "offset:0x%04"PRIx64" width:%d-bit value:0x%04x cmd:0x%02x wcycle:%u"
>>
>> I can also simply remove this information. Ideally I'd revert this=20
>> patch once the we get this format parsable by the SystemTap backend.
>=20
> Reporting either 'width:8-bit'/'width:16-bit' (explicit bits) or=20
> 'width:1'/'width:2' (implying byte) is fine by me.=C2=A0 Showing a bus wi=
dth=20
> in bytes adequately explains why you are using <<3 (aka converting bits=
=20
> to bytes), and how it compares to the previous <<1 (converting bits to=20
> number of hex characters).=C2=A0 But whichever you pick (tracing bit widt=
h=20
> vs. byte width, and how it differs from previous usage of width as=20
> output-character count), documenting it in the commit message will make=
=20
> life easier to understand the change.

Yes you are right, I should have documented to avoid wasting review time=20
clearing the confusion.


