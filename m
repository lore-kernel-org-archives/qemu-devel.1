Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF49C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEACF206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8bsp9KK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEACF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0Rf-0003O5-Lz
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kVzXb-000230-QU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kVzXY-0006D6-6m
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603469017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lSfWWpmzSw4rX2o3LemtfdTgjZIS5q+X4XJk85b8bk0=;
 b=P8bsp9KKcER5dScA80lEx8nVOQT9zXMBZiDpFXtIfPflkGctkPSOr1qiHgOaRaxcC5+zUP
 MoWJRXkgYFSOKwyE5/BaYKakJTvXyXuFzL/pjS6/VTAPI0HvXP2KDd1JHvBVcVH8dWfKeh
 4ulpFM7sYd7CgBrUZ/qzik/8+NqDM7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-vnAJ5WjGNIGmI6GywoO_nw-1; Fri, 23 Oct 2020 12:03:36 -0400
X-MC-Unique: vnAJ5WjGNIGmI6GywoO_nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FB73804B6A;
 Fri, 23 Oct 2020 16:03:34 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8809210013D0;
 Fri, 23 Oct 2020 16:03:23 +0000 (UTC)
Date: Fri, 23 Oct 2020 12:03:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/8] arm/virt: add usb support
Message-ID: <20201023120306-mutt-send-email-mst@kernel.org>
References: <20201023071022.24916-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023071022.24916-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 09:10:14AM +0200, Gerd Hoffmann wrote:
> Bring new microvm goodies to arm virt too.  Wire up
> -machine usb=on, add sysbus-xhci in case it is enabled.


For ACPI bits:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Gerd Hoffmann (8):
>   tests/acpi: allow updates for expected data files
>   tests/acpi: add empty tests/data/acpi/virt/DSDT.usb file
>   arm/virt: add support for -machine usb=on
>   arm/virt: add device tree node for xhci
>   arm/virt: add acpi dsdt entry for xhci
>   tests/acpi: add usb testcase for virt
>   tests/acpi: update expected data files
>   tests/acpi: disallow updates for expected data files
> 
>  include/hw/arm/virt.h            |   1 +
>  hw/arm/virt-acpi-build.c         |   6 ++++++
>  hw/arm/virt.c                    |  36 +++++++++++++++++++++++++++++++
>  hw/usb/hcd-xhci-sysbus.c         |   2 ++
>  tests/qtest/bios-tables-test.c   |  18 ++++++++++++++++
>  hw/arm/Kconfig                   |   1 +
>  tests/data/acpi/microvm/DSDT.usb | Bin 414 -> 426 bytes
>  tests/data/acpi/virt/DSDT.usb    | Bin 0 -> 5257 bytes
>  8 files changed, 64 insertions(+)
>  create mode 100644 tests/data/acpi/virt/DSDT.usb
> 
> -- 
> 2.27.0
> 


