Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCDC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45A720786
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45A720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagLi-0002Bi-NZ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kagKt-0001jk-2o
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:33:59 -0500
Received: from 9.mo51.mail-out.ovh.net ([46.105.48.137]:41731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kagKq-00062y-Nx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:33:58 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.158])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 6BB3923434A;
 Thu,  5 Nov 2020 15:33:53 +0100 (CET)
Received: from kaod.org (37.59.142.99) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 5 Nov 2020
 15:33:47 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003f4e5f242-09f6-416d-a3fa-c6d85f1897a3,
 5D04B6D4EAACA18D9EDEF493C42F41A1D3896549) smtp.auth=groug@kaod.org
Date: Thu, 5 Nov 2020 15:33:46 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-6.0 2/3] hw/virtio: Build most of virtio devices as
 arch-independent objects
Message-ID: <20201105153346.11586e80@bahia.lan>
In-Reply-To: <20201105124353.3680057-3-philmd@redhat.com>
References: <20201105124353.3680057-1-philmd@redhat.com>
 <20201105124353.3680057-3-philmd@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 643cfeb2-4b98-4184-a4da-666681a56857
X-Ovh-Tracer-Id: 958140824974170381
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehsthgvfhgrnhhhrgesghhmrghilhdrtghomh
Received-SPF: pass client-ip=46.105.48.137; envelope-from=groug@kaod.org;
 helo=9.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 09:33:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Nov 2020 13:43:52 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> VirtIO devices shouldn't be arch-specific. Some device have to
> use PAGE_SIZE definition or access to CPUState. Keep building
> them as arch-specific objects. Move all we can to libcommon.fa.
>=20

This patch breaks build:

$ ./configure && make
...

[890/2578] Compiling C object libcommon.fa.p/hw_virtio_virtio-mem.c.o
FAILED: libcommon.fa.p/hw_virtio_virtio-mem.c.o=20
cc -Ilibcommon.fa.p -I. -I.. -I../slirp -I../slirp/src -Iqapi -Itrace -Iui =
-Iui/shader -I/usr/include/SDL2 -I/usr/include/pixman-1 -I/usr/include/libp=
ng16 -I/usr/include/capstone -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/=
include -fdiagnostics-color=3Dauto -pipe -Wall -Winvalid-pch -Werror -std=
=3Dgnu99 -O2 -g -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -m64 -mcx16 -D_GNU_=
SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wr=
edundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-ali=
asing -fno-common -fwrapv -Wold-style-declaration -Wold-style-definition -W=
type-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers=
 -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-m=
issing-include-dirs -Wno-shift-negative-value -Wno-psabi -fstack-protector-=
strong -isystem /var/tmp/qemu/linux-headers -isystem linux-headers -iquote =
/var/tmp/qemu/tcg/i386 -iquote . -iquote /var/tmp/qemu -iquote /var/tmp/qem=
u/accel/tcg -iquote /var/tmp/qemu/include -iquote /var/tmp/qemu/disas/libvi=
xl -pthread -fPIC -D_REENTRANT -Wno-undef -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=
=3D600 -DNCURSES_WIDECHAR -MD -MQ libcommon.fa.p/hw_virtio_virtio-mem.c.o -=
MF libcommon.fa.p/hw_virtio_virtio-mem.c.o.d -o libcommon.fa.p/hw_virtio_vi=
rtio-mem.c.o -c ../hw/virtio/virtio-mem.c
In file included from ../hw/virtio/virtio-mem.c:28:
/var/tmp/qemu/include/exec/ram_addr.h:23:10: fatal error: cpu.h: No such fi=
le or directory
   23 | #include "cpu.h"
      |          ^~~~~~~
compilation terminated.

Unless I'm missing something legacy devices require to be built according
to the target because of the endianess.

> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/9pfs/meson.build            |  2 +-
>  hw/block/dataplane/meson.build |  2 +-
>  hw/block/meson.build           |  2 +-
>  hw/char/meson.build            |  2 +-
>  hw/net/meson.build             |  2 +-
>  hw/scsi/meson.build            |  2 +-
>  hw/virtio/meson.build          | 15 +++++++++------
>  7 files changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
> index cc094262122..ac964be15ce 100644
> --- a/hw/9pfs/meson.build
> +++ b/hw/9pfs/meson.build
> @@ -17,4 +17,4 @@
>  fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
>  softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
> =20
> -specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-devi=
ce.c'))
> +softmmu_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-devic=
e.c'))
> diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.bu=
ild
> index 12c6a264f10..e2f3721ce24 100644
> --- a/hw/block/dataplane/meson.build
> +++ b/hw/block/dataplane/meson.build
> @@ -1,2 +1,2 @@
> -specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'=
))
> +softmmu_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
>  specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
> diff --git a/hw/block/meson.build b/hw/block/meson.build
> index 602ca6c8541..497592c33ac 100644
> --- a/hw/block/meson.build
> +++ b/hw/block/meson.build
> @@ -15,7 +15,7 @@
>  softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('tc58128.c'))
>  softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('nvme.c', 'nvme-n=
s.c'))
> =20
> -specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'=
))
> +softmmu_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
>  specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-use=
r-blk.c'))
> =20
>  subdir('dataplane')
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index 196ac91fa29..7496594ea07 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -37,5 +37,5 @@
> =20
>  specific_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
>  specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal327=
0.c'))
> -specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus=
.c'))
> +softmmu_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.=
c'))
>  specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
> diff --git a/hw/net/meson.build b/hw/net/meson.build
> index 4a7051b54a0..c795af23eee 100644
> --- a/hw/net/meson.build
> +++ b/hw/net/meson.build
> @@ -43,7 +43,7 @@
>  specific_ss.add(when: 'CONFIG_XILINX_ETHLITE', if_true: files('xilinx_et=
hlite.c'))
> =20
>  softmmu_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('net_rx_pkt.c'))
> -specific_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'=
))
> +softmmu_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
> =20
>  softmmu_ss.add(when: ['CONFIG_VIRTIO_NET', 'CONFIG_VHOST_NET'], if_true:=
 files('vhost_net.c'), if_false: files('vhost_net-stub.c'))
>  softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost_net-stub.c'))
> diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
> index 923a34f344c..fdf27156f6a 100644
> --- a/hw/scsi/meson.build
> +++ b/hw/scsi/meson.build
> @@ -19,7 +19,7 @@
>  virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
>  virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi=
-common.c', 'vhost-scsi.c'))
>  virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost=
-scsi-common.c', 'vhost-user-scsi.c'))
> -specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scs=
i_ss)
> +softmmu_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
> =20
>  specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_v=
scsi.c'))
> =20
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 95415913a9a..40df99f1a48 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -9,12 +9,15 @@
> =20
>  softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
> =20
> +virtio_arch_ss =3D ss.source_set()
> +virtio_arch_ss.add(files('virtio.c'))
> +virtio_arch_ss.add(when: 'CONFIG_VIRTIO_LEGACY', if_true: files('virtio-=
legacy.c'))
> +virtio_arch_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user=
.c'))
> +virtio_arch_ss.add(when: 'CONFIG_VHOST_VDPA', if_true: files('vhost-vdpa=
.c'))
> +virtio_arch_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-i=
ommu.c'))
> +
>  virtio_ss =3D ss.source_set()
> -virtio_ss.add(files('virtio.c'))
> -virtio_ss.add(when: 'CONFIG_VIRTIO_LEGACY', if_true: files('virtio-legac=
y.c'))
>  virtio_ss.add(when: 'CONFIG_VHOST', if_true: files('vhost.c', 'vhost-bac=
kend.c'))
> -virtio_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user.c'))
> -virtio_ss.add(when: 'CONFIG_VHOST_VDPA', if_true: files('vhost-vdpa.c'))
>  virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-ball=
oon.c'))
>  virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypt=
o.c'))
>  virtio_ss.add(when: ['CONFIG_VIRTIO_CRYPTO', 'CONFIG_VIRTIO_PCI'], if_tr=
ue: files('virtio-crypto-pci.c'))
> @@ -24,7 +27,6 @@
>  virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'=
, 'vhost-vsock-common.c'))
>  virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-use=
r-vsock.c', 'vhost-vsock-common.c'))
>  virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
> -virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.=
c'))
>  virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
> =20
>  virtio_pci_ss =3D ss.source_set()
> @@ -49,4 +51,5 @@
> =20
>  virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
> =20
> -specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_ss)
> +softmmu_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_ss)
> +specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_arch_ss)


