Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B229CC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB8B2245B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws2ndbty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB8B2245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIlP-0005nB-2m
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVITN-0001Qi-24
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVITJ-0001ox-5K
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603303463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RPNIwnLb3M4COoKC7f83RGuFgI2Q9r/pYtwfNk7wF38=;
 b=Ws2ndbtyDDMR0xRCY2F+z903FnKK5MI0BiFjpHe7m0axviDgbd9d6qZlLjSogTXMsUyJv+
 zhgU+p1/GcOgzvAmYuo93V9vTkaalvk1ap3vUqHKjyZ0VUMOg8PjKWS7xM9MMPz4s/vRFO
 +kgmA8LNFUqeB1M0k9DCXxssmNCOCFI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-zh9dl3OGMF-745vTYOprmQ-1; Wed, 21 Oct 2020 14:04:18 -0400
X-MC-Unique: zh9dl3OGMF-745vTYOprmQ-1
Received: by mail-qt1-f198.google.com with SMTP id e8so2250886qtp.18
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 11:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RPNIwnLb3M4COoKC7f83RGuFgI2Q9r/pYtwfNk7wF38=;
 b=SH38xCelrH0rHFVp6XB5e3usW3VTrgH4wiPrGMlvAAZUlEC2yuuIuu6uuPbqapnRG/
 2Zsgolr3JqFWSxHN4i5Cj7oEMsWE1Yn70fRlMTeqej1CqvWqWuo/ZVupZiwG0bmg8sGw
 Nlhrdn9EB8jeXT0QVkHbA7QyOEp8PlbNKPhsV09ZCqyV3tNq8A2yAdu/GJGr2sdd+ikL
 fQDGukOf9EccdnVTfza5LdzLsIyS3d3crObLPQHyH/w3CZxUbeK3nAAiEq1rF2ServTk
 +Vl7aNSGDBEpEkk/VgbMUYDrpSo45e2ap9FGXgPLWe2vagNbYu1qD5ZEoS0dyXvfbo/N
 cyJQ==
X-Gm-Message-State: AOAM531QW+0eX2Cd+cMBFV8SFGIHkmAf5vYXQwC1fB2/HaFFVu5QEiTu
 zqXkd2VmaGvb7vkeZeCmc+/tochStugAOHnHn813ucH2pc/WEARTJkXhjwrI8mUmN15Vx4oFO/h
 aGAlBAr+XB+DDgns=
X-Received: by 2002:a37:a5c9:: with SMTP id o192mr2201889qke.302.1603303458291; 
 Wed, 21 Oct 2020 11:04:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx/EQqcJobU/kuU7ICeh2DOm6AUjKKkRdBOiYnfTmYS0eer2KuwnkJspL3dw9Aj+bIRAgTXw==
X-Received: by 2002:a37:a5c9:: with SMTP id o192mr2201869qke.302.1603303458003; 
 Wed, 21 Oct 2020 11:04:18 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id t13sm1650535qtw.23.2020.10.21.11.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 11:04:16 -0700 (PDT)
Date: Wed, 21 Oct 2020 14:04:14 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 3/6] migration: Maintain postcopy faulted addresses
Message-ID: <20201021180414.GB248275@xz-x1>
References: <20201019225720.172743-1-peterx@redhat.com>
 <20201019225720.172743-4-peterx@redhat.com>
 <20201021142345.GC3671@work-vm> <20201021155016.GH200400@xz-x1>
 <20201021174219.GG3671@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201021174219.GG3671@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 06:42:19PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Wed, Oct 21, 2020 at 03:23:45PM +0100, Dr. David Alan Gilbert wrote:
> > > > @@ -354,8 +368,33 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
> > > >  }
> > > >  
> > > >  int migrate_send_rp_req_pages(MigrationIncomingState *mis,
> > > > -                              RAMBlock *rb, ram_addr_t start)
> > > > +                              RAMBlock *rb, ram_addr_t start, uint64_t haddr)
> > > >  {
> > > > +    void *aligned = (void *)(uintptr_t)(haddr & qemu_real_host_page_mask);
> > > 
> > > Can you remind me, what happens here for hugepages?
> > 
> > Sure.  Previously it was:
> > 
> >   (haddr & (-qemu_target_page_size())
> > 
> > Now it is:
> > 
> >   (haddr & qemu_real_host_page_mask)
> > 
> > Basically we changed the psize alignment from guest to host.
> > 
> > The bug triggered previously on ppc64 where host_psize=64k, then when guest
> > psize is smaller, e.g., 4k, we can have some addr that aligned to 4k rather
> > than 64k, so we failed later on checking the host psize alignment (because this
> > pointer should point to a host page, so it should align with host psize).
> 
> But my question is what happens when we have say a 2MB hugepage?

Oops, I definitely misread.

Good point, I think it can break hugepages.  So the mask should really be
"(qemu_ram_pagesize(rb) - 1)".

I'll fix and smoke it with some huge pages before another repost.

Thanks!

-- 
Peter Xu


