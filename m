Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5169EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D28206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mc25anHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D28206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZchP-0002D8-7W
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZcgc-0001PO-1x
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:55:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZcga-0005vr-Pl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589558143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtXWoNOchQkg/jrYnv0O2uMYTDRYqqetz96/9IJRxak=;
 b=Mc25anHrDK3QunuzV0Q6DAyCeA8Psrtyy8EX2bwBQPyn9k3GV+BKOj3fTCg3CIayMnvYwx
 jeaQcSGPGtLCC5H2DEOFKSxyAfYB67eJIbIGbO9+UqVxWGbFVzLPRembZ3YYJGs+p1s+Sj
 Ryolklh8pP/VRpavwhrqq/fww6QX75s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-DJgiDMZDPeGYHt7r-fkmZg-1; Fri, 15 May 2020 11:55:39 -0400
X-MC-Unique: DJgiDMZDPeGYHt7r-fkmZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3114E107ACF4;
 Fri, 15 May 2020 15:55:38 +0000 (UTC)
Received: from work-vm (ovpn-114-149.ams2.redhat.com [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E08A5C5FA;
 Fri, 15 May 2020 15:55:22 +0000 (UTC)
Date: Fri, 15 May 2020 16:55:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 12/17] MAINTAINERS: Add myself as virtio-mem maintainer
Message-ID: <20200515155520.GI2954@work-vm>
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-13-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506094948.76388-13-david@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..09fff9e1bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1734,6 +1734,14 @@ F: hw/virtio/virtio-crypto.c
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
>  nvme
>  M: Keith Busch <kbusch@kernel.org>
>  L: qemu-block@nongnu.org
> -- 
> 2.25.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


