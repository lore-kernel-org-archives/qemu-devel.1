Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51326C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263EE217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263EE217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAscZ-00074l-8i
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iAsZR-0003ZF-SR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iAsZQ-0007Mm-ST
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:17:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iAsZM-0007Ix-5u; Thu, 19 Sep 2019 05:17:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8392310C030B;
 Thu, 19 Sep 2019 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.116.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89A7F5C207;
 Thu, 19 Sep 2019 09:17:21 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:17:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190919091720.GB10163@localhost.localdomain>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 09:17:42 +0000 (UTC)
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
Cc: fam@euphon.net, peter.maydell@linaro.org, mst@redhat.com,
 codyprime@gmail.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 armbru@redhat.com, kraxel@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, david@redhat.com, mdroth@linux.vnet.ibm.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 rth@twiddle.net, farman@linux.ibm.com, groug@kaod.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, stefanha@redhat.com,
 jsnow@redhat.com, david@gibson.dropbear.id.au,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, berrange@redhat.com,
 cohuck@redhat.com, qemu-s390x@nongnu.org, sundeep.lkml@gmail.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.09.2019 um 19:10 hat Eric Blake geschrieben:
> On 9/18/19 8:02 AM, Vladimir Sementsov-Ogievskiy wrote:
> > + */
> > +#define MAKE_ERRP_SAFE(errp) \
> > +g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
> > +if ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) { \
> > +    (errp) = &__auto_errp_prop.local_err; \
> > +}
> 
> Not written to take a trailing semicolon in the caller.
> 
> You could even set __auto_errp_prop unconditionally rather than trying
> to reuse incoming errp (the difference being that error_propagate() gets
> called more frequently).

I think this difference is actually a problem.

When debugging things, I hate error_propagate(). It means that the Error
(specifically its fields src/func/line) points to the outermost
error_propagate() rather than the place where the error really happened.
It also makes error_abort completely useless because at the point where
the process gets aborted, the interesting information is already lost.

So I'd really like to restrict the use of error_propagate() to places
where it's absolutely necessary. Unless, of course, you can fix these
practical problems that error_propagate() causes for debugging.

In fact, in the context of Greg's series, I think we really only need to
support hints for error_fatal, which are cases that users are supposed
to see. We should exclude error_abort in MAKE_ERRP_SAFE() because these
are things that are never supposed to happen. A good stack trace is more
important there than adding a hint to the message.

Kevin

