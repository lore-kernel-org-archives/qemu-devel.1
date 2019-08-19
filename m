Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B73C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA88A20651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA88A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzih3-0004wp-Um
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzigI-0004UK-5a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzigH-0002GA-2O
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:30:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzigG-0002FV-Qn
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:30:45 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D82F55117D
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:30:43 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a17so5372136wrw.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 07:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MS4B/pV3tUheCdVBtUiEF7rWIZVPnWhcDNAneU+PDpg=;
 b=oyc6gACzYXiU0wg4Ta9Mo4vVO3m+Zg8kWh3V/w9q1bvnFT9gMuY48lL7zIZzfKZefj
 7f6uDi1HSJGYnomgpaQCt3nFwFE3L+tBodu8X2c0/zVHT0TqFPZKnChG3N65s/NRsMJe
 +onqDfn0bSMsfRzw/ne343d9hhWWLExgG8XHVDpZxb0jUzvh2rK21oJDBcmPSNtIrHNy
 3Li0OM+rjLGNCLXUxMz3bGQL7YvLIlm70rovCVfvt2RoHsRU/b21oKAed/6/P0KLReKd
 Qv8/+b8eBJxX3PzxJlk9Vg4KHidE9OY+FIDD1V9Guy4XojtCyKik15ZeWokJTAYH89hb
 zMYg==
X-Gm-Message-State: APjAAAXHxVbdvucU1dWE5kxRq62d0NbWAX4TGT7aOoL++LNoeI4btZRw
 DylXwZ+Nep42oH5bGC3vqS2RCaoC4NKBGGw+9cWn+Z2NI+jnt2DFGf4sZgWSITIUW+OwcQfBjFm
 zdHqoscIuijeyrK0=
X-Received: by 2002:a1c:9855:: with SMTP id a82mr19464319wme.134.1566225042200; 
 Mon, 19 Aug 2019 07:30:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxy3MGIJtDGBr6ke9N31bj1ALob5a8natHU5pP+Nf9GNN9RHPqfwOliLDZYOo6lhb76LQnVHQ==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr19464291wme.134.1566225041892; 
 Mon, 19 Aug 2019 07:30:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f?
 ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
 by smtp.gmail.com with ESMTPSA id z8sm11076168wmi.7.2019.08.19.07.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 07:30:41 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190817093237.27967-1-peterx@redhat.com>
 <20190817093237.27967-2-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <da9a1a0d-749b-a81d-fc9a-af6ff2775be8@redhat.com>
Date: Mon, 19 Aug 2019 16:30:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817093237.27967-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] memory: Replace has_coalesced_range
 with add/del flags
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

On 17/08/19 11:32, Peter Xu wrote:
> The previous has_coalesced_range counter has a problem in that it only
> works for additions of coalesced mmio ranges but not deletions.  The
> reason is that has_coalesced_range information can be lost when the
> FlatView updates the topology again when the updated region is not
> covering the coalesced regions. When that happens, due to
> flatrange_equal() is not checking against has_coalesced_range, the new
> FlatRange will be seen as the same one as the old and the new
> instance (whose has_coalesced_range will be zero) will replace the old
> instance (whose has_coalesced_range _could_ be non-zero).
> 
> To fix it, we don't cache has_coalesced_range at all in the FlatRange.
> Instead we introduce two flags to make sure the coalesced_io_{add|del}
> will only be called once for every FlatRange instance.  This will even
> work if another FlatRange replaces current one.

It's still a bit ugly that coalesced_mmio_add_done ends up not being set
on the new (but equal) FlatRange.

Would something like this work too?

diff --git a/memory.c b/memory.c
index edd0c13..fc91f06 100644
--- a/memory.c
+++ b/memory.c
@@ -939,6 +939,7 @@ static void address_space_update_topology_pass(AddressSpace *as,
             /* In both and unchanged (except logging may have changed) */
 
             if (adding) {
+                frnew->has_coalesced_range = frold->has_coalesced_range;
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_nop);
                 if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
                     MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, log_start,

Thanks,

Paolo

> Without this patch, MemoryListener.coalesced_io_del is hardly being
> called due to has_coalesced_range will be mostly zero in
> flat_range_coalesced_io_del() when topologies frequently change for
> the "memory" address space.


