Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEF221479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEF221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9J9-0006jO-Et
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:27:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP9IK-0006SR-KA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP9IJ-0003to-IQ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:26:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hP9IJ-0003tQ-DH
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:26:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4918D309E9B5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 17:26:50 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A60A960159;
	Fri, 10 May 2019 17:26:44 +0000 (UTC)
Date: Fri, 10 May 2019 18:26:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190510172641.GS7671@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
	<20190509181906.GN4189@habkost.net>
	<87o94au06m.fsf@dusky.pond.sub.org>
	<20190510171711.GS4189@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510171711.GS4189@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 10 May 2019 17:26:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
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
Cc: mprivozn@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 02:17:11PM -0300, Eduardo Habkost wrote:
> On Fri, May 10, 2019 at 11:29:53AM +0200, Markus Armbruster wrote:
> [...]
> > I'm afraid our command line is awkward both for machines and for humans,
> > albeit for different reasons.
> > 
> > For humans doing simple things, the command line is okay.  But beyond
> > that, it gets forbiddingly unwieldy[2].
> > 
> > Machines are fine with that kind of unwieldy, but would prefer something
> > with more structure, both on input (talking to QEMU) and even more so on
> > output (QEMU talking back).
> > 
> > Ideally, we'd support machines do their work in (structured) QMP,
> > resorting to the command line only to set up a QMP monitor.  We're not
> > anywhere close to this.
> > 
> > As long as management applications use the command line in not-trivial
> > ways, they have to deal with configuration errors reported via stderr.
> 
> That's only true if we want to.
> 
> Command line is an interface usable by machines.  Not the ideal,
> but it works.
> 
> Messages on stderr are not an interface for machines.  We must
> provide something better, and I don't think "wait until we
> convert everything to QMP" is a reasonable answer.

If QEMU successfully starts then libvirt essentially ignores stderr
just letting it go to the logfile.

If we see any deprecated features used during startup the natural
thing would be to queue up a list of warnings, and then once the
client (libvirt) connects to QMP emit them as events.

QEMU still ought to emit them on stderr anyway so they do end up
in the logs regardless of whether anyone actually procsses the
deprecation QMP events.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

