Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7086FC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA1B20702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHtNf7Xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA1B20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmRe-00011c-EP
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iwmPP-0005zp-TD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iwmPO-0000jq-2I
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:25:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24317
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iwmPN-0000gM-O4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580300725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eD0787NDohNjvxappA/qu+C3lhvoXKd+Eyz4of1nOSo=;
 b=EHtNf7XcBa8XRiZre60N8oEuHL+ePRhJ1+CNeu06aWTIjfJF4oOLv0pusl+iTNYRtggJ4m
 dKKFMh8hVZWyRKcz9vnfeonIFC/sABYdhN40HDSxIVy7mV/twUqPw4YCIlFero/hJ8D6Kf
 ER5gCXlWE8qgCIf7p/rwRkku8TLz12c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-vwla4zUSPA-eS1tmUB1m8A-1; Wed, 29 Jan 2020 07:25:23 -0500
X-MC-Unique: vwla4zUSPA-eS1tmUB1m8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EF66107ACC5;
 Wed, 29 Jan 2020 12:25:21 +0000 (UTC)
Received: from gondolin (ovpn-116-225.ams2.redhat.com [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0F985C219;
 Wed, 29 Jan 2020 12:25:08 +0000 (UTC)
Date: Wed, 29 Jan 2020 13:25:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 06/25] scripts/update-linux-headers: Import iommu.h
Message-ID: <20200129132505.52501bda.cohuck@redhat.com>
In-Reply-To: <1580300216-86172-7-git-send-email-yi.l.liu@intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-7-git-send-email-yi.l.liu@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com,
 hao.wu@intel.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 04:16:37 -0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
> 
> Update the script to import the new iommu.h uapi header.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index f76d773..dfdfdfd 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -141,7 +141,7 @@ done
>  
>  rm -rf "$output/linux-headers/linux"
>  mkdir -p "$output/linux-headers/linux"
> -for header in kvm.h vfio.h vfio_ccw.h vhost.h \
> +for header in kvm.h vfio.h vfio_ccw.h vhost.h iommu.h \
>                psci.h psp-sev.h userfaultfd.h mman.h; do
>      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>  done

Acked-by: Cornelia Huck <cohuck@redhat.com>


