Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D574C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C432177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icG2pnU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C432177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVGOl-0002Eg-KG
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVGNg-0001Y2-J2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVGNb-0007te-0X
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603295421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmXVyP+THV2SRlMManBcML3W7R7gig/Ewv/AA8ussHk=;
 b=icG2pnU+xaFGHOPTl+4y9KgZYt7ksvQkRlyQP6pGcxdgXRstdV6fpV29v1caokuOrbm1vU
 puhedHzv29i2XbGmqHsNFvVxoK3bvv3y3ZGELUpD7RNRlprovz4H6I1GBeqXAvMi9vKPDz
 aKXnNivzN0GLTJiMNAlIghIg5RljMF8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-tyJ1BagiN8eGYQ7yKUi9YA-1; Wed, 21 Oct 2020 11:50:18 -0400
X-MC-Unique: tyJ1BagiN8eGYQ7yKUi9YA-1
Received: by mail-qk1-f198.google.com with SMTP id n125so1958762qke.19
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 08:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zmXVyP+THV2SRlMManBcML3W7R7gig/Ewv/AA8ussHk=;
 b=OO+gK/ivQzXqAylpAB8/3M2FPeHatNjuV+IRPWUL51at4/7AnWs9AFvxqFAjK9EMRv
 wNymWAq4eZ1lh3HEg8GK3pr8eAlirQVmZRjWKtwNRmT3mW0fyWoQ7G3Nupf4aQ9GVsUE
 vjfH0G7H6rF/18GIsT9W5IXIiBQyL6e/Qe6hFn2LO9wVbPrZIjCh7zNPIwRe0iqBDd46
 q4ztm03iOVoIlXw4wEqCR2IbJqdyAp0oR7ndQM1xBwxwZFmgwPpGOifJNo99btuIfzWR
 9WSZj/b14+JAdp8mxy+YrguC2QwDWre9dNNPrmKolMjOB4nS2eWl84shQ197l2ZkSSvE
 1ImQ==
X-Gm-Message-State: AOAM530O2DnjfoVRRfdE4hiZCfnBQKaFLwLQq5HyFOWzf+HxKD0D7nrj
 oLb9a7YGGl8yXk/sp0zNecyBtisDVQmO+6D8VQh3RI1i/5EXvMkXRPUfFCbIu+YC0LtI6/AIZbG
 Nj29Qqb0YhENMeso=
X-Received: by 2002:ac8:5315:: with SMTP id t21mr3720248qtn.64.1603295417729; 
 Wed, 21 Oct 2020 08:50:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSF64NmHhT0FVrQ8I63uJRC6qFANsKAPNSkLPwLBAzca0HQLTz/g/7PIq3IaUtUbLiuxo2+g==
X-Received: by 2002:ac8:5315:: with SMTP id t21mr3720229qtn.64.1603295417472; 
 Wed, 21 Oct 2020 08:50:17 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id m33sm1473719qtb.65.2020.10.21.08.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 08:50:16 -0700 (PDT)
Date: Wed, 21 Oct 2020 11:50:16 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 3/6] migration: Maintain postcopy faulted addresses
Message-ID: <20201021155016.GH200400@xz-x1>
References: <20201019225720.172743-1-peterx@redhat.com>
 <20201019225720.172743-4-peterx@redhat.com>
 <20201021142345.GC3671@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201021142345.GC3671@work-vm>
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

On Wed, Oct 21, 2020 at 03:23:45PM +0100, Dr. David Alan Gilbert wrote:
> > @@ -354,8 +368,33 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
> >  }
> >  
> >  int migrate_send_rp_req_pages(MigrationIncomingState *mis,
> > -                              RAMBlock *rb, ram_addr_t start)
> > +                              RAMBlock *rb, ram_addr_t start, uint64_t haddr)
> >  {
> > +    void *aligned = (void *)(uintptr_t)(haddr & qemu_real_host_page_mask);
> 
> Can you remind me, what happens here for hugepages?

Sure.  Previously it was:

  (haddr & (-qemu_target_page_size())

Now it is:

  (haddr & qemu_real_host_page_mask)

Basically we changed the psize alignment from guest to host.

The bug triggered previously on ppc64 where host_psize=64k, then when guest
psize is smaller, e.g., 4k, we can have some addr that aligned to 4k rather
than 64k, so we failed later on checking the host psize alignment (because this
pointer should point to a host page, so it should align with host psize).

-- 
Peter Xu


