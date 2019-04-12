Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89F9C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7E420652
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7E420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzuK-00036j-Kh
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:24:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEztW-0002mL-S8
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEztV-0004kv-Ft
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:23:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEztV-0004kb-7w
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:23:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74C54811D5;
	Fri, 12 Apr 2019 17:23:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CDA61001E81;
	Fri, 12 Apr 2019 17:23:12 +0000 (UTC)
Date: Fri, 12 Apr 2019 18:23:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190412172309.GF25308@redhat.com>
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
	<fff20c68-d4db-3a56-ba39-dc487d6f80e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <fff20c68-d4db-3a56-ba39-dc487d6f80e5@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 12 Apr 2019 17:23:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Add 'inline-fd:' protocol for migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	"open list:All patches CC here" <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yury Kotov <yury-kotov@yandex-team.ru>, yc-core@yandex-team.ru,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412172309.Qey6-kBtb0SdehC4L0k2UoIyk80npTC-Y5_r2ZSfWoA@z>

On Fri, Apr 12, 2019 at 12:13:51PM -0500, Eric Blake wrote:
> On 4/12/19 7:20 AM, Yury Kotov wrote:
> > Hi,
> > 
> > I've added 'inline-fd:' proto to simplify migration to/from fd.
> > I thought about modifying the existing 'fd:' proto but I'm not sure it's a
> > good idea to change it's contract.
> > 
> > Existing 'fd:' proto works with previously added fd by getfd or add-fd commands.
> > If client doesn't want to work with this fd before or after migration then it's
> > easier to send an fd with the migrate-* command. Also, client shouldn't maintain
> > this fd.
> 
> While the sentiment of making it easier by having fewer QMP commands
> might be worthwhile, I'm worried about whether this scales. Having just
> a limited set of commands that take an fd over SCM rights, and every
> other command wired to automagically work with existing named fds,
> scales a lot easier than having to teach individual commands how to take
> an fd inline.

Yeah I tend to agree - we use FD passing extensively across QMP/HMP
and all these commands are written to interact with "getfd". I think
it would be a step backwards to introduce a special case with
migration that doesn't use "getfd".

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

