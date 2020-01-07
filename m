Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D2AC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E868222D9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeRG4pyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E868222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqiI-0006CN-KN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ioqKh-0008Hd-W1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ioqKg-0007Qj-O2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:59:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ioqKg-0007QM-JC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=F9moqg1p1FkruYaTmcxeVHpS1JXSXLSw6VS7uqHhO4A=;
 b=IeRG4pyRGTcPxk/TrTtc57rC5ICcna67HwclnkA3k/CynyIjJAbCWT2EcvqRopNtDhCe92
 DvHE2Z0sQ9+gCZGc5zozCxxEwsL8R05XiCzKW7v1P8l7+ZMOreOKRUzE6knvBPPD+UJ+Rh
 JtGsveh/6XLGNmnjyhuf2PQPxqeAmbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-qYAGBGQiPRq_d2RBV9o7VQ-1; Tue, 07 Jan 2020 09:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD5F4107B7F9;
 Tue,  7 Jan 2020 14:59:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49F685C3F8;
 Tue,  7 Jan 2020 14:59:25 +0000 (UTC)
Subject: Re: [PATCH v2 8/8] pc: stubify x86 iommu
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-9-git-send-email-pbonzini@redhat.com>
 <fae3437d-36c9-73bf-05a5-294cbffb9fad@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <51be9ce0-383f-2bf1-fda6-c6d9b09f3169@redhat.com>
Date: Tue, 7 Jan 2020 15:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fae3437d-36c9-73bf-05a5-294cbffb9fad@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qYAGBGQiPRq_d2RBV9o7VQ-1
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, philmd@redhat.com,
 slp@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 15.26, Thomas Huth wrote:
> On 12/12/2019 18.29, Paolo Bonzini wrote:
>> Allow building microvm without x86-iommu.c and in turn hw/i386/pc.h.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/i386/Kconfig          |  6 ++++++
>>  hw/i386/Makefile.objs    |  3 ++-
>>  hw/i386/x86-iommu-stub.c | 34 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 42 insertions(+), 1 deletions(-)
>>  create mode 100644 hw/i386/x86-iommu-stub.c
> 
> I just ran into this strange Travis build issue:
> 
>  https://travis-ci.com/huth/qemu/jobs/273007378#L3509
> 
> ... I think it might be related to this patch?
> 
> CONFIG_Q35 only does "imply AMD_IOMMU", so when compiling with
> "--without-default-devices", x86-iommu.c is not used... Do
> x86_iommu_ir_supported() and x86_iommu_get_type() need to be added to
> the x86-iommu-stub.c file?

FWIW, I just found Phil's patch which should fix this issue:

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg00959.html

 Thomas


