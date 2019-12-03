Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6148AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C18220674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKCEE7eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C18220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6bk-0002km-A7
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ic6Yi-0001Xv-2c
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ic6Yg-00048I-10
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:41:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41789
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ic6Yf-00042v-S4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575373287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwAk+Da7Sa9WbF8WdOPnmCk9odQXkD2H7mOgA6oAhlU=;
 b=iKCEE7eqMspUojsSxdTFpprdky1iIPVogyY9bDItmEg13iwRsCaOhcEwzma9Keus6NWXrA
 juXYA9PquPh5MfhQCsaVCGYKr4Uenjdag96UlhA0tGByFnatE6fjk2Lh6WyZmLTEnXLWXU
 NdB7/xPJLSkC76HJN2Ea+6cNxM83B50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-UQkry_sTMOyU-FXzNTpUYw-1; Tue, 03 Dec 2019 06:41:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1589F1B18BC3;
 Tue,  3 Dec 2019 11:41:25 +0000 (UTC)
Received: from gondolin (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 734E75DA60;
 Tue,  3 Dec 2019 11:41:19 +0000 (UTC)
Date: Tue, 3 Dec 2019 12:41:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v5 11/13] hw/s390x/ipl: replace deprecated
 qdev_reset_all registration
Message-ID: <20191203124116.1a1ca685.cohuck@redhat.com>
In-Reply-To: <20191018150630.31099-12-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-12-damien.hedde@greensocs.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: UQkry_sTMOyU-FXzNTpUYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com, qemu-s390x@nongnu.org,
 mark.burton@greensocs.com, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, edgari@xilinx.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 17:06:28 +0200
Damien Hedde <damien.hedde@greensocs.com> wrote:

> Replace deprecated qdev_reset_all by resettable_cold_reset_fn for
> the ipl registration in the main reset handlers.
> 
> This does not impact the behavior for the following reasons:
> + at this point resettable just call the old reset methods of devices
>   and buses in the same order than qdev/qbus.
> + resettable handlers registered with qemu_register_reset are
>   serialized; there is no interleaving.
> + eventual explicit calls to legacy reset API (device_reset or
>   qdev/qbus_reset) inside this reset handler will not be masked out
>   by resettable mechanism; they do not go through resettable api.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


