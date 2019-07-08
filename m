Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCBFC606C1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355E520665
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355E520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkVnr-0004w5-FC
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36485)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hkVmD-0003c3-Sk
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hkVmC-0005ZQ-QQ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 11:42:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hkVmC-0005YQ-Jz; Mon, 08 Jul 2019 11:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3BFB8831C;
 Mon,  8 Jul 2019 15:41:58 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDAC8608A4;
 Mon,  8 Jul 2019 15:41:54 +0000 (UTC)
Date: Mon, 8 Jul 2019 17:41:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190708174152.5182c0ff.cohuck@redhat.com>
In-Reply-To: <20190708150931.93448-1-borntraeger@de.ibm.com>
References: <20190708150931.93448-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 08 Jul 2019 15:41:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] s390: cpumodel: fix description for the
 new vector facility
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
Cc: Collin Walling <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  8 Jul 2019 17:09:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The new facility is called "Vector-Packed-Decimal-Enhancement Facility"
> and not "Vector BCD enhancements facility 1". As the shortname might
> have already found its way into some backports lets keep vxbeh.

s/lets/let's/

> 
> Fixes: 54d65de0b525 ("s390x/cpumodel: vector enhancements")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features_def.inc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
> index ef190e2fc783..3118a9f89228 100644
> --- a/target/s390x/cpu_features_def.inc.h
> +++ b/target/s390x/cpu_features_def.inc.h
> @@ -104,7 +104,7 @@ DEF_FEAT(CMM_NT, "cmmnt", STFL, 147, "CMM: ESSA-enhancement (no translate) facil
>  DEF_FEAT(VECTOR_ENH2, "vxeh2", STFL, 148, "Vector Enhancements facility 2")
>  DEF_FEAT(ESORT_BASE, "esort-base", STFL, 150, "Enhanced-sort facility (excluding subfunctions)")
>  DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "Deflate-conversion facility (excluding subfunctions)")
> -DEF_FEAT(VECTOR_BCD_ENH, "vxbeh", STFL, 152, "Vector BCD enhancements facility 1")
> +DEF_FEAT(VECTOR_BCD_ENH, "vxbeh", STFL, 152, "Vector-Packed-Decimal-Enhancement Facility")
>  DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)")
>  DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
>  

I like this one better than v1, as it seems less risky (and I think we
can live with the odd shortname; it's not like all facilities are named
in an obvious way...)

I'll queue this first thing tomorrow, unless someone objects.

