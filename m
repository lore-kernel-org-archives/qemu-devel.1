Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E326EC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D6E2399A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmZtsCVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D6E2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOBu-00007r-D5
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kLNdX-000788-MK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kLNdV-0007Wz-Sf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600940037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wew+sGo2TuH7TibO12fv/ngEo2tTMD6APPxVssLrjQM=;
 b=XmZtsCVONo4t+dQl7h7u2vvD5M0ZtpM1ywAu+37bVppv3MAX+qgibFCEzyJBIOpWLQM6ds
 5n7ijmfx9/JWLOW5yVikiS/FAGyKgJh3oiX2hr6yFDfVAxhjmS3qlVFCd69/B9dDH/yI5u
 BNfsHKOjLp/vndV/GTpQ+ALtLvUzhEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-VLhakY_tPLePSYvMSd2Atw-1; Thu, 24 Sep 2020 05:33:55 -0400
X-MC-Unique: VLhakY_tPLePSYvMSd2Atw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C9A10BBECA;
 Thu, 24 Sep 2020 09:33:54 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0901E100238C;
 Thu, 24 Sep 2020 09:33:46 +0000 (UTC)
Date: Thu, 24 Sep 2020 11:33:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v3 6/7] hw/acpi/ich9: Set ACPI PCI hot-plug as default
Message-ID: <20200924113345.21c8749e@redhat.com>
In-Reply-To: <20200924070013.165026-7-jusual@redhat.com>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-7-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Ani Sinha <ani@anisinha.ca>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Sep 2020 09:00:12 +0200
Julia Suvorova <jusual@redhat.com> wrote:

> Signed-off-by: Julia Suvorova <jusual@redhat.com>

I'd drop this patch for now.
mgmt can turn it on for Windows guests to workaround
its native hotplug issues.

> ---
>  hw/acpi/ich9.c | 2 +-
>  hw/i386/pc.c   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 987f23e388..c67c20de4e 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -425,7 +425,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
>      pm->disable_s3 = 0;
>      pm->disable_s4 = 0;
>      pm->s4_val = 2;
> -    pm->use_acpi_hotplug_bridge = false;
> +    pm->use_acpi_hotplug_bridge = true;
>  
>      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
>                                     &pm->pm_io_base, OBJ_PROP_FLAG_READ);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b55369357e..5de4475570 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -101,6 +101,7 @@ GlobalProperty pc_compat_5_1[] = {};
>  const size_t pc_compat_5_1_len = G_N_ELEMENTS(pc_compat_5_1);
>  
>  GlobalProperty pc_compat_5_0[] = {
> +    { "ICH9-LPC", "acpi-pci-hotplug-with-bridge-support", "off" },
>  };
>  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
>  


