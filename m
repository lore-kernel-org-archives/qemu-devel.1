Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DFC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB1920673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB1920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD3NY-0005EH-UN
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 05:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iD3Lj-0003Ti-0H
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iD3Lh-0003z8-1y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:12:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iD3Lg-0003yh-Sk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:12:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 784043B77;
 Wed, 25 Sep 2019 09:12:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C55D261559;
 Wed, 25 Sep 2019 09:12:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CABB99D69; Wed, 25 Sep 2019 11:12:25 +0200 (CEST)
Date: Wed, 25 Sep 2019 11:12:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
Message-ID: <20190925091225.bx4c4x2o6qgydidj@sirius.home.kraxel.org>
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com>
 <87h850ssnb.fsf@redhat.com>
 <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 25 Sep 2019 09:12:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Pankaj Gupta <pagupta@redhat.com>, mtosatti@redhat.com, ehabkost@redhat.com,
 Sergio Lopez <slp@redhat.com>, mst@redhat.com, lersek@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> If you want to add hotplug to microvm, you can reuse the existing code
> for CPU and memory hotplug controllers, and write drivers for them in
> Linux's drivers/platform.  The drivers would basically do what the ACPI
> AML tells the interpreter to do.

How would the linux kernel detect those devices?

I guess that wouldn't be ACPI, seems everyone wants avoid it[1].

So device tree on x86?  Something else?

cheers,
  Gerd

[1] Not clear to me why, some minimal ACPI tables listing our
    devices (isa-serial, fw_cfg, ...) doesn't look unreasonable
    to me.  We could also make virtio-mmio discoverable that way.
    Also we could do acpi cpu hotplug without having to write those
    linux platform drivers.  We would need a sysbus-acpi device though,
    but given that most acpi code is already separated out so piix and
    q35 can share it it should not be that hard to wire up.

