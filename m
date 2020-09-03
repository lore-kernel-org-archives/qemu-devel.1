Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC38DC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFE3206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWGRppIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFE3206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnXb-0002WO-KC
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDnX2-00023u-DH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:35:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDnX0-0000oQ-Q7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599132953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ooIROgHCRalCAuSXrybe9ineZEQOHT4FL0oEFxPN9wI=;
 b=KWGRppIrFxM6l15+u7LSZPDCEcz/Mbf1ckGQHU3IakMsKNSwLoiw/ipZfYUZ9tt2sffm4t
 FZQgzwhUwjF+6aQIYZEa5Cj3TvAk6iTL8ZB1BLPF9cNh8wOmHQhP668Jd40HtcWHwBIDIh
 n9wtBoizZEHEUxmeanIf2V3pV2fIg5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-XNexdWm2PYShc7V7PKbpKQ-1; Thu, 03 Sep 2020 07:35:50 -0400
X-MC-Unique: XNexdWm2PYShc7V7PKbpKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEF0118CBC40;
 Thu,  3 Sep 2020 11:35:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B87145D9CC;
 Thu,  3 Sep 2020 11:35:43 +0000 (UTC)
Subject: Re: [PATCH 08/63] vfio: Rename VFIO_AP_DEVICE_TYPE to
 TYPE_VFIO_AP_DEVICE
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-9-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6a9a50ff-a696-c983-e02f-c6c363033d41@redhat.com>
Date: Thu, 3 Sep 2020 13:35:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-9-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, berrange@redhat.com,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/2020 00.42, Eduardo Habkost wrote:
> This will make the type name constant consistent with the name of
> the type checking macro.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/vfio/ap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 68ed059b39..582c091a24 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -30,7 +30,7 @@
>  #include "exec/address-spaces.h"
>  #include "qom/object.h"
>  
> -#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
> +#define TYPE_VFIO_AP_DEVICE      "vfio-ap"
>  
>  struct VFIOAPDevice {
>      APDevice apdev;
> @@ -39,7 +39,7 @@ struct VFIOAPDevice {
>  typedef struct VFIOAPDevice VFIOAPDevice;
>  
>  DECLARE_INSTANCE_CHECKER(VFIOAPDevice, VFIO_AP_DEVICE,
> -                         VFIO_AP_DEVICE_TYPE)
> +                         TYPE_VFIO_AP_DEVICE)
>  
>  static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>  {
> @@ -72,7 +72,7 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>  
>      if (!group_path) {
>          error_setg(errp, "%s: no iommu_group found for %s: %s",
> -                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror->message);
> +                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev, gerror->message);
>          g_error_free(gerror);
>          return NULL;
>      }
> @@ -176,7 +176,7 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo vfio_ap_info = {
> -    .name = VFIO_AP_DEVICE_TYPE,
> +    .name = TYPE_VFIO_AP_DEVICE,
>      .parent = TYPE_AP_DEVICE,
>      .instance_size = sizeof(VFIOAPDevice),
>      .class_init = vfio_ap_class_init,
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


