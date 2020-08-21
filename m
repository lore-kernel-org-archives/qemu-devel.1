Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B413C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 03:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B7A208B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 03:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cz04I7tS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B7A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8xwe-0005Nv-8c
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 23:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k8xw1-0004wp-4j
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 23:41:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k8xvy-0005rZ-Ly
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 23:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597981299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxuW6Dvh6+FnzhqPr20th8XoYYNBfg2T1L45UjG9cYs=;
 b=Cz04I7tSmuCCC8GZAjF+67cye4XB5v3NtI45TzAogeKT9zK8kVzp1rztf+OKxK26pavkFA
 qLeuhMhOknyFUjHoAJU1ANnh0LYb1Nay9fICey6HFcy3dOp1QUJ7gbxvoC7JbWigvu+fmd
 ka/oW4A3EpoqccrP9UaM+SvnDskugHM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-4RWoTIHHOdKbDy1cUSUWgw-1; Thu, 20 Aug 2020 23:41:37 -0400
X-MC-Unique: 4RWoTIHHOdKbDy1cUSUWgw-1
Received: by mail-qv1-f69.google.com with SMTP id d19so457978qvm.23
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 20:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UxuW6Dvh6+FnzhqPr20th8XoYYNBfg2T1L45UjG9cYs=;
 b=AfB6ptg58tj3vPzjEeDvOHFsfnPSZWT1q2BYgYQ6mVBjdMjMYGBtM/p6cJ6ZGYB5r+
 9NiY8JLBvnkLt5KI580a1pdpsD0t4Eh9Nom5fXmLcJ+vJi/TiLgHXeMsaaqF0atVXxgt
 ObRKMhsidjeLDezfGP5sWFB9tESH3ml707wooVytDnFqDPlOnvj5jIwH/SQpo34Np17z
 k9C+B/Dq3L33AQtS7zj8k6RxAY2fc5w0O83jvYFYUzK+QxCVmO0HUjBth8oLVlCtbv1/
 9BLt++B/XwZJmFBfXVy0zJVtiE64H09xRomJhMOT7eqZh3G0cPvlZaJ8MPOqiB9Bv573
 mRig==
X-Gm-Message-State: AOAM533R/9BoWRv8XO9sLsY0UoqjTSxpY555SvYfa1xZmiWgpdpHJv3b
 jOp/zyqERKNnz0UEjcSMO7dFdarEIWrrlsmN9iJHCW7wT9ONmkMuZE8kSMeDFbVFRfy2k8oMENR
 Wj7vmJLE0u4JPXXI=
X-Received: by 2002:a05:620a:1122:: with SMTP id
 p2mr1154562qkk.45.1597981297034; 
 Thu, 20 Aug 2020 20:41:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIH9DoLHRZlFpzgCb03Nuqi4tUoRu+Mh28df1yw3OSZNaylTDYNDeeQqyTsXzkcpXXgql1Pg==
X-Received: by 2002:a05:620a:1122:: with SMTP id
 p2mr1154548qkk.45.1597981296772; 
 Thu, 20 Aug 2020 20:41:36 -0700 (PDT)
Received: from redhat.com (bzq-109-67-40-161.red.bezeqint.net. [109.67.40.161])
 by smtp.gmail.com with ESMTPSA id c70sm494713qke.109.2020.08.20.20.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 20:41:36 -0700 (PDT)
Date: Thu, 20 Aug 2020 23:41:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] Use ACPI PCI hot-plug for q35
Message-ID: <20200820234019-mutt-send-email-mst@kernel.org>
References: <20200818215227.181654-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200818215227.181654-1-jusual@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 11:52:23PM +0200, Julia Suvorova wrote:
> PCIe native hot-plug has numerous problems with racing events and unpredictable
> guest behaviour (Windows). Switching to ACPI hot-plug for now.
> 
> Tested on RHEL 8 and Windows 2019.
> pxb-pcie is not yet supported.

Julia, pls update expected acpi tables, see tests/qtest/bios-tables-test.c

> v2:
>     * new ioport range for acpiphp [Gerd]
>     * drop find_pci_host() [Igor]
>     * explain magic numbers in _OSC [Igor]
>     * drop build_q35_pci_hotplug() wrapper [Igor]
> 
> Julia Suvorova (4):
>   hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
>   hw/i386/acpi-build: Add ACPI PCI hot-plug methods to q35
>   hw/i386/acpi-build: Turn off support of PCIe native hot-plug and SHPC
>     in _OSC
>   hw/acpi/ich9: Enable ACPI PCI hot-plug
> 
>  hw/i386/acpi-build.h    | 12 ++++++++++
>  include/hw/acpi/ich9.h  |  3 +++
>  include/hw/acpi/pcihp.h |  3 ++-
>  hw/acpi/ich9.c          | 52 ++++++++++++++++++++++++++++++++++++++++-
>  hw/acpi/pcihp.c         | 15 ++++++++----
>  hw/acpi/piix4.c         |  2 +-
>  hw/i386/acpi-build.c    | 48 +++++++++++++++++++++++--------------
>  hw/i386/pc.c            |  1 +
>  hw/acpi/trace-events    |  4 ++++
>  9 files changed, 114 insertions(+), 26 deletions(-)
> 
> -- 
> 2.25.4


