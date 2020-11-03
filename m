Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0E7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3A820735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aekwXRqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3A820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvU6-0006Pu-BP
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvTE-000538-27
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvTC-0003b6-3K
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604406685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGnvEjPJJ0VdjKm9RCFITqBUBKzCvnEc/uGDBjoYwKo=;
 b=aekwXRqe+zR3gKO6sIiHlI/8I+YX9Tj2cfKiMH+IDsUm4zi3Hd9kQAUe2OHrztiwrKSUGw
 JRj3549QI4CbGuy62QHPKqvjROp0RJyxd3MkMlU8rN/aboFVKgGKcyUpexMluc0HGdNetc
 LycqNqnvJLxQKEOLjSUBbZvvSvHlYNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-q-uE3CtpPIaUOzrn2y10sA-1; Tue, 03 Nov 2020 07:31:23 -0500
X-MC-Unique: q-uE3CtpPIaUOzrn2y10sA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 895A78030B0;
 Tue,  3 Nov 2020 12:31:22 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F01EF1002D48;
 Tue,  3 Nov 2020 12:31:17 +0000 (UTC)
Date: Tue, 3 Nov 2020 13:31:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 16/20] nvdimm: Remove unnecessary prefix from error message
Message-ID: <20201103133116.38f36be9@redhat.com>
In-Reply-To: <20201030202131.796967-17-ehabkost@redhat.com>
References: <20201030202131.796967-1-ehabkost@redhat.com>
 <20201030202131.796967-17-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 16:21:27 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> object_property_parse() will add a
>   "Property '<TYPE>.<PROP>' can't take value '<VALUE>'"
> prefix automatically for us.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/mem/nvdimm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index e1574bc07c..b9a99d58ed 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -56,8 +56,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>      if (value < MIN_NAMESPACE_LABEL_SIZE) {
> -        error_setg(errp, "Property '%s.%s' (0x%" PRIx64 ") is required"
> -                   " at least 0x%lx", object_get_typename(obj), name, value,
> +        error_setg(errp, "label size should be at least 0x%lx",
>                     MIN_NAMESPACE_LABEL_SIZE);
>          return;
>      }
> @@ -89,8 +88,7 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
>      }
>  
>      if (qemu_uuid_parse(value, &nvdimm->uuid) != 0) {
> -        error_setg(errp, "Property '%s.%s' has invalid value",
> -                   object_get_typename(obj), name);
> +        error_setg(errp, "invalid UUID");
>      }
>  
>      g_free(value);


