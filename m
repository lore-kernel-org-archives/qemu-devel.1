Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E7C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983052176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HChLM/Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983052176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j456t-0001Ak-QL
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4562-0000E5-UT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4561-0005Za-Oh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:47:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4561-0005ZA-KZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582040856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqzvczSd7hsfKd5wUqF8qpa0Jcq9c4LI8xf3e+uUOpQ=;
 b=HChLM/OwUPCWATTpFTDgtpwy8+UPMAchgwgLKuFvrn3NplxmbiCG/5LuBnKpiCe6oi0hSZ
 4t0hz8GaXqXfztbsBChOhX3hnCjb5UayJtmFPGlpvtmZFPgemy4GYLQfalWqYJ+xGdfFrP
 S/unLh1SmL0hOProEQcdOkubl4yEVuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-w1R2-YJIMMS7ZizDkqD8dQ-1; Tue, 18 Feb 2020 10:47:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3687DB49;
 Tue, 18 Feb 2020 15:47:28 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE4BB60BE1;
 Tue, 18 Feb 2020 15:47:27 +0000 (UTC)
Date: Tue, 18 Feb 2020 16:47:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: no-reply@patchew.org
Subject: Re: [PATCH v5 00/79] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200218164725.106c5666@redhat.com>
In-Reply-To: <158197229663.4691.11682540765175903321@a1bbccc8075a>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <158197229663.4691.11682540765175903321@a1bbccc8075a>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: w1R2-YJIMMS7ZizDkqD8dQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 12:44:57 -0800 (PST)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/20200217173452.15243-1-imammedo@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
[...]
> 8/79 Checking commit 363d60235895 (alpha/dp264: use memdev for RAM)
> ERROR: spaces required around that '*' (ctx:WxV)
> #30: FILE: hw/alpha/alpha_sys.h:14:
> +PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4],
>                                                                       ^
false positive

[...]
> 66/79 Checking commit 37756d65c749 (ppc/{ppc440_bamboo, sam460ex}: use memdev for RAM)
> WARNING: Block comments use a leading /* on a separate line
> #50: FILE: hw/ppc/ppc4xx_devs.c:669:
> +/* Split RAM between SDRAM banks.

fixed up in v6 posted as reply to this patch

[...]


