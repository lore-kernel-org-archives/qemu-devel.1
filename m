Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C2DC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B53F2339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B53F2339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0l7d-00063e-Jm
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0l33-0002ig-06
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0l31-0003Pp-6m
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0l30-0003PA-Vk
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:14:31 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0606F85545
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:14:30 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id b135so1908886wmg.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 04:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rhfp2qgvDRgqWhAxuW6vwvHkw8FLbpA6+WLuiPtJ4Pk=;
 b=ugE7o0gRX8QVvfqQ5pIF+jeDT1vFaUjIoSjgEYVmOYAx24OKwfAAK+4kWcOuaQJY4G
 5oonKqGqe1HB/Yp+P/DLqJ/bhjw7uEVDIzH3X2/oKvEzYkryopudIj5OF4QmDP1oN6ds
 wF2dsdg3fmTzY7PeFcJAkXGLFtn2DJpF/lNrEIgg7nGNyn4dJlXFWqX6t63K5OjNRPIJ
 l6C261OGWy9Ac4C9SqpTw4MtR2yDgShR8e8CwmfR/7BuAJPTeJjlcHUqb0r5yhqcZ2T4
 NPph3ZGB7cJ04w8mASnpB/nROw8V+QrGa8oqHTEz4oYhFjBQT5+wsdwezj2spd7xG3Mq
 rFrQ==
X-Gm-Message-State: APjAAAXtTh8nGfHR9mXDU+nHvAEGEFicEXila3EGT3BErumpthdQjqtL
 9Y+y5dmgvhGLQ3tn09fB4caEB6gLieKWsEJZS0TTafmGEZ55K4aUWG+mhKvSKbOiz2n0tnhjOut
 582+DxJrrt6SVHH4=
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr5482591wme.35.1566472468714; 
 Thu, 22 Aug 2019 04:14:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2vVPK89Fv79pRuHL1UpaRfdcYIlVmr5mkSOGEqPs8SS8O0ueLIV1nlIkkjGM1dNhSOvBXsg==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr5482573wme.35.1566472468402; 
 Thu, 22 Aug 2019 04:14:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id v7sm8109442wrn.41.2019.08.22.04.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 04:14:27 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822104957.GE20491@stefanha-x1.localdomain>
 <CAFEAcA8c_BukhU+ZgfqUxPUqsOaN6MJdJL5n3-Daf-j05ZeTig@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <18cdf90d-1724-e7bf-2079-b7ec829256f0@redhat.com>
Date: Thu, 22 Aug 2019 13:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8c_BukhU+ZgfqUxPUqsOaN6MJdJL5n3-Daf-j05ZeTig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 13:04, Peter Maydell wrote:
> On Thu, 22 Aug 2019 at 11:50, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> One-off tasks:
>>
>> 1. Create CI runners that offer similar cross-architecture coverage to
>>    Peter's current setup.  qemu.org has some x86, ppc, and s390 server
>>    resources available.  I'm not sure about ARM and other architectures.
> 
> Quick list of what I currently have:
>  * freebsd/openbsd/netbsd -- these are just running the tests/vm stuff
>  * an x86-64 machine doing the w32/w64 crossbuilds
>  * aarch64
>  * aarch32 (done via chroot on an aarch64 box)
>  * osx

I was thinking of setting up a Macincloud account with a Patchew runner
for this.

>  * ppc64 (on a gcc compile farm machine)
>  * s390 (on a machine Christian arranged for project use)

Great, we could also move the Patchew tester off the Fedora machine that
is getting a bit crowded.

David, any chance you could add Docker support to ppc64 builds?  I don't
feel too comfortable doing untrusted builds inside the RH network
without any protection from containers etc.

> Of those the s390 is OK for project use. I'm not sure the gcc
> compile farm stuff is recommended for fully automatic CI, so
> if we can avoid that it would be better. Linaro can probably
> provide some arm-server resources but I haven't checked/asked yet.

Same as above for Docker support.  If ARM builds can be containerized, I
can also look for resources inside Red Hat.

Paolo

