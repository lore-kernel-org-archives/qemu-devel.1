Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5E3C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF6B2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF6B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsDGr-0006kY-O8
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsDFa-0006BW-Rr
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsDFZ-0003tS-T1
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:32:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsDFY-0003sk-5O
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:32:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so63488000wrs.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 14:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ta6yFkWaTOOr9slw1D7NlZu6j2glEYecvNoJPmsns0A=;
 b=hesY7msPyczgH93SFgfWN7KUCHXtL8rESwZR8gF0ldck0NeQYxmKkcMU+eac92k05D
 QvtzDulKTSa2FX+u9La0+O1rQyHj2EHAMLTlxNY8bTggxuaetkQYNUnDKwpJwF9fQoNL
 tSDZxbaFPAkj6nIqemEF+fxEiF5B+lvyg5ozlhbxQvZy964LediTk9XQZXpUTqqM0gX+
 jvZLADlwfYRe+oSNeCIAhN1Nxw683XBwdWA2RtaDFvXWe42FlFMgNjtzlPsPU/W0d/Z1
 CqQ5uwkxaYkUQj9WTe2CS8AKU9A/NmR4jqq9V8dwyudbSTHNLFY64g1Fnm8INuMgEp7t
 xUaQ==
X-Gm-Message-State: APjAAAVIdHvDmu93w/zwrB44wEWgCfDvMilR7CrqH9yYHoRDOK26GNQI
 tZrkxx7Lu4U4frLgdh3gXmTBuQ==
X-Google-Smtp-Source: APXvYqw/6vsvpgcxOrpbzUSvwcfC3uaO3zsN5VjsMLXdR6oFcqbcWtBhT8d5AZNw7Nmkpuq8RP7WBg==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr3032317wrl.79.1564435926423; 
 Mon, 29 Jul 2019 14:32:06 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w25sm59038357wmk.18.2019.07.29.14.32.05
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 14:32:05 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <1562554503-177179-1-git-send-email-shaju.abraham@nutanix.com>
 <087e6cb5-b24d-b144-744c-d74defeadb86@redhat.com>
 <34a8030e-a173-162d-6786-3dafa5a1d4ed@redhat.com>
 <20190729100946.GC3369@stefanha-x1.localdomain>
 <9c34e70f-5ead-309c-865c-4a64d8a28724@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7005cc99-3bb2-fa70-aaf6-86870c37827b@redhat.com>
Date: Mon, 29 Jul 2019 23:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9c34e70f-5ead-309c-865c-4a64d8a28724@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] Fix Guest VM crash due to iSCSI Sense Key
 error
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
Cc: Kevin Wolf <kwolf@redhat.com>, shaju.abraham@nutanix.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/19 21:45, John Snow wrote:
> Next, we'll unschedule the BH if there is one. I think the only case
> where there is one is the reschedule_dma case of dma_blk_cb. (I'm not
> too familiar with these DMA helpers: in what cases do we expect the iov
> to be empty?)

When there is another I/O that is using the DMA bounce buffer (the one
case that comes to mind in which you do DMA from MMIO areas is
loading/saving VGA RAM).

> So it looks like this cancellation will produce one of two effects,
> depending on when it's invoked:
> 
> 1) We'll stall the DMA permanently by deleting that BH, because
> dma_complete will never get invoked and therefore nobody will ever call
> ide_dma_cb with any return value of any kind. The IDE state machine
> likely just hangs waiting for the DMA to finish until the guest OS
> decides to reset the errant controller.
> 
> 2) The DMA will continue blissfully unaware it was canceled, because the
> lower AIOCB has no cancel method, and so will finish, call back to
> dma_blk_cb, and continue the transfer loop unaware.
> 
> 
> ... Does your reading align with mine?
> 
> 
> If it does -- if there are indeed no places in the code today that
> artificially inject -ECANCELED -- I need to remove these special stanzas
> from the IDE code and allow the IDE state machine to handle these errors
> as true errors.

The bug is that there is no place to inject -ECANCELED in the dbs->bh
case.  I've sent an obviously^W untested patch.

Paolo

> I'm just not confident enough in my unwinding of the DMA callback
> spaghetti, though.
> 
> --js
> 


