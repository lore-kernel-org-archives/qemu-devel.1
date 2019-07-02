Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED75EC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C171C206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C171C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiIkp-0007yw-3A
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 09:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiIjm-0007U3-VJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiIjl-00012S-Uy
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiIjl-0000pJ-O3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:22:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32C223084021;
 Tue,  2 Jul 2019 13:21:53 +0000 (UTC)
Received: from redhat.com (ovpn-124-236.rdu2.redhat.com [10.10.124.236])
 by smtp.corp.redhat.com (Postfix) with SMTP id C35EB179CB;
 Tue,  2 Jul 2019 13:21:49 +0000 (UTC)
Date: Tue, 2 Jul 2019 09:21:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190702092133-mutt-send-email-mst@kernel.org>
References: <20190529143106.11789-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529143106.11789-1-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 02 Jul 2019 13:22:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 0/4] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org,
 Amit Shah <amit@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 04:31:02PM +0200, Laurent Vivier wrote:
> Add a new RNG backend using QEMU builtin getrandom function.
> 
> v7: rebase on master
>     Make rng-builtin asynchronous with QEMUBH (removed existing R-b)
> 
> v6: remove "sysemu/rng-random.h" from virtio-rng.c
>     rebase on qemu_getrandom v8
> 
> v5: PATCH 1 s/linux/Linux/
>     remove superfluous includes from rng-builtin.c
>     don't update rng-random documentation
>     add a patch from Markus to keep the default backend out of VirtIORNGConf
>     move TYPE_RNG_BUILTIN to sysemu/rng.h and remove sysemu/rng-builtin.h
> 
> v4: update PATCH 1 commit message
> 
> v3: Include Kashyap's patch in the series
>     Add a patch to change virtio-rng default backend to rng-builtin
> 
> v2: Update qemu-options.hx
>     describe the new backend and specify virtio-rng uses the
>     rng-random by default


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge.

> Kashyap Chamarthy (1):
>   VirtIO-RNG: Update default entropy source to `/dev/urandom`
> 
> Laurent Vivier (2):
>   rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
>   virtio-rng: change default backend to rng-builtin
> 
> Markus Armbruster (1):
>   virtio-rng: Keep the default backend out of VirtIORNGConf
> 
>  backends/Makefile.objs         |  2 +-
>  backends/rng-builtin.c         | 77 ++++++++++++++++++++++++++++++++++
>  backends/rng-random.c          |  2 +-
>  hw/virtio/virtio-rng.c         | 19 ++++-----
>  include/hw/virtio/virtio-rng.h |  2 -
>  include/sysemu/rng.h           |  2 +
>  qemu-options.hx                |  9 +++-
>  7 files changed, 97 insertions(+), 16 deletions(-)
>  create mode 100644 backends/rng-builtin.c
> 
> -- 
> 2.20.1

