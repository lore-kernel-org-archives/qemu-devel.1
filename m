Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DCC28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09312064A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09312064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYp1f-0001ke-1V
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:49:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYp0i-0001Tv-TD
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYp0h-0004t4-NI
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYp0h-0004sC-HX
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:48:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E01481E0A;
	Thu,  6 Jun 2019 09:48:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E722267C70;
	Thu,  6 Jun 2019 09:48:23 +0000 (UTC)
Date: Thu, 6 Jun 2019 10:48:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190606094819.GF14300@redhat.com>
References: <6364a057-23ab-db7f-cb2c-ccff70fb7aed@zytor.com>
	<aaf15ebe-7442-2e25-d533-c40c2e2df8cb@zytor.com>
	<87ef47jn6n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ef47jn6n.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 06 Jun 2019 09:48:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Qemu baseline requirements/portability?
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
Cc: qemu-devel@nongnu.org, "H. Peter Anvin" <hpa@zytor.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 06, 2019 at 07:30:08AM +0200, Markus Armbruster wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > On 6/5/19 12:55 PM, H. Peter Anvin wrote:
> >> Hi,
> >> 
> >> I am writing some code I'm hoping will be able to make it into Qemu, but I
> >> can't seem to find what the baseline portability requirements are.  I'm
> >> specifically wondering about newer POSIX features like openat(), which seems
> >> to be used in the 9p filesystem and nowhere else, and what version of glib one
> >> can rely on?
> >> 
> >
> > Specifically, I'm trying to satisfy a 10-year-old request by me and others to
> > support composite initrd during Linux boot.
> 
> Please peruse qemu-doc.texi @appendix Supported build platforms.  If it
> doesn't fully answer your question, ask for clarification here.

And specificially on the glib version question, we currently mandate 2.40.

If you try to use a glib API from a version newer than 2.40 we have things
setup so that you should get a fatal compile error due to our use of

   #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40


If you do think it is useful to have an API from glib > 2.40 you can put
some back compat logic in include/glib-compat.h so that you can use the
newer API and gracefully degrade on older glib.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

