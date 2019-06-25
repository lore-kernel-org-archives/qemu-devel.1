Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F7C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180092086D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180092086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfqD3-0001SI-7V
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50722)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hfqBA-0000XF-Uh
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hfqB8-0001Jw-Sk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hfqB6-0001Cf-Tz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:28:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90740B0CF5
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 18:28:05 +0000 (UTC)
Received: from redhat.com (ovpn-112-73.ams2.redhat.com [10.36.112.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D69515C22F;
 Tue, 25 Jun 2019 18:27:57 +0000 (UTC)
Date: Tue, 25 Jun 2019 19:27:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190625182755.GN3139@redhat.com>
References: <20190625161629.302-1-imammedo@redhat.com>
 <2647871f-34f2-0f8d-adb7-0265f951acd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2647871f-34f2-0f8d-adb7-0265f951acd3@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 25 Jun 2019 18:28:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH v2] deprecate -mem-path fallback
 to anonymous RAM
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
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 01:18:01PM -0500, Eric Blake wrote:
> On 6/25/19 11:16 AM, Igor Mammedov wrote:
> > Fallback might affect guest or worse whole host performance
> > or functionality if backing file were used to share guest RAM
> > with another process.
> > 
> > Patch deprecates fallback so that we could remove it in future
> > and ensure that QEMU will provide expected behavior and fail if
> > it can't use user provided backing file.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >  * improve text language
> >     (Markus Armbruster <armbru@redhat.com>)
> > 
> 
> Is this deprecation introspectible? Does it need to be?
> 
> Do we even need a deprecation period, or can we declare this a bug fix
> (it was a bug that we didn't fail outright on an impossible request) and
> do it immediately?

I think it is hard to call it a bug when we added explicit extra code to
make it work as it does today.

It is really a misguided feature.

> If it is not a bug fix, perhaps it could be made introspectible by
> having a new boolean parameter to opt in to the failure now, rather than
> 2 releases from now?

From libvirt's POV I don't see a need for introspection. There's no
special action we need to take to deal with the new behaviour - it is
ultimately just providing the behaviour we kind of assumed it already
had.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

