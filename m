Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A31C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4A42077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4/TGzkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4A42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorC4-0006Vt-KY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iorAK-0003Ji-Ui
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iorAJ-0000jr-RZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:53:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29711
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iorAJ-0000jU-NW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578412387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCRNamqpK0fJRKMGrYopymoOjDkBbBc2TQ5SUbcsGYY=;
 b=i4/TGzkfoc9NrZ8/cHGFENXZg5m/ZZ/MWMyuLXy2X0EkGnN7aLkaFAgZek4BBqbtaza8Bx
 LPs1FTpe5OcsfuXPPRzKJyUth2OKOpxPqlPQ4gws9o2rKqWZSwr36RbuBjHSJVawqHfvbT
 omYBmtjj2wzRS2dExLhX7wCjOQpxSMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-G4cw4dbSNAupgzcOWPrlbA-1; Tue, 07 Jan 2020 10:53:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E91CB19057A2;
 Tue,  7 Jan 2020 15:53:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 122559CA3;
 Tue,  7 Jan 2020 15:52:59 +0000 (UTC)
Date: Tue, 7 Jan 2020 16:52:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: minyard@acm.org
Subject: Re: [PATCH] i386:acpi: Remove _HID from the SMBus ACPI entry
Message-ID: <20200107165258.56feae12@redhat.com>
In-Reply-To: <20200106152705.8258-1-minyard@acm.org>
References: <20200106152705.8258-1-minyard@acm.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: G4cw4dbSNAupgzcOWPrlbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 Jan 2020 09:27:05 -0600
minyard@acm.org wrote:

> From: Corey Minyard <cminyard@mvista.com>
> 
> Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
> on enumerated buses (like PCI in this case), _ADR is required (and is
> already there).  And the _HID value is wrong.  Linux appears to ignore
> the _HID entry, but it confuses Windows.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 7b8da62d41..ab73a8f4c8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1815,7 +1815,6 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
>      Aml *scope = aml_scope("_SB.PCI0");
>      Aml *dev = aml_device("SMB0");
>  
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
>      aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
>      build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
>      aml_append(scope, dev);


