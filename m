Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F0C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5410C24681
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2dKmvGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5410C24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70nn-0004wO-Cw
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j70mn-0003tj-Cc
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j70mm-0002AM-9z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:47:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j70mm-000291-6Y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582739271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6rqBdkrTv6+OD3BXdG4o0FUEG/yy1/W+m/baiqwrU8=;
 b=G2dKmvGqzrFTY3GCaV2g4hiJlTUBWLmMm1Wvsmf9bNCTfTj39BMJkQH1PAJHOtRLrziEXD
 FbedxFKZn/suf3rVD9UTe7TIMCtwEjuZW/x3uKed3RCk5hCZskaANZEzrK2763Ab06P4FM
 LLhTd25taKeonXrKWFT2vRyIkCb0t0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-BjXvljPRPZynpH8qw6zbbA-1; Wed, 26 Feb 2020 12:47:50 -0500
X-MC-Unique: BjXvljPRPZynpH8qw6zbbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC683800D48;
 Wed, 26 Feb 2020 17:47:48 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0842F60BE2;
 Wed, 26 Feb 2020 17:47:41 +0000 (UTC)
Subject: Re: [PATCH v3 00/10] vTPM for aarch64
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200226102549.12158-1-eric.auger@redhat.com>
 <31e81f4b-ef00-692e-540f-ef3d9be5bb9a@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <22380cd3-b13e-aede-a7f5-158d86ca6136@redhat.com>
Date: Wed, 26 Feb 2020 18:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <31e81f4b-ef00-692e-540f-ef3d9be5bb9a@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 2/26/20 2:32 PM, Stefan Berger wrote:
> On 2/26/20 5:25 AM, Eric Auger wrote:
>> This series adds the capability to instantiate an MMIO TPM TIS
>> in ARM virt. It is candidate to qemu 5.0.
> 
> Looks good. Can you run the checkpatch script over the patches and
> address the warnings?
> 
> 
Thank you for you review!

About warnings

- There are warnings due to new files added but I think they all have an
entry in MAINTAINERS as wildcards are used.

- In tpm: Add the SysBus TPM TIS device.
  There is line over 80 chars but I think it is fine

#define TPM_TIS_SYSBUS(obj) OBJECT_CHECK(TPMStateSysBus, (obj),
TYPE_TPM_TIS_SYSBUS)

- test: tpm-tis: Get prepared to share tests between ISA and sysbus devices
has lots of warnings due to old comment style being used in
tests/qtest/tpm-tis-test.c. I did not fix the style issue because I just
copy the code into tpm-tis-util.c

Do you want me to fix them in the same patch, in a separate patch or
ignore the style issue for now?

Thanks

Eric


