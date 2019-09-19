Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798BCC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F20421924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F20421924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtQ4-00027U-Ra
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iAtNi-0008K2-Rb
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iAtNh-0000qo-FM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:09:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iAtNc-0000mV-1n; Thu, 19 Sep 2019 06:09:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50DFD3168BEB;
 Thu, 19 Sep 2019 10:09:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A149A5C21E;
 Thu, 19 Sep 2019 10:09:05 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:09:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190919100903.GF20217@redhat.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919091720.GB10163@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 19 Sep 2019 10:09:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: fam@euphon.net, peter.maydell@linaro.org, mst@redhat.com,
 codyprime@gmail.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 armbru@redhat.com, kraxel@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, david@redhat.com, mdroth@linux.vnet.ibm.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 rth@twiddle.net, farman@linux.ibm.com, groug@kaod.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, stefanha@redhat.com,
 jsnow@redhat.com, david@gibson.dropbear.id.au,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, cohuck@redhat.com,
 qemu-s390x@nongnu.org, sundeep.lkml@gmail.com, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 11:17:20AM +0200, Kevin Wolf wrote:
> Am 18.09.2019 um 19:10 hat Eric Blake geschrieben:
> > On 9/18/19 8:02 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > + */
> > > +#define MAKE_ERRP_SAFE(errp) \
> > > +g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
> > > +if ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) { \
> > > +    (errp) = &__auto_errp_prop.local_err; \
> > > +}
> > 
> > Not written to take a trailing semicolon in the caller.
> > 
> > You could even set __auto_errp_prop unconditionally rather than trying
> > to reuse incoming errp (the difference being that error_propagate() gets
> > called more frequently).
> 
> I think this difference is actually a problem.
> 
> When debugging things, I hate error_propagate(). It means that the Error
> (specifically its fields src/func/line) points to the outermost
> error_propagate() rather than the place where the error really happened.
> It also makes error_abort completely useless because at the point where
> the process gets aborted, the interesting information is already lost.

Yeah, that is very frustrating. For personal development you can eventually
figure it out, but with customer support requests, all you get is the
stack trace and you've no core file to investigate, so you're stuck.
IOW, as a general principle, we should strive to minimize the usage
of error propagate.

The key reason why we typically need the propagate calls, is because
we allow the passed in Error **errp parameter to be NULL, while at the
same time we want to inspect it to see if its contents are non-NULL
to detect failure. I venture to suggest that this is flawed API
design on our part. We should not need to inspect the error object
to see if a method call fails - the return value can be used for
this purpose.

IOW, instead of this pattern with typically 'void' methods

     extern void somemethod(Error **errp);

     void thismethod(Error **errp) {
        Error *local_err = NULL;
	...
        somemethod(&local_err);
        if (local_err) {
	    error_propagate(errp, local_err);
	    return;
	}
        ...
     }

We should be preferring

     extern int somemethod(Error **errp);

     int thismethod(Error **errp) {
	...
        if (somemethod(errp) < 0) {
	    return -1;
	}
        ...
     }

ie only using the Error object to bubble up the *details* of
the error, not as the mechanism for finding if an error occurred.

There is of course a downside with this approach, in that a
method might set 'errp' but return 0, or not set 'errp' but
return -1. I think this is outweighed by the simpler code
pattern overall though.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

