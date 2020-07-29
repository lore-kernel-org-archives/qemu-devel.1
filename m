Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A137AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A01D2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2M4a+oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A01D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mzv-0002BB-RY
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0myw-0001U7-IZ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:22:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0myu-0000kW-5D
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596032575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cHoVpnYLXVulP4Nmg8+08mjcJvmU6i93ZjO7Wn03w0=;
 b=h2M4a+oOJX8oBSnHdnSk/Tkyu+aG4u2cERfg3rg++UTArZsp/j5izIRLEuj6DSsaEJ+sgI
 xmMfghL2j4Fc+px5tbl5KiQgeLzqEZFSe8LrOoej2dJihTn5cHVrxDB1RatFxvdJpWvxZv
 MDXgCvg8BEE0eV99TGl7gStNqQ04rOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-zSiVxbh0O4Kc5NpwVIkJ_Q-1; Wed, 29 Jul 2020 10:22:51 -0400
X-MC-Unique: zSiVxbh0O4Kc5NpwVIkJ_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C02E8C3540;
 Wed, 29 Jul 2020 14:22:49 +0000 (UTC)
Received: from gondolin (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7424C5C1BD;
 Wed, 29 Jul 2020 14:22:41 +0000 (UTC)
Date: Wed, 29 Jul 2020 16:22:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw: add compat machines for 5.2
Message-ID: <20200729162239.0f71b7a5.cohuck@redhat.com>
In-Reply-To: <20200729101032-mutt-send-email-mst@kernel.org>
References: <20200728094645.272149-1-cohuck@redhat.com>
 <20200729101032-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jul 2020 10:10:56 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jul 28, 2020 at 11:46:45AM +0200, Cornelia Huck wrote:
> > Add 5.2 machine types for arm/i440fx/q35/s390x/spapr.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> We merge this kind of thing after the release, right?

I guess the first person to do an arch pull request for 5.2 gets to
merge this.

(I don't have much for s390 yet, so probably someone else.)

> 
> 
> > ---
> >  hw/arm/virt.c              |  9 ++++++++-
> >  hw/core/machine.c          |  3 +++
> >  hw/i386/pc.c               |  3 +++
> >  hw/i386/pc_piix.c          | 14 +++++++++++++-
> >  hw/i386/pc_q35.c           | 13 ++++++++++++-
> >  hw/ppc/spapr.c             | 15 +++++++++++++--
> >  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> >  include/hw/boards.h        |  3 +++
> >  include/hw/i386/pc.h       |  3 +++
> >  9 files changed, 71 insertions(+), 6 deletions(-)


