Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B12C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CD620658
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="UEe4nbDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CD620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Rwx-00084O-FW
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k5RwN-0007ZR-VQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 06:55:35 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:1408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k5RwL-0002h3-Vh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 06:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1597143333;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HJeFnSV/+ONcf4QjRxk/eFMrNPUmsA5U0nFiCFmbOF4=;
 b=UEe4nbDspk21UeJI0bpCh73at54yfR2es0byHycYeGOj1gQ8P4ZZVLid
 dyVGSnDm6UnlH1SAG3mYo9ssreD0UM6eY4R/G1sSe5yuIsLy7rOA263z/
 AVYL2jRlhxMND0YvREYzTEYDuVLwb3ZkxNnX4Cac1O9lxfyEjUl7dDt9H s=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: EZMbyMaOMLPt1xDQxrFocP3wLpqJ33C91woV+4GwI5YkFG7akLl86jAftNH0Op8MDbxKbopIy2
 U+7KaKFLcHIcBBrluwTFyB41KCfKkHudc1njk+sNZECRDJDynEdBeqyU7uAdgpvvRFwrhmw48p
 rIXJzvEuBpBVgxi2wPWMki40pr3EhGZTZkQWRtZVUuvktWY4haN4pEjOQT+zHXuv6+5RltLEHz
 uKnDGfr9ApsnIsmEhw9Ynfiy6GaYgkMY4pdb6AMl1AtJ+3u+/ldwb8DwISCQTd7XUwD1fRL6sC
 /E0=
X-SBRS: 2.7
X-MesageID: 25162782
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,461,1589256000"; d="scan'208";a="25162782"
Date: Tue, 11 Aug 2020 11:55:22 +0100
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
CC: <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paul Durrant <paul@xen.org>, "Roger
 Pau =?iso-8859-1?Q?Monn=E9?=" <roger.pau@citrix.com>,
 <xen-devel@lists.xenproject.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Eduardo
 Habkost" <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH-for-5.2] hw/i386/q35: Remove unreachable Xen code on Q35
 machine
Message-ID: <20200811105522.GB2024@perard.uk.xensource.com>
References: <20200722082517.18708-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722082517.18708-1-philmd@redhat.com>
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=anthony.perard@citrix.com; helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:55:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

On Wed, Jul 22, 2020 at 10:25:17AM +0200, Philippe Mathieu-Daudé wrote:
> Xen accelerator requires specific changes to a machine to be able
> to use it. See for example the 'Xen PC' machine configure its PCI
> bus calling pc_xen_hvm_init_pci(). There is no 'Xen Q35' machine
> declared. This code was probably added while introducing the Q35
> machine, based on the existing PC machine (see commit df2d8b3ed4
> "Introduce q35 pc based chipset emulator"). Remove the unreachable
> code to simplify this file.

This is almost correct, we can't start a xen guest with the q35 machine
due to missing setup. But we wouldn't need to declare a new xen specific
machine as setting "accel=xen" is enough.

Anyway, that patch can be reverted whenever someone takes care of
bringing q35 to xen.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

