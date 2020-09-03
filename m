Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9499FC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE2C20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFIDD0hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE2C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmZm-0001jU-CZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDmZ4-0000Je-8k
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:33:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDmZ2-0001Dw-7F
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599129235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JII04JBkQInx0VX1qd9SF79bbAmdEjqOUUOR0/iVqaI=;
 b=CFIDD0hhYp9pG790IAY9cwm7aQo1IBkCe7ePFh/CKK8FEUkuo1ZrewS07q+jd5x/QarTKH
 kfeE3o1GHw8AQ7xu+hV65oxObVt7LEASmRIvNpveo/w8f+iuREWGQt1FL9ais3m/lJMF4C
 d7q9CyZKruRhWES3lSO6bwQbw6OCHP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-WrkEPX92PaK3u0yKZm7UQw-1; Thu, 03 Sep 2020 06:33:51 -0400
X-MC-Unique: WrkEPX92PaK3u0yKZm7UQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4B62801AB8;
 Thu,  3 Sep 2020 10:33:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD217EED3;
 Thu,  3 Sep 2020 10:33:37 +0000 (UTC)
Subject: Re: [PATCH 05/63] ap-device: Rename AP_DEVICE_TYPE to TYPE_AP_DEVICE
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-6-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <96a6b874-5770-021d-5073-f7873f2da8a5@redhat.com>
Date: Thu, 3 Sep 2020 12:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-6-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/2020 00.42, Eduardo Habkost wrote:
> This will make the type name constant consistent with the name of
> the type checking macro.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/s390x/ap-device.h | 4 ++--
>  hw/s390x/ap-device.c         | 2 +-
>  hw/vfio/ap.c                 | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
> index fb250a20f3..e502745de5 100644
> --- a/include/hw/s390x/ap-device.h
> +++ b/include/hw/s390x/ap-device.h
> @@ -14,7 +14,7 @@
>  #include "hw/qdev-core.h"
>  #include "qom/object.h"
>  
> -#define AP_DEVICE_TYPE       "ap-device"
> +#define TYPE_AP_DEVICE       "ap-device"
>  
>  struct APDevice {
>      DeviceState parent_obj;
> @@ -22,6 +22,6 @@ struct APDevice {
>  typedef struct APDevice APDevice;
>  
>  DECLARE_INSTANCE_CHECKER(APDevice, AP_DEVICE,
> -                         AP_DEVICE_TYPE)
> +                         TYPE_AP_DEVICE)
>  
>  #endif /* HW_S390X_AP_DEVICE_H */
> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
> index fc0b41e937..237d1f19c5 100644
> --- a/hw/s390x/ap-device.c
> +++ b/hw/s390x/ap-device.c
> @@ -21,7 +21,7 @@ static void ap_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo ap_device_info = {
> -    .name = AP_DEVICE_TYPE,
> +    .name = TYPE_AP_DEVICE,
>      .parent = TYPE_DEVICE,
>      .instance_size = sizeof(APDevice),
>      .class_size = sizeof(DeviceClass),
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index f399ec0a31..68ed059b39 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -177,7 +177,7 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>  
>  static const TypeInfo vfio_ap_info = {
>      .name = VFIO_AP_DEVICE_TYPE,
> -    .parent = AP_DEVICE_TYPE,
> +    .parent = TYPE_AP_DEVICE,
>      .instance_size = sizeof(VFIOAPDevice),
>      .class_init = vfio_ap_class_init,
>  };
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


