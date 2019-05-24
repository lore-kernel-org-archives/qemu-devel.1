Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C15DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 20:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD5C217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 20:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD5C217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUGPp-0003AU-Py
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 16:03:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUGOr-0002rP-5y
	for qemu-devel@nongnu.org; Fri, 24 May 2019 16:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUGOq-0003j6-8B
	for qemu-devel@nongnu.org; Fri, 24 May 2019 16:02:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hUGOq-0003id-1z
	for qemu-devel@nongnu.org; Fri, 24 May 2019 16:02:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id e19so2651640wme.1
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 13:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NRlY775EICpwaY8JpTjiQ7Cg4KD2pMQe5qV2pmGqXNQ=;
	b=XS1P72q0WWsqriZodLj1HGUuzmJ7ILMN+5/1VfNlDLQEELn5fHDxaqbMHSqwkUp3Y+
	RhsnEp6H9N9mBfQloleVrbjpmfyZWZPSzLHX6xEgDjOv2yG1wjcy+3IBOrDCPSu47gb/
	Zf24ol9suWGhkDkDKwakyAe7Iajdx59Q89nUYm6TjtFSORLVcrvrwzpQYQep6M/M6LI2
	o2v5L1Zhc90obw+ngtMjATq7Tm698ZMrTBP/4ajb/mo+zQlOyhhtYrARTubXOelFuBIj
	Btax937k8Ywd/xytPVCN602rtX6DPErbUrobnnh9Ip0634gYSgyCQ+NqO1xs0YL9Yzx/
	L2kg==
X-Gm-Message-State: APjAAAWNMscPp4mh5aATVaGYyi4ICaZ2+Hlrsd9NHKPxRzlOc/ZMZPLA
	LOBJKNAwLVHu0eHwy3cGpRflew==
X-Google-Smtp-Source: APXvYqybq0Gu2+Vq/FYDmu1tAzRHwdBPv7O+U5H/8fvnPV7NhaAtTgUoh0wL73Nb7JNtZoEH3N3ifA==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr1138923wmi.167.1558728162563; 
	Fri, 24 May 2019 13:02:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4d53:18d:3ffd:370?
	([2001:b07:6468:f312:4d53:18d:3ffd:370])
	by smtp.gmail.com with ESMTPSA id
	y17sm2931344wrp.70.2019.05.24.13.02.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 13:02:41 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
	<87pnobrg37.fsf@dusky.pond.sub.org>
	<CAFEAcA8db=UsyU_kRBoatFT2ULQBqL318xRhg+CV4D_7hV76Og@mail.gmail.com>
	<7e468375-ca5f-0048-789e-c41d09065eeb@redhat.com>
	<20190521203712.GO10764@habkost.net>
	<dff30917-557a-cf41-e82e-03465d0209aa@redhat.com>
	<8a936e5b-9e27-b1a2-dc3c-fa0190d54923@redhat.com>
	<1351764e-ee0f-c863-de38-010314ca7003@redhat.com>
	<20190524190850.GK10764@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a905e7bb-ab8f-247f-f213-d814e09a5182@redhat.com>
Date: Fri, 24 May 2019 22:02:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524190850.GK10764@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/19 21:08, Eduardo Habkost wrote:
> On Fri, May 24, 2019 at 08:34:23PM +0200, Paolo Bonzini wrote:
>> On 23/05/19 14:20, John Snow wrote:
>>> OK, if that's where we're at! I just saw the RFC from Peter Maydell and
>>> assumed we were a little further along the decision making process, but
>>> maybe not. I'll stay tuned.
>>
>> For the decision making, yes; I think there's consensus to use
>> kerneldoc.  For the "debugging and seeing if anything has changed in 2.5
>> years", no.
>>
>> Testing the patch that Eduardo posted will help Gabriel, Eduardo and
>> everyone else decide whether to patch kerneldoc or rather change the API
>> doc comments style.  (Personally I am in favor of patching; the
>> different coding conventions make using vanilla kerneldoc awkward, and
>> there are several thousands of lines of existing doc comments which
>> would require a transition.)
> 
> I'd prefer to fix our doc comments instead of patching kerneldoc,
> whenever possible.  We don't even have a consistent doc comment
> style in QEMU.

I think we *mostly* do, at least as far as the @/#/% sigils are
concerned.  In particular, only "#" separates the QEMU doc comment style
from the kernel and it has 200+ instances vs. 6 for the kernel's
'&struct foo' (all in accel/tcg/translate-all.c), so it's clear that our
standard is different from the kernel in this respect.

The rest of the patch is to handle typedefed structs, which again is
more or less a necessity.

Paolo

