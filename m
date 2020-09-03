Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04E7C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97F720578
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5Sxbjdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97F720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsDS-00088r-Sz
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsCn-0007BK-IE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:35:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsCl-0003S5-EY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599150917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FLwYpLv3CbLQZkkYBT4DwW58MU6UxODqwwT6kP6qOA=;
 b=U5SxbjdweyEQrWR5CkDJeAkofNZqYQTBKsL2CDlwtnr4hlrEUOIHSoBiSeh7UnbYUwPtFO
 kYIB3Ose1izRjZmtQO9cvr3etrOoC5vsMVR42YQF4kXs7ZZU+CNFl5pSQ8OITdZs86kTzw
 y+oPmTFonHjMZPWfiIB+ULEQOGrSI7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-NMXKLDiQOda-c0RnzRletA-1; Thu, 03 Sep 2020 12:35:15 -0400
X-MC-Unique: NMXKLDiQOda-c0RnzRletA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3BFC1005E67
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 16:35:14 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6861E59;
 Thu,  3 Sep 2020 16:35:14 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:35:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 33/63] net/can: Rename TYPE_CAN_CPI constants
Message-ID: <20200903163513.GK4940@habkost.net>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-34-ehabkost@redhat.com>
 <701fdf7d-be1b-a419-cedc-782d9f48b96e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <701fdf7d-be1b-a419-cedc-782d9f48b96e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, berrange@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 02:59:00PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> > Rename macros to names that are unique in the source tree, to
> > reduce confusion and make automated conversion of the code
> > easier.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  hw/net/can/can_kvaser_pci.c   | 6 +++---
> >  hw/net/can/can_mioe3680_pci.c | 6 +++---
> >  hw/net/can/can_pcm3680_pci.c  | 6 +++---
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
> > index 168b3a620d..12d4f8df33 100644
> > --- a/hw/net/can/can_kvaser_pci.c
> > +++ b/hw/net/can/can_kvaser_pci.c
> > @@ -45,11 +45,11 @@
> >  #include "can_sja1000.h"
> >  #include "qom/object.h"
> >  
> > -#define TYPE_CAN_PCI_DEV "kvaser_pci"
> > +#define TYPE_KVASER_PCI "kvaser_pci"
> 
> Why keep "PCI" and not keep the "CAN" part?
> To be consistent we should use both busses or none.

Because the type name is "kvaser_pci", the device state struct is
called KVaserPCIState, the type checking macro is called
KVASER_PCI_DEV, and most functions inside that file are called
kvaser_pci_*().

-- 
Eduardo


