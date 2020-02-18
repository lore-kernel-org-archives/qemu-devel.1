Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD3C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE2C207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jU9P9qUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE2C207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wpz-0007Me-Mj
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wok-0006Nf-TC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3woj-00071V-WB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:57:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42384
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3woj-00071M-Sw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582009033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtkkgCFrr2ZuEk96iMlNOJBtVAzlp4MkxR6+LdiQ3to=;
 b=jU9P9qUpQFz2PTSKuHjwUgBnwKaO1YuJbq9R8J99s97VtZRSWAZUa8S0A5i8UOoln0Jyrj
 AOQlMicYmvNyGSdrI+rR65x3EB8rhjMsp6eVnfX45MSWeRVe1KOUlJnI7Klti7W7dAEizq
 QW223WtLoeGtL6FUWkpR15H9v5iMeAQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-VY1EG8WePqW4j8whWHRvLg-1; Tue, 18 Feb 2020 01:57:11 -0500
Received: by mail-wr1-f71.google.com with SMTP id p8so10294036wrw.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W1HXxJ3jivPb8kT1VQpVcJB5q4RGglFABsv+B4Dss20=;
 b=kmjNg3DC5aIRviSdz6DifP2ok+EMNIhPnTjSlW07rqyuNm3hLeKyWCWyup+mwxNaI6
 5HsTjLtufzVn7dUfa7otdReDnJfOxRcwCkaNwrHlOCUI8nBi7yoUuaq0NSiYZR0J7Pj8
 mHl9P32z4JVbzlzmHCASGrurZ+9LYHh5LSXSEjUTGOG1FZ89U+5/O7DZ7UMly4EhGCXM
 S0PJ1Pht/wYhWX6Yjb4HQs2iKp3EYl+xEJAdYieXSKYu4HuvSvw/NGrVSl6fYrsLU/Aq
 9nYzLqioffINJXwXfwugEA93gnLrFyk0ALwWehvNf/evWeQwQwOcX7DFkJyj7Nb5cMuc
 Ioyg==
X-Gm-Message-State: APjAAAXnHUDNA7R14Seg3Mt6WK6CW48BXTAHeaMLwe4JXdyvcPipYPmY
 P1oQWXN0g5Omn32i33NCPMZfkiugoJWPY706BSOTX29txAjVG4MQWwWLOJSRT/LGClZNewqwWtD
 GOEUBaddf/JRvOOc=
X-Received: by 2002:a1c:a952:: with SMTP id s79mr1251854wme.83.1582009030388; 
 Mon, 17 Feb 2020 22:57:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4COAGkcxouhcJNnscMiYEVC3z01XRbGs3DYdI+07A6DaNnwlpYnuB0BqG6mkwwqqLOaQ28Q==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr1251814wme.83.1582009030123; 
 Mon, 17 Feb 2020 22:57:10 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c13sm4882074wrn.46.2020.02.17.22.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:57:09 -0800 (PST)
Subject: Re: [PATCH v5 23/79] arm/mps2: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-24-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc2c80d1-5504-64a1-59d4-a3c77c7860dc@redhat.com>
Date: Tue, 18 Feb 2020 07:57:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-24-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: VY1EG8WePqW4j8whWHRvLg-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:33 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>   while at it add check for user supplied RAM size and error
>   out if it mismatches board expected value.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
> v2:
>    * fix format string causing build failure on 32-bit host
>      (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
> ---
>   hw/arm/mps2.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


