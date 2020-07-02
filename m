Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E090C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5C220781
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1kdK6kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5C220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqpMU-0006PJ-6H
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 22:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqpLY-0005zB-Fw
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 22:53:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46012
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqpLW-0002jM-DA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 22:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593658384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQusHVTU8/6OQGtoRFcfVgZcYCvq4bvezw8mDE0o8qc=;
 b=L1kdK6kbQdOFembYKWFgDJJnrWRd7u+AqNzdSYWhLvi2okLspzWNICewVqTG1MGjlI7Nx3
 HxewZ+S8+lcYFkpYQvSz2d9e8auDqigsmXFezjOOVGh3dJpTBh011c9DmLoJoC2wRCjpjy
 myQKIJlvdWc27Su3m5Nq8nzTMFl9p10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-SFHSIuqxMeizASzFB6yqEA-1; Wed, 01 Jul 2020 22:53:03 -0400
X-MC-Unique: SFHSIuqxMeizASzFB6yqEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B888800C60
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 02:53:02 +0000 (UTC)
Received: from [10.72.13.248] (ovpn-13-248.pek2.redhat.com [10.72.13.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D88215D9CA;
 Thu,  2 Jul 2020 02:52:54 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: add VT-d entry
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200701124418.63060-1-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <05ce8b91-ad23-ba40-88c5-3fd46b32f19b@redhat.com>
Date: Thu, 2 Jul 2020 10:52:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701124418.63060-1-peterx@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 22:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/1 下午8:44, Peter Xu wrote:
> Add this entry as suggested by Jason and Michael.
>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..569cfc1fcd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2615,6 +2615,15 @@ F: tests/uefi-test-tools/
>   F: .gitlab-ci.d/edk2.yml
>   F: .gitlab-ci.d/edk2/
>   
> +VT-d Emulation
> +M: Michael S. Tsirkin <mst@redhat.com>
> +M: Peter Xu <peterx@redhat.com>
> +R: Jason Wang <jasowang@redhat.com>
> +S: Supported
> +F: hw/i386/intel_iommu.c
> +F: hw/i386/intel_iommu_internal.h
> +F: include/hw/i386/intel_iommu.h
> +
>   Usermode Emulation
>   ------------------
>   Overall usermode emulation


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



