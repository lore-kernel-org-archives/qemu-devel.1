Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B92C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899A9204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899A9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho4H1-0005gG-TA
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44266)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho4Gp-0005Ba-CQ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho4Gm-0000xl-SG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:08:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho4Gm-0000va-Lx
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:08:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so28198425wrl.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 04:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q2fq1d9/oo3bIAnatC3hN81hxfAR9Qw++5Mjp/Rbbfo=;
 b=hBh1ldrbVCqJffFqd+80AJxZ/ti2xActtGqx34pdgzCVbHlvwr0aiX+BQ1EEGahBLs
 //Rpo/kK93yoNaveyES4qWYdiNvkvH+cs+cO7/RaoVijRv68alal6QRpoBU532R6PpBE
 8jkB7iX3DLAReZLxeKVtQ2fbfbEbZGUeBFyaBV7CrbfYg0TPC6k9Phrj/ljsTJEz4Ity
 Id/rnDagZAyWGIK48ZeWsXRxHkMzcmz6zEvpRWCitVWZK4QNDagdvtF7ZbmJUWocr0n6
 A9kn2GY5CoTL+dAbeXDn5gRLCwoCsOBwuoGECeox0EHOIegclPv/AaO1XfzVYWYq+Z0K
 30ew==
X-Gm-Message-State: APjAAAUa3+GYpn1A0ARcTK5FTFKVL/IqqPSC+2LbY+Gg1hhuwbGneMo5
 yhQikb38UMculZnEb7CA2/JKaw==
X-Google-Smtp-Source: APXvYqyKlPIPmSN7wzrJWHHZWxWisVo6wrm5bltwml2dZ67cy0hthjuvbpWLQzW3jE8+m+iECE+huA==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr51599013wrj.283.1563448095159; 
 Thu, 18 Jul 2019 04:08:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id a64sm27253649wmf.1.2019.07.18.04.08.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 04:08:14 -0700 (PDT)
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190718103951.10027-1-npiggin@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a411dc3f-3b9d-8977-0ec4-dc0e8456af51@redhat.com>
Date: Thu, 18 Jul 2019 13:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718103951.10027-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 0/3] Series to implement suspend for
 ppc/spapr
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/19 12:39, Nicholas Piggin wrote:
> Any comments on this series would be welcome. Hopefully someone who
> knows i386 can give some feedback on the possible bug fix, and
> whether the new wakeup method will suit i386.

Looks good, though only i386 supports wakeup so perhaps it's better to
DTRT and move the reset to the PC machine's wakeup method.  Then pseries
need not implement mc->wakeup at all.

Paolo

> Thanks,
> Nick
> 
> Nicholas Piggin (3):
>   qmp: don't emit the RESET event on wakeup
>   machine: Add wakeup method to MachineClass
>   spapr: Implement ibm,suspend-me
> 
>  hw/ppc/spapr.c         | 11 +++++++++++
>  hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
>  include/hw/boards.h    |  1 +
>  include/hw/ppc/spapr.h |  3 ++-
>  vl.c                   | 31 +++++++++++++++++++++++++++++--
>  5 files changed, 75 insertions(+), 3 deletions(-)
> 


