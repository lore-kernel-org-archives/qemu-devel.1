Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6EAC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717FB215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717FB215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEyix-00004z-Ki
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 12:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iEyi9-0007lX-IA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iEyi8-0007Dy-Em
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iEyi2-0007B6-05; Mon, 30 Sep 2019 12:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 51EF010CC1F4;
 Mon, 30 Sep 2019 16:39:36 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-86.ams2.redhat.com [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9728B5D9CA;
 Mon, 30 Sep 2019 16:39:10 +0000 (UTC)
Date: Mon, 30 Sep 2019 18:39:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 04/25] error: auto propagated local_err
Message-ID: <20190930163909.GD12777@linux.fritz.box>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-5-vsementsov@virtuozzo.com>
 <20190930151215.GB12777@linux.fritz.box>
 <ca629ae8-15c5-1685-1cbb-99283d37b0a1@virtuozzo.com>
 <20190930160039.GC12777@linux.fritz.box>
 <495102b2-5d1a-f659-4387-5733ae34b3e2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <495102b2-5d1a-f659-4387-5733ae34b3e2@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 30 Sep 2019 16:39:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Paul Burton <pburton@wavecomp.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 "integration@gluster.org" <integration@gluster.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.09.2019 um 18:26 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 30.09.2019 19:00, Kevin Wolf wrote:
> > Am 30.09.2019 um 17:19 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 30.09.2019 18:12, Kevin Wolf wrote:
> >>> Am 24.09.2019 um 22:08 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>>> Here is introduced ERRP_FUNCTION_BEGIN macro, to be used at start of
> >>>> functions with errp parameter.
> >>>
> >>> A bit of bike shedding, but FOO_BEGIN suggests to me that a FOO_END will
> >>> follow. Can we find a different name, especially now that we won't use
> >>> this macro in every function that uses an errp, so even the "errp
> >>> function" part isn't really correct any more?
> >>>
> >>> How about ERRP_AUTO_PROPAGATE?
> >>
> >> I have an idea that with this macro we can (optionally) get the whole call stack
> >> of the error and print it to log, so it's good to give it more generic name, not
> >> limited to propagation..
> > 
> > Hm, what's the context for this feature?
> > 
> > The obvious one where you want to have a stack trace is &error_abort,
> > but that one crashes, so you get it automatically. If it's just a normal
> > error (like a QAPI option contains an invalid value and some function
> > down the call chain checks it), why would anyone want to know what the
> > call chain in the QEMU code was?
> > 
> 
> When I have bug from testers, call stack would be a lot more descriptive, than just
> an error message.
> 
> We may add trace point which will print this information, so with disabled trace point
> - no extra output.

But wouldn't it make much more sense then to optionally add this
functionality to any trace point? I really don't see how this is related
specifically to user-visible error messages.

However, even if we decide that we want to have this in Error objects,
wouldn't it make much more sense to use the real C stack trace and save
it from the innermost error_set() using backtrace() or compiler
built-ins rather than relying on an error_propagate() chain?

Kevin

