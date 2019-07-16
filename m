Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A72C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB1D2173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB1D2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIrY-0006ns-C8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hnIrK-0006MN-8U
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hnIrJ-0000wU-6o
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:30:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hnIrI-0000w2-UI; Tue, 16 Jul 2019 04:30:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73D49308FBB4;
 Tue, 16 Jul 2019 08:30:47 +0000 (UTC)
Received: from gondolin (ovpn-117-180.ams2.redhat.com [10.36.117.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EDEF6012C;
 Tue, 16 Jul 2019 08:30:43 +0000 (UTC)
Date: Tue, 16 Jul 2019 10:30:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190716103039.0b4a1e5e.cohuck@redhat.com>
In-Reply-To: <20000ebf-06d5-a2bc-cdd3-aee2deef159c@de.ibm.com>
References: <20190715142304.215018-1-borntraeger@de.ibm.com>
 <20190715142304.215018-3-borntraeger@de.ibm.com>
 <f7d7a281-0310-f9bf-68ce-669f730d0856@redhat.com>
 <b8a57e4b-247d-de25-2f2f-d4ccc52138e6@de.ibm.com>
 <a736953d-06de-7577-6904-3c1bde7240ba@de.ibm.com>
 <2c966565-aa0f-5ef2-246f-dde9582fcdf2@redhat.com>
 <20000ebf-06d5-a2bc-cdd3-aee2deef159c@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 16 Jul 2019 08:30:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/3] s390x/cpumodel: also
 change name of vxbeh
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 09:25:42 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 16.07.19 09:24, David Hildenbrand wrote:

> > We also have
> > 
> > sortl vs. sort
> > vxe vs. vxeh
> > vxe2 vs. vxeh2
> > 
> > So I tend to prefer "vxpde", or rather "vxpdeh".
> > 
> > (all other enhancement facilities have "eh", so we should actually use
> > "vxpdeh")  
> 
> Fine with me. Conny, shall I resend or can you fixup everything?
> 

I now have the following; can you please double check?

commit a02c8264b7219bc30ec258f068c89b93ad244c36
Author: Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Mon Jul 15 16:23:03 2019 +0200

    s390x/cpumodel: also change name of vxbeh
    
    David suggested to keep everything in sync as 4.1 is not yet released.
    This patch fixes the name "vxbeh" into "vxpdeh".
    
    To simplify the backports this patch will not change VECTOR_BCD_ENH as
    this is just an internal name. That will be done by an extra patch that
    does not need to be backported.
    
    Suggested-by: David Hildenbrand <david@redhat.com>
    Fixes: d05be57ddc2e ("s390: cpumodel: fix description for the new vector facility")
    Fixes: 54d65de0b525 ("s390x/cpumodel: vector enhancements")
    Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
    Message-Id: <20190715142304.215018-3-borntraeger@de.ibm.com>
    Reviewed-by: David Hildenbrand <david@redhat.com>
    Signed-off-by: Cornelia Huck <cohuck@redhat.com>

diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
index 3118a9f89228..05b7674affe6 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -104,7 +104,7 @@ DEF_FEAT(CMM_NT, "cmmnt", STFL, 147, "CMM: ESSA-enhancement (no translate) facil
 DEF_FEAT(VECTOR_ENH2, "vxeh2", STFL, 148, "Vector Enhancements facility 2")
 DEF_FEAT(ESORT_BASE, "esort-base", STFL, 150, "Enhanced-sort facility (excluding subfunctions)")
 DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "Deflate-conversion facility (excluding subfunctions)")
-DEF_FEAT(VECTOR_BCD_ENH, "vxbeh", STFL, 152, "Vector-Packed-Decimal-Enhancement Facility")
+DEF_FEAT(VECTOR_BCD_ENH, "vxpdeh", STFL, 152, "Vector-Packed-Decimal-Enhancement Facility")
 DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)")
 DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
 

