Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268FBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D167520759
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zqsq9ZMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D167520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRCL-0003oI-2U
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbRBE-0002aV-UI
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:02:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbRBC-0002om-VW
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589990569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xwYbz+wmK7npnV+vVcQzDOpVINUREQVEaIQxYqTLVuo=;
 b=Zqsq9ZMtFxXvrJiunCd8qE84qAcv3bdr0uLvwG6OHkTenVJ/adWAFHMQF0wfZBMyEiJIg9
 UAkJyDmp0kkNfKUtZaePbWPWcR8jdI2t9gFUHUG2vVjdx2SJPuQvVRLdIM5QFQEkxmAR/N
 A/uuea7dMNwRFKA1AcFm19DqpK4AI88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-rkU9kdoyMWyk56uPuaeMbg-1; Wed, 20 May 2020 12:02:36 -0400
X-MC-Unique: rkU9kdoyMWyk56uPuaeMbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B4201015DB8;
 Wed, 20 May 2020 16:01:58 +0000 (UTC)
Received: from work-vm (ovpn-114-169.ams2.redhat.com [10.36.114.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B3F13AC;
 Wed, 20 May 2020 16:01:50 +0000 (UTC)
Date: Wed, 20 May 2020 17:01:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 12/19] MAINTAINERS: Add myself as virtio-mem maintainer
Message-ID: <20200520160148.GF2820@work-vm>
References: <20200520123152.60527-1-david@redhat.com>
 <20200520123152.60527-13-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520123152.60527-13-david@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> Let's make sure patches/bug reports find the right person.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47ef3139e6..91c2791679 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1744,6 +1744,14 @@ F: hw/virtio/virtio-crypto.c
>  F: hw/virtio/virtio-crypto-pci.c
>  F: include/hw/virtio/virtio-crypto.h
>  
> +virtio-mem
> +M: David Hildenbrand <david@redhat.com>
> +S: Supported
> +F: hw/virtio/virtio-mem.c
> +F: hw/virtio/virtio-mem-pci.h
> +F: hw/virtio/virtio-mem-pci.c
> +F: include/hw/virtio/virtio-mem.h
> +

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  nvme
>  M: Keith Busch <kbusch@kernel.org>
>  L: qemu-block@nongnu.org
> -- 
> 2.25.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


