Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC9BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CBD205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CBD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAXCU-0005YG-2u
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAXAs-0004Tf-Pf
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAXAr-00049p-Om
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAXAm-00046j-Bp; Wed, 18 Sep 2019 06:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB85C882F2;
 Wed, 18 Sep 2019 10:26:54 +0000 (UTC)
Received: from gondolin (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D443460A9F;
 Wed, 18 Sep 2019 10:26:30 +0000 (UTC)
Date: Wed, 18 Sep 2019 12:26:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190918122628.7acb9284.cohuck@redhat.com>
In-Reply-To: <20190917183620.044e980d@bahia.lan>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871569396.196432.12307975838741351907.stgit@bahia.lan>
 <20190917132412.6610576c.cohuck@redhat.com>
 <20190917183620.044e980d@bahia.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 18 Sep 2019 10:26:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 10/17] s390x/css: Pass local error object
 pointer to error_append_hint()
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-s390x@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 18:36:20 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 17 Sep 2019 13:24:12 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Tue, 17 Sep 2019 12:21:34 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >   
> > > Ensure that hints are added even if errp is &error_fatal or &error_abort.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/s390x/s390-ccw.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)  
> > 
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > 
> > Can also take this via the s390 tree, let me know what would work best.  
> 
> I guess it would be easier to merge if each individual patch goes
> through the corresponding sub-maintainer tree. But Eric mentioned
> in another mail that the whole whole series could maybe go through
> Markus' error tree... so, I don't know which is best. :)

Ok, it's probably best to take this through the s390 tree, as I plan to
send a pull request tomorrow :)

Thanks, applied.

