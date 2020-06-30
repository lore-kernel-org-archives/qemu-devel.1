Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCB7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EE120720
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHtN-0004pm-Ng
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jqHsd-0004JY-KJ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:09:03 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:46127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jqHsb-0005yw-O3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:09:03 -0400
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: OjpqnZo3XH7g7b87jmn7DyAGGy6bnb1vG0VaLDdwnbRe5viygiv6JcLiAhoVymBXSaSdifaKYW
 bu0yCX7KWl3TJWfIEmK9avXh/VBUr6kY2qjK36Fhl+ov/GVYjrQdWlcZjEwZbCuQvvEXoNC1DX
 uFgiDiABsgJwowLWz9ZYhrlqb/o5mUsCSgMw/LRuw7UfHl+SUQoBXSlKUfYBXoyhPnE2ud8a3U
 wNQQ83m4aRjNZbCYpsogUZkLpa/mDZfMfOkrXd+R3XWBTTuyXg27l+UEIkPf8F1lI5KZzaKOJ2
 sPg=
X-SBRS: 2.7
X-MesageID: 21294008
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,297,1589256000"; d="scan'208";a="21294008"
Date: Tue, 30 Jun 2020 16:08:49 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul@xen.org>
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
Message-ID: <20200630150849.GA2110@perard.uk.xensource.com>
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200624121841.17971-3-paul@xen.org>
Received-SPF: pass client-ip=216.71.145.153;
 envelope-from=anthony.perard@citrix.com; helo=esa2.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:08:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <pdurrant@amazon.com>,
 Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 01:18:41PM +0100, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> The generic pc_machine_initfn() calls pc_system_flash_create() which creates
> 'system.flash0' and 'system.flash1' devices. These devices are then realized
> by pc_system_flash_map() which is called from pc_system_firmware_init() which
> itself is called via pc_memory_init(). The latter however is not called when
> xen_enable() is true and hence the following assertion fails:
> 
> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
> Assertion `dev->realized' failed
> 
> These flash devices are unneeded when using Xen so this patch avoids the
> assertion by simply removing them using pc_system_flash_cleanup_unused().
> 
> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blockdev")
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> Tested-by: Jason Andryuk <jandryuk@gmail.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

I think I would add:

Fixes: dfe8c79c4468 ("qdev: Assert onboard devices all get realized properly")

as this is the first commit where the unrealized flash devices are an
issue.

-- 
Anthony PERARD

