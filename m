Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5228AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D252072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a06LZsou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D252072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsJQ-0000nc-6a
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsGP-0003sf-62
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:39:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsGN-00043V-EL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599151142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEGpoufcUZBbnJCZjV18HKmV7y/xyR1QgLd/SAYfPEE=;
 b=a06LZsouJUCxf8qbp/j8aMg4TRiyGpEGylBrBlu01sKCBSkMQL7UsHNrbo0qKaq4A+8RJ8
 uTtBN6wpbAAuPV793DOUSA2axSC/58cPDkbKLS4g9mx0/QnIyOd4ImaeGYh6U9ajVpJ8S7
 d9eJwQ30yNsth9M9pOwsJtA4d8iQXPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-jImJib3pP5KT0PNE1ug2-Q-1; Thu, 03 Sep 2020 12:39:00 -0400
X-MC-Unique: jImJib3pP5KT0PNE1ug2-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E394E10074AF;
 Thu,  3 Sep 2020 16:38:59 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A96C21C4;
 Thu,  3 Sep 2020 16:38:59 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:38:58 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 24/63] scsi: Rename TYPE_AM53C974_DEVICE to TYPE_PCI_ESP
Message-ID: <20200903163858.GN4940@habkost.net>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-25-ehabkost@redhat.com>
 <cb06c88c-d6e4-c951-5bcd-e0b029bdce81@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cb06c88c-d6e4-c951-5bcd-e0b029bdce81@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 02:55:06PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> > This will make the type name constant consistent with the name of
> > the type checking macro.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Fam Zheng <fam@euphon.net>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  hw/scsi/esp-pci.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> > index 2ce96dc56e..2b1198380b 100644
> > --- a/hw/scsi/esp-pci.c
> > +++ b/hw/scsi/esp-pci.c
> > @@ -35,11 +35,11 @@
> >  #include "qemu/module.h"
> >  #include "qom/object.h"
> >  
> > -#define TYPE_AM53C974_DEVICE "am53c974"
> > +#define TYPE_PCI_ESP "am53c974"
> 
> We are loosing information helpful to reviewers :(

Considering that the PCI_ESP macro is used in very few places, we
can use TYPE_AM53C974 and amAM53C974().  I will do it instead.

-- 
Eduardo


