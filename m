Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE4AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F3E2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FP1BY+2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F3E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Wx-0004dN-JB
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD87z-0000z0-Mk
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD87x-0006rd-3k
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598973796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R4ilDNmcENKf88JVo+QQQWiziBYkVYzcxWLhbUqyl+k=;
 b=FP1BY+2cZnjYey7S5N0S8mECRuqxgc+9/DUPEFm8yRpyUkp2zUmckZYdritUciETNrf8FC
 zw83eJRL3MhT+BpBsP/48BHmu+6RnIa2I/mFJUKMOuyEP+i1SojJ+i1N2dKkYC9Knwp5W9
 11Ye5PwK7jVTOEsPYX+5VYiCGEsQIEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-DbOJnrmGNpuWH8YA3HUfzQ-1; Tue, 01 Sep 2020 11:23:07 -0400
X-MC-Unique: DbOJnrmGNpuWH8YA3HUfzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A880E1007471;
 Tue,  1 Sep 2020 15:23:06 +0000 (UTC)
Received: from redhat.com (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD77219C66;
 Tue,  1 Sep 2020 15:23:01 +0000 (UTC)
Date: Tue, 1 Sep 2020 16:22:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v8 1/8] Introduce yank feature
Message-ID: <20200901152259.GO345480@redhat.com>
References: <cover.1598951375.git.lukasstraub2@web.de>
 <ab5c04766f270d53e90f17f76c0af7e5b66f8623.1598951375.git.lukasstraub2@web.de>
 <874kohsgsp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <874kohsgsp.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 04:38:46PM +0200, Markus Armbruster wrote:
> One more question...
> 
> Lukas Straub <lukasstraub2@web.de> writes:
> 
> > The yank feature allows to recover from hanging qemu by "yanking"
> > at various parts. Other qemu systems can register themselves and
> > multiple yank functions. Then all yank functions for selected
> > instances can be called by the 'yank' out-of-band qmp command.
> > Available instances can be queried by a 'query-yank' oob command.
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> [...]
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 9d32820dc1..7de330416a 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -1615,3 +1615,65 @@
> >  ##
> >  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> >
> > +##
> > +# @YankInstances:
> > +#
> > +# @instances: List of yank instances.
> > +#
> > +# A yank instance can be yanked with the "yank" qmp command to recover from a
> > +# hanging qemu.
> > +#
> > +# Yank instances are named after the following schema:
> > +# "blockdev:<node-name>" refers to a block device. Currently only nbd block
> > +# devices are implemented.
> > +# "chardev:<chardev-name>" refers to a chardev. Currently only socket chardevs
> > +# are implemented.
> > +# "migration" refers to the migration currently in progress.
> > +#
> > +# Currently implemented yank instances:
> > +#  -nbd block device:
> > +#   Yanking it will shutdown the connection to the nbd server without
> > +#   attempting to reconnect.
> > +#  -socket chardev:
> > +#   Yanking it will shutdown the connected socket.
> > +#  -migration:
> > +#   Yanking it will shutdown all migration connections.
> 
> How is yanking migration related to command migrate_cancel?

migrate_cancel will do a shutdown() on the primary migration socket only.
In addition it will toggle the migration state.

Yanking will do a shutdown on all migration sockets (important for
multifd), but won't touch migration state or any other aspect of QEMU
code.

Overall yanking has less potential for things to go wrong than the
migrate_cancel method, as it doesn't try to do any kind of cleanup
or migration.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


