Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1817C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6950220730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpgoXK8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6950220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0ui-0001td-I8
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iz0ty-0001PJ-RA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iz0tx-0000zo-7B
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:18:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iz0tx-0000sG-3P
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580833092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMCLRVTWgya2KZpzt3G8jtuGuS7Ymj5Y1AMXpSnncrU=;
 b=UpgoXK8Xj0ujd8F+evfTSqsI01unlHfw4Y1vefhZTTF66ROQwmmBnCy+pVD2FIIY9uYWwi
 uwLn3QLcduuith/4XoiSWBubJDn5ro+OSHiFzF/icivMR62gNDs79KyZa3/VcFibrBVuxL
 pgcM0feF5Xb7JXrvgSGm6JfZn8pK/A8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-BX6HEOH_PTCOhwlKgfQP6A-1; Tue, 04 Feb 2020 11:18:10 -0500
Received: by mail-wr1-f70.google.com with SMTP id 50so9689266wrc.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uNSIxeuEO+X93EfAtC8K4SpJNuwIxCqO0cAMY1oIlwc=;
 b=UN1LmxtlWzWR+xWOCrRr6NG3hHXL9CqCNx30mT9WtxxKssmitPe7DoCYgeV0t5hhH6
 unVkMtw6TP7ZHGxPEapJuadQQLa7se9LDZJ/swglDzDInaqXgTqAaX1EonYHYbVNSxHG
 oU/aTdTn9nCA4M8PrpHr1/dPXewh1/3GMqGCzfhoL9wMGiVwIOEIA5bdQ6E7LUYzU/8u
 rYk6xL9rSDh98BKgL18sfhWcLfJk/8L9VAs9DraHDglTSvbQnOGal6ztOutRQj+aIguv
 nuxbIvxHOFrYYTc9hJy6eE1COfda86L0ogyPmtwk4qSnQ6vyLNtKmReEhoRB5lJozDqL
 Rmfg==
X-Gm-Message-State: APjAAAW/ZC59QJN103xnDo3O2ZF9R3MLJPuobHlmxf1ZmurKRjynYrxH
 UhL4osmv9Wpk9RK57AsdHCZifQX+T+2zvO5Isim5DkKT9Ob4cP2Smc7CAMbxsCfCIkbg9IFubYN
 lFWvTLKouMOZGRBA=
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr25183309wrw.60.1580833088917; 
 Tue, 04 Feb 2020 08:18:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwobPgMeKaaXEwMBovmtLHLRef9OW8cbpQ7aObNPCtAUYfrRpeySNMx76dRB2OAWeB7JRSiZg==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr25183284wrw.60.1580833088644; 
 Tue, 04 Feb 2020 08:18:08 -0800 (PST)
Received: from [192.168.178.40] ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id v5sm31055935wrv.86.2020.02.04.08.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:18:08 -0800 (PST)
Subject: Re: [PATCH] scripts/signrom: remove Python 2 support, add shebang
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200204160028.16211-1-pbonzini@redhat.com>
 <a1940860-ff53-ee17-bb28-bfae85bc4b98@redhat.com>
 <ca7a1e44-8a8f-2e45-e6c3-37541648231d@redhat.com>
 <8d18ae5a-031e-0ffc-01eb-befe0926e216@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b95aaead-a387-854a-ba64-645bcd9dccc8@redhat.com>
Date: Tue, 4 Feb 2020 17:18:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8d18ae5a-031e-0ffc-01eb-befe0926e216@redhat.com>
Content-Language: en-US
X-MC-Unique: BX6HEOH_PTCOhwlKgfQP6A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/02/20 17:11, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>> Also, applied to my python-next tree:
>>> https://gitlab.com/philmd/qemu/commits/python-next
>>
>> Oh, good.=C2=A0 So I've unqueued your series on which this is based.
>=20
> Aargh I received your "series queued" mail _after_ this patch.
>=20
> As you prefer, but I have various python patches pending already.
> If I keep "Explicit usage of Python 3" do you mind Acking it?

Sure, the least patches I queue the better.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


