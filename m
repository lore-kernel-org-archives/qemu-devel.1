Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48989C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3103207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNidaUru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3103207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSi5J-0002gZ-Lv
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iSi3g-0001ON-H8
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iSi3d-0000EH-Jk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:42:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41294
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iSi3d-0000DA-G0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573134159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G44jTQvZo8to1CPoYz9m+ZnVx4ct6/TZaQ0+QasfHtc=;
 b=dNidaUruxxuU5dm3kNIAOt09yhrkYQDVDS5Ryr+/ArfFnxqWMwkqS3U+uOCwEtOjfa7gZn
 GaJhbSGp7SrSG6eZ+sH9eC85HT7tpyl8kEPommPn+kiumXBlDR7m/bIZ9nRUC1niC0loo9
 c1fl4w5wy0iHSYjhLcM3UhOUNZAxc6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-XmF0O_slOw6ENDXCq_LNvA-1; Thu, 07 Nov 2019 08:42:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C3FB107ACC3;
 Thu,  7 Nov 2019 13:42:36 +0000 (UTC)
Received: from [10.72.12.21] (ovpn-12-21.pek2.redhat.com [10.72.12.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2541860BFB;
 Thu,  7 Nov 2019 13:42:34 +0000 (UTC)
Subject: Re: [PATCH v4 19/20] fuzz: add virtio-net fuzz target
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-20-alxndr@bu.edu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <66465e73-d009-ec62-58dd-279bfac6894c@redhat.com>
Date: Thu, 7 Nov 2019 21:42:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191030144926.11873-20-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XmF0O_slOw6ENDXCq_LNvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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


On 2019/10/30 =E4=B8=8B=E5=8D=8810:50, Oleinik, Alexander wrote:
> From: Alexander Oleinik <alxndr@bu.edu>
>
> The virtio-net fuzz target feeds inputs to all three virtio-net
> virtqueues, and uses forking to avoid leaking state between fuzz runs.
>
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>


Can this fuzz vhost-net or vhost-user (I only see socket backend)? If=20
it's not too hard, it would be even more interesting.

Thanks


> ---
>   tests/fuzz/Makefile.include  |   1 +
>   tests/fuzz/virtio_net_fuzz.c | 123 +++++++++++++++++++++++++++++++++++
>   2 files changed, 124 insertions(+)
>   create mode 100644 tests/fuzz/virtio_net_fuzz.c
>
> diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
> index 37d6821bee..f1d9b46b1c 100644
> --- a/tests/fuzz/Makefile.include
> +++ b/tests/fuzz/Makefile.include
> @@ -6,5 +6,6 @@ fuzz-obj-y +=3D tests/fuzz/fork_fuzz.o
>   fuzz-obj-y +=3D tests/fuzz/qos_fuzz.o
>  =20
>   fuzz-obj-y +=3D tests/fuzz/i440fx_fuzz.o
> +fuzz-obj-y +=3D tests/fuzz/virtio_net_fuzz.o
>  =20
>   FUZZ_LDFLAGS +=3D -Xlinker -T$(SRC_PATH)/tests/fuzz/fork_fuzz.ld
> diff --git a/tests/fuzz/virtio_net_fuzz.c b/tests/fuzz/virtio_net_fuzz.c
> new file mode 100644
> index 0000000000..0543cfd32a
> --- /dev/null
> +++ b/tests/fuzz/virtio_net_fuzz.c
> @@ -0,0 +1,123 @@
> +/*
> + * virtio-net Fuzzing Target
> + *
> + * Copyright Red Hat Inc., 2019
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "fuzz.h"
> +#include "fork_fuzz.h"
> +#include "qos_fuzz.h"
> +#include "tests/libqtest.h"
> +#include "tests/libqos/virtio-net.h"
> +
> +
> +static void virtio_net_fuzz_multi(QTestState *s,
> +        const unsigned char *Data, size_t Size)
> +{
> +    typedef struct vq_action {
> +        uint8_t queue;
> +        uint8_t length;
> +        uint8_t write;
> +        uint8_t next;
> +        bool kick;
> +    } vq_action;
> +
> +    uint64_t req_addr[10];
> +    int reqi =3D 0;
> +    uint32_t free_head =3D 0;
> +
> +    QGuestAllocator *t_alloc =3D fuzz_qos_alloc;
> +
> +    QVirtioNet *net_if =3D fuzz_qos_obj;
> +    QVirtioDevice *dev =3D net_if->vdev;
> +    QVirtQueue *q;
> +    vq_action vqa;
> +    int iters =3D 0;
> +    while (true) {
> +        if (Size < sizeof(vqa)) {
> +            break;
> +        }
> +        memcpy(&vqa, Data, sizeof(vqa));
> +        vqa =3D *((vq_action *)Data);
> +        Data +=3D sizeof(vqa);
> +        Size -=3D sizeof(vqa);
> +
> +        q =3D net_if->queues[vqa.queue % 3];
> +
> +        vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
> +
> +        req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
> +        qtest_memwrite(s, req_addr[reqi], Data, vqa.length);
> +        if (iters =3D=3D 0) {
> +            free_head =3D qvirtqueue_add(s, q, req_addr[reqi], vqa.lengt=
h,
> +                    vqa.write, vqa.next);
> +        } else {
> +            qvirtqueue_add(s, q,
> +                    req_addr[reqi], vqa.length, vqa.write , vqa.next);
> +        }
> +        iters++;
> +        reqi++;
> +        if (iters =3D=3D 10) {
> +            break;
> +        }
> +        Data +=3D vqa.length;
> +        Size -=3D vqa.length;
> +    }
> +    if (iters) {
> +        qvirtqueue_kick(s, dev, q, free_head);
> +        qtest_clock_step_next(s);
> +        for (int i =3D 0; i < reqi; i++) {
> +            guest_free(t_alloc, req_addr[i]);
> +        }
> +    }
> +}
> +
> +static int *sv;
> +
> +static void *virtio_net_test_setup_socket(GString *cmd_line, void *arg)
> +{
> +    if (!sv) {
> +        sv =3D g_new(int, 2);
> +        int ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
> +        fcntl(sv[0], F_SETFL, O_NONBLOCK);
> +        g_assert_cmpint(ret, !=3D, -1);
> +    }
> +    g_string_append_printf(cmd_line, " -netdev socket,fd=3D%d,id=3Dhs0 "=
, sv[1]);
> +    return arg;
> +}
> +
> +static void virtio_net_fork_fuzz(QTestState *s,
> +        const unsigned char *Data, size_t Size)
> +{
> +    if (fork() =3D=3D 0) {
> +        virtio_net_fuzz_multi(s, Data, Size);
> +        flush_events(s);
> +        _Exit(0);
> +    } else {
> +        wait(NULL);
> +    }
> +}
> +
> +static void register_virtio_net_fuzz_targets(void)
> +{
> +    fuzz_add_qos_target(&(FuzzTarget){
> +                .name =3D "virtio-net-fork-fuzz",
> +                .description =3D "Fuzz the virtio-net virtual queues, fo=
rking"
> +                                "for each fuzz run",
> +                .pre_vm_init =3D &counter_shm_init,
> +                .pre_fuzz =3D &qos_init_path,
> +                .fuzz =3D virtio_net_fork_fuzz,},
> +                "virtio-net",
> +                &(QOSGraphTestOptions){.before =3D virtio_net_test_setup=
_socket}
> +                );
> +}
> +
> +fuzz_target_init(register_virtio_net_fuzz_targets);


