Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902BC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B76020840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B76020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZMA-0000JI-C1
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hxZLC-0007VT-Gs
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hxZLB-0006By-Dw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hxZLB-0006BY-5h; Tue, 13 Aug 2019 12:08:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8ADB4923AB;
 Tue, 13 Aug 2019 16:08:03 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D65C6E6FB;
 Tue, 13 Aug 2019 16:07:58 +0000 (UTC)
Date: Tue, 13 Aug 2019 18:07:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190813180756.4d6dc545.cohuck@redhat.com>
In-Reply-To: <20190805152947.28536-10-david@redhat.com>
References: <20190805152947.28536-1-david@redhat.com>
 <20190805152947.28536-10-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 13 Aug 2019 16:08:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v1 9/9] s390x/cpumodel: Add new TCG
 features to QEMU cpu model
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  5 Aug 2019 17:29:47 +0200
David Hildenbrand <david@redhat.com> wrote:

> We now implement a bunch of new facilities we can properly indicate.
> 
> ESOP-1/ESOP-2 handling is discussed in the PoP Chafter 3-15
> ("Suppression on Protection"). The "Basic suppression-on-protection (SOP)
> facility" is a core part of z/Architecture without a facility
> indication. ESOP-2 is indicated by ESOP-1 + Side-effect facility
> ("ESOP-2"). Besides ESOP-2, the side-effect facility is only relevant for
> the guarded-storage facility (we don't implement).
> 
> S390_ESOP:
> - We indicate DAT exeptions by setting bit 61 of the TEID (TEC) to 1 and
>   bit 60 to zero. We don't trigger ALCP exceptions yet. Also, we set
>   bit 0-51 and bit 62/63 to the right values.
> S390_ACCESS_EXCEPTION_FS_INDICATION:
> - The TEID (TEC) properly indicates in bit 52/53 on any access if it was
>   a fetch or a store
> S390_SIDE_EFFECT_ACCESS_ESOP2:
> - We have no side-effect accesses (esp., we don't implement the
>   guarded-storage faciliy), we correctly set bit 64 of the TEID (TEC) to
>   0 (no side-effect).
> - ESOP2: We properly set bit 56, 60, 61 in the TEID (TEC) to indicate the
>   type of protection. We don't trigger KCP/ALCP exceptions yet.
> S390_INSTRUCTION_EXEC_PROT:
> - The MMU properly detects and indicates the exception on instruction fetches
> - Protected TLB entries will never get PAGE_EXEC set.
> 
> There is no need to fake the abscence of any of the facilities - without
> the facilities, some bits of the TEID (TEC) are simply unpredictable.
> 
> As IEP was added with z14 and we currently implement a z13, add it to
> the MAX model instead.

Looks sane, once we get those features supported.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/gen-features.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 7e82f2f004..6e78d40d9a 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -704,12 +704,16 @@ static uint16_t qemu_V4_1[] = {
>  };
>  
>  static uint16_t qemu_LATEST[] = {
> +    S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
> +    S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
> +    S390_FEAT_ESOP,
>  };
>  
>  /* add all new definitions before this point */
>  static uint16_t qemu_MAX[] = {
>      /* generates a dependency warning, leave it out for now */
>      S390_FEAT_MSA_EXT_5,
> +    S390_FEAT_INSTRUCTION_EXEC_PROT,

This 'dependency warning' only refers to msa_ext_5, no? Can we make
that more obvious?

>  };
>  
>  /****** END FEATURE DEFS ******/


