Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD64EC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 07:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCB421702
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 07:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbLS/zDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCB421702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxmN5-0006Y4-VO
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 03:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxmLn-0005Vm-1B
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 03:06:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxmLk-0001JD-UC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 03:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595315164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5bT9f/UIxrSImFy78hK26YbDB3pxu5Qgs6E9TSEvTdw=;
 b=hbLS/zDKTVTy8fPStSYybSOHncFhoSmb5n+UNyshIvr1LVwgBPCnVLgDYk/53gUiQns51h
 R5VC6V+lHN+UyEmOcgXneso8ERtaSIiC7rAz1aFeNQbexcSHTG5trwBz2KArWRv/7pD1oi
 PYKG49Nkf5q4KMt/UXPuwdHNdfbBCmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-_xNrTRcjN-yzgJ9cFcciDg-1; Tue, 21 Jul 2020 03:06:02 -0400
X-MC-Unique: _xNrTRcjN-yzgJ9cFcciDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C95F800469;
 Tue, 21 Jul 2020 07:06:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EA1B2B6E2;
 Tue, 21 Jul 2020 07:05:56 +0000 (UTC)
Subject: Re: [PATCH 6/7] pc-bios: s390x: Use PSW constants in start.S
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200715094045.381984-1-frankja@linux.ibm.com>
 <20200715094045.381984-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0692c47b-6c3b-fdd8-72af-66c337a434e2@redhat.com>
Date: Tue, 21 Jul 2020 09:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200715094045.381984-7-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/07/2020 11.40, Janosch Frank wrote:
> Let's decrease the number of magic numbers.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/s390-arch.h | 25 +++++++++++++++----------
>  pc-bios/s390-ccw/start.S     |  9 +++++----
>  2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
> index 6da44d4436..d450c096d0 100644
> --- a/pc-bios/s390-ccw/s390-arch.h
> +++ b/pc-bios/s390-ccw/s390-arch.h
> @@ -11,6 +11,20 @@
>  #ifndef S390_ARCH_H
>  #define S390_ARCH_H
>  
> +/* s390 psw bit masks */
> +#define PSW_MASK_EXT        0x0100000000000000UL
> +#define PSW_MASK_IOINT      0x0200000000000000ULL
> +#define PSW_MASK_SHORTPSW   0x0008000000000000ULL
> +#define PSW_MASK_WAIT       0x0002000000000000ULL
> +#define PSW_MASK_EAMODE     0x0000000100000000ULL
> +#define PSW_MASK_BAMODE     0x0000000080000000ULL
> +#define PSW_MASK_SHORT_ADDR 0x000000007fffffffULL
> +#define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
> +#define PSW_MASK_DWAIT      (PSW_MASK_64 | PSW_MASK_WAIT)
> +#define PSW_MASK_EWAIT      (PSW_MASK_DWAIT | PSW_MASK_IOINT | PSW_MASK_EXT)
> +
> +#ifndef __ASSEMBLER__
> +
>  typedef struct PSW {
>      uint64_t mask;
>      uint64_t addr;
> @@ -24,15 +38,6 @@ typedef struct PSWLegacy {
>  } __attribute__ ((aligned(8))) PSWLegacy;
>  _Static_assert(sizeof(struct PSWLegacy) == 8, "PSWLegacy size incorrect");
>  
> -/* s390 psw bit masks */
> -#define PSW_MASK_IOINT      0x0200000000000000ULL
> -#define PSW_MASK_SHORTPSW   0x0008000000000000ULL
> -#define PSW_MASK_WAIT       0x0002000000000000ULL
> -#define PSW_MASK_EAMODE     0x0000000100000000ULL
> -#define PSW_MASK_BAMODE     0x0000000080000000ULL
> -#define PSW_MASK_SHORT_ADDR 0x000000007fffffffULL
> -#define PSW_MASK_64         (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
> -
>  /* Low core mapping */
>  typedef struct LowCore {
>      /* prefix area: defined by architecture */
> @@ -107,5 +112,5 @@ static inline uint32_t store_prefix(void)
>      asm volatile("stpx %0" : "=m" (address));
>      return address;
>  }
> -
> +#endif /* !__ASSEMBLER__ */
>  #endif
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index ce519300a1..01c4c21b26 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -9,6 +9,7 @@
>   * your option) any later version. See the COPYING file in the top-level
>   * directory.
>   */
> +#include "s390-arch.h"
>  
>          .globl _start
>  _start:
> @@ -108,10 +109,10 @@ io_new_code:
>  
>          .align  8
>  disabled_wait_psw:
> -        .quad   0x0002000180000000,0x0000000000000000
> +        .quad   PSW_MASK_DWAIT, 0x0000000000000000
>  enabled_wait_psw:
> -        .quad   0x0302000180000000,0x0000000000000000
> +        .quad   PSW_MASK_EWAIT, 0x0000000000000000
>  external_new_mask:
> -        .quad   0x0000000180000000
> +        .quad   PSW_MASK_64
>  io_new_mask:
> -        .quad   0x0000000180000000
> +        .quad   PSW_MASK_64
> 

This fails to compile with older versions of binutils (e.g. the ones in
RHEL7):

pc-bios/s390-ccw/start.S: Assembler messages:
pc-bios/s390-ccw/start.S:108: Error: found 'L', expected: ')'
pc-bios/s390-ccw/start.S:108: Error: found 'L', expected: ')'
pc-bios/s390-ccw/start.S:108: Error: junk at end of line, first
unrecognized character is `L'
pc-bios/s390-ccw/start.S:110: Error: found 'L', expected: ')'
pc-bios/s390-ccw/start.S:110: Error: found 'L', expected: ')'
pc-bios/s390-ccw/start.S:110: Error: found 'L', expected: ')'
pc-bios/s390-ccw/start.S:110: Error: junk at end of line, first
unrecognized character is `L'
pc-bios/s390-ccw/start.S:112: Error: found 'L', expected: ')'
pc-bios/s390-ccw/start.S:112: Error: junk at end of line, first
unrecognized character is `L'
pc-bios/s390-ccw/start.S:114: Error: found 'L', expected: ')'
pc-bios/s390-ccw/start.S:114: Error: junk at end of line, first
unrecognized character is `L'

You either need some macro-magic for this, or simply drop the patch.

 Thomas


