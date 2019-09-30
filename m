Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5DC388F3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89A220679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89A220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEt32-0005O8-J2
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iEt1r-0004kr-MA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iEt1p-00088w-Ur
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:35:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iEt1p-000884-Os
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:35:41 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19BC836899
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 10:35:40 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j2so4329726wre.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zx5vfNXFM2ZHpXnfBNCQCh//CUROb+k/hFweI12GYLQ=;
 b=peSCxar2ZCCmuUZ7JuFErQfZoMen/kKm6HC2ssrbE5ZAnkzbm36VfqYNwjOEWsWAOW
 KPujyxVFtEWE6ACTxLCud6eod9ZmujJ31gs+qfJaVQaAKmoouzpGOceYENwoCDCv3AcK
 W6s0SIxBdvsL3949rwaOLu9CpD6Kic85Y9Gnbh7V4vdUzMG7sR0G5nvxT7CfVJ2By59N
 yGU7MMNewYSpV8SXEeXCj4V5/iQVpyZLOkgxT4onW3+pwPeEdz4IygmZO4CJb+/Sc8ye
 ZQnL9YVY9Q/6iy1+Cjb7DsbPF8GHeIh03HfBs2bvFYGQYv8q+ag7oQuzMyjkb0qe0SHi
 W+3A==
X-Gm-Message-State: APjAAAXJm0clqpa9AQcr1a6RLXQy9PSTVuX7uFGAzkVxQH+NwbtM9HVG
 afgNo54cIv9MyiqYI8P6RGscZ0EFuDldefTYBxJKaMLlnDT5Q+1dxa5JehZxy+OjfrwI8HTn3Z/
 0ATzNDmDiyfyoEB0=
X-Received: by 2002:a1c:1aca:: with SMTP id
 a193mr17082542wma.120.1569839738710; 
 Mon, 30 Sep 2019 03:35:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1zVajw0VhHCajWqJrX/YGOuRUqnV/kZGMp/kHCrm0HrT/YIM5KNfWh8s5kVTHpUIpBS+Hgg==
X-Received: by 2002:a1c:1aca:: with SMTP id
 a193mr17082517wma.120.1569839738448; 
 Mon, 30 Sep 2019 03:35:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d958:8ffa:a1f9:6bfa?
 ([2001:b07:6468:f312:d958:8ffa:a1f9:6bfa])
 by smtp.gmail.com with ESMTPSA id g11sm14980623wmh.45.2019.09.30.03.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2019 03:35:37 -0700 (PDT)
Subject: Re: [PATCH v7 4/4] s390: do not call
 memory_region_allocate_system_memory() multiple times
To: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-5-imammedo@redhat.com> <20190925032700.GI28074@xz-x1>
 <20190925135105.6e5f249a@redhat.com> <20190925235235.GV28074@xz-x1>
 <20190927153320.2edc683c@redhat.com> <20190928012808.GA31218@xz-x1>
 <63e706b4-4a6a-3be5-6bb7-9c744d269d98@de.ibm.com>
 <20190930113329.71cab280@redhat.com>
 <475f2019-4cc2-5d55-06de-99ea907c4d28@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <496f97e0-ae90-3e3f-6781-c3bcc8171d4e@redhat.com>
Date: Mon, 30 Sep 2019 12:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <475f2019-4cc2-5d55-06de-99ea907c4d28@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/19 12:04, Christian Borntraeger wrote:
> Paolo, ok it I pick the first 3 patches as well? Can you ack?

Yes, please.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

