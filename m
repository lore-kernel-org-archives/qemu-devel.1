Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA2AC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763D320675
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763D320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34051 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtap-000224-Lb
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:39:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEtZo-0001U7-3s
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEtZm-0004oS-UM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:38:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEtZm-0004o4-Gg; Fri, 12 Apr 2019 06:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F047486658;
	Fri, 12 Apr 2019 10:38:28 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDA31001E61;
	Fri, 12 Apr 2019 10:38:26 +0000 (UTC)
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com,
	alifm@linux.ibm.com, borntraeger@de.ibm.com
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
	<1554388475-18329-2-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <f70b7eea-c72c-e8d4-8a91-ec999c45ee09@redhat.com>
Date: Fri, 12 Apr 2019 12:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554388475-18329-2-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 12 Apr 2019 10:38:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 01/16] s390 vfio-ccw: Add bootindex
 property and IPLB data
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412103825.24IRTlRA3_oCdn8UcqdFypYdD1HNgPcocz51dNATgKQ@z>

On 04/04/2019 16.34, Jason J. Herne wrote:
> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Refactor s390_get_ccw_device() to return device type. This prevents us from
> having to use messy casting logic in several places.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
[...]
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 9246729..507d513 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -21,11 +21,11 @@
>  #include "hw/vfio/vfio.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/s390x/s390-ccw.h"
> +#include "hw/s390x/vfio-ccw.h"
>  #include "hw/s390x/ccw-device.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
>  
> -#define TYPE_VFIO_CCW "vfio-ccw"
>  typedef struct VFIOCCWDevice {
>      S390CCWDevice cdev;
>      VFIODevice vdev;
> diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
> index 7d15a1a..901d805 100644
> --- a/include/hw/s390x/s390-ccw.h
> +++ b/include/hw/s390x/s390-ccw.h
> @@ -27,6 +27,7 @@ typedef struct S390CCWDevice {
>      CcwDevice parent_obj;
>      CssDevId hostid;
>      char *mdevid;
> +    int32_t bootindex;
>  } S390CCWDevice;
>  
>  typedef struct S390CCWDeviceClass {
> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
> new file mode 100644
> index 0000000..ee5250d
> --- /dev/null
> +++ b/include/hw/s390x/vfio-ccw.h
> @@ -0,0 +1,28 @@
> +/*
> + * vfio based subchannel assignment support
> + *
> + * Copyright 2017, 2019 IBM Corp.
> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef HW_VFIO_CCW_H
> +#define HW_VFIO_CCW_H
> +
> +#include "hw/vfio/vfio-common.h"
> +#include "hw/s390x/s390-ccw.h"
> +#include "hw/s390x/ccw-device.h"
> +
> +#define TYPE_VFIO_CCW "vfio-ccw"
> +#define VFIO_CCW(obj) \
> +        OBJECT_CHECK(VFIOCCWDevice, (obj), TYPE_VFIO_CCW)
> +
> +#define TYPE_VFIO_CCW "vfio-ccw"
> +typedef struct VFIOCCWDevice VFIOCCWDevice;
> +
> +#endif
> 

This causes a build failure with clang:

 https://gitlab.com/huth/qemu/-/jobs/195530081

I'll squash the following patch to fix this issue:

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e6ac21d006..31dd3a2a87 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -26,7 +26,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"

-typedef struct VFIOCCWDevice {
+struct VFIOCCWDevice {
     S390CCWDevice cdev;
     VFIODevice vdev;
     uint64_t io_region_size;
@@ -35,7 +35,7 @@ typedef struct VFIOCCWDevice {
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
-} VFIOCCWDevice;
+};


 Thomas

