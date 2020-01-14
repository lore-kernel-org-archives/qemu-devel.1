Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8005EC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B00024676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sW7VMcwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B00024676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKJo-0003Jk-Cu
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irKIV-0001y5-1y
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irKIU-0005T9-4C
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:23:46 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:45643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irKIT-0005Sq-Vh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:23:46 -0500
Received: by mail-oi1-x22a.google.com with SMTP id n16so11422885oie.12
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 03:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eLtOGnrWBSUk7yc4uJqc+K2sQW+NnelyLPsR72FSB60=;
 b=sW7VMcwksrYyxWd94VSSbQq7sNUx4dcK7CSzCM+8S81ZKRwl3zw9erIIqe1lieBipw
 E8b03zJO7mIH/58OY5NXE+5yAopFxaPydgs1SJt7YqoAuhbxe9ktGvN+0gfuRb/nW0XI
 A7qFcs8pH3ia16xaVSMSWe7UyOZq+2yo+kEwS++0Ozfh4oq7x+ASNhQiBMKtJchoElNs
 CPxvJQhha3Ndc+hU0r7AYrnE1Um+mpg28520avI17FY6J1qHAcv1FUapHCKollYPblr1
 8Gz91/8Rx52HA/52Vy5ZQ846KsR7kPBZ61y70N4SRTU1IlrK7+o+Hci7DO3lGjGL8vth
 8iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eLtOGnrWBSUk7yc4uJqc+K2sQW+NnelyLPsR72FSB60=;
 b=D5uNWEs1JWtXg27bBXZF59Qf58dnR7eCoD8O3dKa9eUN/0IHpiSnGorxM3fDPgLUkZ
 +Fp7IMyNfv72oChoUxOSbqHKwnaqzhFyL2xqns1WwRFAf2zr6GUyB06vYNwuR3fU6VUu
 FkHG85BaPtC0b5biyKlIbU6QuJVQ94kEYNwiT8BzxBEO9z3EmapY9bTVBPtL23zhRIre
 KWjzquAkD+2Y2LcEuh96JhVFs//SDxeMrLCIIt0/EiZqtqINEEgl3PK2IeGhjyNBZXpw
 PxxPRC8/sOLb5BbzCeZbDNSHrQngOu0uszjakSbYqgo4MVxAqiEf9QhIPOoIPTSrAoBB
 uwHQ==
X-Gm-Message-State: APjAAAX8pyj20D3WzddI7xOxdhyKbZ26PUW6fXch9b+S5fTi9zSL53H4
 YSmpituR2y4QV5eglm7mQU7x+OYMJHHmuNFamNXohQ==
X-Google-Smtp-Source: APXvYqx23JdE2e2IcUAjjzfkfJ9scPxM8bVHA08lPW6TZucrpph5O8qyFq30HuETMIJJrfbD3+2XmAGksepUeWgZ3cY=
X-Received: by 2002:aca:570d:: with SMTP id l13mr15625752oib.146.1579001025198; 
 Tue, 14 Jan 2020 03:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20200114092606.1761-1-quintela@redhat.com>
 <CAFEAcA-7aLrp4n9gtD=0MzmMDpzNyJCUpOmY2XPxNOun5MKeGA@mail.gmail.com>
 <875zhewae5.fsf@secure.laptop>
In-Reply-To: <875zhewae5.fsf@secure.laptop>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2020 11:23:34 +0000
Message-ID: <CAFEAcA8JCmxx4XGbGnT1gJZ9b=Mj3Tq4yS8-9y2NrKFvSBK3_g@mail.gmail.com>
Subject: Re: [PULL 00/29] Migration pull patches (second try)
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 11:22, Juan Quintela <quintela@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Still fails on hosts where ram_addr_t is 32 bits.
> > Looks like you still haven't got the fix for the problem
> > Dan pointed out where multifd_save_setup() is using the
> > wrong type when it calculates p->packetlen to allocate the
> > data structure.
>
> Ouch.  Then there is "yet" another different problem. I fixed the one
> that daniel pointed.

Daniel pointed out both bugs back in July, in the same email,
and again this time around...

thanks
-- PMM

