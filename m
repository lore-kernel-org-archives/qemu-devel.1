Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C951C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636092070B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiUSyq4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636092070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWzOJ-00057s-NC
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 05:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWzMr-000379-3K
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:32:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57627
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWzMp-0003Qb-Ij
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588930345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90gg94RIij9PKO3TBm55uQYlq2tbzaaBnLSmF5y7tVg=;
 b=DiUSyq4F1FaX8lrqLIZwIhvWa/t2UK1D3eSOEgsb8YYW9IGZ7/poLgy8mX2g3zCSoYemjo
 AGN2Ki9+Fcle1zeJGJ4L1GVK6pVofFY/jTrjiIudsvYssWxnu9et30TlK2O33E3onOq0an
 ffzfnqf9t+TAYj12Cl0lRIxrP8mpe+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-UtnOvgPbNeCOgdEekb8YPA-1; Fri, 08 May 2020 05:32:24 -0400
X-MC-Unique: UtnOvgPbNeCOgdEekb8YPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 183FA1005510;
 Fri,  8 May 2020 09:32:22 +0000 (UTC)
Received: from gondolin (ovpn-112-144.ams2.redhat.com [10.36.112.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68B155C1C5;
 Fri,  8 May 2020 09:32:10 +0000 (UTC)
Date: Fri, 8 May 2020 11:32:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 07/10] exec: Move all RAMBlock functions to
 'exec/ramblock.h'
Message-ID: <20200508113207.26770b12.cohuck@redhat.com>
In-Reply-To: <20200507173958.25894-8-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-8-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  7 May 2020 19:39:55 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The RAMBlock API was dispersed in 3 different headers.
> One of these headers, "exec/ram_addr.h", is restricted
> to target dependent code. However these functions are
> not target specific. Move all functions into a single
> place.  Now all these functions can be accessed by
> target-agnostic code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/exec/cpu-common.h    |  24 -------
>  include/exec/ram_addr.h      | 105 ---------------------------
>  include/exec/ramblock.h      | 134 +++++++++++++++++++++++++++++++++++
>  migration/migration.h        |   1 +
>  accel/tcg/translate-all.c    |   2 -
>  hw/block/nvme.c              |   2 +-
>  hw/s390x/s390-stattrib-kvm.c |   1 -
>  hw/s390x/s390-stattrib.c     |   1 -
>  hw/s390x/s390-virtio-ccw.c   |   1 -
>  hw/virtio/vhost-user.c       |   1 +
>  hw/virtio/vhost.c            |   1 +
>  hw/virtio/virtio-balloon.c   |   1 +
>  memory.c                     |   1 +
>  migration/migration.c        |   1 +
>  migration/postcopy-ram.c     |   1 +
>  migration/savevm.c           |   1 +
>  stubs/ram-block.c            |   2 +-
>  target/ppc/kvm.c             |   1 -
>  target/s390x/kvm.c           |   1 -
>  util/vfio-helpers.c          |   2 +-
>  20 files changed, 145 insertions(+), 139 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>


