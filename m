Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE056C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 05:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C892072D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 05:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C892072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeXS6-0003q3-Ll
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 01:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeXRG-0003JP-Go
 for qemu-devel@nongnu.org; Fri, 29 May 2020 01:20:14 -0400
Received: from relay64.bu.edu ([128.197.228.104]:40422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeXRF-0006RW-3c
 for qemu-devel@nongnu.org; Fri, 29 May 2020 01:20:13 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04T5JPL2001184
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 29 May 2020 01:19:29 -0400
Date: Fri, 29 May 2020 01:19:25 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 1/1] tests/qtest/fuzz: Add faster virtio tests
Message-ID: <20200529051925.peokp7tmedgnqrqv@mozz.bu.edu>
References: <20200528165303.1877-1-f4bug@amsat.org>
 <20200528165303.1877-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528165303.1877-2-f4bug@amsat.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:20:11
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

On 200528 1853, Philippe Mathieu-Daudé wrote:
> We don't need to serialize over QTest chardev when we can
> directly access the MMIO address space via the first
> registered CPU view.
> Rename the currents tests as $TEST-qtest, add add faster
> tests that don't use the qtest chardev.
> 
> virtio-net-socket gets ~50% performance improvement.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

Thanks for fixing the spaces in the descriptions, too.

> ---
>  tests/qtest/fuzz/virtio_net_fuzz.c  | 42 ++++++++++++++++++++---
>  tests/qtest/fuzz/virtio_scsi_fuzz.c | 53 +++++++++++++++++++++++++----
>  2 files changed, 84 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
> index d08a47e278..7a39cfbb75 100644
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
> @@ -29,7 +31,9 @@ static int sockfds[2];
>  static bool sockfds_initialized;
>  
>  static void virtio_net_fuzz_multi(QTestState *s,
> -        const unsigned char *Data, size_t Size, bool check_used)
> +                                  const unsigned char *Data, size_t Size,
> +                                  bool check_used, bool use_qtest_chardev)
> +
>  {
>      typedef struct vq_action {
>          uint8_t queue;
> @@ -69,8 +73,13 @@ static void virtio_net_fuzz_multi(QTestState *s,
>               * If checking used ring, ensure that the fuzzer doesn't trigger
>               * trivial asserion failure on zero-zied buffer
>               */
> -            qtest_memwrite(s, req_addr, Data, vqa.length);
> -
> +            if (use_qtest_chardev) {
> +                qtest_memwrite(s, req_addr, Data, vqa.length);
> +            } else {
> +                address_space_write(first_cpu->as, req_addr,
> +                                     MEMTXATTRS_UNSPECIFIED,
> +                                     &Data, vqa.length);
> +            }
>  
>              free_head = qvirtqueue_add(s, q, req_addr, vqa.length,
>                      vqa.write, vqa.next);
> @@ -118,7 +127,20 @@ static void virtio_net_fork_fuzz(QTestState *s,
>          const unsigned char *Data, size_t Size)
>  {
>      if (fork() == 0) {
> -        virtio_net_fuzz_multi(s, Data, Size, false);
> +        virtio_net_fuzz_multi(s, Data, Size, false, false);
> +        flush_events(s);
> +        _Exit(0);
> +    } else {
> +        wait(NULL);
> +    }
> +}
> +
> +static void virtio_net_fork_fuzz_qtest(QTestState *s,
> +                                       const unsigned char *Data,
> +                                       size_t Size)
> +{
> +    if (fork() == 0) {
> +        virtio_net_fuzz_multi(s, Data, Size, false, true);
>          flush_events(s);
>          _Exit(0);
>      } else {
> @@ -130,7 +152,7 @@ static void virtio_net_fork_fuzz_check_used(QTestState *s,
>          const unsigned char *Data, size_t Size)
>  {
>      if (fork() == 0) {
> -        virtio_net_fuzz_multi(s, Data, Size, true);
> +        virtio_net_fuzz_multi(s, Data, Size, true, false);
>          flush_events(s);
>          _Exit(0);
>      } else {
> @@ -173,6 +195,16 @@ static void register_virtio_net_fuzz_targets(void)
>              &(QOSGraphTestOptions){.before = virtio_net_test_setup_socket}
>              );
>  
> +    fuzz_add_qos_target(&(FuzzTarget){
> +            .name = "virtio-net-socket-qtest",
> +            .description = "Fuzz the virtio-net virtual queues. Fuzz incoming "
> +            "traffic using the socket backend (over a qtest chardev)",
> +            .pre_fuzz = &virtio_net_pre_fuzz,
> +            .fuzz = virtio_net_fork_fuzz_qtest,},
> +            "virtio-net",
> +            &(QOSGraphTestOptions){.before = virtio_net_test_setup_socket}
> +            );
> +
>      fuzz_add_qos_target(&(FuzzTarget){
>              .name = "virtio-net-socket-check-used",
>              .description = "Fuzz the virtio-net virtual queues. Wait for the "
> diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> index 3b95247f12..27b63b2e32 100644
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
> @@ -63,7 +66,8 @@ static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev, uint64_t mask)
>  }
>  
>  static void virtio_scsi_fuzz(QTestState *s, QVirtioSCSIQueues* queues,
> -        const unsigned char *Data, size_t Size)
> +                             const unsigned char *Data, size_t Size,
> +                             bool use_qtest_chardev)
>  {
>      /*
>       * Data is a sequence of random bytes. We split them up into "actions",
> @@ -108,7 +112,13 @@ static void virtio_scsi_fuzz(QTestState *s, QVirtioSCSIQueues* queues,
>  
>          /* Copy the data into ram, and place it on the virtqueue */
>          uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
> -        qtest_memwrite(s, req_addr, Data, vqa.length);
> +        if (use_qtest_chardev) {
> +            qtest_memwrite(s, req_addr, Data, vqa.length);
> +        } else {
> +            address_space_write(first_cpu->as, req_addr,
> +                                 MEMTXATTRS_UNSPECIFIED,
> +                                 &Data, vqa.length);
> +        }
>          if (vq_touched[vqa.queue] == 0) {
>              vq_touched[vqa.queue] = 1;
>              free_head[vqa.queue] = qvirtqueue_add(s, q, req_addr, vqa.length,
> @@ -141,7 +151,25 @@ static void virtio_scsi_fork_fuzz(QTestState *s,
>          queues = qvirtio_scsi_init(scsi->vdev, 0);
>      }
>      if (fork() == 0) {
> -        virtio_scsi_fuzz(s, queues, Data, Size);
> +        virtio_scsi_fuzz(s, queues, Data, Size, false);
> +        flush_events(s);
> +        _Exit(0);
> +    } else {
> +        wait(NULL);
> +    }
> +}
> +
> +static void virtio_scsi_fork_fuzz_qtest(QTestState *s,
> +                                        const unsigned char *Data,
> +                                        size_t Size)
> +{
> +    QVirtioSCSI *scsi = fuzz_qos_obj;
> +    static QVirtioSCSIQueues *queues;
> +    if (!queues) {
> +        queues = qvirtio_scsi_init(scsi->vdev, 0);
> +    }
> +    if (fork() == 0) {
> +        virtio_scsi_fuzz(s, queues, Data, Size, true);
>          flush_events(s);
>          _Exit(0);
>      } else {
> @@ -159,7 +187,9 @@ static void virtio_scsi_with_flag_fuzz(QTestState *s,
>          if (Size >= sizeof(uint64_t)) {
>              queues = qvirtio_scsi_init(scsi->vdev, *(uint64_t *)Data);
>              virtio_scsi_fuzz(s, queues,
> -                             Data + sizeof(uint64_t), Size - sizeof(uint64_t));
> +                             Data + sizeof(uint64_t),
> +                             Size - sizeof(uint64_t),
> +                             false);
>              flush_events(s);
>          }
>          _Exit(0);
> @@ -189,7 +219,7 @@ static void register_virtio_scsi_fuzz_targets(void)
>  {
>      fuzz_add_qos_target(&(FuzzTarget){
>                  .name = "virtio-scsi-fuzz",
> -                .description = "Fuzz the virtio-scsi virtual queues, forking"
> +                .description = "Fuzz the virtio-scsi virtual queues, forking "
>                                  "for each fuzz run",
>                  .pre_vm_init = &counter_shm_init,
>                  .pre_fuzz = &virtio_scsi_pre_fuzz,
> @@ -198,9 +228,20 @@ static void register_virtio_scsi_fuzz_targets(void)
>                  &(QOSGraphTestOptions){.before = virtio_scsi_test_setup}
>                  );
>  
> +    fuzz_add_qos_target(&(FuzzTarget){
> +                .name = "virtio-scsi-fuzz-qtest",
> +                .description = "Fuzz the virtio-scsi virtual queues, forking "
> +                                "for each fuzz run (over a qtest chardev)",
> +                .pre_vm_init = &counter_shm_init,
> +                .pre_fuzz = &virtio_scsi_pre_fuzz,
> +                .fuzz = virtio_scsi_fork_fuzz_qtest,},
> +                "virtio-scsi",
> +                &(QOSGraphTestOptions){.before = virtio_scsi_test_setup}
> +                );
> +
>      fuzz_add_qos_target(&(FuzzTarget){
>                  .name = "virtio-scsi-flags-fuzz",
> -                .description = "Fuzz the virtio-scsi virtual queues, forking"
> +                .description = "Fuzz the virtio-scsi virtual queues, forking "
>                  "for each fuzz run (also fuzzes the virtio flags)",
>                  .pre_vm_init = &counter_shm_init,
>                  .pre_fuzz = &virtio_scsi_pre_fuzz,
> -- 
> 2.21.3
> 

