Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F6EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBBC21D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BluKLda6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBBC21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYrL-0001u8-JK
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQYpg-0000kj-Bh
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQYpe-0000Yg-Nd
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602174713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+307tl6JlB034sIj3k+T2VscNthAMUMV71Pq6T2fzZI=;
 b=BluKLda64xaEJwDayixWeerz6lZf/IVFaoLEwf+9IYbV/SSTe+VEhySGzBGZJFE/oGZEc7
 blZ5tFnanK+ZaOfyRPso/bxjpunOueGuboJGdBWGydK4Zkv39HdZQj70/z51XFT99R9OX/
 axgu597MBFLkel9QFAdWTx1bseb/kv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-LAGX7c0OOjeKaffLrOQXmg-1; Thu, 08 Oct 2020 12:31:52 -0400
X-MC-Unique: LAGX7c0OOjeKaffLrOQXmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAB0181EE64;
 Thu,  8 Oct 2020 16:31:50 +0000 (UTC)
Received: from work-vm (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AD895D9E8;
 Thu,  8 Oct 2020 16:31:43 +0000 (UTC)
Date: Thu, 8 Oct 2020 17:31:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/10] migration queue
Message-ID: <20201008163140.GE2962@work-vm>
References: <20201007155600.337316-1-dgilbert@redhat.com>
 <CAFEAcA9fjk5gpuV5Pq46DS8gux0gkY1fkhn=GU6W=B9jdAKBdg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9fjk5gpuV5Pq46DS8gux0gkY1fkhn=GU6W=B9jdAKBdg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
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
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 zhengchuan@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Wed, 7 Oct 2020 at 17:06, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > The following changes since commit f2687fdb7571a444b5af3509574b659d35ddd601:
> >
> >   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-06 15:04:10 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dagrh/qemu.git tags/pull-migration-20201007b
> >
> > for you to fetch changes up to 1df31b8aca2aa4f83d5827d74700eeb6d711bbdf:
> >
> >   migration/dirtyrate: present dirty rate only when querying the rate has completed (2020-10-07 16:49:26 +0100)
> >
> > ----------------------------------------------------------------
> > Migration and virtiofs pull 2020-07-10
> >
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
> Compile failure, windows crossbuilds:
> 
> ../../migration/migration.c: In function 'page_request_addr_cmp':
> ../../migration/migration.c:148:23: error: cast from pointer to
> integer of different size [-Werror=pointer-to-int-cast]
>      unsigned long a = (unsigned long) ap, b = (unsigned long) bp;
>                        ^
> ../../migration/migration.c:148:47: error: cast from pointer to
> integer of different size [-Werror=pointer-to-int-cast]
>      unsigned long a = (unsigned long) ap, b = (unsigned long) bp;

Sorry about that; I'll see if we can fix it.

Dave

> 
> thanks
> -- PMM
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


