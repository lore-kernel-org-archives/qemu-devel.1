Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534BAC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF701217BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtO/iwi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF701217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMTD-0007fi-MZ
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iaLN8-0004Yt-Ar
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iaLN2-0008AY-Ff
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:06:18 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iaLN1-0007pg-Ta
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:06:16 -0500
Received: by mail-oi1-x244.google.com with SMTP id l136so7939060oig.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qTJ8l4vPpwMcbWyg5Ry3AYSw37e3ZU0Z6+Wr1vz5I14=;
 b=YtO/iwi5sQBP3B1l2aJQBwFSG3XxWE23z0znn7dbTQCPChdeJ12diNcPz0M0kUxWbk
 tdSwe+nwKa7iWcX7x0POY5N4PC57yXx0+BxsBKWegak1fP09uwH8P0BKL4uk7SVYneiM
 VKyL27Jwsd9KCqiNoZjsqljcOPOmQp75sAZO2erXS4bES2hyly8WRhuunfZL6153JK0i
 CcDIcOZV26W5eBdRdy4sjgoKgUKaQDKUXm4VKGjzt0MJo/VktZ37nI2tRuSwSsw/ot+B
 UTn/RWs2SK1JsL8bpkfw5IdE6VbKDyi8ugLWjVnrZs8PTsfwHJkQrj6+G31vGTJ2PX0i
 xkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qTJ8l4vPpwMcbWyg5Ry3AYSw37e3ZU0Z6+Wr1vz5I14=;
 b=snjkjc/ybDxpKguhOPblyq42P+Z8RoT3HiDpSppJ52xiOvMxdRTiCrtxOAKimibJpi
 wJiXNt+WbQe6EMw85gmo04wIaLE396R+LFM6rfqL/QuwpvIAfm5jauKcL+DY3Zc5BVp1
 Mva/UITCYI2gmvWBOEXHA24a/oHbUd/apO2lrzx9EnTox2G0xk9Dy7sBNh6f8hXkDF3G
 ggUW+YbXZZqsPbGe88BuTx790+eC0xElLIbUFQrjbptpHTao5+2eas8O5PTvbB6QupxK
 Lrwymmlum5A8dZq0hTNeiSue4B8waW+ciI2UdJ2LU28QhadWxU/SjPlkXswC3qUe8u6m
 s7lA==
X-Gm-Message-State: APjAAAUesWLaFnUWXIe/6NhQEvgefJ6AnGq/wNkYjUvX8rcQGSWP770A
 9CVebr4QsdVGdW1aheA6GaPOq7wY2rwUD95GRLsx/w==
X-Google-Smtp-Source: APXvYqybYEPmDQPi/2vtteUZNXtPnvohh3aw65UDte47LgxCmt7S9JzEz5mXTZThfRtkyUErsbbf4O6G/v/mY3dhODk=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr7012763oif.170.1574953566869; 
 Thu, 28 Nov 2019 07:06:06 -0800 (PST)
MIME-Version: 1.0
References: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
 <52e295af-3b34-6cb7-ba52-a26ae70aebcd@de.ibm.com>
 <20191128134517.7caf3496.cohuck@redhat.com>
 <bbfd3b99-c38f-ccb0-9c16-24bad35f357a@de.ibm.com>
In-Reply-To: <bbfd3b99-c38f-ccb0-9c16-24bad35f357a@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2019 15:05:55 +0000
Message-ID: <CAFEAcA_vJP_nBRCtD=E2Lya1MejNBz0=Me-RcS6G39=VZ2zbAg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pc-bios/s390-ccw: fix sclp_get_loadparm_ascii
To: Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 at 12:48, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 28.11.19 13:45, Cornelia Huck wrote:
> > On Thu, 28 Nov 2019 13:35:29 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >
> >> Ack.
> >>
> >> Conny, I think this would be really nice to have for 4.2 (together with a bios rebuild)
> >> as this fixes a regression. Opinions?
> >
> > I fear that this is a bit late for 4.2... but this should get a
> > cc:stable.
>
> So we would rather ship a qemu regression instead of pushing a 1 line fixup?
> Peter, what is the current state of 4.2? does it look like we will have an rc4
> or is everything else silent.

There isn't currently anything else that would need an rc4.

thanks
-- PMM

