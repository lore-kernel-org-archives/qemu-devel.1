Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E11C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991E321874
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991E321874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvhnV-0007VS-OT
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 08:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58281)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvhn0-00070u-SU
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvhmz-0006Xc-Iu
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:45:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvhmz-0006XA-DP
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:45:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so2299433wmg.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 05:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=53Q3q447XzLKCoXf2C31qp3mSGpPh0Hmi1gehkOCIkQ=;
 b=SNWcs5Wo0YIjlsrgTWdFSfl+2J2x/7aHZciJMd1rpVEwetKARc6oygF0qpvgCqfeC7
 lyrXHmGFMCkdGobi4ggJcEFMefOqtbXzdmWd9gy//Bjhgzgz0xXGAcWHOz9JfZrGqUZh
 FtwcKe/Wy2sk1uZnneF2YejEFuJqk4txMw4h+m8yrfmu81W9KtVyumRZ3SA8xcAx+7qA
 0II9g1qSPem8atI9JE+Y72YzFCujM2+loaYCFlo+wNNsZ/0nb1NO8A4FcruQQXfFrl/z
 0hK8pbVNNf0p1HE75T5c9YiGWeYWSijekNOC/kGU28jvFIsYC/PTpJXvSMYgThzi+Vcg
 hBBA==
X-Gm-Message-State: APjAAAVeaRlhBAIDDV2Coyzt9BB9aZHxDhiVGQx+IGjF+2ujGP2Ac0cO
 s+I7y1bTQ8YM26LFirXY06yoUw==
X-Google-Smtp-Source: APXvYqyW8sChRXeghe608Htk3PNYXXBjDjbo34L4U+UJklhofB8ptQn70GSHFJBQNWpUQJDjnq9u4w==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr4463480wmj.39.1565268303984; 
 Thu, 08 Aug 2019 05:45:03 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id c3sm97046084wrx.19.2019.08.08.05.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2019 05:45:03 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Balamuruhan S <bala24@linux.ibm.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
 <20190808104904.GD2534@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5b5eb81f-86c7-30c3-16e3-7be969e45fde@redhat.com>
Date: Thu, 8 Aug 2019 14:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808104904.GD2534@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, qemu-devel@nongnu.org, hari@linux.vnet.ibm.com,
 clg@kaod.org, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 12:49 PM, Daniel P. Berrangé wrote:
> On Wed, Aug 07, 2019 at 12:44:40PM +0530, Balamuruhan S wrote:
>> Adds scripting interface with python library to call functions in
>> python modules from Qemu that can be used to feed input externally
>> and without recompiling Qemu that can be used for early development,
>> testing and can be extended to abstract some of Qemu code out to a
>> python script to ease maintenance.
> 
> I admit the use case is interesting, but this is opening a can of
> worms...
> 
> Historically the project has held the view that we do not wish
> to have an mechanism to support loading out of tree code into the
> QEMU process. Much previously talk was around dlopen'd C plugins,
> but dynanically loaded Python plugins are doing the same thing
> at a conceptual level.
> 
> We didn't wish to expose internals of QEMU in a plugin API to
> avoid having any kind of API promise across releases.
> 
> There was also the question of licensing with plugins opening
> the door for people to extend QEMU with non-free/closed source
> functionality.
> 
> While this series only uses the plugin for one fairly obscure
> device, once a python plugin feature is intergrated in QEMU
> there will inevitably be requests to use it in further areas
> of QEMU.
> 
> IOW, acceptance of this patch is a significant question for
> the project, and a broader discussion point, than just this
> PPC feature patch series.

Since performance is not an issue, we can use a QMP-PyMMIO bridge.
Most of the functions required are already exposed, Damien completed the
missing ones in his 'FAULT INJECTION FRAMEWORK' series:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06230.html

Maybe we simply need a clearer (better documented) QMP 'MMIO' API?

