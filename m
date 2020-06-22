Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D266EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B3220716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR9OqH6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B3220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKx8-0004p4-T1
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnKom-0003Li-4j
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:40:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnKok-00020Y-25
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592826048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=h2ttrwrCozwSsSgrj+2Ve9p4KKb7etod7Sxow9XQVBA=;
 b=DR9OqH6eHPPtv/167p3l4YQRj02mPe4XsAzquBh1Cx3QzHhbzLQbKVxiRVajBVpoAX/sSD
 0KRqPVDAhQAHAnBycW3Hp543VtEfrkKDv+FR3T/2rRGi2ABWZwLlIcue8Wp1tD8QAvtnT9
 pL5B/DdBblrpMgYcKIsVL626o33AzzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-1yN2_A2lOVOk-ZSRICJ3XA-1; Mon, 22 Jun 2020 07:40:46 -0400
X-MC-Unique: 1yN2_A2lOVOk-ZSRICJ3XA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D3AAA0BD7;
 Mon, 22 Jun 2020 11:40:45 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 817A07167A;
 Mon, 22 Jun 2020 11:40:41 +0000 (UTC)
Subject: Re: [PATCH v4 5/9] pc-bios: s390x: Rename and use PSW_MASK_ZMODE
 constant
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200622074235.32528-1-frankja@linux.ibm.com>
 <20200622074235.32528-6-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5990e65c-732a-e3c1-bd4c-1fb870e8f567@redhat.com>
Date: Mon, 22 Jun 2020 13:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622074235.32528-6-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/2020 09.42, Janosch Frank wrote:
> ZMODE has a lot of ambiguity with the ESAME architecture mode, but is
> actually 64 bit addressing.
> 
> As PSW_MASK_64 is now effectively 33 bit long and the PSWLegacy struct
> has 2 32 bit members, let's also use a unsigned long pointer in
> dasd-ipl.c instead when oring the constant into a 8 byte PSW.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  pc-bios/s390-ccw/dasd-ipl.c  | 5 ++---
>  pc-bios/s390-ccw/s390-arch.h | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
> index 0fc879bb8e..0dbad051a2 100644
> --- a/pc-bios/s390-ccw/dasd-ipl.c
> +++ b/pc-bios/s390-ccw/dasd-ipl.c
> @@ -206,7 +206,7 @@ static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
>   */
>  void dasd_ipl(SubChannelId schid, uint16_t cutype)
>  {
> -    PSWLegacy *pswl = (PSWLegacy *) 0x00;
> +    unsigned long *pswl = 0x0;

... or we could use the "lowcore" pointer from s390-arch.h ... though
that's PSWLegacy again...

>      uint32_t ipl2_addr;
>  
>      /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
> @@ -229,7 +229,6 @@ void dasd_ipl(SubChannelId schid, uint16_t cutype)
>      run_ipl2(schid, cutype, ipl2_addr);
>  
>      /* Transfer control to the guest operating system */
> -    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */

Wait, PSW_MASK_EAMODE was 0x0000000100000000 and ->mask was only a
32-bit value ... how was that ever supposed to work correctly?

> -    pswl->addr |= PSW_MASK_BAMODE;   /* ...          */
> +    *pswl |= PSW_MASK_64;   /* Force 64 bit addressing */

So is this even a bug fix and not only a cosmetic change?

... the whole logic here looks fishy to me ... do we need this PSW
modification at all? Shouldn't the guest decide which mode it wants to
use in its startup code?

 Thomas


>      jump_to_low_kernel();
>  }
> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
> index 5f36361c02..73852029d4 100644
> --- a/pc-bios/s390-ccw/s390-arch.h
> +++ b/pc-bios/s390-ccw/s390-arch.h
> @@ -29,7 +29,7 @@ _Static_assert(sizeof(struct PSWLegacy) == 8, "PSWLegacy size incorrect");
>  #define PSW_MASK_WAIT       0x0002000000000000ULL
>  #define PSW_MASK_EAMODE     0x0000000100000000ULL
>  #define PSW_MASK_BAMODE     0x0000000080000000ULL
> -#define PSW_MASK_ZMODE      (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
> +#define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
>  
>  /* Low core mapping */
>  typedef struct LowCore {
> 


