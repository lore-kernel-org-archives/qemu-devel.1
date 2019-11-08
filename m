Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15DFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AAC2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AAC2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1TE-0008TP-Ge
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT1Nh-0001Wc-PV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT1Ng-0007Ox-7J
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT1Ng-0007OS-1V
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:20:40 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F257C59451
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 10:20:38 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id b10so2182314wmh.6
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 02:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QtT10W8vgH8OqSewK4mmqQdOpRcpmXW/jxpUrutYBGA=;
 b=BxBozVpDWR8rM6aVChRIFqUv8Pfq8WMkrg8xCbDCO6H5z1VIfKkjdphO/STLEMZSp7
 YIMEQSJMRI8XlUZNZPQ4/OSx4PudMmwcbKZkS4S+XxbuCEx6W1cSTVr17ryx/ibJGUk7
 QiKNxPuAqbz8r8c0wL9HU/XpQMPBkLu3i4Nw7sdk1EDI3NPff2jcMByaGsHy8zH6Dzc5
 WqQiX4CDaEGg69DKFxe5u0TRXj2Brag2rAxL5HqBXYDq9dx/qGyJn6Tgx7eDOTez4SSr
 1uVFM22usZ53loCEyPfvUEr910DmuJ4RH4OeuJEqyshFz12AqUmJ7LlET3bOYliw9YTS
 wD7Q==
X-Gm-Message-State: APjAAAW0NR9Vqoc/JhQgk6IHjn4TyMEFbzmbDdEOSQP80DmRa7d5gS+a
 kBXlm8TxY1c90oPU/HM1X6NDccW/m4Sv0CJRgMCFoFJNe2ldAI+ly8N2Fxrd88bbbSPIdUWEPvj
 es/dIK0yAS0GmRlg=
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr6855087wrm.299.1573208437762; 
 Fri, 08 Nov 2019 02:20:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJD5QTYxzpcfnlx4wZ1NmYOXzEgE/v7xCk30BeKkFYfrhNjoyqngiuSIuFaZG1PsWcdIzClg==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr6855074wrm.299.1573208437549; 
 Fri, 08 Nov 2019 02:20:37 -0800 (PST)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id h8sm11057249wrc.73.2019.11.08.02.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 02:20:36 -0800 (PST)
Subject: Re: Should QEMU's configure script check for bzip2 ?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <da6cfaeb-420e-6e84-ca14-a75d900d65c0@redhat.com>
 <20191108094856.GD182396@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <839dd7c3-2f28-d00e-c14b-abd507f2296c@redhat.com>
Date: Fri, 8 Nov 2019 11:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108094856.GD182396@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 10:48 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Nov 07, 2019 at 08:43:27PM +0100, Thomas Huth wrote:
>>
>>   Hi,
>>
>> I just tried to compile QEMU on a freshly installed system. "configure=
"
>> finished without problems, but during "make" I hit this error:
>>
>>    BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>> /bin/sh: bzip2: command not found
>> make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
>> make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>> make: *** Waiting for unfinished jobs....
>>
>> Sure, it's easy to fix, but maybe "configure" should already check for=
 the

You found a bug :)

>> availablity of "bzip2", so that we then either skip the installation o=
f the
>> edk2 images if "bzip2" is not available, or bail out during "configure=
"
>> already?
>=20
> The general rule is that if we run a binary we should check for it upfr=
ont
> so users immediately see any missing pre-requisites, rather than wastin=
g
> 30 minutes waiting for QEMU to build & then fail.

Yes, I'll send a fix.

Regards,

Phil.

