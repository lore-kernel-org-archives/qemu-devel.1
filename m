Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E8E206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9LHybMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E8E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3qL-0000jL-4d
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kD3pY-0008Ap-0O
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:48:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kD3pU-0002oR-RH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598957275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOeoxQ2+FEh1ZAAwDhF43GksqD60IF+AxtwvZU9FAoA=;
 b=W9LHybMpMawo4yVkbUwb+RFnpbcR8PogJboM7D8XQnATH7hO4u0Wv+Sm2qPf3OUKmY0CVn
 hyt8ifJpHIwXCcGuQyAO2aQGJFObgSDfV1KKNLcL6t5IDFHdDPC+4nSFavrypIH9ul1UQu
 dxGv467O5fub8HLEx0EAeVG/6YHFeow=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-CxIpuPeZMa-PfE5geiFigQ-1; Tue, 01 Sep 2020 06:47:52 -0400
X-MC-Unique: CxIpuPeZMa-PfE5geiFigQ-1
Received: by mail-ot1-f71.google.com with SMTP id a3so321965oti.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 03:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vOeoxQ2+FEh1ZAAwDhF43GksqD60IF+AxtwvZU9FAoA=;
 b=LuglHYIHiZ+wNUGOVBr/ddOWMiLpuEmaDhRO+50derBmw4JOrHLj+bZRkALknsuh7x
 P1+deeoTKterwUOUdcQKkU4NlTklRFwBNNKdKeIrG574lcc3S70sDp9V5lGOSF/YO/1D
 hc/fWvDCglh2zwu1lylKBXnpAh8OH+ocils6chd33eop+hpQ42kCPbIrEW6st2c8le1t
 Q+KbyTX+8uA7hAoyixqX7z6SR5M2Uyw7KHd/wUX8nGiN0WGXtRQur6Q6ZDGMZxqFoDaY
 AWWI0PKnetMVTK6kAf5pXwr6OCF7tYUgN3Y4CAv+RwUv3RO75JoNe7+WkfWCSH1e6fSz
 qvKA==
X-Gm-Message-State: AOAM530jUZ+8lzCP8Z6gjkr6j08W6Wioixt1qn1eBue7+o9GT5CDxvzH
 do6GsxmkQGA03Jm0/WT7RIED7MnIeyZJpVAspK/21f019cs01VjQVzJ5ci9qK6DBPM7RSz/Br8u
 DnxagMjjoR8iY1J0JPEdCbjDTDXH+qXE=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr752083oif.56.1598957271340; 
 Tue, 01 Sep 2020 03:47:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw12UxdQQKnRwuhkLLPrjXFIq8TJ7ufYLpKK97s+pCV2t2UDc/WpQ6fFBrkXkhW1cvUkYiDG0+CbE7c3EplBt0=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr752079oif.56.1598957271116; 
 Tue, 01 Sep 2020 03:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200831140127.657134-1-nsoffer@redhat.com>
 <20200831140127.657134-2-nsoffer@redhat.com>
 <w51a6y9okrv.fsf@maestria.local.igalia.com>
In-Reply-To: <w51a6y9okrv.fsf@maestria.local.igalia.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 1 Sep 2020 13:47:35 +0300
Message-ID: <CAMRbyyvgPrrkkAUK8mT1yeg=B8aSj5=8AcdRKZd3Zzj0QYjjcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: file-posix: Extract preallocate helpers
To: Alberto Garcia <berto@igalia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 1, 2020 at 1:27 PM Alberto Garcia <berto@igalia.com> wrote:
>
> On Mon 31 Aug 2020 04:01:26 PM CEST, Nir Soffer wrote:
> > +static int preallocate_falloc(int fd, int64_t current_length, int64_t offset,
> > +                              Error **errp)
> > +{
> > +#ifdef CONFIG_POSIX_FALLOCATE
> > +    int result;
> > +
> > +    if (offset == current_length)
> > +        return 0;
>
> You can also take the chance to add the missing braces here (there's a
> similar warning for the other patch).

Sure, I'll change it in the next version.

I forgot to run checkpatch.pl, and it also seems extra work when using
git publish.


