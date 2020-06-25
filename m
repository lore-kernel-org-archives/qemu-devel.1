Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DF12053B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvJ29Qxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DF12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPhv-0001AB-RE
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joPhE-0000XW-ND
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:05:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37847
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joPhC-0003G5-2M
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593083128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NV0xxIS4Bi7YhzuEeWyiesyIyHGcmDJ5qClRYSXuZVY=;
 b=OvJ29QxmeTB5b6htkpikVrLJQNa73iWRWnw6KDmxZ3nO0q9XT/ezCMhYA8JGRJ/Wj4nos+
 3GRqfBSPcN/er8h1t6e2eTAu5+eRFXCv4gQ7cZGM7LVwfUl6vNdDpWDANzfuNzZ6AlNaJZ
 CTcfqke8PGH6aFL3UCVokDznrJL0HQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-V_2gPbnvPYK7pVP2xqQBjw-1; Thu, 25 Jun 2020 07:05:26 -0400
X-MC-Unique: V_2gPbnvPYK7pVP2xqQBjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2E2D10059A3;
 Thu, 25 Jun 2020 11:05:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 257AC71660;
 Thu, 25 Jun 2020 11:05:21 +0000 (UTC)
Subject: Re: [PATCH v5 06/12] pc-bios: s390x: Rename PSW_MASK_ZMODE to
 PSW_MASK_64
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1ddcd6e2-4c5e-e25a-c3ba-ecb471fd6e66@redhat.com>
Date: Thu, 25 Jun 2020 13:05:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624075226.92728-7-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 09.52, Janosch Frank wrote:
> This constant enables 64 bit addressing, not the ESAME architecture,
> so it shouldn't be named ZMODE.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/s390-arch.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
> index 5f36361c02..73852029d4 100644
> --- a/pc-bios/s390-ccw/s390-arch.h
> +++ b/pc-bios/s390-ccw/s390-arch.h
> @@ -29,7 +29,7 @@ _Static_assert(sizeof(struct PSWLegacy) == 8, "PSWLegacy size incorrect");
>   #define PSW_MASK_WAIT       0x0002000000000000ULL
>   #define PSW_MASK_EAMODE     0x0000000100000000ULL
>   #define PSW_MASK_BAMODE     0x0000000080000000ULL
> -#define PSW_MASK_ZMODE      (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
> +#define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)

I think you could maybe squash it with the next patch.

Reviewed-by: Thomas Huth <thuth@redhat.com>


