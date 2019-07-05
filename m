Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45633C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7C02085A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7C02085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLLH-00082D-8W
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjLJw-0006GQ-Ag
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjLJv-0003w3-Fj
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:20:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjLJv-0003sn-97
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:19:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id a10so8261296wrp.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bly6fgPhRNa49Lllahy5LnB63+lFwEc5rVmnEblkrXI=;
 b=qH6jp8rFScDLRNXSD/57Or/RtnFrsfx2914XPss2hF+83eAu4TjYzK80+NXuvAWDeT
 fRVLsd/+xVggW1vMRpuX8VY35tRFHe6PsNU3LjJNyzBFKccmowemy5To8SAZ2Ym3WfmL
 xyMXsetCILWZPnCSRgwaPdaD78tkNusZdHp0reWl/2mvsM7uonK/PH3Iu9ZXH6aXH8Sn
 n6pCOKfsdIxIiHWqUhKhWoIrZIk6M5t2ODWA7mUBfPl2iN6LThhiEXryi4apSRNsxoxB
 pOO24VfFs2kNgbjj4inDG3oGscMz1TAlxVxza2hXwjcysu3X9w5tQZB7KTFzyNp3Tn/N
 Fa4Q==
X-Gm-Message-State: APjAAAW8tTAcud0LDLJiGETYm5jNXeNbOn3PX/Gz1ool2HymvUsG9MaT
 xRc5v6hvPno4JH/sQAZigWmoaU8WytM=
X-Google-Smtp-Source: APXvYqy4NaPyIQtw/hQp/atg2zYKKtUkZZy0Q7P2u65AiVqO/hmr2RdYyBKICOr1/H24ghzuBjf5FQ==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr1942207wrw.108.1562321997359; 
 Fri, 05 Jul 2019 03:19:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id d9sm12182998wrb.71.2019.07.05.03.19.56
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 03:19:56 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <156210201797.16064.1193142357173483033@c4a48874b076>
 <20190702213824.GS5198@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a94d0cc2-cc2e-4337-4b1c-74bb8de30d95@redhat.com>
Date: Fri, 5 Jul 2019 12:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702213824.GS5198@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] No symbols in LeakSanitizer output (was Re: [RFC
 PATCH 0/7] target/i386: support VMX features in "-cpu")
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/19 23:38, Eduardo Habkost wrote:
> Can the asan build test in Patchew be updated to include
> symbolize=1?
> 
> For reference, below is the full stack trace of the leak.  It
> looks like it existed for a long time.

Sure, just add the "export" lines to tests/docker/test-debug and Patchew
will pick them up automatically.

Paolo

