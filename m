Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FCCC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 14:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400CD20867
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 14:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OF7eFUaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400CD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibQUl-0005x8-M4
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 09:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ibQTA-0005K4-FQ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ibQT5-0000UF-SR
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:45:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ibQT5-0000SP-Bz
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 09:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575211498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fezVymmgMynEg185gbpYNZ8g4CgMcPsnxexyVBPdjQ=;
 b=OF7eFUaL5P92cvrQKSuXYfpzhgf7VN/H9khyKDt9p3+WT0rSaY7MtvCgwGJ6A8FzRgJYCG
 pFjggF+X4T6wt55o+KXYinZwf3u+LaCOKz/pvo3tFC3NigT+vg1o2QJ2sFV6Bk2CsaGJ0K
 SkwICAkyRmq8y6K+ZmwlECqOSQulE3s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-GPvtviOBMdaXuNVByHyy4w-1; Sun, 01 Dec 2019 09:44:55 -0500
Received: by mail-qt1-f197.google.com with SMTP id e37so8305597qtk.7
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 06:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Xr5toL4MnJEaBP0pyxaqVUMAf6P8R3pGs7GSsgdNaHA=;
 b=FlWCTRNDLTBfbO+CKP+yC5ePdW6FC8FHe9+pZgVTxiiQ2YhIR8yoVf8mGWygIGAz/e
 36oQWhX07bCY7ps+TwBLQODFmm455lrQc/0+oRiDD9TcgBovuetZWA4F64gW4lou8wkN
 Y+r03Gy5v3Vn6P2IAgBgbn+ThmmiQtAgyPG0zB1GToA2i5DKIb6fLqAnJ/SYd8WMg06S
 Cgt5iXzfqKbiXPAPOJlGLRUqT2xkBeObQ3/KG1CkFuFvXYOhtTAGt7BoMlDce+9fXVyL
 2HMyWuMT/RWKho0sCp3GvGuXH5H27ZLoGGwg0t/Ef0A1yxTUFBNSFIuhHl/6tqSPkTLw
 P5Bg==
X-Gm-Message-State: APjAAAVKu50ldXDPXYxPmn/j4VxtgeG5uQmcAEURddxxLIukWQv7eWoB
 g9NYypkc+CK4muhqhU1EGppldb0A1fSVR0ySJEz5EQYs0vcxnrFzk52Y2/vYFe2P1SGiRJKsjcW
 YeUpl4blGm4ZFZHQ=
X-Received: by 2002:a0c:804c:: with SMTP id 70mr28912624qva.81.1575211494629; 
 Sun, 01 Dec 2019 06:44:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrp5Oth7ZLHhxm0o1MP5WjnFL3w7hsrpXKWbz6qEJ6in88m/A77SF3+j13QECozi6aZs5gdQ==
X-Received: by 2002:a0c:804c:: with SMTP id 70mr28912592qva.81.1575211494397; 
 Sun, 01 Dec 2019 06:44:54 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id 184sm12905124qke.73.2019.12.01.06.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2019 06:44:53 -0800 (PST)
Date: Sun, 1 Dec 2019 09:44:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 00/21] Error handling fixes, may contain 4.2 material
Message-ID: <20191201094354-mutt-send-email-mst@kernel.org>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
X-MC-Unique: GPvtviOBMdaXuNVByHyy4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 vsementsov@virtuozzo.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Nishanth Aravamudan <naravamudan@digitalocean.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 30, 2019 at 08:42:19PM +0100, Markus Armbruster wrote:
> PATCH 2-4 fix crash bugs.  Including them would be a no-brainer at
> -rc0.  But we're post -rc3, and even for crash bugs we require a
> certain likelihood of users getting bitten.
>=20
> Jens, please assess impact of PATCH 2's crash bug.
>=20
> Kevin, please do the same for PATCH 3.
>=20
> Daniel, please do the same for PATCH 4.

virtio things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Jason do you want to pick these?

> The remainder is definitely not 4.2 material.
>=20
> Cc: "Daniel P. Berrang=E9" <berrange@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Corey Minyard <cminyard@mvista.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Jens Freimann <jfreimann@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Markus Armbruster (21):
>   net/virtio: Drop useless n->primary_dev not null checks
>   net/virtio: Fix failover error handling crash bugs
>   block/file-posix: Fix laio_init() error handling crash bug
>   crypto: Fix certificate file error handling crash bug
>   crypto: Fix typo in QCryptoTLSSession's <example> comment
>   io: Fix Error usage in a comment <example>
>   tests: Clean up initialization of Error *err variables
>   exec: Fix latent file_ram_alloc() error handling bug
>   hw/acpi: Fix latent legacy CPU plug error handling bug
>   hw/core: Fix latent fit_load_fdt() error handling bug
>   hw/ipmi: Fix latent realize() error handling bugs
>   qga: Fix latent guest-get-fsinfo error handling bug
>   memory-device: Fix latent memory pre-plug error handling bugs
>   s390x/event-facility: Fix latent realize() error handling bug
>   s390x/cpu_models: Fix latent feature property error handling bugs
>   s390/cpu_modules: Fix latent realize() error handling bugs
>   s390x: Fix latent query-cpu-model-FOO error handling bugs
>   s390x: Fix latent query-cpu-definitions error handling bug
>   error: Clean up unusual names of Error * variables
>   hw/intc/s390: Simplify error handling in kvm_s390_flic_realize()
>   tests-blockjob: Use error_free_or_abort()
>=20
>  include/crypto/tlssession.h         |  2 +-
>  include/io/task.h                   |  2 +-
>  block/file-posix.c                  |  2 +-
>  crypto/tlscredsx509.c               |  2 +-
>  exec.c                              |  6 +-
>  hw/acpi/cpu_hotplug.c               | 10 +--
>  hw/core/loader-fit.c                | 15 ++---
>  hw/intc/s390_flic_kvm.c             | 16 +++--
>  hw/ipmi/isa_ipmi_bt.c               |  7 ++-
>  hw/ipmi/isa_ipmi_kcs.c              |  7 ++-
>  hw/ipmi/pci_ipmi_bt.c               |  6 +-
>  hw/ipmi/pci_ipmi_kcs.c              |  6 +-
>  hw/mem/memory-device.c              |  6 +-
>  hw/net/virtio-net.c                 | 27 ++++----
>  hw/ppc/spapr_pci.c                  | 16 ++---
>  hw/ppc/spapr_pci_nvlink2.c          | 10 +--
>  hw/s390x/event-facility.c           |  6 +-
>  qga/commands-posix.c                |  6 +-
>  target/s390x/cpu_models.c           | 98 +++++++++++++++++------------
>  tests/test-blockjob.c               | 15 +++--
>  tests/test-qobject-output-visitor.c |  8 +--
>  tests/test-string-output-visitor.c  |  4 +-
>  22 files changed, 154 insertions(+), 123 deletions(-)
>=20
> --=20
> 2.21.0


