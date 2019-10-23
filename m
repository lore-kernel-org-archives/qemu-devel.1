Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F25CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B12B2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goTxWXH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B12B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNEvK-0000Rn-PC
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iNERk-00041P-Da
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iNERi-0003k3-6m
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:04:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39480
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iNERi-0003jd-3V
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571828693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6Tug7bQdLju1iBfx4LAU0FpVEH7FZOr4RXnZMT3SJk=;
 b=goTxWXH6tBUqUdP01E2nzhlIyYRkWMEpM2VcCrlc4PIw9mbXhs1fipAAqQCfshxFk5Ee6i
 iPdC8EihRf6U22i77V2V2bY4rqOP8qJGk2Ft7gED+5J1lqKfHlCUvFGAqfi7PEXtBRtSa2
 qCk7oXgZ/nNpzdYOodHclXdV4Ny2BCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-buZIOQZ-P_mKOk6hhn0EDg-1; Wed, 23 Oct 2019 07:04:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A3C41800D6B;
 Wed, 23 Oct 2019 11:04:50 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 370B054681;
 Wed, 23 Oct 2019 11:04:50 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0A51E18089C8;
 Wed, 23 Oct 2019 11:04:50 +0000 (UTC)
Date: Wed, 23 Oct 2019 07:04:49 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <442729553.8150608.1571828689863.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191023100425.12168-9-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
 <20191023100425.12168-9-stefanha@redhat.com>
Subject: Re: [PATCH v4 08/16] libqos: implement VIRTIO 1.0 FEATURES_OK step
MIME-Version: 1.0
X-Originating-IP: [149.14.88.107, 10.4.196.7, 10.5.100.50, 10.4.195.8]
Thread-Topic: libqos: implement VIRTIO 1.0 FEATURES_OK step
Thread-Index: 5X4OA3CFCYziXQhrt3GL/AUwzOo2vA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: buZIOQZ-P_mKOk6hhn0EDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
> Sent: Wednesday, October 23, 2019 12:04:17 PM
>=20
> Device initialization has an extra step in VIRTIO 1.0.  The FEATURES_OK
> status bit is set to indicate that feature negotiation has completed.
> The driver then reads the status register again to check that the device
> agrees with the final features.
>=20
> Implement this step as part of qvirtio_set_features() instead of
> introducing a separate function.  This way all existing code works
> without modifications.
>=20
> The check in qvirtio_set_driver_ok() needs to be updated because
> FEATURES_OK will be set for VIRTIO 1.0 devices.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v4:
>  * Make FEATURES_OK change in qvirtio_set_driver_ok() clearer and
>    mention it in the commit description [Thomas]
> ---
>  tests/libqos/virtio.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth" <thuth@redhat.com>


