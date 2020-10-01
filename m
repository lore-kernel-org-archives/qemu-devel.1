Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC814C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56106206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PS0YaFAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56106206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyTc-0000Q0-4c
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kNyRK-0007nq-FK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kNyRI-00079N-JT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601558160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bXCTi3HWmxyjkU0PoUMNokwPgzgHP+oT66ZbySd1Lw=;
 b=PS0YaFApFSo1291Ui1XUk/Tw4Jhb4Nu4buG6MEYlDbRkTgPgLGBSfLaFbyHmi6goC50q4W
 NVILFXvKsYqr6Upc4HbA8TBUCD06NyruYfF4RdE+9XjvaP7CmHRoMFEV+oPDqequsRoF1d
 WBXZfIHsMaijYRvo2LuzDsiR5Pg8uU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-KyYir4HPPJW4I0IOX675uw-1; Thu, 01 Oct 2020 09:15:58 -0400
X-MC-Unique: KyYir4HPPJW4I0IOX675uw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B345186DD2F
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2020 13:15:44 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0D455DEDE;
 Thu,  1 Oct 2020 13:15:42 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: Ignore bios-tables-test in the qtest section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201001042717.136033-1-thuth@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a49014f1-0fed-74d0-85c3-a8bfc91e26ab@redhat.com>
Date: Thu, 1 Oct 2020 15:15:42 +0200
MIME-Version: 1.0
In-Reply-To: <20201001042717.136033-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/20 06:27, Thomas Huth wrote:
> I'm very often getting CC: on rather large patch series that
> modify the ACPI stuff of either ARM or x86, just because the
> bios-table-test is often slightly involved here. I can't say
> much about ACPI, and the bios-table-test is already covered
> by the ACPI section in MAINTAINERS,

Right, the exact same pattern that you're going to exclude in this patch
from under "qtest" is already covered under "ACPI/SMBIOS":

F: tests/qtest/bios-tables-test*

> so I'd rather prefer to
> not getting automatically CC-ed on such patch series anymore.
> If people want my opinion about qtest-related changes, they
> can still put me on CC manually.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1e8ae277d..d476fbf627 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2474,7 +2474,7 @@ S: Maintained
>  F: softmmu/qtest.c
>  F: accel/qtest.c
>  F: tests/qtest/
> -X: tests/qtest/bios-tables-test-allowed-diff.h
> +X: tests/qtest/bios-tables-test*
>  
>  Device Fuzzing
>  M: Alexander Bulekov <alxndr@bu.edu>
> 

FWIW:

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


