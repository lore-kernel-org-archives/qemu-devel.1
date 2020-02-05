Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43512C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDF020674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXvJguS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDF020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izO0x-0003lR-7W
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1izO04-0002v1-Dx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1izO03-0006zt-7L
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:58:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48934
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1izO03-0006w0-1F
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580921882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0JxQ8JDSfae41/ptTDrJK6DCw0VgPYUJI+Y2WUWZfc=;
 b=WXvJguS7vdKV55BvaJ7NKfYUfp9qHm6CZcwL67U4nRWVIVQhTJNL/KLF1f/yTMCDDV+58a
 8BA8xPc75DyuHRhkLW7EUsAal4xCkxbl6LtfgufcF9h5vLzJZ0YsLU3jrIelMM5QKVNqND
 SgudWcxBi3k3ltbQ0Og4RQpK77uVcgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-fsHgQdI4P9GMAAxdY23cLg-1; Wed, 05 Feb 2020 11:58:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08C258010C4;
 Wed,  5 Feb 2020 16:57:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF6BB5C1B5;
 Wed,  5 Feb 2020 16:57:54 +0000 (UTC)
Date: Wed, 5 Feb 2020 17:57:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v5 2/4] nvdimm: add uuid property to nvdimm
Message-ID: <20200205175753.5026ed04@redhat.com>
In-Reply-To: <158038487514.16440.10078356123772690069.stgit@lep8c.aus.stglabs.ibm.com>
References: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
 <158038487514.16440.10078356123772690069.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: fsHgQdI4P9GMAAxdY23cLg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 sbhat@linux.vnet.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 05:47:59 -0600
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> For ppc64, PAPR requires the nvdimm device to have UUID property
> set in the device tree. Add an option to get it from the user.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/nvdimm.c         |   40 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/mem/nvdimm.h |    7 +++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 39f1426d1f..8e426d24bb 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -69,11 +69,51 @@ out:
>      error_propagate(errp, local_err);
>  }
>  
> +static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm = NVDIMM(obj);
> +    char *value = NULL;
> +
> +    value = qemu_uuid_unparse_strdup(&nvdimm->uuid);
> +
> +    visit_type_str(v, name, &value, errp);
> +    g_free(value);
> +}
> +
> +
> +static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm = NVDIMM(obj);
> +    Error *local_err = NULL;
> +    char *value;
> +
> +    visit_type_str(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    if (qemu_uuid_parse(value, &nvdimm->uuid) != 0) {
> +        error_setg(errp, "Property '%s.%s' has invalid value",
> +                   object_get_typename(obj), name);
> +        goto out;
> +    }
> +    g_free(value);
> +
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
> +
>  static void nvdimm_init(Object *obj)
>  {
>      object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
>                          nvdimm_get_label_size, nvdimm_set_label_size, NULL,
>                          NULL, NULL);
> +
> +    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
> +                        nvdimm_set_uuid, NULL, NULL, NULL);
>  }
>  
>  static void nvdimm_finalize(Object *obj)
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 523a9b3d4a..4807ca615b 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -25,6 +25,7 @@
>  
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qemu/uuid.h"
>  
>  #define NVDIMM_DEBUG 0
>  #define nvdimm_debug(fmt, ...)                                \
> @@ -49,6 +50,7 @@
>                                                 TYPE_NVDIMM)
>  
>  #define NVDIMM_LABEL_SIZE_PROP "label-size"
> +#define NVDIMM_UUID_PROP       "uuid"
>  #define NVDIMM_UNARMED_PROP    "unarmed"
>  
>  struct NVDIMMDevice {
> @@ -83,6 +85,11 @@ struct NVDIMMDevice {
>       * the guest write persistence.
>       */
>      bool unarmed;
> +
> +    /*
> +     * The PPC64 - spapr requires each nvdimm device have a uuid.
> +     */
> +    QemuUUID uuid;
>  };
>  typedef struct NVDIMMDevice NVDIMMDevice;
>  
> 
> 


