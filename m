Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB25C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3969F20FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4WBiS62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3969F20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVuRT-0001cK-90
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVuQt-00018d-Ok
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVuQr-0001yN-EJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603449383;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UneqABSH2lLBDzFayFpETvwbxHYCL7rMkxpxnYEULes=;
 b=c4WBiS62RznBmB1+6zjjvQ4WUzydUgXEUv8ECKutvUGo0ZiQNLS4/9BsDeccUooa/r4RPO
 dg9KPwF8H1589gg4JgrodVHXBZNGKTvNdPa8yn1ovLj5BYggQWBrlz3UMTFTuML7yTq85F
 JOJHiDFy5o5VNTkKq8LolTX10lW4pH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-jGTUG-72PLyeoMhiMfj4fw-1; Fri, 23 Oct 2020 06:36:17 -0400
X-MC-Unique: jGTUG-72PLyeoMhiMfj4fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B872781C9BE;
 Fri, 23 Oct 2020 10:36:16 +0000 (UTC)
Received: from redhat.com (ovpn-114-187.ams2.redhat.com [10.36.114.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B14527BB4;
 Fri, 23 Oct 2020 10:36:06 +0000 (UTC)
Date: Fri, 23 Oct 2020 11:36:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/6] qemu-storage-daemon: QAPIfy --chardev
Message-ID: <20201023103603.GG445638@redhat.com>
References: <20201023101222.250147-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023101222.250147-1-kwolf@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 12:12:16PM +0200, Kevin Wolf wrote:
> While the qemu-storage-daemon command line is still considered unstable,
> let's change --chardev from the old QemuOpts-based parser to QAPI, so
> that it becomes a simple mapping of chardev-add to the command line and
> will fit in a future fully QAPIfied command line without later
> incompatible changes or additional compatibility glue.

NB, I am *not* objecting to this series in what I'm about to write,
but I want to point out that I don't think we should assume that
this proposed QAPIified CLI is neccessarily the long term end point.
Below I outline potential incompatible changes that would end up
turning -chardev into legacy / deprecated syntax.


The chardev QAPI-ification is a good example of the gap between QOM
and QAPI.

The chardev backends are QOM classes, but they lack the "user creatable"
interface.

Thus instead of configuring them using -object / object_add, we have a
QAPI model, custom args/commands -chardev / chardev_add, and then code
that populates the object instance properties from the QAPI model. Except
we've not really exposed them as object instance properties - they are
mostly just struct fields directly accessed.


The benefit of the chardev approach is that we have an introspectable
QAPI model. The downside is that we have a bunch of conversion code
for QAPI to QOM mapping.

The benefit of the user creatable object approach is that we dont
have to add custom CLI args for different types of object, nor write
code to populate QOM from QAPI. The downside is that we're divorced
from the QAPI schema, so loose introspection, and have a different
type of tedious boilerplate code to write.


The fact that we have this custom -chardev arg, instead of just using
-object is related to the ordering problems we have in main() in the
system emulators.

We have some -object types that need creating before the chardev
types, and some -object types that need creating after the chardevs.

If -chardev didn't exist, and we used -object for chardev creation,
then the ordering problem would trivially not exist, as we would
simply be processing all -object args in order that we receive them.


IOW, if we're considering our ideal long term configuration goals
for QEMU, then I think we should be looking at a solution to bridge
the gap, so that we can get the best of both worlds, and have a single
way todo things.

IMHO, ideally none of -netdev, -chardev, -device, etc would exist
in any "modern" CLI, they would just be considered legacy syntax.
Essentially everything would be created using the same -object arg
and object_add  commands.


What I think this means is that we need to use QAPI to represent
the properties of an object, and auto-generate the QOM code to
register properties, provider setters/getters, constructors, etc.

For existing user creatable objects this would largely involve
deleting lots of existing code and defining some simple QAPI
schemas. This is probably quite easy, if tedious.

For the chardev/netdev/etc objects we already have the QAPI schema,
but would need to add code genration parts to turn them into full
user creatable object classes. This is likely harder more involved
work, especially to keep backcompat working well.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


