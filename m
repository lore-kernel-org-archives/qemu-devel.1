Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3D1C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622EB2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622EB2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGSw-0004uy-6w
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAGKG-0006I4-DE
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAGKE-0006I7-Go
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:27:35 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:60164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAGKE-0006HE-8Y
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:27:34 -0400
Received: from player799.ha.ovh.net (unknown [10.109.160.232])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id F0062227B18
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 18:27:31 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 2D3BD9E56172;
 Tue, 17 Sep 2019 16:26:57 +0000 (UTC)
Date: Tue, 17 Sep 2019 18:26:56 +0200
From: Greg Kurz <groug@kaod.org>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190917182656.1db277b1@bahia.lan>
In-Reply-To: <de1d7856-3c59-0e94-2ba8-d0438e9d0ff6@redhat.com>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871571297.196432.545961868971946073.stgit@bahia.lan>
 <de1d7856-3c59-0e94-2ba8-d0438e9d0ff6@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 680887968690772361
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.178.36
Subject: Re: [Qemu-devel] [PATCH 13/17] nbd: Pass local error object pointer
 to error_append_hint()
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
 Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 10:15:07 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 9/17/19 5:21 AM, Greg Kurz wrote:
> > Ensure that hints are added even if errp is &error_fatal or &error_abort.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  nbd/client.c |   24 +++++++++++++-----------
> >  nbd/server.c |    7 +++++--
> >  2 files changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/nbd/client.c b/nbd/client.c
> > index b9dc829175f9..c6e6e4046fd5 100644
> > --- a/nbd/client.c
> > +++ b/nbd/client.c
> > @@ -154,6 +154,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
> >                                  bool strict, Error **errp)
> >  {
> >      g_autofree char *msg = NULL;
> > +    Error *local_err = NULL;
> 
> I'd prefer 'err' here...
> 
> >  
> >      if (!(reply->type & (1 << 31))) {
> >          return 1;
> > @@ -161,14 +162,14 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
> >  
> >      if (reply->length) {
> >          if (reply->length > NBD_MAX_BUFFER_SIZE) {
> > -            error_setg(errp, "server error %" PRIu32
> > +            error_setg(&local_err, "server error %" PRIu32
> 
> so that &err doesn't change line lengths.
> 
> >      case NBD_REP_ERR_SHUTDOWN:
> > -        error_setg(errp, "Server shutting down before option %" PRIu32 " (%s)",
> > +        error_setg(&local_err, "Server shutting down before option %" PRIu32 " (%s)",
> 
> For example, here, you went beyond 80 columns.
> 
> At any rate, I'm assuming this will probably go in through Markus' error
> tree as part of the whole series, rather than me needing to pick just
> this patch through my NBD tree.
> 
> Whether or not you shorten the local variable name,
> 

Regardless of which tree this goes through, it will be code for
which you're the official maintainer in the end. I'll gladly fix
it to meet your needs :)

> Reviewed-by: Eric Blake <eblake@redhat.com>
> 


