Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD692C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9F320781
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZ59rRq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9F320781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jom8k-0000uO-Sp
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jom7J-0008Au-Ej
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:01:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jom7H-00070j-3q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593169314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54AFfCAwRZMabq3p21YNLO9j9iX9H+8Mbtv8XIhgcY4=;
 b=DZ59rRq1TkRmR86uznD4xzQ7A2kf/SPUdabuUw8OG+loZbonYIXVq9jS/m8vZqPt0omTdo
 gHGKX6p4qO24QWGEgrnfbPi/JvWPaSeisiD62AGF/+vngWIXPawX/GJRtMstv7heCrRloi
 GcwY582R4ymgnKCi5R6+wmLDle8Gmew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-mku7AJ7rNAa1Mp-RJOTPew-1; Fri, 26 Jun 2020 07:01:50 -0400
X-MC-Unique: mku7AJ7rNAa1Mp-RJOTPew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A6AE18A0763;
 Fri, 26 Jun 2020 11:01:48 +0000 (UTC)
Received: from work-vm (ovpn-113-27.ams2.redhat.com [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E916960E1C;
 Fri, 26 Jun 2020 11:01:36 +0000 (UTC)
Date: Fri, 26 Jun 2020 12:01:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 1/9] host trust limitation: Introduce new host trust
 limitation interface
Message-ID: <20200626110134.GF3087@work-vm>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619020602.118306-2-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Gibson (david@gibson.dropbear.id.au) wrote:
> Several architectures have mechanisms which are designed to protect guest
> memory from interference or eavesdropping by a compromised hypervisor.  AMD
> SEV does this with in-chip memory encryption and Intel has a similar
> mechanism.  POWER's Protected Execution Framework (PEF) accomplishes a
> similar goal using an ultravisor and new memory protection features,
> instead of encryption.
> 
> To (partially) unify handling for these, this introduces a new
> HostTrustLimitation QOM interface.

This does make some sense to me from a SEV point of view, so

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  backends/Makefile.objs               |  2 ++
>  backends/host-trust-limitation.c     | 29 ++++++++++++++++++++++++
>  include/exec/host-trust-limitation.h | 33 ++++++++++++++++++++++++++++
>  include/qemu/typedefs.h              |  1 +
>  4 files changed, 65 insertions(+)
>  create mode 100644 backends/host-trust-limitation.c
>  create mode 100644 include/exec/host-trust-limitation.h
> 
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 28a847cd57..af761c9ab1 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -21,3 +21,5 @@ common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
>  common-obj-$(CONFIG_GIO) += dbus-vmstate.o
>  dbus-vmstate.o-cflags = $(GIO_CFLAGS)
>  dbus-vmstate.o-libs = $(GIO_LIBS)
> +
> +common-obj-y += host-trust-limitation.o
> diff --git a/backends/host-trust-limitation.c b/backends/host-trust-limitation.c
> new file mode 100644
> index 0000000000..96a381cd8a
> --- /dev/null
> +++ b/backends/host-trust-limitation.c
> @@ -0,0 +1,29 @@
> +/*
> + * QEMU Host Trust Limitation interface
> + *
> + * Copyright: David Gibson, Red Hat Inc. 2020
> + *
> + * Authors:
> + *  David Gibson <david@gibson.dropbear.id.au>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "exec/host-trust-limitation.h"
> +
> +static const TypeInfo host_trust_limitation_info = {
> +    .name = TYPE_HOST_TRUST_LIMITATION,
> +    .parent = TYPE_INTERFACE,
> +    .class_size = sizeof(HostTrustLimitationClass),
> +};
> +
> +static void host_trust_limitation_register_types(void)
> +{
> +    type_register_static(&host_trust_limitation_info);
> +}
> +
> +type_init(host_trust_limitation_register_types)
> diff --git a/include/exec/host-trust-limitation.h b/include/exec/host-trust-limitation.h
> new file mode 100644
> index 0000000000..03887b1be1
> --- /dev/null
> +++ b/include/exec/host-trust-limitation.h
> @@ -0,0 +1,33 @@
> +/*
> + * QEMU Host Trust Limitation interface
> + *
> + * Copyright: David Gibson, Red Hat Inc. 2020
> + *
> + * Authors:
> + *  David Gibson <david@gibson.dropbear.id.au>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + *
> + */
> +#ifndef QEMU_HOST_TRUST_LIMITATION_H
> +#define QEMU_HOST_TRUST_LIMITATION_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_HOST_TRUST_LIMITATION "host-trust-limitation"
> +#define HOST_TRUST_LIMITATION(obj)                                    \
> +    INTERFACE_CHECK(HostTrustLimitation, (obj),                       \
> +                    TYPE_HOST_TRUST_LIMITATION)
> +#define HOST_TRUST_LIMITATION_CLASS(klass)                            \
> +    OBJECT_CLASS_CHECK(HostTrustLimitationClass, (klass),             \
> +                       TYPE_HOST_TRUST_LIMITATION)
> +#define HOST_TRUST_LIMITATION_GET_CLASS(obj)                          \
> +    OBJECT_GET_CLASS(HostTrustLimitationClass, (obj),                 \
> +                     TYPE_HOST_TRUST_LIMITATION)
> +
> +typedef struct HostTrustLimitationClass {
> +    InterfaceClass parent;
> +} HostTrustLimitationClass;
> +
> +#endif /* QEMU_HOST_TRUST_LIMITATION_H */
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index ce4a78b687..f75c7eb2f2 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -51,6 +51,7 @@ typedef struct FWCfgIoState FWCfgIoState;
>  typedef struct FWCfgMemState FWCfgMemState;
>  typedef struct FWCfgState FWCfgState;
>  typedef struct HostMemoryBackend HostMemoryBackend;
> +typedef struct HostTrustLimitation HostTrustLimitation;
>  typedef struct I2CBus I2CBus;
>  typedef struct I2SCodec I2SCodec;
>  typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


