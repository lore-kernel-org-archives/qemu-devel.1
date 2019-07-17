Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9EEC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79F4217F9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79F4217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnhHr-0001Vj-L6
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hnhHc-00013i-OU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hnhHb-0001Ky-Mf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35825)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hnhHb-0001KH-Ef
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:35:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2142E285AE;
 Wed, 17 Jul 2019 10:35:34 +0000 (UTC)
Received: from redhat.com (ovpn-120-247.rdu2.redhat.com [10.10.120.247])
 by smtp.corp.redhat.com (Postfix) with SMTP id E43015D71D;
 Wed, 17 Jul 2019 10:35:27 +0000 (UTC)
Date: Wed, 17 Jul 2019 06:35:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190717063514-mutt-send-email-mst@kernel.org>
References: <20190624091304.666-1-stefanha@redhat.com>
 <20190717101453.GE7341@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717101453.GE7341@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 17 Jul 2019 10:35:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] docs: clarify multiqueue vs multiple
 virtqueues
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, qemu-devel@nongnu.org,
 Cathy Zhang <cathy.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 11:14:53AM +0100, Stefan Hajnoczi wrote:
> On Mon, Jun 24, 2019 at 10:13:04AM +0100, Stefan Hajnoczi wrote:
> > The vhost-user specification does not explain when
> > VHOST_USER_PROTOCOL_F_MQ must be implemented.  This may lead
> > implementors of vhost-user masters to believe that this protocol feature
> > is required for any device that has multiple virtqueues.  That would be
> > a mistake since existing vhost-user slaves offer multiple virtqueues but
> > do not advertise VHOST_USER_PROTOCOL_F_MQ.
> > 
> > For example, a vhost-net device with one rx/tx queue pair is not
> > multiqueue.  The slave does not need to advertise
> > VHOST_USER_PROTOCOL_F_MQ.  Therefore the master must assume it has these
> > virtqueues and cannot rely on askingt the slave how many virtqueues
> > exist.
> > 
> > Extend the specification to explain the different between true
> > multiqueue and regular devices with a fixed virtqueue layout.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Based-on: <20190621094005.4134-1-stefanha@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> 
> Ping?

queued, thanks!

> > 
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 5750668aba..7827b710aa 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -324,6 +324,15 @@ must support changing some configuration aspects on the fly.
> >  Multiple queue support
> >  ----------------------
> >  
> > +Many devices have a fixed number of virtqueues.  In this case the master
> > +already knows the number of available virtqueues without communicating with the
> > +slave.
> > +
> > +Some devices do not have a fixed number of virtqueues.  Instead the maximum
> > +number of virtqueues is chosen by the slave.  The number can depend on host
> > +resource availability or slave implementation details.  Such devices are called
> > +multiple queue devices.
> > +
> >  Multiple queue support allows the slave to advertise the maximum number of
> >  queues.  This is treated as a protocol extension, hence the slave has to
> >  implement protocol features first. The multiple queues feature is supported
> > @@ -339,6 +348,14 @@ queue in the sent message to identify a specified queue.
> >  The master enables queues by sending message ``VHOST_USER_SET_VRING_ENABLE``.
> >  vhost-user-net has historically automatically enabled the first queue pair.
> >  
> > +Slaves should always implement the ``VHOST_USER_PROTOCOL_F_MQ`` protocol
> > +feature, even for devices with a fixed number of virtqueues, since it is simple
> > +to implement and offers a degree of introspection.
> > +
> > +Masters must not rely on the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature for
> > +devices with a fixed number of virtqueues.  Only true multiqueue devices
> > +require this protocol feature.
> > +
> >  Migration
> >  ---------
> >  
> > -- 
> > 2.21.0
> > 



