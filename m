Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFF82076E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY0iZvqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFF82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo77e-0005g9-AJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo76l-0004am-2f
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:14:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo76g-0003Co-RV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593011673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLitUZoasDGAMNBpeQqPn+I+TWkYVx0RJeDFBC8tMcg=;
 b=KY0iZvqYOw3Pjo3EKVVvS2JqPkah1CSJnHMkYVoHgk8E25koW6kThGXFvDvoc9J4mQlzJR
 3/XRO2Kdf76eo6/gWet1wN65rJ46F6Q9jlWKcmBj/8SwBU6gbDVYy1jXs0hhH+GG5NCrN8
 8p2IbNuKKw8IK6hN0WQJCbb1d1sd9Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-12rJkm0cNH-GYS50_M6Iww-1; Wed, 24 Jun 2020 11:14:29 -0400
X-MC-Unique: 12rJkm0cNH-GYS50_M6Iww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F1EA18FF662;
 Wed, 24 Jun 2020 15:14:28 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-35.ams2.redhat.com [10.36.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C83185D9DC;
 Wed, 24 Jun 2020 15:14:23 +0000 (UTC)
Subject: Re: [PATCH v9 5/5] new qTest case to test the vhost-user-blk-server
To: Coiby Xu <coiby.xu@gmail.com>, qemu-devel@nongnu.org
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-6-coiby.xu@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <605004b3-c075-ade2-fe59-1f2f266da58f@redhat.com>
Date: Wed, 24 Jun 2020 17:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200614183907.514282-6-coiby.xu@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/06/2020 20.39, Coiby Xu wrote:
> This test case has the same tests as tests/virtio-blk-test.c except for
> tests have block_resize. Since vhost-user server can only server one
> client one time, two instances of qemu-storage-daemon are launched
> for the hotplug test.
> 
> In order to not block scripts/tap-driver.pl, vhost-user-blk-server will
> send "quit" command to qemu-storage-daemon's QMP monitor. So a function
> is added to libqtest.c to establish socket connection with socket
> server.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
[...]
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 49075b55a1..02cc09f893 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -52,8 +52,7 @@ typedef struct QTestClientTransportOps {
>       QTestRecvFn     recv_line; /* for receiving qtest command responses */
>   } QTestTransportOps;
>   
> -struct QTestState
> -{
> +struct QTestState {
>       int fd;
>       int qmp_fd;
>       pid_t qemu_pid;  /* our child QEMU process */
> @@ -608,6 +607,38 @@ QDict *qtest_qmp_receive(QTestState *s)
>       return qmp_fd_receive(s->qmp_fd);
>   }
>   
> +QTestState *qtest_create_state_with_qmp_fd(int fd)
> +{
> +    QTestState *qmp_test_state = g_new0(QTestState, 1);
> +    qmp_test_state->qmp_fd = fd;
> +    return qmp_test_state;
> +}
> +
> +int qtest_socket_client(char *server_socket_path)
> +{
> +    struct sockaddr_un serv_addr;
> +    int sock;
> +    int ret;
> +    int retries = 0;
> +    sock = socket(PF_UNIX, SOCK_STREAM, 0);
> +    g_assert_cmpint(sock, !=, -1);
> +    serv_addr.sun_family = AF_UNIX;
> +    snprintf(serv_addr.sun_path, sizeof(serv_addr.sun_path), "%s",
> +             server_socket_path);
> +
> +    do {

Why not simply:

  for (retries = 0; retries < 3; retries++)

?

> +        ret = connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
> +        if (ret == 0) {
> +            break;
> +        }
> +        retries += 1;
> +        g_usleep(G_USEC_PER_SEC);
> +    } while (retries < 3);
> +
> +    g_assert_cmpint(ret, ==, 0);
> +    return sock;
> +}
[...]
> diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
> new file mode 100644
> index 0000000000..56e3d8f338
> --- /dev/null
> +++ b/tests/qtest/vhost-user-blk-test.c
> @@ -0,0 +1,739 @@
> +/*
> + * QTest testcase for VirtIO Block Device
> + *
> + * Copyright (c) 2014 SUSE LINUX Products GmbH
> + * Copyright (c) 2014 Marc Marí
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "qemu/bswap.h"
> +#include "qemu/module.h"
> +#include "standard-headers/linux/virtio_blk.h"
> +#include "standard-headers/linux/virtio_pci.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/vhost-user-blk.h"
> +#include "libqos/libqos-pc.h"
> +
> +/* TODO actually test the results and get rid of this */
> +#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))

Please no more qmp_discard_response() in new code!

> +#define TEST_IMAGE_SIZE         (64 * 1024 * 1024)
> +#define QVIRTIO_BLK_TIMEOUT_US  (30 * 1000 * 1000)
> +#define PCI_SLOT_HP             0x06
> +
> +typedef struct QVirtioBlkReq {
> +    uint32_t type;
> +    uint32_t ioprio;
> +    uint64_t sector;
> +    char *data;
> +    uint8_t status;
> +} QVirtioBlkReq;
> +
> +
> +#ifdef HOST_WORDS_BIGENDIAN
> +static const bool host_is_big_endian = true;
> +#else
> +static const bool host_is_big_endian; /* false */
> +#endif
> +
> +static inline void virtio_blk_fix_request(QVirtioDevice *d, QVirtioBlkReq *req)
> +{
> +    if (qvirtio_is_big_endian(d) != host_is_big_endian) {
> +        req->type = bswap32(req->type);
> +        req->ioprio = bswap32(req->ioprio);
> +        req->sector = bswap64(req->sector);
> +    }
> +}
> +
> +

One empty line should be enough ;-)

> +static inline void virtio_blk_fix_dwz_hdr(QVirtioDevice *d,
> +    struct virtio_blk_discard_write_zeroes *dwz_hdr)
> +{
> +    if (qvirtio_is_big_endian(d) != host_is_big_endian) {
> +        dwz_hdr->sector = bswap64(dwz_hdr->sector);
> +        dwz_hdr->num_sectors = bswap32(dwz_hdr->num_sectors);
> +        dwz_hdr->flags = bswap32(dwz_hdr->flags);
> +    }
> +}
> +
> +static uint64_t virtio_blk_request(QGuestAllocator *alloc, QVirtioDevice *d,
> +                                   QVirtioBlkReq *req, uint64_t data_size)
> +{
> +    uint64_t addr;
> +    uint8_t status = 0xFF;
> +
> +    switch (req->type) {
> +    case VIRTIO_BLK_T_IN:
> +    case VIRTIO_BLK_T_OUT:
> +        g_assert_cmpuint(data_size % 512, ==, 0);
> +        break;
> +    case VIRTIO_BLK_T_DISCARD:
> +    case VIRTIO_BLK_T_WRITE_ZEROES:
> +        g_assert_cmpuint(data_size %
> +                         sizeof(struct virtio_blk_discard_write_zeroes), ==, 0);
> +        break;
> +    default:
> +        g_assert_cmpuint(data_size, ==, 0);
> +    }
> +
> +    addr = guest_alloc(alloc, sizeof(*req) + data_size);
> +
> +    virtio_blk_fix_request(d, req);
> +
> +    memwrite(addr, req, 16);
> +    memwrite(addr + 16, req->data, data_size);
> +    memwrite(addr + 16 + data_size, &status, sizeof(status));
> +
> +    return addr;
> +}
> +
> +/* Returns the request virtqueue so the caller can perform further tests */
> +static QVirtQueue *test_basic(QVirtioDevice *dev, QGuestAllocator *alloc)
> +{
> +    QVirtioBlkReq req;
> +    uint64_t req_addr;
> +    uint64_t capacity;
> +    uint64_t features;
> +    uint32_t free_head;
> +    uint8_t status;
> +    char *data;
> +    QTestState *qts = global_qtest;
> +    QVirtQueue *vq;
> +
> +    features = qvirtio_get_features(dev);
> +    features = features & ~(QVIRTIO_F_BAD_FEATURE |
> +                    (1u << VIRTIO_RING_F_INDIRECT_DESC) |
> +                    (1u << VIRTIO_RING_F_EVENT_IDX) |
> +                    (1u << VIRTIO_BLK_F_SCSI));
> +    qvirtio_set_features(dev, features);
> +
> +    capacity = qvirtio_config_readq(dev, 0);
> +    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
> +
> +    vq = qvirtqueue_setup(dev, alloc, 0);
> +
> +    qvirtio_set_driver_ok(dev);
> +
> +    /* Write and read with 3 descriptor layout */
> +    /* Write request */
> +    req.type = VIRTIO_BLK_T_OUT;
> +    req.ioprio = 1;
> +    req.sector = 0;
> +    req.data = g_malloc0(512);
> +    strcpy(req.data, "TEST");
> +
> +    req_addr = virtio_blk_request(alloc, dev, &req, 512);
> +
> +    g_free(req.data);
> +
> +    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
> +    qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
> +    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
> +
> +    qvirtqueue_kick(qts, dev, vq, free_head);
> +
> +    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
> +                           QVIRTIO_BLK_TIMEOUT_US);
> +    status = readb(req_addr + 528);
> +    g_assert_cmpint(status, ==, 0);
> +
> +    guest_free(alloc, req_addr);
> +
> +    /* Read request */
> +    req.type = VIRTIO_BLK_T_IN;
> +    req.ioprio = 1;
> +    req.sector = 0;
> +    req.data = g_malloc0(512);
> +
> +    req_addr = virtio_blk_request(alloc, dev, &req, 512);
> +
> +    g_free(req.data);
> +
> +    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
> +    qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
> +    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
> +
> +    qvirtqueue_kick(qts, dev, vq, free_head);
> +
> +    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
> +                           QVIRTIO_BLK_TIMEOUT_US);
> +    status = readb(req_addr + 528);
> +    g_assert_cmpint(status, ==, 0);
> +
> +    data = g_malloc0(512);
> +    memread(req_addr + 16, data, 512);

Since you have a "qts" variable here anyway, could you please use 
qtest_memread(qts, ...) here instead? (also in the other spots where you 
use memread and memwrite if possible) ... in case we ever have to 
introduce multiple test states later, we then don't have to rewrite the 
code anymore.
(generally, it's nice to avoid libqtest-single.h nowadays and only use 
libqtest.h if possible)

[...]
> +static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
> +{
> +    QVirtQueue *vq;
> +    QVhostUserBlk *blk_if = obj;
> +    QVirtioDevice *dev = blk_if->vdev;
> +    QVirtioBlkReq req;
> +    QVRingIndirectDesc *indirect;
> +    uint64_t req_addr;
> +    uint64_t capacity;
> +    uint64_t features;
> +    uint32_t free_head;
> +    uint8_t status;
> +    char *data;
> +    QTestState *qts = global_qtest;
> +
> +    features = qvirtio_get_features(dev);
> +    g_assert_cmphex(features & (1u << VIRTIO_RING_F_INDIRECT_DESC), !=, 0);
> +    features = features & ~(QVIRTIO_F_BAD_FEATURE |
> +                            (1u << VIRTIO_RING_F_EVENT_IDX) |
> +                            (1u << VIRTIO_BLK_F_SCSI));
> +    qvirtio_set_features(dev, features);
> +
> +    capacity = qvirtio_config_readq(dev, 0);
> +    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
> +
> +    vq = qvirtqueue_setup(dev, t_alloc, 0);
> +    qvirtio_set_driver_ok(dev);
> +
> +    /* Write request */
> +    req.type = VIRTIO_BLK_T_OUT;
> +    req.ioprio = 1;
> +    req.sector = 0;
> +    req.data = g_malloc0(512);
> +    strcpy(req.data, "TEST");
> +
> +    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
> +
> +    g_free(req.data);
> +
> +    indirect = qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
> +    qvring_indirect_desc_add(dev, qts, indirect, req_addr, 528, false);
> +    qvring_indirect_desc_add(dev, qts, indirect, req_addr + 528, 1, true);
> +    free_head = qvirtqueue_add_indirect(qts, vq, indirect);
> +    qvirtqueue_kick(qts, dev, vq, free_head);
> +
> +    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
> +                           QVIRTIO_BLK_TIMEOUT_US);
> +    status = readb(req_addr + 528);
> +    g_assert_cmpint(status, ==, 0);
> +
> +    g_free(indirect);
> +    guest_free(t_alloc, req_addr);
> +
> +    /* Read request */
> +    req.type = VIRTIO_BLK_T_IN;
> +    req.ioprio = 1;
> +    req.sector = 0;
> +    req.data = g_malloc0(512);
> +    strcpy(req.data, "TEST");
> +
> +    req_addr = virtio_blk_request(t_alloc, dev, &req, 512);
> +
> +    g_free(req.data);
> +
> +    indirect = qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
> +    qvring_indirect_desc_add(dev, qts, indirect, req_addr, 16, false);
> +    qvring_indirect_desc_add(dev, qts, indirect, req_addr + 16, 513, true);
> +    free_head = qvirtqueue_add_indirect(qts, vq, indirect);
> +    qvirtqueue_kick(qts, dev, vq, free_head);
> +
> +    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
> +                           QVIRTIO_BLK_TIMEOUT_US);
> +    status = readb(req_addr + 528);
> +    g_assert_cmpint(status, ==, 0);
> +
> +    data = g_malloc0(512);
> +    memread(req_addr + 16, data, 512);
> +    g_assert_cmpstr(data, ==, "TEST");
> +    g_free(data);
> +
> +    g_free(indirect);
> +    guest_free(t_alloc, req_addr);
> +    qvirtqueue_cleanup(dev->bus, vq, t_alloc);
> +}
> +
> +

One empty line is enough.

[...]
> +static void drive_destroy(void *path)
> +{
> +    unlink(path);
> +    g_free(path);
> +    qos_invalidate_command_line();
> +}
> +
> +

dito.

[...]
> +static char *drive_create(void)
> +{
> +    int fd, ret;
> +    /** vhost-user-blk won't recognize drive located in /tmp */
> +    char *t_path = g_strdup("qtest.XXXXXX");
> +
> +    /** Create a temporary raw image */
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
> +static char sock_path_tempate[] = "/tmp/qtest.vhost_user_blk.XXXXXX";
> +static char qmp_sock_path_tempate[] = "/tmp/qtest.vhost_user_blk.qmp.XXXXXX";
> +
> +

dito.

> +static void quit_storage_daemon(void *qmp_test_state)
> +{
> +    qobject_unref(qtest_qmp((QTestState *)qmp_test_state, "{ 'execute': 'quit' }"));
> +    g_free(qmp_test_state);
> +}
> +
> +static char *start_vhost_user_blk(void)
> +{
> +    int fd, qmp_fd;
> +    char *sock_path = g_strdup(sock_path_tempate);
> +    char *qmp_sock_path = g_strdup(qmp_sock_path_tempate);
> +    QTestState *qmp_test_state;
> +    fd = mkstemp(sock_path);
> +    g_assert_cmpint(fd, >=, 0);
> +    g_test_queue_destroy(drive_destroy, sock_path);
> +
> +

dito.

> +    qmp_fd = mkstemp(qmp_sock_path);
> +    g_assert_cmpint(qmp_fd, >=, 0);
> +    g_test_queue_destroy(drive_destroy, qmp_sock_path);
> +
> +    /* create image file */
> +    const char *img_path = drive_create();
> +
> +    const char *vhost_user_blk_bin = qtest_qemu_storage_daemon_binary();
> +    gchar *command = g_strdup_printf(
> +            "exec %s "
> +            "--blockdev driver=file,node-name=disk,filename=%s "
> +            "--object vhost-user-blk-server,id=disk,unix-socket=%s,"
> +            "node-name=disk,writable=on "
> +            "--chardev socket,id=qmp,path=%s,server,nowait --monitor chardev=qmp",
> +            vhost_user_blk_bin, img_path, sock_path, qmp_sock_path);
> +
> +

dito.

> +    g_test_message("starting vhost-user backend: %s", command);
> +    pid_t pid = fork();
> +    if (pid == 0) {
> +        execlp("/bin/sh", "sh", "-c", command, NULL);
> +        exit(1);
> +    }
> +    g_free(command);
> +
> +    qmp_test_state = qtest_create_state_with_qmp_fd(
> +                             qtest_socket_client(qmp_sock_path));
> +    /*
> +     * Ask qemu-storage-daemon to quit so it
> +     * will not block scripts/tap-driver.pl.
> +     */
> +    g_test_queue_destroy(quit_storage_daemon, qmp_test_state);
> +
> +    qobject_unref(qtest_qmp(qmp_test_state,
> +                  "{ 'execute': 'qmp_capabilities' }"));
> +    return sock_path;
> +}
> +
> +

dito

> +static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
> +{
> +    char *sock_path1 = start_vhost_user_blk();
> +    g_string_append_printf(cmd_line,
> +                           " -object memory-backend-memfd,id=mem,size=128M,share=on -numa node,memdev=mem "
> +                           "-chardev socket,id=char1,path=%s ", sock_path1);
> +    return arg;
> +}
> +
> +

dito

> +/*
> + * Setup for hotplug.
> + *
> + * Since vhost-user server only serves one vhost-user client one time,
> + * another exprot
> + *
> + */
> +static void *vhost_user_blk_hotplug_test_setup(GString *cmd_line, void *arg)
> +{
> +    vhost_user_blk_test_setup(cmd_line, arg);
> +    char *sock_path2 = start_vhost_user_blk();
> +    /* "-chardev socket,id=char2" is used for pci_hotplug*/
> +    g_string_append_printf(cmd_line, "-chardev socket,id=char2,path=%s",
> +                           sock_path2);
> +    return arg;
> +}
> +
> +static void register_vhost_user_blk_test(void)
> +{
> +    QOSGraphTestOptions opts = {
> +        .before = vhost_user_blk_test_setup,
> +    };
> +
> +    /*
> +     * tests for vhost-user-blk and vhost-user-blk-pci
> +     * The tests are borrowed from tests/virtio-blk-test.c. But some tests
> +     * regarding block_resize don't work for vhost-user-blk.
> +     * vhost-user-blk device doesn't have -drive, so tests containing
> +     * block_resize are also abandoned,
> +     *  - config
> +     *  - resize
> +     */
> +    qos_add_test("basic", "vhost-user-blk", basic, &opts);
> +    qos_add_test("indirect", "vhost-user-blk", indirect, &opts);
> +    qos_add_test("idx", "vhost-user-blk-pci", idx, &opts);
> +    qos_add_test("nxvirtq", "vhost-user-blk-pci",
> +                 test_nonexistent_virtqueue, &opts);
> +
> +    opts.before = vhost_user_blk_hotplug_test_setup;
> +    qos_add_test("hotplug", "vhost-user-blk-pci", pci_hotplug, &opts);
> +}
> +
> +libqos_init(register_vhost_user_blk_test);
> 

  Thomas


