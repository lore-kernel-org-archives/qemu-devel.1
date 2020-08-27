Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00CCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FEF20786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0RierbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FEF20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCx7-0001N1-Jo
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBCwa-0000x2-Vp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBCwY-0002T5-0B
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598515652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbP7kfHwpttC44PD2HhEMLj3p9a3d3zF8ybkWyFsE4k=;
 b=P0RierbBBSGi4tQpA8eGYcHqDSerDu4hm5Gt2TrVibYWxFnvsYD69oj770Q6xjK3Pd2j77
 N3lIL08agihD/OBoavpp8ikFU/iV2L8MWidLxSkh9q4pD1fFeSfj2XVEc+POMItd5NZ+Ef
 yl97AAWLzaCt9fcKiYrPwfVyJG+E8pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-yVfgykO_O7uQ7_2djt8hvw-1; Thu, 27 Aug 2020 04:07:28 -0400
X-MC-Unique: yVfgykO_O7uQ7_2djt8hvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FEAC873155;
 Thu, 27 Aug 2020 08:07:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF31E712EB;
 Thu, 27 Aug 2020 08:07:22 +0000 (UTC)
Subject: Re: [PATCH v3 28/74] s390x: Move typedef SCLPEventFacility to
 event-facility.h
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-29-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <11f256cd-3044-8ac6-d64b-b079430fcd47@redhat.com>
Date: Thu, 27 Aug 2020 10:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200825192110.3528606-29-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/08/2020 21.20, Eduardo Habkost wrote:
> This will make future conversion to OBJECT_DECLARE* easier.
> 
> In sclp.h, use "struct SCLPEventFacility" to avoid introducing
> unnecessary header dependencies.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3: none
> 
> Changes series v1 -> v2: new patch in series v2
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/s390x/event-facility.h | 1 +
>  include/hw/s390x/sclp.h           | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
> index 700a610f33..e61c4651d7 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -195,6 +195,7 @@ typedef struct SCLPEventClass {
>  } SCLPEventClass;
>  
>  #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
> +typedef struct SCLPEventFacility SCLPEventFacility;
>  #define EVENT_FACILITY(obj) \
>       OBJECT_CHECK(SCLPEventFacility, (obj), TYPE_SCLP_EVENT_FACILITY)
>  #define EVENT_FACILITY_CLASS(klass) \
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index 822eff4396..a87ed2a0ab 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -185,12 +185,12 @@ typedef struct SCCB {
>  #define SCLP_CLASS(oc) OBJECT_CLASS_CHECK(SCLPDeviceClass, (oc), TYPE_SCLP)
>  #define SCLP_GET_CLASS(obj) OBJECT_GET_CLASS(SCLPDeviceClass, (obj), TYPE_SCLP)
>  
> -typedef struct SCLPEventFacility SCLPEventFacility;
> +struct SCLPEventFacility;
>  
>  typedef struct SCLPDevice {
>      /* private */
>      DeviceState parent_obj;
> -    SCLPEventFacility *event_facility;
> +    struct SCLPEventFacility *event_facility;
>      int increment_size;
>  
>      /* public */
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


