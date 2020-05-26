Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE301C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B323F2078C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B323F2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbaz-00026m-TL
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jdbaO-0001fT-OI
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:33:48 -0400
Received: from relay64.bu.edu ([128.197.228.104]:60939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jdbaN-0007PJ-1y
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:33:47 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04QFWuQk031293
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 26 May 2020 11:32:57 -0400
Date: Tue, 26 May 2020 11:32:56 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/2] tests/qtest/fuzz: Avoid QTest mmio serialization
Message-ID: <20200526153256.eorfnmfaxkui66q2@mozz.bu.edu>
References: <20200526055820.12999-1-f4bug@amsat.org>
 <20200526055820.12999-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526055820.12999-3-f4bug@amsat.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:57:30
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200526 0758, Philippe Mathieu-Daudé wrote:
> We don't need to serialize over QTest chardev when we can
> directly access the MMIO address space via the first
> registered CPU view.
> 
> virtio-net-socket gets ~50% performance improvement.

One option might be to write alternate (direct) implemtations for
qtest_out*, qtest_write*, qest_read*, qtest_bufread, qtest_bufwrite and
qtest_memset. Maybe these could even go into qtest.c, alleviating some
of the complexity of qtest_process_command(). Then there can be
a preprocessor option to link against libqtest or against the direct
access functions. In the case of qos-based virtio and scsi fuzzers
below, this would also mean that abstract functions such as
qvirtqueue_add would also go through the direct access layer, instead of
mixing direct access and qtest commands.

I don't think this is something we need right now, but it would be
useful for building qtest reproducers.

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

> ---
>  tests/qtest/fuzz/virtio_net_fuzz.c  | 6 ++++--
>  tests/qtest/fuzz/virtio_scsi_fuzz.c | 6 +++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
> index d08a47e278..ec993c9d5f 100644
> --- a/tests/qtest/fuzz/virtio_net_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
> @@ -19,6 +19,8 @@
>  #include "fork_fuzz.h"
>  #include "qos_fuzz.h"
>  
> +#include "exec/address-spaces.h"
> +#include "hw/core/cpu.h"
>  
>  #define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
>  #define QVIRTIO_RX_VQ 0
> @@ -69,8 +71,8 @@ static void virtio_net_fuzz_multi(QTestState *s,
>               * If checking used ring, ensure that the fuzzer doesn't trigger
>               * trivial asserion failure on zero-zied buffer
>               */
> -            qtest_memwrite(s, req_addr, Data, vqa.length);
> -
> +            address_space_write(first_cpu->as, req_addr, MEMTXATTRS_UNSPECIFIED,
> +                                &Data, vqa.length);
>  
>              free_head = qvirtqueue_add(s, q, req_addr, vqa.length,
>                      vqa.write, vqa.next);
> diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> index 3b95247f12..5096a5a730 100644
> --- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> @@ -23,6 +23,9 @@
>  #include "fork_fuzz.h"
>  #include "qos_fuzz.h"
>  
> +#include "exec/address-spaces.h"
> +#include "hw/core/cpu.h"
> +
>  #define PCI_SLOT                0x02
>  #define PCI_FN                  0x00
>  #define QVIRTIO_SCSI_TIMEOUT_US (1 * 1000 * 1000)
> @@ -108,7 +111,8 @@ static void virtio_scsi_fuzz(QTestState *s, QVirtioSCSIQueues* queues,
>  
>          /* Copy the data into ram, and place it on the virtqueue */
>          uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
> -        qtest_memwrite(s, req_addr, Data, vqa.length);
> +        address_space_write(first_cpu->as, req_addr, MEMTXATTRS_UNSPECIFIED,
> +                            &Data, vqa.length);
>          if (vq_touched[vqa.queue] == 0) {
>              vq_touched[vqa.queue] = 1;
>              free_head[vqa.queue] = qvirtqueue_add(s, q, req_addr, vqa.length,
> -- 
> 2.21.3
> 

