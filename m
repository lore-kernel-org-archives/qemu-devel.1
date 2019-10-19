Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF5CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 03:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678A1222C5
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 03:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678A1222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLfeE-0004V8-LO
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 23:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iLfd1-0003PH-3Q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iLfd0-0005D0-2v
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:42:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iLfcz-0005Cl-Tk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:42:06 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0B91C049D59
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 03:42:04 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id h11so4960291plt.11
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 20:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=o/TTwX0sez7a3GllNWDmoPn4DU2UEYsacMgPXlo80rE=;
 b=nGeD0YymZptdHjbPp0EEdMVPmMqfTITLixptTGEtaLz0AxiijoO20DvBAYKM6Czfro
 5eVjoPZ1JO8omxMJI1iJcGtkTityt6UiEU9Y5sO6R4fQvYazO3NV2/caT3cHk0s06b+c
 j4guCTxha4sXIoxNFj0KINHfMvPlg0KgDRQf/47132Lc5yCYMH+M/l+JAoGgUkL2pdYy
 44A54lzUf1VZWONLD21u3DmgCzpOERyVc4flYzP+xUJpucFfOQSh5EOZvu2l0ph2wplk
 rLmKBOfoO6lDjE1wvNwV0/BU+aZ2Gxc8AJE5jNTwo7oc4n5QyIn9S4Pyp+cCbg86hAHS
 Cubg==
X-Gm-Message-State: APjAAAVGhDf9KPqtxrlwEW4KZHtSSwnp1V2EQ7PcwjPmW9fdd6+Km17z
 OqWm6BQqrOiLHk+kTzDPbjsPqcwk/B003VHSPQwXstjIo4+LmGujwl1WUfeHFocbRGNdd/i+vKk
 T+LO2wZk4zXsSiSs=
X-Received: by 2002:a17:902:fe14:: with SMTP id
 g20mr12990261plj.174.1571456524330; 
 Fri, 18 Oct 2019 20:42:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgH1xytJ+4F6BEFXlHdq0vcGGaLU0YVdFcnZLwMe81Q85nPA9qTYfelb479Gog42Mq5NZU6g==
X-Received: by 2002:a17:902:fe14:: with SMTP id
 g20mr12990240plj.174.1571456523906; 
 Fri, 18 Oct 2019 20:42:03 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b14sm8444214pfi.95.2019.10.18.20.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 20:42:02 -0700 (PDT)
Date: Sat, 19 Oct 2019 11:41:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 0/4] apic: Fix migration breakage of >255 vcpus
Message-ID: <20191019034153.GB9478@xz-x1>
References: <20191016022933.7276-1-peterx@redhat.com>
 <20191016144001.GE4084@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016144001.GE4084@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 11:40:01AM -0300, Eduardo Habkost wrote:
> On Wed, Oct 16, 2019 at 10:29:29AM +0800, Peter Xu wrote:
> > v2:
> > - use uint32_t rather than int64_t [Juan]
> > - one more patch (patch 4) to check dup SaveStateEntry [Dave]
> > - one more patch to define a macro (patch 1) to simplify patch 2
> > 
> > Please review, thanks.
> 
> I wonder how hard it is to write a simple test case to reproduce
> the original bug.  We can extend tests/migration-test.c or
> tests/acceptance/migration.py.  If using -device with explicit
> apic-id, we probably don't even need to create >255 VCPUs.

I can give it a shot next week. :)

-- 
Peter Xu

