Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B76C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981D121E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981D121E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPnX-0000wU-Vn
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvPn3-0000AF-Jr
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvPn2-0002ec-Hj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:31:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvPn2-0002dV-BJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:31:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so92175467wrr.5
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r/5g57qrA0jMvEmj5H22OMkSWVwh5TMlyqzOmzZEJeA=;
 b=VCwjimn2Gd7Ou7iBx/6ZX9LEEzA5vQ1Jqy0kisYfEsT9Hv5f1qv5Pcq1u6qnzMAbbv
 xn4E70l7CEElJqCRl7njsWz3e8qaJzBtilOch6sgvBS1akI1BgkQ950F+r1YvVj0nC8j
 HaN88EB/IHrx/kDmhh/PBrODP1AuBlJ7oM+gcJ/7Xh7eLdLWlHtvKRxg1E37Gva5Otoy
 567lnBt/ta2ZeNhYKnNgBfyS/UMDJsC5VbKdIpAybK/6o10eO9l/OC+DHDoWgynh0R/b
 92VGEta2c5yolHMyqWPrKc5TCqgXS3Bpxu3XY51oj2bKkisF720v0xQ7OFz/i0PNRR0X
 sHyQ==
X-Gm-Message-State: APjAAAVrH7gPmTH7aDyrLmJswuJjKuT+Vgupm7q3tj+rD3lO59tkTQXU
 MqKOW0jbAOAwpOxN/c4x2267FQ==
X-Google-Smtp-Source: APXvYqw0Y2ntkQQG4mN1DKIYrn7KoBjtDz9K6Y+6BlW6kMejMyJWNobDIWlhycYCdRngdofFGFFNwQ==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr11622074wrr.252.1565199115438; 
 Wed, 07 Aug 2019 10:31:55 -0700 (PDT)
Received: from [192.168.1.115] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id l8sm180058276wrg.40.2019.08.07.10.31.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 10:31:54 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
Date: Wed, 7 Aug 2019 19:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-28-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 27/29] Include sysemu/sysemu.h a lot less
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> In my "build everything" tree, changing sysemu/sysemu.h triggers a
> recompile of some 5400 out of 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h).
> 
> hw/qdev-core.h includes sysemu/sysemu.h since recent commit e965ffa70a
> "qdev: add qdev_add_vm_change_state_handler()".  This is a bad idea:
> hw/qdev-core.h is widely included.
> 
> Move the declaration of qdev_add_vm_change_state_handler() to
> sysemu/sysemu.h, and drop the problematic include from hw/qdev-core.h.
> 
> Touching sysemu/sysemu.h now recompiles some 1800 objects.
> qemu/uuid.h also drops from 5400 to 1800.  A few more headers show
> smaller improvement: qemu/notify.h drops from 5600 to 5200,
> qemu/timer.h from 5600 to 4500, and qapi/qapi-types-run-state.h from
> 5500 to 5000.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  accel/kvm/kvm-all.c               | 1 +
>  backends/hostmem.c                | 1 +
>  cpus.c                            | 1 +
>  hw/arm/allwinner-a10.c            | 1 +
>  hw/arm/aspeed_soc.c               | 1 +
>  hw/arm/kzm.c                      | 1 +
>  hw/arm/msf2-soc.c                 | 1 +
>  hw/arm/stm32f205_soc.c            | 1 +
>  hw/char/serial-isa.c              | 1 +
>  hw/char/xen_console.c             | 1 +
>  hw/core/numa.c                    | 1 +
>  hw/core/vm-change-state-handler.c | 1 +
>  hw/display/qxl-render.c           | 1 +
>  hw/i386/xen/xen-hvm.c             | 1 +
>  hw/i386/xen/xen-mapcache.c        | 1 +
>  hw/intc/ioapic.c                  | 1 +
>  hw/pci/pci.c                      | 1 +
>  hw/riscv/sifive_e.c               | 1 +
>  hw/riscv/sifive_u.c               | 1 +
>  hw/riscv/spike.c                  | 1 +
>  hw/riscv/virt.c                   | 1 +
>  hw/sparc64/niagara.c              | 2 +-
>  hw/usb/hcd-ehci.h                 | 1 +
>  hw/xen/xen-common.c               | 1 +
>  hw/xen/xen_devconfig.c            | 1 +
>  hw/xenpv/xen_machine_pv.c         | 1 +
>  include/hw/qdev-core.h            | 5 -----
>  include/sysemu/sysemu.h           | 3 +++
>  migration/global_state.c          | 1 +
>  migration/migration.c             | 1 +
>  migration/savevm.c                | 1 +
>  31 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e1a44eccf5..fc38d0b9e3 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -29,6 +29,7 @@
>  #include "exec/gdbstub.h"
>  #include "sysemu/kvm_int.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/sysemu.h"
>  #include "qemu/bswap.h"
>  #include "exec/memory.h"
>  #include "exec/ram_addr.h"

Include missing in net/netmap.c:

  CC      net/netmap.o
net/netmap.c: In function 'netmap_update_fd_handler':
net/netmap.c:108:5: error: implicit declaration of function
'qemu_set_fd_handler' [-Werror=implicit-function-declaration]
     qemu_set_fd_handler(s->nmd->fd,
     ^~~~~~~~~~~~~~~~~~~
net/netmap.c:108:5: error: nested extern declaration of
'qemu_set_fd_handler' [-Werror=nested-externs]

