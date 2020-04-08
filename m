Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DCEC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2F3206F5
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auTG4UhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2F3206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMCHN-0000Pv-Dz
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 11:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jMCGh-0008G8-6k
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jMCGf-0002Ec-O3
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:05:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49729
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jMCGf-0002E7-FP
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586358328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PEKSzxHVyNHQRprGqbJIixczk3tWG/zrkwMbevoVzYg=;
 b=auTG4UhCGR1OcGrlPDFFtdlZmfeutsIK2M9rp7K1AgZcaqBDcubSdX5A807Nl6Nd4I5oI8
 5ABYI/5yeqQnQdBPj4xTVjm5/kZVi5Z9rmtQt0hU1fnq8S1gBu13By7kKMpymUJPk32MAC
 SvsiVuO3JfnZrAOjpGiTESjFJLaVyCg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-ZK0Lzk2iMSCfRgoSpYf4HA-1; Wed, 08 Apr 2020 11:05:26 -0400
X-MC-Unique: ZK0Lzk2iMSCfRgoSpYf4HA-1
Received: by mail-wr1-f70.google.com with SMTP id t13so4279018wru.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 08:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y1YeSmYbIJL1PiAGxEkBHwkbsOcVYoGnDQi+4h86LtU=;
 b=aGLQg1McIpNbxnUH++yRIqFtggFi6Lt5TBopzHGYGiUP9EPXdix8eCO9pY8uA56ffi
 t0qK5+Kb0Q9fBlowvQZ1uJcaSnLQv4Zls+9PlHliTEWhSf8KILsBkDMFPxLcsnvVKxTa
 kuDOZRWPqm6f7gfPyrHa9d8UShadkDujgBkqc2MJhi7VzGJUvIPpTFqGiq3HHyb5oz2I
 QRg8zgC3CrZ/IkQzPG5ogxNCgMd5FOkRDFjAxDQ20jYPx1J6A3Pf3x6K/v9l6DFKZwrv
 PwJGRBRl1wPKGebi+v2RDtgQ66lLSQhbNB1IX6e1ntWAIZbdjWi4o5y3EoozUXETAoNG
 LyzQ==
X-Gm-Message-State: AGi0PuYUmE/mt0og4vSLnFKJ5w4Kaidpnn8rscNSp04NYsdw1k+CmPA5
 Tj2VKUNAeAuEYUUB/1gPmNpeiy0ylgbJJlx2ZH4cvnJzp/JGll/mue8mqOcFDFFV8Sk6EB1P12i
 RifL8YFhX381qDck=
X-Received: by 2002:adf:aade:: with SMTP id i30mr8798708wrc.336.1586358325367; 
 Wed, 08 Apr 2020 08:05:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypKerlsLGXSHPboPNG293ukNywPYrx0hQ1s3cCgrhgO1JuC+bvWa3z25/BfJtrC3phc7wjRV/A==
X-Received: by 2002:adf:aade:: with SMTP id i30mr8798677wrc.336.1586358325073; 
 Wed, 08 Apr 2020 08:05:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9c71:ae6b:ee1c:2d9e?
 ([2001:b07:6468:f312:9c71:ae6b:ee1c:2d9e])
 by smtp.gmail.com with ESMTPSA id u17sm7518267wmu.31.2020.04.08.08.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2020 08:05:24 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] async: fix hangs on weakly-ordered architectures
To: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org
References: <20200407140746.8041-1-pbonzini@redhat.com>
 <047d4327-8a79-ffc1-94fe-47355ed955c5@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13f3affe-0c08-476d-e85c-2a3826b5dc1c@redhat.com>
Date: Wed, 8 Apr 2020 17:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <047d4327-8a79-ffc1-94fe-47355ed955c5@huawei.com>
Content-Language: en-US
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/04/20 11:12, Ying Fang wrote:
> On 2020/4/7 22:07, Paolo Bonzini wrote:
>> ARM machines and other weakly-ordered architectures have been suffering
>> for a long time from hangs in qemu-img and qemu-io.=C2=A0 For QEMU binar=
ies
>> these are mitigated by the timers that sooner or later fire in the main
>> loop, but these will not happen for the tools and probably not with I/O
>> threads either.
>
> yes, we occasionally see qemu main thread hangs and VM stuck in in-shutdo=
wn
> state on aarch64 platform. So this could happen with I/O threads.

Thanks for confirming!  Have you managed to test the final version of
the patches?  It would be great to include test results.

Paolo


