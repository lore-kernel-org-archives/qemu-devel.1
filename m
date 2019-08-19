Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60650C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E9F206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E9F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziNY-0005xw-Cz
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hziMu-0005UY-Mi
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hziMt-0006Cm-B3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:10:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hziMt-0006CW-3O
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:10:43 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E931164043
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:10:41 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id h3so5312739wrw.7
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 07:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I2zyjHD2ke/DcDnodzJT7UVFnr3rQjHxfcTBA/cAirU=;
 b=ntg38MXMvidMAopHhaQBKJAaMFItLPsRVwet9uij9dCzRDbb6lzRJwtmxV85227D/0
 BLONM25DL59lAWVbGeJZKJUGo0L7ZFPudRtoiObtBiINUcQpYg42U6ynryq5R0HNU4wU
 mUCLHHM/oCbd4oCj2KVZgjTKPD2R/mJoxo/KOLJ5CC9mXe0b57yRAAcqiPMF1xddyDhQ
 ojcctT7VJ+SeTbfYlj2HRDmvizV/HaLebRbwKYoboKMx0sa3qlk/rrHghZZyi7sHbrKX
 Y12rwK87TJ+4pQT9v7wBm1IJpDVG0ZKuk8BYc6zDHkE6BbT8PzI2wAAUkgRKu1i+0G2B
 Tsnw==
X-Gm-Message-State: APjAAAWOqqVz8PtKTbKL2NJwdBNJeGUzcnpwJzCAYBPIPJpSpvwSX6BD
 uXbKsgKr9B0M3OR5MkQqvGRaG/kcGFlqErKXGJZCqS1n2+ociIhIqyfBJDbbVwl8NI7gwLOgrA+
 W4+R9C30jToWNvgM=
X-Received: by 2002:adf:8004:: with SMTP id 4mr19857755wrk.341.1566223840498; 
 Mon, 19 Aug 2019 07:10:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1+iXEK+s0t+/gwGtW+6iKHeKAiWoHR786oRIFNLoQY5otuKoTwXxum9khbhnWWOB4D4t0fw==
X-Received: by 2002:adf:8004:: with SMTP id 4mr19857719wrk.341.1566223840193; 
 Mon, 19 Aug 2019 07:10:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f?
 ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
 by smtp.gmail.com with ESMTPSA id c15sm40715342wrb.80.2019.08.19.07.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 07:10:39 -0700 (PDT)
To: "Yao, Jiewen" <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4afa24cb-1ab7-b085-ba84-70271712d62e@redhat.com>
Date: Mon, 19 Aug 2019 16:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/19 01:00, Yao, Jiewen wrote:
> in real world, we deprecate AB-seg usage because they are vulnerable
> to smm cache poison attack. I assume cache poison is out of scope in
> the virtual world, or there is a way to prevent ABseg cache poison.

Indeed the SMRR would not cover the A-seg on real hardware.  However, if
the chipset allowed aliasing A-seg SMRAM to 0x30000, it would only be
used for SMBASE relocation of hotplugged CPU.  The firmware would still
keep low SMRAM disabled, *except around SMBASE relocation of hotplugged
CPUs*.  To avoid cache poisoning attacks, you only have to issue a
WBINVD before enabling low SMRAM and before disabling it.  Hotplug SMI
is not a performance-sensitive path, so it's not a big deal.

So I guess you agree that PCI DMA attacks are a potential vector also on
real hardware.  As Alex pointed out, VT-d is not a solution because
there could be legitimate DMA happening during CPU hotplug.  For OVMF
we'll probably go with Igor's idea, it would be nice if Intel chipsets
supported it too. :)

Paolo

