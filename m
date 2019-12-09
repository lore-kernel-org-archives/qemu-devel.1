Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE7BC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69C62072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvt0p0/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69C62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieF8L-0006f8-NH
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ieF7O-0005TY-Sm
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ieF7N-00007S-PL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:14:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53840
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ieF7N-000072-M5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575882853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg914zhVRWU/PXU4bqk0dhOqJTfDhMBjbVHa5VDvUIE=;
 b=Rvt0p0/xUhBsldF2BYXOPgLMdHmMF4juUhy/goPZ+QhinmXXroSfy+xYzNVGiVCrcboFaT
 RRWsORhQsJ6wF5MbsdcyFukMRhXnQ6VCiKOoGdVCDut3cS4JVD2jpQc5BXiWSv9gRSygHu
 PbE0KToJD8bLQGvaExggWaDsTvv2Lps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-X4inzE7gOh2EdYLqIXGvZQ-1; Mon, 09 Dec 2019 04:14:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DD22801E70;
 Mon,  9 Dec 2019 09:14:09 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DE2610016E8;
 Mon,  9 Dec 2019 09:14:07 +0000 (UTC)
Subject: Re: [PATCH 1/5] hw/arm/smmuv3: Apply address mask to linear strtab
 base address
To: Simon Veith <sveith@amazon.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
 <1575467748-28898-2-git-send-email-sveith@amazon.de>
 <0f01a30e-5b27-f97c-903a-a8a2a74a1cdd@redhat.com>
 <13be5c71-128a-0ae7-1af0-72b58b5958ab@amazon.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <efcd94cb-4397-9004-20d3-950469e30ab7@redhat.com>
Date: Mon, 9 Dec 2019 10:14:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <13be5c71-128a-0ae7-1af0-72b58b5958ab@amazon.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: X4inzE7gOh2EdYLqIXGvZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Simon,

On 12/5/19 11:04 PM, Simon Veith wrote:
> Hello Eric,
> 
> On 05/12/2019 09:42, Auger Eric wrote:
>> Not related to this patch but I noticed SMMU_BASE_ADDR_MASK should be
>> 0xffffffffffc0 and not 0xffffffffffe0. I can fix it separately or if you
>> respin, you may fix it as well?
> 
> Good catch, thank you. I'll fix it in the next version.
> 
> Looking at the upper end of that mask, it seems that we are currently masking out bits 48 through 63, rather than just 51 through 63.
> The reference manual says that this should be done to match the system physical address size as given by SMMU_IDR5.OAS.
Yes you're right. This should go up to 51 as per the field range
definition. Spec says address bits and above this field range are
treated as zero.
> 
> We define SMMU_IDR5_OAS to be 4, which selects a physical address size of 44 bits (ref. section 6.3.6). I think the mask should therefore be 0xfffffffffc0 to clear bits 44 and above. Do you agree?
bits beyond the OAS are RES0. The spec does not says those fields are
treated as zero, as explicitly mentioned for bits > 51. Normally the
guest should not set them to something != 0, this would be a programming
error right? Guest is supposed to read the IDR5 and program accordingly?

> 
> Ideally, we would derive this mask from our definition of SMMU_IDR5_OAS, but I'm not sure it's okay to stuff a call to oas2bits() into the SMMU_BASE_ADDR_MASK macro.
Well I am not sure this is worth the candle. I am not sure we are
obliged to enforce this.

Thanks

Eric
> 
> Regards
> Simon
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 


