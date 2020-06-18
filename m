Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E063C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC6A206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLtrFQlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC6A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwmF-0005WC-8h
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlwhZ-0007bn-7e
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:43:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlwhX-0000u6-3w
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592495018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zrIqMX8xTE/RgeCFBWMQyxbDigu9jXkKkXY6EJS5Rw=;
 b=FLtrFQlbixyh5WRBzRvXnefvSCXI3oXxSUCc/KSfv/MrJzidgqVhvDwwODaGADdCpPtftj
 68Iei7GH3gk8QafimliNXrKYRvxDOCP7uG8U87wlW25wLVWoTq7SBMgGKqUTFS2JRef5ep
 9x09lFaNVMhrmvbEIOriCrdzvkTxj3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-6HmVXCqMPgWqyDC2JetvOw-1; Thu, 18 Jun 2020 11:43:31 -0400
X-MC-Unique: 6HmVXCqMPgWqyDC2JetvOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94652107ACCA;
 Thu, 18 Jun 2020 15:43:30 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E7AF5C1D0;
 Thu, 18 Jun 2020 15:43:26 +0000 (UTC)
Date: Thu, 18 Jun 2020 16:43:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] scripts/tracetool: Add plainlog backend
Message-ID: <20200618154323.GK671599@redhat.com>
References: <20200617134505.9D06E7482D3@zero.eik.bme.hu>
 <20200618073124.GA1956319@stefanha-x1.localdomain>
 <20200618090741.GC671599@redhat.com>
 <20200618153516.GE1956319@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200618153516.GE1956319@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 04:35:16PM +0100, Stefan Hajnoczi wrote:
> On Thu, Jun 18, 2020 at 10:07:41AM +0100, Daniel P. Berrangé wrote:
> > On Thu, Jun 18, 2020 at 08:31:24AM +0100, Stefan Hajnoczi wrote:
> > > On Wed, Jun 17, 2020 at 03:36:29PM +0200, BALATON Zoltan wrote:
> > > > Add a backend that is the same as the log backend but omits the
> > > > process id and timestamp so logs are easier to read and diff-able.
> > > > 
> > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > ---
> > > >  scripts/tracetool/backend/plainlog.py | 48 +++++++++++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > > >  create mode 100644 scripts/tracetool/backend/plainlog.py
> > > > 
> > > > diff --git a/scripts/tracetool/backend/plainlog.py b/scripts/tracetool/backend/plainlog.py
> > > > new file mode 100644
> > > > index 0000000000..40bbfa6d76
> > > > --- /dev/null
> > > > +++ b/scripts/tracetool/backend/plainlog.py
> > > > @@ -0,0 +1,48 @@
> > > > +# -*- coding: utf-8 -*-
> > > > +
> > > > +"""
> > > > +Stderr built-in backend, plain log without proc ID and time.
> > > > +"""
> > > > +
> > > > +__author__     = "Llu????s Vilanova <vilanova@ac.upc.edu>"
> > > > +__copyright__  = "Copyright 2012-2017, Llu????s Vilanova <vilanova@ac.upc.edu>"
> > > 
> > > There is a Unicode issue here, Lluís' name is not printed correctly.
> > > 
> > > > +__license__    = "GPL version 2 or (at your option) any later version"
> > > > +
> > > > +__maintainer__ = "Stefan Hajnoczi"
> > > > +__email__      = "stefanha@linux.vnet.ibm.com"
> > > > +
> > > > +
> > > > +from tracetool import out
> > > > +
> > > > +
> > > > +PUBLIC = True
> > > > +
> > > > +
> > > > +def generate_h_begin(events, group):
> > > > +    out('#include "qemu/log-for-trace.h"',
> > > > +        '')
> > > > +
> > > > +
> > > > +def generate_h(event, group):
> > > > +    argnames = ", ".join(event.args.names())
> > > > +    if len(event.args) > 0:
> > > > +        argnames = ", " + argnames
> > > > +
> > > > +    if "vcpu" in event.properties:
> > > > +        # already checked on the generic format code
> > > > +        cond = "true"
> > > > +    else:
> > > > +        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
> > > > +
> > > > +    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> > > > +        '        qemu_log("%(name)s " %(fmt)s "\\n" %(argnames)s);',
> > > > +        '    }',
> > > > +        cond=cond,
> > > > +        name=event.name,
> > > > +        fmt=event.fmt.rstrip("\n"),
> > > > +        argnames=argnames)
> > > 
> > > It is not necessary to introduce a new backend. There could be an option
> > > that controls whether or not the timestamp/tid is printed. For example,
> > > -trace timestamp=off or maybe the timestmap/tid can be integrated into
> > > qemu_log() itself so that it's used more consistently and a -d timestamp
> > > option enables it.
> > 
> > QEMU already has a "-msg timestamp=on|off" option that controls whether
> > error reports on stderr get a timestamp. I think it is probably reasonable
> > for this existing option to apply to anything QEMU prints to stdout/err,
> > and thus we could wire it up for qemu_log().
> 
> I thought about that but the features are somewhat unrelated.
> 
> If we unify them, how about making the timestamp/tid apply to *all*
> qemu_log() output, not just tracing?

That's exactly what I intended.

Essentially if QEMU is going to add timestamps to things it writes to
stdout/err, then it should do that universally for all parts of the code
base that use stdio. This means error_report(), qemu_log(), and any
other places that are relevant wrt stdio.

Having separate timestamp on/off switches for each feature is not
desirable.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


