Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629DEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0C3207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzjxwE6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0C3207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKN5C-0000nC-9u
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKN4K-0008Kh-HM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKN4H-0007lB-6Y
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34054
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKN4G-0007km-WB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585923188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOfx1iZ5dwabYH+c+qem6wypzzDCA8iKhIZxqeRlpvU=;
 b=EzjxwE6ZtfYPvBPXAmDWUjhJcFbiyinUTa0AZIcYLWkNt8jAjyM+4nukq7XjzqMAe7xGjA
 ko//2l0kXAiIkNSrXIz8Bb/Fhv1KFmOrxWsoB3uAbxY3xZj8iCE8B7CQy7VQU5kj690x+5
 tEMMf8hWYes6NmV1RnRkv5NQEDaMNyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-PvjK-1uwNCyLBbzIRwrwLg-1; Fri, 03 Apr 2020 10:13:06 -0400
X-MC-Unique: PvjK-1uwNCyLBbzIRwrwLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6109C18A6EC6;
 Fri,  3 Apr 2020 14:13:04 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F306810002A8;
 Fri,  3 Apr 2020 14:13:00 +0000 (UTC)
Date: Fri, 3 Apr 2020 16:12:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] nvdimm-utils: clean up headers and add license comment
Message-ID: <20200403161259.6af638b7@redhat.com>
In-Reply-To: <CAFEAcA_cyK+1+BjYqVB+nu70jiShx861NM=W0ezp_8g5eV6qcw@mail.gmail.com>
References: <20200403140018.13531-1-imammedo@redhat.com>
 <CAFEAcA_cyK+1+BjYqVB+nu70jiShx861NM=W0ezp_8g5eV6qcw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?Q8OpZHJp?= =?UTF-8?B?Yw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 15:06:14 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 3 Apr 2020 at 15:00, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Fixes: 3f350f6bb36233be50fc2bc18dc78b6a948a5dbe
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/qemu/nvdimm-utils.h |  2 --
> >  util/nvdimm-utils.c         | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
> > index 4b8b198ba7..1f1dae477f 100644
> > --- a/include/qemu/nvdimm-utils.h
> > +++ b/include/qemu/nvdimm-utils.h
> > @@ -1,7 +1,5 @@
> >  #ifndef NVDIMM_UTILS_H
> >  #define NVDIMM_UTILS_H
> >  
> 
> .h file still missing the copyright-n-license comment ?
do we have to add that for headers as well?

> 
> > -#include "qemu/osdep.h"
> > -
> >  GSList *nvdimm_get_device_list(void);
> >  #endif
> > diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
> > index 5cc768ca47..ca41d39af5 100644
> > --- a/util/nvdimm-utils.c
> > +++ b/util/nvdimm-utils.c
> > @@ -1,3 +1,32 @@
> > +/*
> > + * NVDIMM utilities
> > + *
> > + * Copyright(C) 2015 Intel Corporation.
> > + *
> > + * Author:
> > + *  Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > + *
> > + * NFIT is defined in ACPI 6.0: 5.2.25 NVDIMM Firmware Interface Table (NFIT)
> > + * and the DSM specification can be found at:
> > + *       http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
> > + *
> > + * Currently, it only supports PMEM Virtualization.
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.  
> 
> I guess you copied this from somewhere else, but commit b7cbb8741b40b7c
> suggests that "Lesser General Public License version 2" is
> wrong and it should either be "Library General Public License
> version 2" or "Lesser General Public License version 2.1"...we
> might as well get it right when we're adding a new file, so
> I would suggest you want 2.1 here.

it's copied from the source file this code was moved from.

> 
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> > + */
> > +
> > +#include "qemu/osdep.h"
> >  #include "qemu/nvdimm-utils.h"
> >  #include "hw/mem/nvdimm.h"
> >
> > --
> > 2.18.1
> >  
> 
> 
> thanks
> -- PMM
> 


