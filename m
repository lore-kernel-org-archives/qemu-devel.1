Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30849C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7132073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6s2CTJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7132073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkYk-00080G-6U
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkVE-0003No-UC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:06:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkVB-0001Zv-To
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592924780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ovN0KAHVdRu+AE0XDQSkxN1bYiEAlSKV+9QgdxQZ5c=;
 b=D6s2CTJIbBsPNkGwt1qJ4vcefoh5bLieY6z2b8pBRURk7RQ/x5Wv1c3/ApHGkjduNxzXAF
 I2ZbTmkJyvPLhsaGIM4iVVEHVjPpe2Of9pl5GGgs3AgKswwcyeOpdWTF9Xt41NEe8Roqga
 0we2Rp4HmyAvECUrtEPhINGui9gtJw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-xea3qbR-Pe-misRH6Py3bw-1; Tue, 23 Jun 2020 11:06:18 -0400
X-MC-Unique: xea3qbR-Pe-misRH6Py3bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 002EF100CD14;
 Tue, 23 Jun 2020 15:06:12 +0000 (UTC)
Received: from localhost (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 772282B4D3;
 Tue, 23 Jun 2020 15:06:07 +0000 (UTC)
Date: Tue, 23 Jun 2020 17:06:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v3 2/3] i386: acpi: vmbus: Add _ADR definition
Message-ID: <20200623170605.08e46f87@redhat.com>
In-Reply-To: <20200618030027.759594-3-arilou@gmail.com>
References: <20200618030027.759594-1-arilou@gmail.com>
 <20200618030027.759594-3-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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
Cc: rvkagan@yandex-team.ru, pbonzini@redhat.com, vkuznets@redhat.com,
 mail@maciej.szmigiero.name, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 06:00:26 +0300
Jon Doron <arilou@gmail.com> wrote:

> It seems like latest HyperV sets _ADR to 0 in the ACPI for the VMBS

that's a hardly a good reason to add this.
To me looks like a pointless addition,
_ADR mostly is used when device resides on a bus with standard ennumeration
algorithm (i.e. PCI, ...).

Value is also wrong  for the bus it's placed currently,
and with the next patch it won't make a sense altogether.

Pls, drop this patch unless Windows refuses to work without it.
 
> 
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  hw/i386/acpi-build.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 91af0d2d0d..6d9df38e31 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1061,6 +1061,7 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>  
>      dev = aml_device("VMBS");
>      aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
> +    aml_append(dev, aml_name_decl("_ADR", aml_int(0x0)));
>      aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
>      aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
>      aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));


