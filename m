Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42E7C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F86206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O39e4xlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F86206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQf0-0001KZ-KX
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQeR-0000sq-Ca
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:52:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQeQ-0003kR-F5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589273553;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0714OduHS8BI0RwStBnCtCN2TBaZ3BVElIJQvpa+Ps=;
 b=O39e4xlMPUpK7FFUXVTsJ2XN4rzJTC3Xm2ywYZSDHIbAPFsNfQ1gahzszX6lSRkfAZyn/r
 Bm/pYRcf8VJM/kIXCFPQ9O5D1vbDt0e2kIkWXaPZbi0wvYctFdo5pP7uRL4f3i/mVLLb4i
 BZ/QZwqIDsGA4U2V2qWpiWcJvKfyes0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-bhh7ZufKPC6G7-WjEkHujg-1; Tue, 12 May 2020 04:52:28 -0400
X-MC-Unique: bhh7ZufKPC6G7-WjEkHujg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B16038014D6;
 Tue, 12 May 2020 08:52:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 401EF1002394;
 Tue, 12 May 2020 08:52:22 +0000 (UTC)
Date: Tue, 12 May 2020 09:52:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 2/5] io/channel.c,io/channel-socket.c: Add yank feature
Message-ID: <20200512085219.GD1191162@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <db00ff13f62fe97634132e43105b9bf63bbbf582.1589193717.git.lukasstraub2@web.de>
 <20200511115146.GK1135885@redhat.com>
 <20200511220042.1f226f70@luklap>
MIME-Version: 1.0
In-Reply-To: <20200511220042.1f226f70@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 10:00:42PM +0200, Lukas Straub wrote:
> On Mon, 11 May 2020 12:51:46 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Mon, May 11, 2020 at 01:14:41PM +0200, Lukas Straub wrote:
> > > Add qio_channel_set_yank function to channel and to channel-socket,
> > > which will register a yank function. The yank function calls
> > > shutdown() on the socket.
> > > 
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > >  Makefile.objs               |  1 +
> > >  include/io/channel-socket.h |  1 +
> > >  include/io/channel.h        | 12 ++++++++++++
> > >  io/channel-socket.c         | 29 +++++++++++++++++++++++++++++
> > >  io/channel.c                |  9 +++++++++
> > >  5 files changed, 52 insertions(+)  
> > 
> > Assuming we want the yank feature (which I'm not entirely convinced
> > of), then I don't think any of this addition should exist. The
> > QIOChannel class already provides a "qio_channel_shutdown" method
> > which can be invoked. The layer above which is using the QIOChannel
> > should be calling this existing qio_channel_shutdown method in
> > response to any yank request.  The I/O layer shouldn't have any
> > direct dependancy on the yank feature.
> 
> Having the code here simplifys the code in the other places.

This introduces a depedancy from the IO channel code into the system
emulator infra which is not desired. The goal is to keep the io/ module
isolated and as self-contained as possible.

I don't think it makes a significant difference to the yank code to
keep it out of the io layer, and simply call the QIOChannel objects
via their existing public API.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


