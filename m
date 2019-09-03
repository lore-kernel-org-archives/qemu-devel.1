Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D322CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB162087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB162087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i57HD-00046k-Og
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i57Fm-0003Ac-1q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i57Fk-0004eJ-PM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:45:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i57Fk-0004dF-HU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2748E8980E5;
 Tue,  3 Sep 2019 11:45:39 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F366A60C05;
 Tue,  3 Sep 2019 11:45:35 +0000 (UTC)
Date: Tue, 3 Sep 2019 12:45:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190903114532.GC15960@redhat.com>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190903112140.GE2744@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903112140.GE2744@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 03 Sep 2019 11:45:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] UUID validation during migration
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 12:21:40PM +0100, Dr. David Alan Gilbert wrote:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> > Hi,
> > 
> > This series adds an UUID validation at the start of the migration
> > on the target side. The idea is to identify the source of migration.
> > 
> > Possible case of problem:
> > 1. There are 3 servers: A, B and C
> > 2. Server A has a VM 1, server B has a VM 2
> > 3. VM 1 and VM 2 want to migrate to the server C
> > 4. Target of VM 1 starts on the server C and dies too quickly for some reason
> > 5. Target of VM 2 starts just after that and listen the same tcp port X, which
> >    the target of VM 1 wanted to use
> > 6. Source of VM 1 connects to the tcp port X, and migrates to VM 2 source
> 
> That shouldn't be possible in practice; you specify the destination tcp
> port when you start the destination qemu; so unless the management code
> that starts the migration is very broken it should know which port it's
> migrating to.
> However, if it is very broken then this is a good check.

In some, but not all, cases allowing the wrong source QEMU to connect to
a target QEMU could be considered a serious security flaw.

Historically live migration security was pretty minimal, to non-existant,
but we do now have the ability todo much better with TLS.

With the way libvirt currently uses TLS for migration, we're just protecting
against a rogue host connecting, as any host with a valid cert gets allowed.

We could do better by using the new ACLs feature to whitelist just the
particular virt host that we know the source VM is on.

This still allows for an accident if libvirt is migrating 2 VMs on the
same source host at the same time.

What's needed is a unique identity for each individual migration operation.

The use of the UUID here is aiming to serve that role.

Assuming libvirt has protected its TLS certificates on the source host,
then this solution is secure. An attacker would need to become root on
the source host to access libvirt's TLS certs, at which point no other
strategy libvirt used instead of UUID would be secure either.


So I think from a security POV, the use of UUID is acceptable.


An alternative would be to not use TLS certificates, and instead use the
TLS pre-shared  keys credential type, generating a new set of PSK creds
for each migration operation.  In this case, UUID would not be required
at all. I don't see this as a reason to reject the UUID check though.
It is reasonable for mgmt apps to have a choice in which approach they
pick.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

