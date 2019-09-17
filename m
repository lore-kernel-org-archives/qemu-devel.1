Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91855C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA462067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA462067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGLz-00085T-9B
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAG9B-0004rd-LP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAG97-0001W2-Lk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:16:09 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:35273)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAG97-0001VU-Fo
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:16:05 -0400
Received: from player788.ha.ovh.net (unknown [10.109.146.20])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 583C013D0F2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 18:16:03 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 5EE3E9E2FEA7;
 Tue, 17 Sep 2019 16:15:34 +0000 (UTC)
Date: Tue, 17 Sep 2019 18:15:33 +0200
From: Greg Kurz <groug@kaod.org>
To: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190917181533.35d62871@bahia.lan>
In-Reply-To: <20190917145157.GA16309@lap1>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871568761.196432.13197720535866413065.stgit@bahia.lan>
 <20190917145157.GA16309@lap1>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 486951712008346024
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.78.111
Subject: Re: [Qemu-devel] [PATCH 09/17] hw/rdma: Fix missing conversion to
 rdma_error_report()
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
 Max Reitz <mreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 17:51:57 +0300
Yuval Shaia <yuval.shaia@oracle.com> wrote:

> On Tue, Sep 17, 2019 at 12:21:27PM +0200, Greg Kurz wrote:
> > Commit 4d71b38ae8fa converted many error_setg() call sites to
> > rdma_error_report(), but it forgot to convert a companion
> > error_append_hint(). Since no guy doesn't set errp anymore in
> > pvrdma_realize(), errp remains NULL and error_append_hint() does
> > nothing.
> > 
> > Also error_append_hint() was a poor choice since its "intended use
> > is adding helpful hints on the human user interface" and "not for
> > clarifying a confusing error message".
> > 
> > Call rdma_error_report() instead.
> 
> Thanks,
> So are you suggesting to replace all other error_setg calls with
> rdma_error_report instead?
> 

No. I don't know what was the motivation behind 4d71b38ae8fa, I'm
just fixing what seems to be a leftover, which should have been
error_prepend() instead of error_append_hint() actually.

> > 
> > Fixes: 4d71b38ae8fa "hw/rdma: Switch to generic error reporting way"
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/rdma/vmw/pvrdma_main.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index 3e36e130139c..d370ae07ca6a 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -667,7 +667,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >  out:
> >      if (rc) {
> >          pvrdma_fini(pdev);
> > -        error_append_hint(errp, "Device failed to load\n");
> > +        rdma_error_report("Device failed to load");
> 
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> 
> >      }
> >  }
> >  
> > 
> > 


