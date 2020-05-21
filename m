Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56935C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AB02070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXabh0Q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AB02070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbe11-0001Ik-4N
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbe0K-0008MI-9P
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:44:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbe0I-000078-Qg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590039865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5fh9BuBHBCq9+Zj7PHhy50GHCg1LVDBI1sEVOZOTOW0=;
 b=cXabh0Q1QIEbdqKUtQNCnkLOutnSMwAGE+t9paGbdWC+S94Puh1QNzOAiTaulkZ1+OAH9f
 kL5pnJKqmTsb/70hrmgeadF+EFcVroQATxEb+rOcGQayUvMwVTcIOsawD9LtikXQUK4qlI
 GpzzIgITJfxL5PWQFYpkBMmxmaX27Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-qdfzsHR8NaaPkaPgij8iOA-1; Thu, 21 May 2020 01:44:23 -0400
X-MC-Unique: qdfzsHR8NaaPkaPgij8iOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE2EC1005510;
 Thu, 21 May 2020 05:44:21 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 663CE82EEA;
 Thu, 21 May 2020 05:44:17 +0000 (UTC)
Subject: Re: [PATCH v2 4/9] pc-bios: s390x: Rename and use PSW_MASK_ZMODE
 constant
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <45c70387-c5e6-ef45-9535-de1c4002b683@redhat.com>
Date: Thu, 21 May 2020 07:44:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200514123729.156283-5-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2020 14.37, Janosch Frank wrote:
> ZMODE has a lot of ambiguity with the ESAME architecture mode, but is
> actually 64 bit addressing.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  pc-bios/s390-ccw/dasd-ipl.c  | 3 +--
>  pc-bios/s390-ccw/s390-arch.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
> index 0fc879bb8e..b932531e6f 100644
> --- a/pc-bios/s390-ccw/dasd-ipl.c
> +++ b/pc-bios/s390-ccw/dasd-ipl.c
> @@ -229,7 +229,6 @@ void dasd_ipl(SubChannelId schid, uint16_t cutype)
>      run_ipl2(schid, cutype, ipl2_addr);
>  
>      /* Transfer control to the guest operating system */
> -    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
> -    pswl->addr |= PSW_MASK_BAMODE;   /* ...          */
> +    pswl->mask |= PSW_MASK_64;   /* Force 64 bit addressing */

This is not only a rename (as announced in the subject), but also a
change in behavior since you now do not change pswl->addr anymore. So
this is even a bug fix? Could you please mention this in the patch
description, too?

 Thanks,
  Thomas


