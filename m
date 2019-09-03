Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C4C3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E22321883
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E22321883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54ZY-0006wT-Ai
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1i54YP-00069R-6T
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1i54YK-00053X-KS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:52:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1i54YK-00053D-Cf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:52:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2431189DADE
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 08:52:38 +0000 (UTC)
Received: from [10.36.116.225] (ovpn-116-225.ams2.redhat.com [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B8A260C83;
 Tue,  3 Sep 2019 08:52:32 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190903061849.21493-1-thuth@redhat.com>
 <20190903061849.21493-4-thuth@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <519996c7-cfdc-4ab3-7805-f23b5df3d9a3@redhat.com>
Date: Tue, 3 Sep 2019 10:52:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903061849.21493-4-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 03 Sep 2019 08:52:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/libqos: Replace clock_step with
 qtest_clock_step in virtio code
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/2019 08:18, Thomas Huth wrote:
> Library functions should not rely on functions that require global_qtest
> (since they might get used in tests that deal with multiple states).
> Commit 1999a70a05ad603d ("Make generic virtio code independent from
> global_qtest") already tried to clean the libqos virtio code, but I
> missed to replace the clock_step() function. Thus change it now to
> qtest_clock_step() instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqos/virtio.c   | 15 ++++++++-------
>  tests/libqos/virtio.h   |  5 +++--
>  tests/virtio-blk-test.c |  8 +++++---
>  3 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
> index 91ce06954b..5a2ed7a1a5 100644
> --- a/tests/libqos/virtio.c
> +++ b/tests/libqos/virtio.c
> @@ -82,13 +82,13 @@ void qvirtio_set_driver_ok(QVirtioDevice *d)
>                      VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE);
>  }
>  
> -void qvirtio_wait_queue_isr(QVirtioDevice *d,
> +void qvirtio_wait_queue_isr(QTestState *qts, QVirtioDevice *d,
>                              QVirtQueue *vq, gint64 timeout_us)
>  {
>      gint64 start_time = g_get_monotonic_time();
>  
>      for (;;) {
> -        clock_step(100);
> +        qtest_clock_step(qts, 100);
>          if (d->bus->get_queue_isr_status(d, vq)) {
>              return;
>          }
> @@ -109,8 +109,8 @@ uint8_t qvirtio_wait_status_byte_no_isr(QTestState *qts, QVirtioDevice *d,
>      gint64 start_time = g_get_monotonic_time();
>      uint8_t val;
>  
> -    while ((val = readb(addr)) == 0xff) {
> -        clock_step(100);
> +    while ((val = qtest_readb(qts, addr)) == 0xff) {
> +        qtest_clock_step(qts, 100);
>          g_assert(!d->bus->get_queue_isr_status(d, vq));
>          g_assert(g_get_monotonic_time() - start_time <= timeout_us);
>      }
> @@ -137,7 +137,7 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
>      for (;;) {
>          uint32_t got_desc_idx;
>  
> -        clock_step(100);
> +        qtest_clock_step(qts, 100);
>  
>          if (d->bus->get_queue_isr_status(d, vq) &&
>              qvirtqueue_get_buf(qts, vq, &got_desc_idx, len)) {
> @@ -149,12 +149,13 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
>      }
>  }
>  
> -void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us)
> +void qvirtio_wait_config_isr(QTestState *qts, QVirtioDevice *d,
> +                             gint64 timeout_us)
>  {
>      gint64 start_time = g_get_monotonic_time();
>  
>      for (;;) {
> -        clock_step(100);
> +        qtest_clock_step(qts, 100);
>          if (d->bus->get_config_isr_status(d)) {
>              return;
>          }
> diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
> index 037176dbd8..1a93f9b1de 100644
> --- a/tests/libqos/virtio.h
> +++ b/tests/libqos/virtio.h
> @@ -112,7 +112,7 @@ void qvirtio_set_acknowledge(QVirtioDevice *d);
>  void qvirtio_set_driver(QVirtioDevice *d);
>  void qvirtio_set_driver_ok(QVirtioDevice *d);
>  
> -void qvirtio_wait_queue_isr(QVirtioDevice *d,
> +void qvirtio_wait_queue_isr(QTestState *qts, QVirtioDevice *d,
>                              QVirtQueue *vq, gint64 timeout_us);
>  uint8_t qvirtio_wait_status_byte_no_isr(QTestState *qts, QVirtioDevice *d,
>                                          QVirtQueue *vq,
> @@ -123,7 +123,8 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
>                              uint32_t desc_idx,
>                              uint32_t *len,
>                              gint64 timeout_us);
> -void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us);
> +void qvirtio_wait_config_isr(QTestState *qts, QVirtioDevice *d,
> +                             gint64 timeout_us);
>  QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
>                               QGuestAllocator *alloc, uint16_t index);
>  void qvirtqueue_cleanup(const QVirtioBus *bus, QVirtQueue *vq,
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index 982ff1538c..247fef0b0f 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -435,6 +435,7 @@ static void config(void *obj, void *data, QGuestAllocator *t_alloc)
>      QVirtioDevice *dev = blk_if->vdev;
>      int n_size = TEST_IMAGE_SIZE / 2;
>      uint64_t capacity;
> +    QTestState *qts = global_qtest;
>  
>      capacity = qvirtio_config_readq(dev, 0);
>      g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
> @@ -444,7 +445,7 @@ static void config(void *obj, void *data, QGuestAllocator *t_alloc)
>      qmp_discard_response("{ 'execute': 'block_resize', "
>                           " 'arguments': { 'device': 'drive0', "
>                           " 'size': %d } }", n_size);
> -    qvirtio_wait_config_isr(dev, QVIRTIO_BLK_TIMEOUT_US);
> +    qvirtio_wait_config_isr(qts, dev, QVIRTIO_BLK_TIMEOUT_US);

qvirtio_wait_config_isr() calls get_config_isr_status() that will
extract qts from PCI bus or MMIO structure. I think you should not add a
parameter here and move all the stuff to
qvirtio_mmio_get_config_isr_status() and
qvirtio_pci_get_config_isr_status().

Thanks,
Laurent

