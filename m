Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA4C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C7B2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0IzJfdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C7B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8OpK-0007Bz-SS
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8OoD-0006R5-EL
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:11:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8OoA-0006LY-4y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597846277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPcpcj0+q4neAxL6WMmwvDt0WiThR+anvePmt9mxJAE=;
 b=c0IzJfdg9RssdaUu/InDvIUM/QT0Onc78Hrmg8Vx3ERd3tgLp/YAZLdoZZOiyTzcjB4OZw
 b1rqpWPAgNwTTgZkz2ikaTlp2caG7njbmZj/4MqJJXFhSgizwiGs5Yro3q3CSnQ64c03ha
 lnhAxY2vvd6j6hXwqPBME8mBsuSCOCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-q1J_Fu5ZMv2R9vQOoRhYbg-1; Wed, 19 Aug 2020 10:11:15 -0400
X-MC-Unique: q1J_Fu5ZMv2R9vQOoRhYbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCF81084C8E;
 Wed, 19 Aug 2020 14:11:12 +0000 (UTC)
Received: from gondolin (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB0BA709DC;
 Wed, 19 Aug 2020 14:10:59 +0000 (UTC)
Date: Wed, 19 Aug 2020 16:10:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 2/7] hw: add 5.2 machine types and 5.1 compat options
Message-ID: <20200819161052.51f73185.cohuck@redhat.com>
In-Reply-To: <20200819145425.622a0751@redhat.com>
References: <20200818143348.310613-1-stefanha@redhat.com>
 <20200818143348.310613-3-stefanha@redhat.com>
 <20200818171132.551e2c72.cohuck@redhat.com>
 <20200819145425.622a0751@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 14:54:25 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 18 Aug 2020 17:11:32 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Tue, 18 Aug 2020 15:33:43 +0100
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >   
> > > arm, i386, ppc, and s390x have versioned machine types and associated
> > > compatibility options. Introduce new ones now that QEMU 5.1 has been
> > > released.
> > > 
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  include/hw/boards.h        |  3 +++
> > >  include/hw/i386/pc.h       |  3 +++
> > >  hw/arm/virt.c              |  9 ++++++++-
> > >  hw/core/machine.c          |  4 ++++
> > >  hw/i386/pc.c               |  4 ++++
> > >  hw/i386/pc_piix.c          | 14 +++++++++++++-
> > >  hw/i386/pc_q35.c           | 13 ++++++++++++-
> > >  hw/ppc/spapr.c             | 15 +++++++++++++--
> > >  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> > >  9 files changed, 73 insertions(+), 6 deletions(-)    
> > 
> > https://lore.kernel.org/qemu-devel/20200728094645.272149-1-cohuck@redhat.com/
> > is already out there :)  
> 
> That one doesn't apply anymore (or I did something wrong when applying it),
> 
> but Stefan's version applies cleanly

Seems that there were some changes afterwards. I'd prefer to just
respin mine, though.


