Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25506C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1727208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1727208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfoHW-0002GS-68
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46483)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hfoGp-0001Ol-Hp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hfoGo-0000Pa-6A
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:26:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hfoGn-0000N8-Ve
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:26:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3F4DB0CF5;
 Tue, 25 Jun 2019 16:26:08 +0000 (UTC)
Received: from redhat.com (ovpn-112-73.ams2.redhat.com [10.36.112.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09FE5608A4;
 Tue, 25 Jun 2019 16:26:05 +0000 (UTC)
Date: Tue, 25 Jun 2019 17:26:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190625162603.GK3139@redhat.com>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190625050008.12789-5-ehabkost@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 25 Jun 2019 16:26:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: Infrastructure for versioned CPU
 models
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 02:00:06AM -0300, Eduardo Habkost wrote:
> Base code for versioned CPU models.  This will register a "-4.1"
> version of all existing CPU models, and make the unversioned CPU
> models be an alias for the -4.1 versions on the pc-*-4.1 machine
> types.
> 
> On older machine types, the unversioned CPU models will keep the
> old behavior.  This way, management software can use old machine
> types while resolving aliases if compatibility with older QEMU
> versions is required.
> 
> Using "-machine none", the unversioned CPU models will be aliases
> to the latest CPU model version.
> 
> Includes a test case to ensure that:
> old machine types won't report any alias to versioned CPU models;
> "pc-*-4.1" will return aliases to -4.1 CPU models;
> and "-machine none" will report aliases to some versioned CPU model.

I'm wondering about the of tieing CPU versions to the release version
number and whether its a good idea or not ?

Could there be a reason for us to introduce 2 or more variants
of a CPU in the same release & would that be a problem if we needed
todo it ?

Consider if we did not have a Broadwell CPU model defined yet
and we were adding it at the same time as Spectre came out. We
might have needed to add "Broadwell-NN" and "Broadwell-MM" one
with "spec-ctrl" and one without, in order to ensure runability
on hosts with & without the microcode upgrade.  "Broadwell" alias
would resolve to either the NN or MM variant according to what
the current host supported.

One way to cope with that would have been to add a 3rd digit
after the version number. eg a Broadwell-4.1.1 and Broadwell-4.1.2

An alternative could consider using a plain counter for the CPU
versions eg Broadwell-1, Broadwell-2, etc.... ?


If we want to backport the newly added CPU model variants to
exist branches, plain counters don't have the unsightly mismatch.
eg we'd backport Broadwell-3 to QEMU 3.1, not Broadwell-4.1 to
QEMU 3.1.  This isn't a functional problem, just something looking
a bit odd.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

