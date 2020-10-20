Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2DCC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 21:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D51206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 21:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipQ4Dwfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D51206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUzF7-0000rL-JI
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 17:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUzDi-00007a-NZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 17:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUzDb-0006hM-Jq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 17:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603229452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0tqzKZskTJk/TP19maEsUbn5Y2e6JitJZMQA3Z8uknw=;
 b=ipQ4DwfpY7I/OcwtjspKBDGkroEn9oHm4pt8CpXTNti127vV+shptSElH/SR9fnjCCzNGU
 MlfzYrDNfHJaXTsJBiTzgQCfxFdc18L5deyTvbabLSA+c19Yjcp4nUlUToJ2XQPjG2h0uI
 GFNVFI2qKrYckx81Ab52J3J5ZO/G2sA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-u5KCRnmEPQCULN4MJwTM-A-1; Tue, 20 Oct 2020 17:30:51 -0400
X-MC-Unique: u5KCRnmEPQCULN4MJwTM-A-1
Received: by mail-qv1-f70.google.com with SMTP id k6so8013qvg.9
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 14:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0tqzKZskTJk/TP19maEsUbn5Y2e6JitJZMQA3Z8uknw=;
 b=tYOEo9YOZ3bVphqIMaaUrRw8Q3Cel6spYiLhz3HuOEpBJzSg1gm4utryB2Hp0Qgs1X
 OLuOtxU462uwUK5LG26TdyqqeMo4gFbiXlFibITOL1TMdscaXrxK+sUC1Q4+nieQhMWz
 5OYbHcg+DfW7N07S0960frh9BuGHnRC+leoUbGALL9F1IGkTdgoqYtUAaMn2uaztZppC
 jb1AAZ4vD4KsytGVeoLVKzM04CjF9+zy9xXcE8xTYzbg/+mgFNBQRa8Pt1fPrB8/BCnr
 iz1r7kPLrMK0eQHwx9QCvfbz2OgtXjjAxHX03JqZAOReXl349sjoveAwnEk6+3+VzBzj
 2rjA==
X-Gm-Message-State: AOAM531ayllsqyYEAIRg+8VZT+jSDa1JW0pyti8IQC0D2p1DHjWTQbGL
 p88VI9Oa/SCgvNQuGFcL5ftPFq2OWYOBYNgf5pAE4V1eo2GlckpbA52Gfx0rWlGY3OXgex2H0NZ
 btkQpSBxkyXOxAlA=
X-Received: by 2002:ae9:c310:: with SMTP id n16mr270530qkg.318.1603229450879; 
 Tue, 20 Oct 2020 14:30:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzISUUV3meprK3VrG4Tp23PDeugF3vheEGp7b2CLGzret4raHnGu1Pu3I2p7GiEaYJsxtR9UQ==
X-Received: by 2002:ae9:c310:: with SMTP id n16mr270493qkg.318.1603229450503; 
 Tue, 20 Oct 2020 14:30:50 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id f187sm95318qke.60.2020.10.20.14.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 14:30:49 -0700 (PDT)
Date: Tue, 20 Oct 2020 17:30:48 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH PROTOTYPE 4/6] memory: Extend
 ram_block_discard_(require|disable) by two discard types
Message-ID: <20201020213048.GG200400@xz-x1>
References: <20200924160423.106747-1-david@redhat.com>
 <20200924160423.106747-5-david@redhat.com>
 <20201020191706.GB200400@xz-x1>
 <ea4d0acb-7ee5-7a4b-61aa-f139e0cbf585@redhat.com>
 <20201020204929.GF200400@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20201020204929.GF200400@xz-x1>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 04:49:29PM -0400, Peter Xu wrote:
> On Tue, Oct 20, 2020 at 09:58:34PM +0200, David Hildenbrand wrote:
> > I remember there were some !BQL users (but I might be confusing it with
> > postcopy code that once used to inhibit the balloon without BQL). Will
> > double-check. Simplifying it is certainly a good idea.
> > 
> > (we want to be able to check from virtio-balloon code repeatedly without
> > taking a mutex over and over again :) )
> 
> Right.  Again I've no strong opinion so feel free to keep the codes as wish.
> However if we'd go the other way (either BQL or another mutex) IMHO we can
> simply read that flag directly without taking mutex.  IMHO here the mutex can
> be used to protect write concurrency and should be enough. Considering that
> this flag should rarely change and it should never flip (e.g., positive would
> never go negative, and vise versa), then READ_ONCE() whould be safe enough on
> read side (e.g., balloon).

Btw, what we've discussed is all about serialzation of the flag.  I'm also
thinking about whether we can make the flag clearer on what it means.  Frankly
speaking on the first glance it confused me quite a bit..

IMHO what we may want is not some complicated counter on "disablement", but
some simple counters on "someone that provided the cap to discard pages", and
"someone that won't work if we _might_ discard pages".  I'm thinking what if we
split the "disable" counter into two:

  - ram_discard_providers ("Who allows ram discard"): balloon, virtio-mem

  - ram_discard_opposers ("Who forbids ram discard"): vfio, rdma, ...

The major benefit is, the counters should always be >=0, as what a usual
counter would do.  Each device/caller should only/majorly increase the counter.
Also we don't need the cmpxchg() loops too since the check is easier - just
read the other side of the counters to know whether we should fail now.

So after this patch to introduce "coordinated discards", the counters can also
grows into four (we can still define some arrays):

        |---------------------------+------------+-----------|
        | counters                  | provider   | opposer   |
        |---------------------------+------------+-----------|
        | RAM_DISCARD_COORDINATED   | virtio-mem | rdma, ... |
        | RAM_DISCARD_UNCOORDINATED | balloon    | vfio      |
        |---------------------------+------------+-----------|

Some examples: for vfio, it only needs to make sure no UNCOORDINATE providers.
For rdma, it needs to make sure no COORDINATE/UNCOORDINATE providers.  The
check helper could simply be done using a similar ANY bitmask as introduced in
the current patch.

Not sure whether this may help.

Thanks,

-- 
Peter Xu


