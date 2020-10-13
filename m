Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19FEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C6E24940
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C6E24940
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMIX-0007oU-JN
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kSMHB-00073g-9j
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:31:45 -0400
Received: from relay64.bu.edu ([128.197.228.104]:36268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kSMH8-0002jc-8T
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:31:44 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 09DFUqtl008619
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 13 Oct 2020 11:30:58 -0400
Date: Tue, 13 Oct 2020 11:30:52 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Dima Stepanov <dimastep@yandex-team.ru>
Subject: Re: [PATCH v1 1/2] fuzz: add virtio-blk fuzz target
Message-ID: <20201013153052.qzq6dhatcbpx33au@mozz.bu.edu>
References: <cover.1602078083.git.dimastep@yandex-team.ru>
 <0b922b854ac4121dd8574c3e9cd36c562f7d0a3c.1602078083.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b922b854ac4121dd8574c3e9cd36c562f7d0a3c.1602078083.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:31:40
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.44, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201007 1647, Dima Stepanov wrote:
> The virtio-blk fuzz target sets up and fuzzes the available virtio-blk
> queues. The implementation is based on two files:
>   - tests/qtest/fuzz/virtio_scsi_fuzz.c
>   - tests/qtest/virtio_blk_test.c
> 
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  tests/qtest/fuzz/meson.build       |   1 +
>  tests/qtest/fuzz/virtio_blk_fuzz.c | 234 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 235 insertions(+)
>  create mode 100644 tests/qtest/fuzz/virtio_blk_fuzz.c
> 
> diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
> index b31ace7..3b923dc 100644
> --- a/tests/qtest/fuzz/meson.build
> +++ b/tests/qtest/fuzz/meson.build
> @@ -5,6 +5,7 @@ specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c',
>  specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
>  specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
>  specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
> +specific_fuzz_ss.add(files('virtio_blk_fuzz.c'))

Hi Dima,
For consistency, maybe
specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio_blk_fuzz.c'))

>  
>  fork_fuzz = declare_dependency(
>    link_args: config_host['FUZZ_EXE_LDFLAGS'].split() +
> diff --git a/tests/qtest/fuzz/virtio_blk_fuzz.c b/tests/qtest/fuzz/virtio_blk_fuzz.c
> new file mode 100644
> index 0000000..623a756
> --- /dev/null
> +++ b/tests/qtest/fuzz/virtio_blk_fuzz.c
> @@ -0,0 +1,234 @@
> +/*
> + * virtio-blk Fuzzing Target
> + *
> + * Copyright Red Hat Inc., 2020
> + *
> + * Based on virtio-scsi-fuzz target.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "tests/qtest/libqos/libqtest.h"
> +#include "tests/qtest/libqos/virtio-blk.h"
> +#include "tests/qtest/libqos/virtio.h"
> +#include "tests/qtest/libqos/virtio-pci.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_pci.h"
> +#include "standard-headers/linux/virtio_blk.h"
> +#include "fuzz.h"
> +#include "fork_fuzz.h"
> +#include "qos_fuzz.h"
> +
> +#define TEST_IMAGE_SIZE         (64 * 1024 * 1024)
> +#define PCI_SLOT                0x02
> +#define PCI_FN                  0x00
> +
> +#define MAX_NUM_QUEUES 64
> +
> +/* Based on tests/qtest/virtio-blk-test.c. */
> +typedef struct {
> +    int num_queues;
> +    QVirtQueue *vq[MAX_NUM_QUEUES + 2];
> +} QVirtioBlkQueues;
> +
> +static QVirtioBlkQueues *qvirtio_blk_init(QVirtioDevice *dev, uint64_t mask)
> +{
> +    QVirtioBlkQueues *vs;
> +    uint64_t features;
> +
> +    vs = g_new0(QVirtioBlkQueues, 1);
> +
> +    features = qvirtio_get_features(dev);
> +    if (!mask) {
> +        mask = ~((1u << VIRTIO_RING_F_INDIRECT_DESC) |
> +                (1u << VIRTIO_RING_F_EVENT_IDX) |
> +                (1u << VIRTIO_BLK_F_SCSI));
> +    }
> +    mask |= ~QVIRTIO_F_BAD_FEATURE;
> +    features &= mask;
> +    qvirtio_set_features(dev, features);
> +
> +    vs->num_queues = 1;
> +    vs->vq[0] = qvirtqueue_setup(dev, fuzz_qos_alloc, 0);
> +
> +    qvirtio_set_driver_ok(dev);
> +
> +    return vs;
> +}
> +
> +static void virtio_blk_fuzz(QTestState *s, QVirtioBlkQueues* queues,
> +        const unsigned char *Data, size_t Size)
> +{
> +    /*
> +     * Data is a sequence of random bytes. We split them up into "actions",
> +     * followed by data:
> +     * [vqa][dddddddd][vqa][dddd][vqa][dddddddddddd] ...
> +     * The length of the data is specified by the preceding vqa.length
> +     */
> +    typedef struct vq_action {
> +        uint8_t queue;
> +        uint8_t length;
> +        uint8_t write;
> +        uint8_t next;
> +        uint8_t kick;
> +    } vq_action;
> +
> +    /* Keep track of the free head for each queue we interact with */
> +    bool vq_touched[MAX_NUM_QUEUES + 2] = {0};
> +    uint32_t free_head[MAX_NUM_QUEUES + 2];
> +
> +    QGuestAllocator *t_alloc = fuzz_qos_alloc;
> +
> +    QVirtioBlk *blk = fuzz_qos_obj;
> +    QVirtioDevice *dev = blk->vdev;
> +    QVirtQueue *q;
> +    vq_action vqa;
> +    while (Size >= sizeof(vqa)) {
> +        /* Copy the action, so we can normalize length, queue and flags */
> +        memcpy(&vqa, Data, sizeof(vqa));
> +
> +        Data += sizeof(vqa);
> +        Size -= sizeof(vqa);
> +
> +        vqa.queue = vqa.queue % queues->num_queues;
> +        /* Cap length at the number of remaining bytes in data */
> +        vqa.length = vqa.length >= Size ? Size : vqa.length;
> +        vqa.write = vqa.write & 1;
> +        vqa.next = vqa.next & 1;
> +        vqa.kick = vqa.kick & 1;
> +
> +        q = queues->vq[vqa.queue];
> +
> +        /* Copy the data into ram, and place it on the virtqueue */
> +        uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
> +        qtest_memwrite(s, req_addr, Data, vqa.length);
> +        if (vq_touched[vqa.queue] == 0) {
> +            vq_touched[vqa.queue] = 1;
> +            free_head[vqa.queue] = qvirtqueue_add(s, q, req_addr, vqa.length,
> +                    vqa.write, vqa.next);
> +        } else {
> +            qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.next);
> +        }
> +
> +        if (vqa.kick) {
> +            qvirtqueue_kick(s, dev, q, free_head[vqa.queue]);
> +            free_head[vqa.queue] = 0;
> +        }
> +        Data += vqa.length;
> +        Size -= vqa.length;
> +    }
> +    /* In the end, kick each queue we interacted with */
> +    for (int i = 0; i < MAX_NUM_QUEUES + 2; i++) {
> +        if (vq_touched[i]) {
> +            qvirtqueue_kick(s, dev, queues->vq[i], free_head[i]);
> +        }
> +    }
> +}
> +
> +static void virtio_blk_fork_fuzz(QTestState *s,
> +        const unsigned char *Data, size_t Size)
> +{
> +    QVirtioBlk *blk = fuzz_qos_obj;
> +    static QVirtioBlkQueues *queues;
> +    if (!queues) {
> +        queues = qvirtio_blk_init(blk->vdev, 0);
> +    }
> +    if (fork() == 0) {
> +        virtio_blk_fuzz(s, queues, Data, Size);
> +        flush_events(s);
> +        _Exit(0);
> +    } else {
> +        flush_events(s);
> +        wait(NULL);
> +    }
> +}
> +
> +static void virtio_blk_with_flag_fuzz(QTestState *s,
> +        const unsigned char *Data, size_t Size)
> +{
> +    QVirtioBlk *blk = fuzz_qos_obj;
> +    static QVirtioBlkQueues *queues;
> +
> +    if (fork() == 0) {
> +        if (Size >= sizeof(uint64_t)) {
> +            queues = qvirtio_blk_init(blk->vdev, *(uint64_t *)Data);
> +            virtio_blk_fuzz(s, queues,
> +                             Data + sizeof(uint64_t), Size - sizeof(uint64_t));
> +            flush_events(s);
> +        }
> +        _Exit(0);
> +    } else {
> +        flush_events(s);
> +        wait(NULL);
> +    }
> +}
> +
> +static void virtio_blk_pre_fuzz(QTestState *s)
> +{
> +    qos_init_path(s);
> +    counter_shm_init();
> +}
> +
> +static void drive_destroy(void *path)
> +{
> +    unlink(path);
> +    g_free(path);
> +}
> +
> +static char *drive_create(void)
> +{
> +    int fd, ret;
> +    char *t_path = g_strdup("/tmp/qtest.XXXXXX");
> +
> +    /* Create a temporary raw image */
> +    fd = mkstemp(t_path);
> +    g_assert_cmpint(fd, >=, 0);
> +    ret = ftruncate(fd, TEST_IMAGE_SIZE);
> +    g_assert_cmpint(ret, ==, 0);
> +    close(fd);
> +
> +    g_test_queue_destroy(drive_destroy, t_path);
> +    return t_path;
> +}
> +

I tested this out and it works with multi-process fuzzing under -jobs=4
-workers=4 (this initialization happens after libfuzzer has already
forked the processes). This seems like an interesting alternative to
using fake null-co:// files. 
I wonder if some state might leak as these disks are filled with fuzzer
data.

Nit: these disk files remain after the fuzzer exists. It looks
like the libfuzzer people suggest simply using atexit() to perform
cleanup: https://reviews.llvm.org/D45762
The is that the only way I have found to terminate the fuzzer is with
SIGKILL, where atexit is skipped. QEMU installs some signal handlers in
os-posix.c:os_setup_signal_handling to notify the main_loop that the
qemu was killed. Since we replace qemu_main_loop by manually running
main_loop_wait, we don't check main_loop_should_exit().

I sent a patch to disable QEMU's signal handlers for the fuzzer.
Message-Id: <20201013152920.448335-1-alxndr@bu.edu>

With an atexit() call to clean up the temporary images:
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

> +static void *virtio_blk_test_setup(GString *cmd_line, void *arg)
> +{
> +    char *tmp_path = drive_create();
> +
> +    g_string_append_printf(cmd_line,
> +                           " -drive if=none,id=drive0,file=%s,"
> +                           "format=raw,auto-read-only=off ",
> +                           tmp_path);
> +
> +    return arg;
> +}
> +
> +static void register_virtio_blk_fuzz_targets(void)
> +{
> +    fuzz_add_qos_target(&(FuzzTarget){
> +                .name = "virtio-blk-fuzz",
> +                .description = "Fuzz the virtio-blk virtual queues, forking "
> +                                "for each fuzz run",
> +                .pre_vm_init = &counter_shm_init,
> +                .pre_fuzz = &virtio_blk_pre_fuzz,
> +                .fuzz = virtio_blk_fork_fuzz,},
> +                "virtio-blk",
> +                &(QOSGraphTestOptions){.before = virtio_blk_test_setup}
> +                );
> +
> +    fuzz_add_qos_target(&(FuzzTarget){
> +                .name = "virtio-blk-flags-fuzz",
> +                .description = "Fuzz the virtio-blk virtual queues, forking "
> +                "for each fuzz run (also fuzzes the virtio flags)",
> +                .pre_vm_init = &counter_shm_init,
> +                .pre_fuzz = &virtio_blk_pre_fuzz,
> +                .fuzz = virtio_blk_with_flag_fuzz,},
> +                "virtio-blk",
> +                &(QOSGraphTestOptions){.before = virtio_blk_test_setup}
> +                );
> +}
> +
> +fuzz_target_init(register_virtio_blk_fuzz_targets);
> -- 
> 2.7.4
> 

