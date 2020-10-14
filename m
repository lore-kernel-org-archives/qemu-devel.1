Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C005A21D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNUV7iTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C005A21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSn2h-0007TJ-Gp
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kSmy8-0003v4-Rd
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kSmy6-0006fZ-Pj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602705704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5hJfoDWpVKL6XWUw36dG9ihTKQ85PgqzTNA6sy6vQ4=;
 b=BNUV7iTkv/V/jxmbYEt9DjljU4ANWxN2sYlQNeuc0C78WwkZdM9LtdnrpGwDYVU85dPn5s
 Gp1HpctiJH2i3TaIFUZYNR0YghygzdSYmFlTo9u1K9r/lRiVeoesZTvOmYdgcedhwjbHI1
 6DFGjbdFJ0ek4IAaZhG7CScoTc53Zcw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-T4CR44UiMnuCDe3FaFiLKQ-1; Wed, 14 Oct 2020 16:01:43 -0400
X-MC-Unique: T4CR44UiMnuCDe3FaFiLKQ-1
Received: by mail-il1-f198.google.com with SMTP id c66so453076ilf.4
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 13:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O5hJfoDWpVKL6XWUw36dG9ihTKQ85PgqzTNA6sy6vQ4=;
 b=gd575WR7L33izrzlXCLX0MdCQ0gNg8/t0Z93bxvX05gaVj6QVgBBz+Q+mhtpQ2JEr+
 WmlMe3pjlK7/3GR4WomFzws2KDLpqnjZuhOmgiNeYT9etmeEKQMTMn7+JJXccs6ljfFP
 3SPsyVc/LWQ+KSdm6u2ngIhGxDaHGTIsdxJrOfv5FfOq2Dm8ZoLn6c6aUajS9VYpUigC
 Oe+/F6YU0hyVMHQLC/ED8CJKGBIJwHY3snt3q8oPvOQGyVssoVIZFoAswSFA9yAZ9ZZO
 h2cP8Ld9i5ksf8dkMF6u7O8aodnz47HFX8O9r7pWr9Relvu2ODp4VdM1xCfdE+6kt1t7
 lZTA==
X-Gm-Message-State: AOAM530at68uYnYmzn9zZbH9v2TcgDIwnL4kM8d8YZN8MUAzgBNBfQQM
 rn+uQ5Rf+nNnRzRU1uhLylT4FFxdNGTVU61QR+yDhAzKMBMQv/0ABCdgSeTyh4NmQgGMLOHO2ag
 +EPQXu/InTp+A3dM=
X-Received: by 2002:a92:b503:: with SMTP id f3mr711505ile.23.1602705701971;
 Wed, 14 Oct 2020 13:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8iMhrpSghpy+nSFLXajNCdLSlbGdVe52Y2TVUdisUVdUv/zJT1F4Xof6pyyA0t9MVesu/IQ==
X-Received: by 2002:a92:b503:: with SMTP id f3mr711471ile.23.1602705701540;
 Wed, 14 Oct 2020 13:01:41 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id c9sm564774iow.1.2020.10.14.13.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 13:01:40 -0700 (PDT)
Date: Wed, 14 Oct 2020 16:01:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/10] migration queue
Message-ID: <20201014200138.GB133059@xz-x1>
References: <20201008191046.272549-1-dgilbert@redhat.com>
 <CAFEAcA-U2BjAne57Zn7c4_J97NAZSYzzy6r59iVeGmtgfD3APg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-U2BjAne57Zn7c4_J97NAZSYzzy6r59iVeGmtgfD3APg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, zhengchuan@huawei.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 11, 2020 at 07:29:25PM +0100, Peter Maydell wrote:
> > Migration:
> >   Dirtyrate measurement API cleanup
> >   Postcopy recovery fixes
> >
> > Virtiofsd:
> >   Missing qemu_init_exec_dir call
> >   Support for setting the group on socket creation
> >   Stop a gcc warning
> >   Avoid tempdir in sandboxing
> 
> This seems to hang in 'make check' trying to run
> tests/qtest/migration-test on s390x and ppc, ie
> the big-endian hosts.

Hi, Peter,

Do you know what's the page size on both platforms?

Asking because after I debugged I do see a bug in one of the patches, however
it's not about endianess but page size.  Something like:

-------8<----------
diff --git a/migration/migration.c b/migration/migration.c
index d8a5c0de44..ca18b1cf17 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -370,7 +370,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
 int migrate_send_rp_req_pages(MigrationIncomingState *mis,
                               RAMBlock *rb, ram_addr_t start, uint64_t haddr)
 {
-    void *aligned = (void *)(uintptr_t)(haddr & (-qemu_target_page_size()));
+    void *aligned = (void *)(uintptr_t)(haddr & qemu_real_host_page_mask));
     bool received;
 
     WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
-------8<----------

When I reproduce this issue I was running x86_64 guests on ppc64be hosts (which
has host page size == 64k).  Above fix works for me on that.  So I want to
confirm with you on the s390x failure you mentioned.  If both of them have
special page sizes then it's probably it (AFAICT, the bug could trigger when
guest page size is smaller than host page size).  But I'd like to double
confirm with you before I repost, just in case there's another bug hidden.

I'm also trying to find a s390x host to give it a shot.  However I decided to
also ask this loud so it might be even faster.

Thanks,

-- 
Peter Xu


