Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F4FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBE620675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMCucPp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBE620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHgt-0000IP-14
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jqHfW-0006Jq-F8
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:55:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jqHfT-0002p5-9j
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593528926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=32/cK0qo0hIftJwPfmtCXT3zsF62UAVKjko2PfncTjg=;
 b=eMCucPp/HWgJhGprlWwY7roFClp0u6lHkYm23gQE6rs6fBFRRpuZkH9K5yAsHEOSshtO/I
 fNJFje4BZsEYgvEZeqWEBXdQe3T6k+1tMeMoHcl8eai97lp/JS+xCz30TMtSonYBmGoppx
 jHDSSecLG/QTPgIfDCQcStT1rmBiKik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-3XNaymunOwegheAGFNJoyg-1; Tue, 30 Jun 2020 10:55:24 -0400
X-MC-Unique: 3XNaymunOwegheAGFNJoyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88085100A8E9
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 14:55:23 +0000 (UTC)
Received: from work-vm (ovpn-113-225.ams2.redhat.com [10.36.113.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EEB15DAA9;
 Tue, 30 Jun 2020 14:54:57 +0000 (UTC)
Date: Tue, 30 Jun 2020 15:54:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200630145455.GK2673@work-vm>
References: <20200623145506.439100-1-mst@redhat.com>
 <20200630090717-mutt-send-email-mst@kernel.org>
 <20200630135912.GI2673@work-vm>
 <20200630104300-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200630104300-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Tue, Jun 30, 2020 at 02:59:12PM +0100, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Tue, Jun 23, 2020 at 10:57:02AM -0400, Michael S. Tsirkin wrote:
> > > > This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
> > > > since that change makes unit tests much slower for all developers, while it's not
> > > > a robust way to fix migration tests. Migration tests need to find
> > > > a more robust way to discover a reasonable bandwidth without slowing
> > > > things down for everyone.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > What's the conclusion here? Should I merge this?
> > 
> > Yes please; I need to rethink that.
> > 
> > Dave
> > 
> > > 
> > > > ---
> > > >  tests/qtest/migration-test.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > > index dc3490c9fa..21ea5ba1d2 100644
> > > > --- a/tests/qtest/migration-test.c
> > > > +++ b/tests/qtest/migration-test.c
> > > > @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
> > > >       * without throttling.
> > > >       */
> > > >      migrate_set_parameter_int(from, "downtime-limit", 1);
> > > > -    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> > > > +    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
> > > >  
> > > >      /* To check remaining size after precopy */
> > > >      migrate_set_capability(from, "pause-before-switchover", true);
> > > > -- 
> > > > MST
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> ack pls?

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


