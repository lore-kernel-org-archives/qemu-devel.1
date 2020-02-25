Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E8C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEBA20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGZK17eH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEBA20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6fK7-00046L-1x
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6fJR-0003Y8-Hz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6fJQ-0007Jk-2V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:52:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6fJP-0007IF-U9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582656726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1eOu0a+zFiu2V0PrChn3Oj2/bFk6N7c9W9bcToRmUTU=;
 b=QGZK17eHjRB7WkF+ktxU8q8X17FYeLU/PR8O0+n6MmRJ2D2+jvD3cdG6n9GF5QS7H+wURO
 r6bfdVDB5RqDj11+PE4fcsCHYH2So+sW/AeByE+yTFnKGa35nWehmZL8g+jJVx+I2E1R9/
 SMntJM70rwW6cXyGm4tuZ9u8oJBY1rc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-sjXUnWxxM36Mg046zYdU9A-1; Tue, 25 Feb 2020 13:52:04 -0500
X-MC-Unique: sjXUnWxxM36Mg046zYdU9A-1
Received: by mail-wr1-f71.google.com with SMTP id u18so209018wrn.11
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1eOu0a+zFiu2V0PrChn3Oj2/bFk6N7c9W9bcToRmUTU=;
 b=eR8/puyVT4z04aGrNO3zpIvVa/aj0Yk8DXgJlOjkxguqCDzBbHFLqys22RGqObYBOo
 F1Mao/pKleBy8f29XvttyNxqsEdjQaZvYTm7CT2oZN/TfR/Md5PaK8JFGpge7JdHYZJu
 XyH+7IY5T2bmL7H7k4DD+F9d025SIwoTsnC+jnbgvlBvBA9LhmuI15nHM7P3D0K1cq28
 NcAc/O8UvYeDBd5x6Qt6sO8zg+6itsP+a4uWe3eTtFAJbTGcCleat4LsimBSmCamNhWf
 v7M2xk9Gklqwq0v03cUFmLEckUYqPX9/8J1Pq42SX3EEAWEaYGFQdSxeiTNocSDi/ajL
 mB3g==
X-Gm-Message-State: APjAAAUcLe8cSP1f2DnXOUD453wMIDMoC+ZqST9Ft+a21w9gDVwDkyxa
 M815QgasMVn16AssLxmyy9Q1PyOukU3SEbthWi76pdMpwPsxDtZrG43sITZky3vzY0Osanuq8e3
 QatVUxTNzNau9R8g=
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr469182wrw.383.1582656723574;
 Tue, 25 Feb 2020 10:52:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzI31deOJt8hJT49kQzTrRZ6iEQCIuCp4Gh1arq3OASahpKPXwwTZ3XsmmYdH4+IDtfVc9Org==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr469169wrw.383.1582656723338;
 Tue, 25 Feb 2020 10:52:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6?
 ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id a26sm5202737wmm.18.2020.02.25.10.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 10:52:02 -0800 (PST)
Subject: Re: [PATCH v4 0/2] qemu-cpu-models: Convert to rST; document other
 MSR bits
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
References: <20200225165618.6571-1-kchamart@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <134d55bf-3923-5530-5fa2-a9e1a64fe196@redhat.com>
Date: Tue, 25 Feb 2020 19:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225165618.6571-1-kchamart@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/02/20 17:56, Kashyap Chamarthy wrote:
> In v4:
>  - Correctly use the 'define-man-page' rule for qemu-cpu-models.7
>    [pm215]
>  - Fix author attribution as per the thread:
>    Message-ID:
>    <CAFEAcA8dTR6xkQnsf32HAo6aDXf5Z0UmkhL3+257KWLj1ES6Sw@mail.gmail.com>
>    [danpb, pm215]
>  - Don't reverse the existing order of the list of CPU models [pm215]
>  - Use rST "definition lists" consistently throughout the document.
>  - Consistently capitalize the phrase: "The QEMU Project Developers"
>  - Update the year of copyright to 2020 in docs/conf.py
>  - Fix two minor rST-related things [pbonzini]

Thanks, I queued this series.  I'm not sure when it will be applied, as
that depends on how the rest of the rST conversion will be done.

Paolo


