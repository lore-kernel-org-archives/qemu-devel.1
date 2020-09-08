Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E26C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B012208FE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIU2WgAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B012208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFk7N-0003Z1-4x
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFk6B-0001fM-Hj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:20:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFk69-0006RD-Bz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599596411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0RADqcbk85myjM7to0VdG4gRFBiOHTuuQyUgLRs2QE=;
 b=UIU2WgAp1ymeR8kHSx8lJALSgcA34SezBKmkG0f9JHSR5EqEsY4dh8EDZlSqqNUnspuGbu
 uh8W84tj7MJ4mCjc7Rd+69zB3dmsylD2Bmc/qPf0hGp11uzCeG8oUFAdXLcsUwoefjYN+/
 seiBW8r69NGX4Prim+yi6CZMgpVhSjA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-O9rpFPOdO92_oDhA-jweDg-1; Tue, 08 Sep 2020 16:20:10 -0400
X-MC-Unique: O9rpFPOdO92_oDhA-jweDg-1
Received: by mail-qt1-f200.google.com with SMTP id o14so348045qtq.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h0RADqcbk85myjM7to0VdG4gRFBiOHTuuQyUgLRs2QE=;
 b=dOv/naAO57eQBtMih/xNNOUhmQsPSEjIuS372C8enYyltJKKA4iMycdYE1o9C+/Ftr
 eMGsKiB5A9IRYFQrbt8CQxjXnwmEt5ZIJ85SrQ8CIlgZ1zGs2WDveotV8efToTjLKRd5
 fuFHr29tH7hVVKsR07EVUFODXINet9cZOx+CETmiYyrLGtBjggfDg3nkCpzBVKIOorK3
 +/lGwvGH3zpGyDX+LSQCU/ahBdLthcrtJLEvzGaOd/uRmVYYIq/KXxKbluuB6XhS+djl
 hBb1cRmG6OnNr4vhBhvPLewVrxXyPZp40VQHkFiKQ7iJzd6HZ00sfCqY/44lQ/Ylk+gJ
 2lFA==
X-Gm-Message-State: AOAM530o63Mz14lV4n5rhxxt9Vmvu/+ERHZlK9O9qCKHvlUEaiq3R6mf
 gHaQwE2R+G5+JjzVgOzVNX4xQHBJcCALtJXdkZmq2RKxXL8geoHsA/zkgHw5G7vGJCVweDTv7Vt
 G3JqVZ1zQ3QhFCeg=
X-Received: by 2002:aed:3030:: with SMTP id 45mr153379qte.73.1599596409888;
 Tue, 08 Sep 2020 13:20:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw71iQrzXEN/kpX9Dz+F8gFZtwc5P4CzVad0uw6YQbN2OB11eo9WNXZ7YTinGuuxj/ucKEbQw==
X-Received: by 2002:aed:3030:: with SMTP id 45mr153356qte.73.1599596409638;
 Tue, 08 Sep 2020 13:20:09 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id x6sm363041qke.54.2020.09.08.13.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:20:08 -0700 (PDT)
Date: Tue, 8 Sep 2020 16:20:07 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/5] migration: Introduce
 migrate_send_rp_message_req_pages()
Message-ID: <20200908202007.GA247092@xz-x1>
References: <20200903152646.93336-1-peterx@redhat.com>
 <20200903152646.93336-3-peterx@redhat.com>
 <20200908095757.GF3295@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200908095757.GF3295@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Xiaohui Li <xiaohli@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 10:57:57AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > This is another layer wrapper for sending a page request to the source VM,
> 
> Ah, it's not obvious why this is needed until 4/5 :-)

Yeah. :) I'll try to move this to be before that one in the next version.

> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

-- 
Peter Xu


