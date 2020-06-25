Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53390C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F9B2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWzVJofr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F9B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPaI-00072s-E3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joPZK-0006IC-KM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:57:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joPZH-0004mB-Jr
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593082638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LOuAAvMFJTIqju4tZJuvxvrDYRtU6gvUd+SO24yG6s=;
 b=LWzVJofrCJDWBWcAtG0rBVwGDPL6jBrXCsJrqde9AKgcEZyFFbNA0m0Ia+ShlLxRSsaaDb
 6eyVmqHeSNYy206izkEsXVVirKRgmJB4qAsHyzkNeelH41dJHAVyg8UXaGdVitC2C8hXMQ
 vPnLsAlWMy3FnQ9wGhr082aIpvMa5aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-hwmQ6aAENveFcuIHnVDkpg-1; Thu, 25 Jun 2020 06:57:16 -0400
X-MC-Unique: hwmQ6aAENveFcuIHnVDkpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3D9B804002;
 Thu, 25 Jun 2020 10:57:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96A3B5D9C5;
 Thu, 25 Jun 2020 10:57:08 +0000 (UTC)
Subject: Re: [PATCH v5 05/12] pc-bios: s390x: Remove unneeded dasd-ipl.c reset
 psw mask changes
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-6-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <95c7fe36-02fe-d430-5ae7-04e3ce38e3fb@redhat.com>
Date: Thu, 25 Jun 2020 12:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624075226.92728-6-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, borntraeger@de.ibm.com,
 cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 09.52, Janosch Frank wrote:
> jump_to_low_kernel() and the functions that it calls will already or
> 64 bit addressing into the reset psw mask when executing
> jump_to_IPL_2() after the diag308 subcode 1.

Hmm, the jump_to_IPL_code() also sets the 64-bit addressing bits ... but 
jump_to_low_kernel() has some logic that tests for the bits before that 
function is called:

     /* Trying to get PSW at zero address */
     if (*((uint64_t *)0) & RESET_PSW_MASK) {
         jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
     }

Could it be that the code in dasd-ipl.c has been written with that 
if-statement in mind?

  Thomas


> The kernel proper is then branched to rather than doing a full PSW
> change.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/dasd-ipl.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
> index 0fc879bb8e..e8f2846740 100644
> --- a/pc-bios/s390-ccw/dasd-ipl.c
> +++ b/pc-bios/s390-ccw/dasd-ipl.c
> @@ -206,7 +206,6 @@ static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
>    */
>   void dasd_ipl(SubChannelId schid, uint16_t cutype)
>   {
> -    PSWLegacy *pswl = (PSWLegacy *) 0x00;
>       uint32_t ipl2_addr;
>   
>       /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
> @@ -229,7 +228,5 @@ void dasd_ipl(SubChannelId schid, uint16_t cutype)
>       run_ipl2(schid, cutype, ipl2_addr);
>   
>       /* Transfer control to the guest operating system */
> -    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
> -    pswl->addr |= PSW_MASK_BAMODE;   /* ...          */
>       jump_to_low_kernel();
>   }
> 


