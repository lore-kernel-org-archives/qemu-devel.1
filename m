Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB908C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B7E2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBGlJD5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B7E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jyp-0006jA-UN
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j8jxy-0005tu-39
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j8jxt-0000m4-Ir
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:14:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j8jxt-0000lu-9u
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583151268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dOaNjFvD9FFDm5f+AHw6gOFvmBy/f2jfxDK6QRSXD0=;
 b=XBGlJD5EYBkevt3sWjmpUC7qfL6tDUVQr5ibcK77R2qW+b46hGR06/t2yn0E2EDiDaWCsK
 6Z6INdq1oomXWeUKIihT1xNO6XAGNFIJ8Cj8QGroZmPm4subVQlpcR2NrtohSlkadyNtz7
 9rLx8+g+y3G3LthJQZablRRk/pDVBEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-9P-OmDnUNDSTRosOZQwCzg-1; Mon, 02 Mar 2020 07:14:26 -0500
X-MC-Unique: 9P-OmDnUNDSTRosOZQwCzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FEEE190D346;
 Mon,  2 Mar 2020 12:14:25 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B58160C05;
 Mon,  2 Mar 2020 12:14:21 +0000 (UTC)
Date: Mon, 2 Mar 2020 13:14:19 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 2/6] hw/arm/virt: Introduce VirtGICType enum type
Message-ID: <20200302121419.vm7l3ooqo26inpt6@kamzik.brq.redhat.com>
References: <20200302105516.5972-1-eric.auger@redhat.com>
 <20200302105516.5972-3-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200302105516.5972-3-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, maz@kernel.org,
 qemu-devel@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 11:55:12AM +0100, Eric Auger wrote:
> We plan to introduce yet another value for the gic version (nosel).
> As we already use exotic values such as 0 and -1, let's introduce
> a dedicated enum type and let vms->gic_version take this
> type.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v2 -> v3:
> - replaced defines by enum VirtGICType
> - use that new type for vms->gic_version
> ---
>  hw/arm/virt.c         | 30 +++++++++++++++---------------
>  include/hw/arm/virt.h | 11 +++++++++--
>  2 files changed, 24 insertions(+), 17 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>


