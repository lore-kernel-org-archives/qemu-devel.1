Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E15C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCF02075D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8Pnrqfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCF02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwjm-0007J4-Ds
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jqwj4-0006rB-1b
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:45:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jqwj1-00080A-SW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593686750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0aJ0qgqUB9ifBntNRqneCEdTJDQ9L1LLky/ys0nGlI=;
 b=e8PnrqfbAxOhteEbBd20xFq2XUUnl66RV5SWUG4FoZEp5TrRyYJETBO5v6YQEgo5F0llL/
 C/MdaSyuKdDYw0KVaYVhestSIWZ+Gbz2g3IuqgRzboedEoJFk1pjRXYdKhoLYnh+hiEEvw
 ft+X4i0DXSjAdd2EYggQwr8sF7jNZfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-eWdTmdtiOKa1shnkVaAjQQ-1; Thu, 02 Jul 2020 06:45:49 -0400
X-MC-Unique: eWdTmdtiOKa1shnkVaAjQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45D7810059AB
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 10:45:48 +0000 (UTC)
Received: from gondolin (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C4285BAD5;
 Thu,  2 Jul 2020 10:45:41 +0000 (UTC)
Date: Thu, 2 Jul 2020 12:45:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200702124538.0ba5d334.cohuck@redhat.com>
In-Reply-To: <20200702060555-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200630121037.GC91444@stefanha-x1.localdomain>
 <20200630142504.688aa989.cohuck@redhat.com>
 <20200630090327-mutt-send-email-mst@kernel.org>
 <20200701181917.62538421.cohuck@redhat.com>
 <20200702060555-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jul 2020 06:16:06 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jul 01, 2020 at 06:19:17PM +0200, Cornelia Huck wrote:
> > On Tue, 30 Jun 2020 09:04:38 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Tue, Jun 30, 2020 at 02:25:04PM +0200, Cornelia Huck wrote:  
> >   
> > > > What bothers me most is that you need to explicitly request a device to
> > > > be modern-only, while that should be the default for any newly added
> > > > device. Hence the approach with the centralized list of device types
> > > > mentioned in a parallel thread. The main problem with that is that the
> > > > proxy device starts getting realized before the virtio device with its
> > > > id is present... I failed to find a solution so far. But I'd really
> > > > like an approach that can work for all transports.    
> > > 
> > > So how about simply validating that the device is modern only,
> > > unless it's one of the whitelist?  
> > 
> > Who would do the validation, the virtio core? How can it distinguish
> > between transitional and non-transitional? But maybe I'm just not
> > getting your idea.  
> 
> OK I've been thinking about two ideas, we can use them both:
> 1. virtio core: that can detect VIRTIO_1 being clear
> in virtio_validate_features.

After feature negotiation is complete? That feels like a regression in
behaviour: You would be able to add a device that may not be usable
(and you'll only find out after the guest tried to use it), instead of
making sure that only a non-transitional device can be added to start
with.

(We do not validate if the guest did not negotiate VERSION_1, but we
can certainly add a special case for the "guest did not accept offered
VERSION_1" case.)

> 2. transports: could use a core API to detect whether
> device can be a legacy one, to block device creation.

That would be the best, but how do we get around the "transport does
not know the device type until it is too late" problem? Unless you want
to redo the internal interfaces.

> 
> 
> > Also, ccw does not currently have a way to explicitly configure a
> > device non-transitional; the revisions can be used to fence off newer
> > features, going down to legacy-only, but fencing off older features is
> > not possible (that is only done by the device, if it has no legacy
> > support).  
> 
> I guess for ccw only option 1 works.
> 

Or keep it as-is, and disallow legacy for the individual device types,
with the validate check as a safety net during development.


