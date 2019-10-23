Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6D5CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059BE214B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rk1Xn8ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059BE214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNEI5-0004tI-JU
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iNDjd-0004ug-4u
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iNDjc-0000wL-1w
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:19:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iNDjb-0000wD-V0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msvm480ex05gsqUIOx1/dHm00x/HecbiFX8wRD05BwU=;
 b=Rk1Xn8ymYhPyOrZ3qDlJ8EEBMQuNEm4e3+ERRyZIXXzK9yMHch6GWNeqIig8ZFw9x7FQ/9
 g9W1rsNuQfQrG1X+Eh2pyv8/dEbWgRc7v5sqg62VE9RxLG8JUSGD+JpdZy6edSEaREZ5RE
 MPHuQegtIjgACZWvbn9nAAB4n+TLi+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-IAVTGeyUN_aq8V6ntNLgHw-1; Wed, 23 Oct 2019 06:19:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79CA1800D6B;
 Wed, 23 Oct 2019 10:19:14 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD97460624;
 Wed, 23 Oct 2019 10:19:14 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id A90494EE50;
 Wed, 23 Oct 2019 10:19:14 +0000 (UTC)
Date: Wed, 23 Oct 2019 06:19:14 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1425198155.8144323.1571825954529.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191023100425.12168-5-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
 <20191023100425.12168-5-stefanha@redhat.com>
Subject: Re: [PATCH v4 04/16] virtio-scsi-test: add missing feature negotiation
MIME-Version: 1.0
X-Originating-IP: [149.14.88.107, 10.4.196.29, 10.5.100.50, 10.4.195.25]
Thread-Topic: virtio-scsi-test: add missing feature negotiation
Thread-Index: DaZghX7nFYRKs5RbtdKPo+3+4DOVwg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IAVTGeyUN_aq8V6ntNLgHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, slp@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> Sent: Wednesday, October 23, 2019 12:04:13 PM
>=20
> VIRTIO Device Initialization requires feature negotiation.  Currently
> virtio-scsi-test.c is non-compliant.
>=20
> libqos tests acknowledge all feature bits advertised by the device,
> except VIRTIO_F_BAD_FEATURE (which devices use to detect broken
> drivers!) and VIRTIO_RING_F_EVENT_IDX (which is not implemented in
> libqos and accepting it would break notifications).
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/virtio-scsi-test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Thomas Huth" <thuth@redhat.com>


