Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203BC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 06:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6329B2166E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 06:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6329B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd7Yv-0002aO-0T
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 02:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hd7Xk-0001zF-HW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hd7Xj-00044b-DT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:24:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hd7Xj-00044B-7z
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:24:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7D5530872CA;
 Tue, 18 Jun 2019 06:24:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A783C61981;
 Tue, 18 Jun 2019 06:24:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DDB3C16E18; Tue, 18 Jun 2019 08:24:06 +0200 (CEST)
Date: Tue, 18 Jun 2019 08:24:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: elena.ufimtseva@oracle.com
Message-ID: <20190618062406.m67ytpr3fjpxhlbo@sirius.home.kraxel.org>
References: <20190617181521.29371-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617181521.29371-1-elena.ufimtseva@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 18 Jun 2019 06:24:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/35] multi-process: build system
 for remote device process
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, konrad.wilk@oracle.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, kwolf@redhat.com, stefanha@redhat.com, afaerber@suse.de,
 pbonzini@redhat.com, mreitz@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> +#########################################################
> +# remote-pci-obj-y is common code used by remote devices
> +
> +remote-pci-obj-$(CONFIG_MPQEMU) += hw/
> +remote-pci-obj-$(CONFIG_MPQEMU) += qom/
> +remote-pci-obj-$(CONFIG_MPQEMU) += backends/
> +remote-pci-obj-$(CONFIG_MPQEMU) += block/
> +remote-pci-obj-$(CONFIG_MPQEMU) += migration/
> +remote-pci-obj-$(CONFIG_MPQEMU) += remote/
> +
> +remote-pci-obj-$(CONFIG_MPQEMU) += cpus-common.o
> +remote-pci-obj-$(CONFIG_MPQEMU) += dma-helpers.o
> +remote-pci-obj-$(CONFIG_MPQEMU) += blockdev.o
> +remote-pci-obj-$(CONFIG_MPQEMU) += qdev-monitor.o
> +remote-pci-obj-$(CONFIG_MPQEMU) += bootdevice.o
> +remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o

> +all-remote-pci-obj-y += $(authz-obj-y)
> +all-remote-pci-obj-y += $(block-obj-y)
> +all-remote-pci-obj-y += $(crypto-obj-y)
> +all-remote-pci-obj-y += $(io-obj-y)
> +all-remote-pci-obj-y += $(chardev-obj-y)
> +all-remote-pci-obj-y += $(remote-pci-obj-y)

> +remote-pci-obj-$(CONFIG_MPQEMU) += core/
> +remote-pci-obj-$(CONFIG_MPQEMU) += block/
> +remote-pci-obj-$(CONFIG_MPQEMU) += pci/
> +remote-pci-obj-$(CONFIG_MPQEMU) += nvram/

Phew.  So you are building half of qemu into the remote process.

Wouldn't it be more useful to split off much smaller, well-defined
pieces into separate processes?

Splitting off the block layer looks like a good candidate to me.  You'll
have a qemu-remote-block[1] then which should not need much beside
block/, and a small blockdev-proxy in qemu which talks to
qemu-remote-block instead of accessing the disk image by itself.  It's
also a nice improvement from the security point of view, even without
moving the device emulation too, because the main qemu process doesn't
need access to the image files any more.

Likewise network, especially useful for slirp.

With that in place other remote device objects (the lsi/scsi emulation,
but also vhost-user-blk) can just talk to the qemu-remote-block service
instead of compiling in the block layer.

cheers,
  Gerd

[1] maybe even qemu-remote-block-{raw,qcow2,vmdk,...)

