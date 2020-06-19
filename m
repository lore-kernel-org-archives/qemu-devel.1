Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977CAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6790E20734
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzmWCYJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6790E20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKH6-0007fj-On
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jmKGE-0007AR-4v
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:53:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44138
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jmKGA-0001ul-SD
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592585574;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nrTAI2aMRSVjF5qT0qxt6xgsCZ17IVsIhhINg0JdIRQ=;
 b=SzmWCYJz5OZVrMyAgdSeByly4Smy4rD717vrqeOSzmstoDnpIjmQTXq+xvy8n00WgVoybk
 8cQtPj1yd0YdB+u5A5ninmvMWeQKiPRt6i5JVRZo90zAmVVLgZmM2W+vvdQsvHwwJ/SnEq
 kjZeHsOc6iH8t8tJ6zOVqoIjZ44ddUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-wE4OSfHFNXCI10roah-0zA-1; Fri, 19 Jun 2020 12:52:52 -0400
X-MC-Unique: wE4OSfHFNXCI10roah-0zA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B35D1800D42;
 Fri, 19 Jun 2020 16:52:51 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 475965D9E5;
 Fri, 19 Jun 2020 16:52:43 +0000 (UTC)
Date: Fri, 19 Jun 2020 17:52:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 1/4] Introduce yank feature
Message-ID: <20200619165240.GB700896@redhat.com>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590421341.git.lukasstraub2@web.de>
 <20200617151240.GM1728005@stefanha-x1.localdomain>
 <20200619182924.7898035e@luklap>
MIME-Version: 1.0
In-Reply-To: <20200619182924.7898035e@luklap>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 06:29:24PM +0200, Lukas Straub wrote:
> On Wed, 17 Jun 2020 16:12:40 +0100
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
> 
> > On Mon, May 25, 2020 at 05:44:23PM +0200, Lukas Straub wrote:
> > > +static struct YankInstance *yank_find_instance(char *name)  
> > 
> > There are const char * -> char * casts in later patches. Please use
> > const char * where possible. Callers shouldn't need to cast away const.
> 
> nbd and chardev generate the instance name dynamically so it
> needs to be char *, but in migration it's hardcoded.

I think you're looking at it from the wrong perspective.

The yank_find_instance() method never modifies the 'name' paramater
that it receives. Therefore it should be "const char *". Likewise
for the other yank_*()  methods in fact.

The caller can have a char *, or a const char * as suits its needs.
Either can be passed into the yank_* methods and will gain const-ness
from the POV of yank code.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


