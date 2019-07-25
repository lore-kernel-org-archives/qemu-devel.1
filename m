Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4427C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB7621901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB7621901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqb0D-0002g8-Pp
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59241)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqb03-0002HG-0e
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqb01-0004wC-RR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:29:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqb01-0004tS-JF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:29:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so50136270wre.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5TlqZFcDImzQ42NqyCae78vvlbEeWZojRMuY42B3eVM=;
 b=I7BPhES+DebD5dFG34GhF6k/ie2Yf9Dzg+04WRwjZ/nShQp7IUkEavlcocNj6683P5
 2h9Bpa5nuLxTjt0EkIsytwhYal3KusyAzOavzNbaP9gNl3V62TZ9DoN5X6vvaBBDSnFE
 klrTohbKkvlUKbnhnc1WjyVqcd2Tem8IFiGkntB5SNz8Y/y9ag8YIpi/w29F7sWJiuFh
 8Tz1P4xPPL++NHNXbAZ6NXy1ECUbPKMUxxWnqfwS5l3HgbnbrTLZ1e73ovQeOUozaIFm
 dLGICXfDwdL6y601Y7aBz/X+AMP+cbOxcZyLp1fJtCJvi+DM/e1/UbPWSTgnDeI7AEdK
 93og==
X-Gm-Message-State: APjAAAUZCoGXkCoVX97o9cgKr6EgTh7HALj8GxVKv+NIu3q911DS5CuL
 z8fVafHTs4Z9I2hVChDdqQophQ==
X-Google-Smtp-Source: APXvYqx6NcEN0rFxHjmHDZ691TnEbg+JukmS2U/DcTMsNp9FKxKT/4bvAUUZyZqskdB/4Ts4MvMunQ==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr21328106wrr.70.1564050562378; 
 Thu, 25 Jul 2019 03:29:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id c78sm70552068wmd.16.2019.07.25.03.29.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 03:29:21 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190725101836.1273-1-pbonzini@redhat.com>
 <CAFEAcA-ta49Qe29zoSzW52OWXYHf+c5t+X3t27Qc3n=harDT=Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <821f0761-a159-3cab-7608-ff09705ee4c1@redhat.com>
Date: Thu, 25 Jul 2019 12:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ta49Qe29zoSzW52OWXYHf+c5t+X3t27Qc3n=harDT=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] 9p: simplify source file selection
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 12:21, Peter Maydell wrote:
>>  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
>>  # only pull in the actual 9p backend if we also enabled virtio or xen.
>> -ifeq ($(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN))),y)
>> +ifeq ($(CONFIG_FSDEV_9P),y)
>>  common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
>>  else
>>  common-obj-y = qemu-fsdev-dummy.o
>
> Maybe we should update the comment here somehow too now?

The comment is still accurate, just a bit low level. :)

> Patch definitely looks like a good idea, though -- those
> nested land/lor calls are pretty ugly :-)

Yeah, FWIW this patch came out of Meson conversion, where the sourceset
mechanism supports "and", "nand" and "or" very well but has issues with
"nor".  While I'm open to adding "nor" if it is really needed, it seems
to me that in general we should not transpose our Make mess to Meson,
and rely on Kconfig as the better tool for this kind of job.

(For a Meson update, see https://wiki.qemu.org/Features/Meson).

Paolo

