Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E47FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960CE20578
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNEXv7fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960CE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjW0-0003bL-ES
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFjVM-0002me-CF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:42:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41484
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFjVJ-0001pd-83
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599594126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4cMlscfpksUT/XdcNhBNk/DNB9ghQMVNblQNGpIK+uk=;
 b=FNEXv7fXMrCAE9ZSPyuH6DQs9WxCnp30UxvM1clGFAibDzAarnjuvqGwl88fJWS0OEhNtN
 LH+HIJJj6r8O7c0XXA549/fJDSYrupl4JlEA+9+9EdWCS2az5cQlwqf6ZKJxtDVmaOyWA1
 BjILjrVQa5L6zfT8PuSOJ+7hF+NmE24=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-8VVOb9poP3qN4Xptpm51xA-1; Tue, 08 Sep 2020 15:42:05 -0400
X-MC-Unique: 8VVOb9poP3qN4Xptpm51xA-1
Received: by mail-qt1-f198.google.com with SMTP id a26so246181qtb.16
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 12:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4cMlscfpksUT/XdcNhBNk/DNB9ghQMVNblQNGpIK+uk=;
 b=kNZ2qwSplN6fv7ZAheGwbcP8qKCdsoi6xIJ5kUcdlyhJjC3kK7NADE5wMZxed1gIEz
 1n2IkcTUg7yt177w/ESDw60E85OdfpEpT2QAP/VeaAgIl0rtmVIHaSjSYeJtWKfh9aR4
 P6VyC/cG2h91lLuut6kuYamRuNEyx012RGN/YtmbjcVXdeMzHiLcMZvC9xoSjaLB8bju
 gsNY3PwOfJXLuxEg/osuOtYts2L78fo38oRUshfxPirwmcTGc8flLAesvFGJERP8iJmk
 tSKlpVsPPrrvhII5VP9bXkpilr26fqgNZ1Fg54FRNqBRhLjXY5K7Kend2/DyWIDq4egA
 oOcQ==
X-Gm-Message-State: AOAM533GRWH4tEBE32cIsa2d5rPbAPZ3kBsJD4bAV3wbJVJGLWMlQX1H
 aZTkyEXgFDcdtgtsZrG81Xtf9+XWDKBSKuCM8Ol9THZoF4e00OGe/4GjG0gk6owgUJ2xkyjRrBD
 pNdo3yDRJP/Y54V4=
X-Received: by 2002:a37:3c8:: with SMTP id 191mr147335qkd.393.1599594124596;
 Tue, 08 Sep 2020 12:42:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzowp26t5L7MHk64aBm0M8X0cthZ0zi03oeSvnM6whe9Zm2msrkbYHbgQpztTaKRNDcW1Lfsw==
X-Received: by 2002:a37:3c8:: with SMTP id 191mr147317qkd.393.1599594124321;
 Tue, 08 Sep 2020 12:42:04 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id g14sm244083qkk.38.2020.09.08.12.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:42:03 -0700 (PDT)
Date: Tue, 8 Sep 2020 15:42:02 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 4/5] migration: Maintain postcopy faulted addresses
Message-ID: <20200908194202.GA233268@xz-x1>
References: <20200903152646.93336-1-peterx@redhat.com>
 <20200903152646.93336-5-peterx@redhat.com>
 <20200908110039.GG3295@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200908110039.GG3295@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 08, 2020 at 12:00:39PM +0100, Dr. David Alan Gilbert wrote:
> > @@ -238,6 +247,11 @@ void migration_incoming_state_destroy(void)
> >          mis->postcopy_remote_fds = NULL;
> >      }
> >  
> > +    if (mis->page_requested) {
> > +        g_tree_destroy(mis->page_requested);
> > +        mis->page_requested = NULL;
> > +    }
> > +
> 
> I think you want a:
>        qemu_mutex_destroy(&current_incoming->page_request_mutex);

I explicitly didn't do that because I saw that we've got quite a few things
that were not destroyed here, just in case I introduce some bug on multi-free
of the mutex.  However... after a closer look, I don't see a reason to not free
them at all...  Namely:

    - postcopy_pause_sem_dst
    - postcopy_pause_sem_fault
    - rp_mutex
    - main_thread_load_event (instead of _reset it in this function, we might
      want to use _destroy)

I'll prepare another standalone patch for that.

> 
> >      qemu_event_reset(&mis->main_thread_load_event);
> >  
> >      if (mis->socket_address_list) {
> > @@ -354,8 +368,33 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
> >  }
> >  
> >  int migrate_send_rp_req_pages(MigrationIncomingState *mis,
> > -                              RAMBlock *rb, ram_addr_t start)
> > +                              RAMBlock *rb, ram_addr_t start, uint64_t haddr)
> >  {
> > +    uint64_t aligned = haddr & (-qemu_target_page_size());
> > +    bool received;
> > +
> > +    qemu_mutex_lock(&mis->page_request_mutex);
> 
> You could use WITH_QEMU_LOCK_GUARD

Sure.

Thanks,

-- 
Peter Xu


