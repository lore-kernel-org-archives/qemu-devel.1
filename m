Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5654C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC232072D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXLHQRRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC232072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ7FZ-0008Ii-PS
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJ7Ez-0007uC-AW
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJ7Ex-00087x-A8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:07:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJ7Ex-00087a-4n
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585624018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BA/dIZWbBaKQirZdCjXZYuDyEDSYk0rlCZ4hfDM4zfI=;
 b=PXLHQRRrk+T0C4mYKhb343g3FgzJs/VRRewmKukCHXyAZojPLelAXwe+52kfk8FQvvJFKE
 1+1KLYqHkS0uX+WzK9iG5jQX6+0H+JL+k2ESTBTAsPncU6PyrlOD2UVyfxaLvGP2fuojmd
 hifRWVFEzAZD8AImY7aSYzaLdqzFERA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428--mS8Yl9HOSO97Zc5dFl30g-1; Mon, 30 Mar 2020 23:06:56 -0400
X-MC-Unique: -mS8Yl9HOSO97Zc5dFl30g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100FB13F7;
 Tue, 31 Mar 2020 03:06:55 +0000 (UTC)
Received: from [10.72.12.115] (ovpn-12-115.pek2.redhat.com [10.72.12.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E5AB60BEC;
 Tue, 31 Mar 2020 03:06:52 +0000 (UTC)
Subject: Re: [PATCH v2] qtest: add tulip test case
To: Li Qiang <liq3ea@163.com>, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20200330145201.32534-1-liq3ea@163.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <44204bf9-0048-026c-192e-7ed5bf338b36@redhat.com>
Date: Tue, 31 Mar 2020 11:06:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200330145201.32534-1-liq3ea@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/30 =E4=B8=8B=E5=8D=8810:52, Li Qiang wrote:
> The tulip networking card emulation has an OOB issue in
> 'tulip_copy_tx_buffers' when the guest provide malformed descriptor.
> This test will trigger a ASAN heap overflow crash. To trigger this
> issue we can construct the data as following:
>
> 1. construct a 'tulip_descriptor'. Its control is set to
> '0x7ff | 0x7ff << 11', this will make the 'tulip_copy_tx_buffers's
> 'len1' and 'len2' to 0x7ff(2047). So 'len1+len2' will overflow
> 'TULIPState's 'tx_frame' field. This descriptor's 'buf_addr1' and
> 'buf_addr2' should set to a guest address.
>
> 2. write this descriptor to tulip device's CSR4 register. This will
> set the 'TULIPState's 'current_tx_desc' field.
>
> 3. write 'CSR6_ST' to tulip device's CSR6 register. This will trigger
> 'tulip_xmit_list_update' and finally calls 'tulip_copy_tx_buffers'.
>
> Following shows the backtrack of crash:
>
> =3D=3D31781=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x628000007cd0 at pc 0x7fe03c5a077a bp 0x7fff05b46770 sp 0x7fff05b45f18
> WRITE of size 2047 at 0x628000007cd0 thread T0
>      #0 0x7fe03c5a0779  (/usr/lib/x86_64-linux-gnu/libasan.so.4+0x79779)
>      #1 0x5575fb6daa6a in flatview_read_continue /home/test/qemu/exec.c:3=
194
>      #2 0x5575fb6daccb in flatview_read /home/test/qemu/exec.c:3227
>      #3 0x5575fb6dae66 in address_space_read_full /home/test/qemu/exec.c:=
3240
>      #4 0x5575fb6db0cb in address_space_rw /home/test/qemu/exec.c:3268
>      #5 0x5575fbdfd460 in dma_memory_rw_relaxed /home/test/qemu/include/s=
ysemu/dma.h:87
>      #6 0x5575fbdfd4b5 in dma_memory_rw /home/test/qemu/include/sysemu/dm=
a.h:110
>      #7 0x5575fbdfd866 in pci_dma_rw /home/test/qemu/include/hw/pci/pci.h=
:787
>      #8 0x5575fbdfd8a3 in pci_dma_read /home/test/qemu/include/hw/pci/pci=
.h:794
>      #9 0x5575fbe02761 in tulip_copy_tx_buffers hw/net/tulip.c:585
>      #10 0x5575fbe0366b in tulip_xmit_list_update hw/net/tulip.c:678
>      #11 0x5575fbe04073 in tulip_write hw/net/tulip.c:783
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Change since v1:
>
> Add detail descriptor construction to trigger the crash.
> Use CSR6_ST to replace the magic value.


Applied.

Thanks


>
>   tests/qtest/Makefile.include |  1 +
>   tests/qtest/tulip-test.c     | 91 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 92 insertions(+)
>   create mode 100644 tests/qtest/tulip-test.c
>
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index 10a28de8a3..9e5a51d033 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -217,6 +217,7 @@ qos-test-obj-y +=3D tests/qtest/es1370-test.o
>   qos-test-obj-y +=3D tests/qtest/ipoctal232-test.o
>   qos-test-obj-y +=3D tests/qtest/megasas-test.o
>   qos-test-obj-y +=3D tests/qtest/ne2000-test.o
> +qos-test-obj-y +=3D tests/qtest/tulip-test.o
>   qos-test-obj-y +=3D tests/qtest/nvme-test.o
>   qos-test-obj-y +=3D tests/qtest/pca9552-test.o
>   qos-test-obj-y +=3D tests/qtest/pci-test.o
> diff --git a/tests/qtest/tulip-test.c b/tests/qtest/tulip-test.c
> new file mode 100644
> index 0000000000..2fb6c4d5a7
> --- /dev/null
> +++ b/tests/qtest/tulip-test.c
> @@ -0,0 +1,91 @@
> +/*
> + * QTest testcase for DEC/Intel Tulip 21143
> + *
> + * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qemu/module.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/pci.h"
> +#include "qemu/bitops.h"
> +#include "hw/net/tulip.h"
> +
> +typedef struct QTulip_pci QTulip_pci;
> +
> +struct QTulip_pci {
> +    QOSGraphObject obj;
> +    QPCIDevice dev;
> +};
> +
> +static void *tulip_pci_get_driver(void *obj, const char *interface)
> +{
> +    QTulip_pci *tulip_pci =3D obj;
> +
> +    if (!g_strcmp0(interface, "pci-device")) {
> +        return &tulip_pci->dev;
> +    }
> +
> +    fprintf(stderr, "%s not present in tulip_pci\n", interface);
> +    g_assert_not_reached();
> +}
> +
> +static void *tulip_pci_create(void *pci_bus, QGuestAllocator *alloc, voi=
d *addr)
> +{
> +    QTulip_pci *tulip_pci =3D g_new0(QTulip_pci, 1);
> +    QPCIBus *bus =3D pci_bus;
> +
> +    qpci_device_init(&tulip_pci->dev, bus, addr);
> +    tulip_pci->obj.get_driver =3D tulip_pci_get_driver;
> +
> +    return &tulip_pci->obj;
> +}
> +
> +static void tulip_large_tx(void *obj, void *data, QGuestAllocator *alloc=
)
> +{
> +    QTulip_pci *tulip_pci =3D obj;
> +    QPCIDevice *dev =3D &tulip_pci->dev;
> +    QPCIBar bar;
> +    struct tulip_descriptor context;
> +    char guest_data[4096];
> +    uint64_t context_pa;
> +    uint64_t guest_pa;
> +
> +    qpci_device_enable(dev);
> +    bar =3D qpci_iomap(dev, 0, NULL);
> +    context_pa =3D guest_alloc(alloc, sizeof(context));
> +    guest_pa =3D guest_alloc(alloc, 4096);
> +    memset(guest_data, 'A', sizeof(guest_data));
> +    context.status =3D TDES0_OWN;
> +    context.control =3D TDES1_BUF2_SIZE_MASK << TDES1_BUF2_SIZE_SHIFT |
> +                      TDES1_BUF1_SIZE_MASK << TDES1_BUF1_SIZE_SHIFT;
> +    context.buf_addr2 =3D guest_pa;
> +    context.buf_addr1 =3D guest_pa;
> +
> +    qtest_memwrite(dev->bus->qts, context_pa, &context, sizeof(context))=
;
> +    qtest_memwrite(dev->bus->qts, guest_pa, guest_data, sizeof(guest_dat=
a));
> +    qpci_io_writel(dev, bar, 0x20, context_pa);
> +    qpci_io_writel(dev, bar, 0x30, CSR6_ST);
> +    guest_free(alloc, context_pa);
> +    guest_free(alloc, guest_pa);
> +}
> +
> +static void tulip_register_nodes(void)
> +{
> +    QOSGraphEdgeOptions opts =3D {
> +        .extra_device_opts =3D "addr=3D04.0",
> +    };
> +    add_qpci_address(&opts, &(QPCIAddress) { .devfn =3D QPCI_DEVFN(4, 0)=
 });
> +
> +    qos_node_create_driver("tulip", tulip_pci_create);
> +    qos_node_consumes("tulip", "pci-bus", &opts);
> +    qos_node_produces("tulip", "pci-device");
> +
> +    qos_add_test("tulip_large_tx", "tulip", tulip_large_tx, NULL);
> +}
> +
> +libqos_init(tulip_register_nodes);


