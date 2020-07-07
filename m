Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED62C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4E92065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGU6y4+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4E92065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskok-0000eW-Jp
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsknx-0008HW-PV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:26:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsknv-00047E-Lg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594117582;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ksh7qm6adGST/ZaaaSRGOC5KkyimhdVy3s/dSUsS2wc=;
 b=XGU6y4+StnZo91tkuOdh5X2SManb75uwPNIrht8vP2Q1v2ahhaoSOXfvCxU8zaMFIVYoL1
 +d7yZ/jb8mfbBsBShpa+eivTKSk9Jjjm5QgBEjkzW6HSgxreKerq80z7gqzBO9XgFHyK+0
 wTJj6ChglurfvG5t3HxzZHwgnEu/hZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-OgGMpmGzP4aC_p9nKwLp_w-1; Tue, 07 Jul 2020 06:25:55 -0400
X-MC-Unique: OgGMpmGzP4aC_p9nKwLp_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742B2879511;
 Tue,  7 Jul 2020 10:25:50 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEF315D9F3;
 Tue,  7 Jul 2020 10:25:13 +0000 (UTC)
Date: Tue, 7 Jul 2020 11:25:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH] trivial: Remove trailing whitespaces
Message-ID: <20200707102510.GF2649462@redhat.com>
References: <20200706162300.1084753-1-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200706162300.1084753-1-dinechin@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Marek Vasut <marex@denx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, xen-devel@lists.xenproject.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 06, 2020 at 06:23:00PM +0200, Christophe de Dinechin wrote:
> There are a number of unnecessary trailing whitespaces that have
> accumulated over time in the source code. They cause stray changes
> in patches if you use tools that automatically remove them.
> 
> Tested by doing a `git diff -w` after the change.
> 
> This could probably be turned into a pre-commit hook.

scripts/checkpatch.pl ought to be made to check it.

> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  block/iscsi.c                                 |   2 +-
>  disas/cris.c                                  |   2 +-
>  disas/microblaze.c                            |  80 +++---
>  disas/nios2.c                                 | 256 +++++++++---------
>  hmp-commands.hx                               |   2 +-
>  hw/alpha/typhoon.c                            |   6 +-
>  hw/arm/gumstix.c                              |   6 +-
>  hw/arm/omap1.c                                |   2 +-
>  hw/arm/stellaris.c                            |   2 +-
>  hw/char/etraxfs_ser.c                         |   2 +-
>  hw/core/ptimer.c                              |   2 +-
>  hw/cris/axis_dev88.c                          |   2 +-
>  hw/cris/boot.c                                |   2 +-
>  hw/display/qxl.c                              |   2 +-
>  hw/dma/etraxfs_dma.c                          |  18 +-
>  hw/dma/i82374.c                               |   2 +-
>  hw/i2c/bitbang_i2c.c                          |   2 +-
>  hw/input/tsc2005.c                            |   2 +-
>  hw/input/tsc210x.c                            |   2 +-
>  hw/intc/etraxfs_pic.c                         |   8 +-
>  hw/intc/sh_intc.c                             |  10 +-
>  hw/intc/xilinx_intc.c                         |   2 +-
>  hw/misc/imx25_ccm.c                           |   6 +-
>  hw/misc/imx31_ccm.c                           |   2 +-
>  hw/net/vmxnet3.h                              |   2 +-
>  hw/net/xilinx_ethlite.c                       |   2 +-
>  hw/pci/pcie.c                                 |   2 +-
>  hw/sd/omap_mmc.c                              |   2 +-
>  hw/sh4/shix.c                                 |   2 +-
>  hw/sparc64/sun4u.c                            |   2 +-
>  hw/timer/etraxfs_timer.c                      |   2 +-
>  hw/timer/xilinx_timer.c                       |   4 +-
>  hw/usb/hcd-musb.c                             |  10 +-
>  hw/usb/hcd-ohci.c                             |   6 +-
>  hw/usb/hcd-uhci.c                             |   2 +-
>  hw/virtio/virtio-pci.c                        |   2 +-
>  include/hw/cris/etraxfs_dma.h                 |   4 +-
>  include/hw/net/lance.h                        |   2 +-
>  include/hw/ppc/spapr.h                        |   2 +-
>  include/hw/xen/interface/io/ring.h            |  34 +--
>  include/qemu/log.h                            |   2 +-
>  include/qom/object.h                          |   4 +-
>  linux-user/cris/cpu_loop.c                    |  16 +-
>  linux-user/microblaze/cpu_loop.c              |  16 +-
>  linux-user/mmap.c                             |   8 +-
>  linux-user/sparc/signal.c                     |   4 +-
>  linux-user/syscall.c                          |  24 +-
>  linux-user/syscall_defs.h                     |   2 +-
>  linux-user/uaccess.c                          |   2 +-
>  os-posix.c                                    |   2 +-
>  qapi/qapi-util.c                              |   2 +-
>  qemu-img.c                                    |   2 +-
>  qemu-options.hx                               |  26 +-
>  qom/object.c                                  |   2 +-
>  target/cris/translate.c                       |  28 +-
>  target/cris/translate_v10.inc.c               |   6 +-
>  target/i386/hvf/hvf.c                         |   4 +-
>  target/i386/hvf/x86.c                         |   4 +-
>  target/i386/hvf/x86_decode.c                  |  20 +-
>  target/i386/hvf/x86_decode.h                  |   4 +-
>  target/i386/hvf/x86_descr.c                   |   2 +-
>  target/i386/hvf/x86_emu.c                     |   2 +-
>  target/i386/hvf/x86_mmu.c                     |   6 +-
>  target/i386/hvf/x86_task.c                    |   2 +-
>  target/i386/hvf/x86hvf.c                      |  42 +--
>  target/i386/translate.c                       |   8 +-
>  target/microblaze/mmu.c                       |   2 +-
>  target/microblaze/translate.c                 |   2 +-
>  target/sh4/op_helper.c                        |   4 +-
>  target/xtensa/core-de212/core-isa.h           |   6 +-
>  .../xtensa/core-sample_controller/core-isa.h  |   6 +-
>  target/xtensa/core-test_kc705_be/core-isa.h   |   2 +-
>  tcg/sparc/tcg-target.inc.c                    |   2 +-
>  tcg/tcg.c                                     |  32 +--
>  tests/tcg/multiarch/test-mmap.c               |  72 ++---
>  ui/curses.c                                   |   4 +-
>  ui/curses_keys.h                              |   4 +-
>  util/cutils.c                                 |   2 +-
>  78 files changed, 440 insertions(+), 440 deletions(-)

The cleanup is a good idea, however, I think it is probably better to
split the patch approx into subsystems. That will make it much easier
to cherry-pick for people doing backports.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


