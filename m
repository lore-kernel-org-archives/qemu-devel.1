Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC02C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B532072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYW6Mh4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B532072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsGJ-0003Ji-PX
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsFO-0001pq-I1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:38:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36183
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsFM-0003tP-7Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599151079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtKyjmdMS0JfvKYhLeH3xy5JrTp6y7X0rJ2R2kA5zJk=;
 b=dYW6Mh4y1TiZ7rZtTeGFadSv4BzviSIC7y2t/mrG+RC1ae/5WheP6+qjmMnrVcwHezRxpf
 j+m5qlUvPAwE/15d4xjdqsi7UPeXhIQ0LpHtFgG7KfEFcvNNYabb41II06sHVVOCe9e4ef
 n6mutHUZpWctPruBcKCCVHx1lUu4UL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-rkBeJHjVNaCLR-Y6rOlk6Q-1; Thu, 03 Sep 2020 12:37:57 -0400
X-MC-Unique: rkBeJHjVNaCLR-Y6rOlk6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08DE9801AEC
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 16:37:57 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1D1C59;
 Thu,  3 Sep 2020 16:37:53 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:37:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 28/63] tusb6010: Rename TYPE_TUSB6010 to TYPE_TUSB
Message-ID: <20200903163753.GM4940@habkost.net>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-29-ehabkost@redhat.com>
 <fa919593-5c84-a42a-e443-2a957b0426a0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fa919593-5c84-a42a-e443-2a957b0426a0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 02:56:20PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> > This will make the type name constant consistent with the name of
> > the type checking macro.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  hw/usb/tusb6010.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
> > index 2bee3ae59f..9b35c1d4b8 100644
> > --- a/hw/usb/tusb6010.c
> > +++ b/hw/usb/tusb6010.c
> > @@ -30,10 +30,10 @@
> >  #include "hw/sysbus.h"
> >  #include "qom/object.h"
> >  
> > -#define TYPE_TUSB6010 "tusb6010"
> > +#define TYPE_TUSB "tusb6010"
> 
> We are loosing information helpful to reviewers.
> Can we rename the type macro TUSB6010() instead?

We can.  I will do it instead.

-- 
Eduardo


