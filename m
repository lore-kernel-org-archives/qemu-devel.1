Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1447C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 04:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52411206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 04:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2Id2mQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52411206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqUHP-0008TH-Ju
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 00:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqUG8-0007OU-RE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 00:22:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqUG4-0000GG-Kp
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 00:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593577322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZPdKBLfZu9VVhXT6izCEiYLbpiYTy2/oPEe3MBHVIU=;
 b=S2Id2mQwOlDbChFOYNVvIeeOMroS9YGevdmBTLBY0lLcV2RVUYaY03tYygRo0CvhZlEQIP
 1lI64PBDHcV+N53Fi0E1yj3jUF70tbLGLAG9u7NVysyZaVnNJ73XWpSxOnJtpWUXbKnAv0
 VopajoE6IbiKK/vm0c2tG+g1KAYsjMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-RJc_hmF6P4WdGuVOtlFYMw-1; Wed, 01 Jul 2020 00:22:01 -0400
X-MC-Unique: RJc_hmF6P4WdGuVOtlFYMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C21FEC1A1;
 Wed,  1 Jul 2020 04:21:58 +0000 (UTC)
Received: from [10.72.13.177] (ovpn-13-177.pek2.redhat.com [10.72.13.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8A4A7BFEA;
 Wed,  1 Jul 2020 04:21:40 +0000 (UTC)
Subject: Re: [PATCH v2 11/12] vhost-vdpa: introduce vhost-vdpa backend
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200630174937.25560-1-lulu@redhat.com>
 <20200630174937.25560-12-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <88395b35-1053-f470-0031-1b7b89dcc6b8@redhat.com>
Date: Wed, 1 Jul 2020 12:21:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630174937.25560-12-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, Tiwei Bie <tiwei.bie@intel.com>,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/1 上午1:49, Cindy Lu wrote:
> Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> vhost-user. The above patch provides a generic device for vDPA purpose,
> this vDPA device exposes to user space a non-vendor-specific configuration
> interface for setting up a vhost HW accelerator, this patch set introduces
> a third vhost backend called vhost-vdpa based on the vDPA interface.
>
> Vhost-vdpa usage:
>
> qemu-system-x86_64 -cpu host -enable-kvm \
>      ......
>      -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-vdpa0 \
>      -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \
>
> Signed-off-by: Lingshan zhu <lingshan.zhu@intel.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>


I would like to add my sob here.


> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   configure                         |  21 ++
>   docs/interop/index.rst            |   1 +
>   docs/interop/vhost-vdpa.rst       |  17 ++
>   hw/net/vhost_net.c                |  19 +-
>   hw/net/virtio-net.c               |  22 +-
>   hw/virtio/Makefile.objs           |   1 +
>   hw/virtio/vhost-backend.c         |   7 +-
>   hw/virtio/vhost-vdpa.c            | 469 ++++++++++++++++++++++++++++++
>   hw/virtio/vhost.c                 |   7 +-
>   include/hw/virtio/vhost-backend.h |   4 +-
>   include/hw/virtio/vhost-vdpa.h    |  26 ++
>   include/hw/virtio/vhost.h         |   7 +
>   qemu-options.hx                   |  12 +
>   13 files changed, 601 insertions(+), 12 deletions(-)
>   create mode 100644 docs/interop/vhost-vdpa.rst
>   create mode 100644 hw/virtio/vhost-vdpa.c
>   create mode 100644 include/hw/virtio/vhost-vdpa.h
>
> diff --git a/configure b/configure
> index 4a22dcd563..3db7f20185 100755
> --- a/configure
> +++ b/configure
> @@ -1575,6 +1575,10 @@ for opt do
>     ;;
>     --enable-vhost-user) vhost_user="yes"
>     ;;
> +  --disable-vhost-vdpa) vhost_vdpa="no"
> +  ;;
> +  --enable-vhost-vdpa) vhost_vdpa="yes"
> +  ;;
>     --disable-vhost-kernel) vhost_kernel="no"
>     ;;
>     --enable-vhost-kernel) vhost_kernel="yes"
> @@ -1883,6 +1887,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>     vhost-crypto    vhost-user-crypto backend support
>     vhost-kernel    vhost kernel backend support
>     vhost-user      vhost-user backend support
> +  vhost-vdpa      vhost-vdpa kernel backend support
>     spice           spice
>     rbd             rados block device (rbd)
>     libiscsi        iscsi support
> @@ -2394,6 +2399,10 @@ test "$vhost_user" = "" && vhost_user=yes
>   if test "$vhost_user" = "yes" && test "$mingw32" = "yes"; then
>     error_exit "vhost-user isn't available on win32"
>   fi
> +test "$vhost_vdpa" = "" && vhost_vdpa=$linux
> +if test "$vhost_vdpa" = "yes" && test "$linux" != "yes"; then
> +  error_exit "vhost-vdpa is only available on Linux"
> +fi
>   test "$vhost_kernel" = "" && vhost_kernel=$linux
>   if test "$vhost_kernel" = "yes" && test "$linux" != "yes"; then
>     error_exit "vhost-kernel is only available on Linux"
> @@ -2422,6 +2431,11 @@ test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
>   if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
>     error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
>   fi
> +#vhost-vdpa backends
> +test "$vhost_net_vdpa" = "" && vhost_net_vdpa=$vhost_vdpa
> +if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
> +  error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
> +fi
>   
>   # OR the vhost-kernel and vhost-user values for simplicity
>   if test "$vhost_net" = ""; then
> @@ -6936,6 +6950,7 @@ echo "vhost-scsi support $vhost_scsi"
>   echo "vhost-vsock support $vhost_vsock"
>   echo "vhost-user support $vhost_user"
>   echo "vhost-user-fs support $vhost_user_fs"
> +echo "vhost-vdpa support $vhost_vdpa"
>   echo "Trace backends    $trace_backends"
>   if have_backend "simple"; then
>   echo "Trace output file $trace_file-<pid>"
> @@ -7437,6 +7452,9 @@ fi
>   if test "$vhost_net_user" = "yes" ; then
>     echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
>   fi
> +if test "$vhost_net_vdpa" = "yes" ; then
> +  echo "CONFIG_VHOST_NET_VDPA=y" >> $config_host_mak
> +fi
>   if test "$vhost_crypto" = "yes" ; then
>     echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
>   fi
> @@ -7452,6 +7470,9 @@ fi
>   if test "$vhost_user" = "yes" ; then
>     echo "CONFIG_VHOST_USER=y" >> $config_host_mak
>   fi
> +if test "$vhost_vdpa" = "yes" ; then
> +  echo "CONFIG_VHOST_VDPA=y" >> $config_host_mak
> +fi
>   if test "$vhost_user_fs" = "yes" ; then
>     echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
>   fi
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index 049387ac6d..006f986420 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -20,3 +20,4 @@ Contents:
>      qemu-ga
>      vhost-user
>      vhost-user-gpu
> +   vhost-vdpa
> diff --git a/docs/interop/vhost-vdpa.rst b/docs/interop/vhost-vdpa.rst
> new file mode 100644
> index 0000000000..5a075b8a63
> --- /dev/null
> +++ b/docs/interop/vhost-vdpa.rst
> @@ -0,0 +1,17 @@
> +=====================
> +Vhost-vdpa Protocol
> +=====================
> +
> +Introduction
> +=============
> +vDPA(Virtual data path acceleration) device is a device that uses
> +a datapath which complies with the virtio specifications with vendor
> +specific control path. vDPA devices can be both physically located on
> +the hardware or emulated by software.
> +
> +This document describes the vDPA support in qemu
> +
> +Here is the kernel commit here
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c8cf31885f69e86be0b5b9e6677a26797365e1d
> +
> +TODO : Moreinfo will add later
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 4096d64aaf..cbdf42ace5 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -17,8 +17,10 @@
>   #include "net/net.h"
>   #include "net/tap.h"
>   #include "net/vhost-user.h"
> +#include "net/vhost-vdpa.h"
>   
>   #include "standard-headers/linux/vhost_types.h"
> +#include "linux-headers/linux/vhost.h"
>   #include "hw/virtio/virtio-net.h"
>   #include "net/vhost_net.h"
>   #include "qemu/error-report.h"
> @@ -33,12 +35,6 @@
>   #include "hw/virtio/vhost.h"
>   #include "hw/virtio/virtio-bus.h"
>   
> -struct vhost_net {
> -    struct vhost_dev dev;
> -    struct vhost_virtqueue vqs[2];
> -    int backend;
> -    NetClientState *nc;
> -};
>   
>   /* Features supported by host kernel. */
>   static const int kernel_feature_bits[] = {
> @@ -96,6 +92,9 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
>       case NET_CLIENT_DRIVER_VHOST_USER:
>           feature_bits = user_feature_bits;
>           break;
> +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> +        feature_bits = vdpa_feature_bits;
> +        break;
>       default:
>           error_report("Feature bits not defined for this type: %d",
>                   net->nc->info->type);
> @@ -316,7 +315,6 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>       }
>   
>       for (i = 0; i < total_queues; i++) {
> -


Unnecessary change.


>           peer = qemu_get_peer(ncs, i);
>           net = get_vhost_net(peer);
>           vhost_net_set_vq_index(net, i * 2);
> @@ -337,6 +335,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>       }
>   
>       for (i = 0; i < total_queues; i++) {
> +


Unnecessary change.


>           peer = qemu_get_peer(ncs, i);
>           r = vhost_net_start_one(get_vhost_net(peer), dev);
>   
> @@ -433,6 +432,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>           vhost_net = vhost_user_get_vhost_net(nc);
>           assert(vhost_net);
>           break;
> +#endif
> +#ifdef CONFIG_VHOST_NET_VDPA
> +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> +        vhost_net = vhost_vdpa_get_vhost_net(nc);
> +        assert(vhost_net);
> +        break;
>   #endif
>       default:
>           break;
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index aff67a92df..6aadc2403a 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -43,6 +43,7 @@
>   #include "monitor/qdev.h"
>   #include "hw/pci/pci.h"
>   #include "net_rx_pkt.h"
> +#include "hw/virtio/vhost.h"
>   
>   #define VIRTIO_NET_VM_VERSION    11
>   
> @@ -124,7 +125,10 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>   {
>       VirtIONet *n = VIRTIO_NET(vdev);
>       struct virtio_net_config netcfg;
> +    int ret = 0;
> +    struct vhost_dev *hdev = NULL;
>   
> +    memset(&netcfg, 0 , sizeof(struct virtio_net_config));
>       virtio_stw_p(vdev, &netcfg.status, n->status);
>       virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
>       virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
> @@ -138,21 +142,37 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>       virtio_stl_p(vdev, &netcfg.supported_hash_types,
>                    VIRTIO_NET_RSS_SUPPORTED_HASHES);
>       memcpy(config, &netcfg, n->config_size);
> +
> +    NetClientState *nc = qemu_get_queue(n->nic);
> +    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        hdev = &(get_vhost_net(nc->peer)->dev);
> +        ret = vhost_dev_get_config(hdev, (uint8_t *)&netcfg, n->config_size);
> +            if (ret != -1) {
> +                memcpy(config, &netcfg, n->config_size);
> +        }
> +    }
>   }
>   
>   static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>   {
>       VirtIONet *n = VIRTIO_NET(vdev);
>       struct virtio_net_config netcfg = {};
> +    struct vhost_dev *hdev = NULL;
>   
>       memcpy(&netcfg, config, n->config_size);
> -


Unnecessary change.


>       if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
>           !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) &&
>           memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
>           memcpy(n->mac, netcfg.mac, ETH_ALEN);
>           qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>       }
> +
> +    NetClientState *nc = qemu_get_queue(n->nic);
> +    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        hdev = &(get_vhost_net(nc->peer)->dev);
> +        vhost_dev_set_config(hdev, (uint8_t *)&netcfg, 0, n->config_size,
> +                        VHOST_SET_CONFIG_TYPE_MASTER);
> +    }
>   }
>   
>   static bool virtio_net_started(VirtIONet *n, uint8_t status)
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 13e75f171f..2b31e9b3dc 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -5,6 +5,7 @@ obj-y += virtio.o
>   obj-$(CONFIG_VHOST) += vhost.o vhost-backend.o
>   common-obj-$(call lnot,$(CONFIG_VHOST)) += vhost-stub.o
>   obj-$(CONFIG_VHOST_USER) += vhost-user.o
> +obj-$(CONFIG_VHOST_VDPA) += vhost-vdpa.o
>   
>   common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
>   common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 48905383f8..b925a2b1ac 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -14,7 +14,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "standard-headers/linux/vhost_types.h"
> -
> +#include "hw/virtio/vhost-vdpa.h"


Let's keep the newline here.


>   #ifdef CONFIG_VHOST_KERNEL
>   #include <linux/vhost.h>
>   #include <sys/ioctl.h>
> @@ -285,6 +285,11 @@ int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
>       case VHOST_BACKEND_TYPE_USER:
>           dev->vhost_ops = &user_ops;
>           break;
> +#endif
> +#ifdef CONFIG_VHOST_VDPA
> +    case VHOST_BACKEND_TYPE_VDPA:
> +        dev->vhost_ops = &vdpa_ops;
> +        break;
>   #endif
>       default:
>           error_report("Unknown vhost backend type");
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> new file mode 100644
> index 0000000000..25c9b537b0
> --- /dev/null
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -0,0 +1,469 @@
> +/*
> + * vhost-vdpa
> + *
> + *  Copyright(c) 2017-2018 Intel Corporation.
> + *  Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vhost.h>
> +#include <linux/vfio.h>
> +#include <sys/eventfd.h>
> +#include <sys/ioctl.h>
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-backend.h"
> +#include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/vhost-vdpa.h"
> +#include "qemu/main-loop.h"
> +#include <linux/kvm.h>
> +#include "sysemu/kvm.h"
> +
> +static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
> +{
> +    return (!memory_region_is_ram(section->mr) &&
> +            !memory_region_is_iommu(section->mr)) ||
> +           /*
> +            * Sizing an enabled 64-bit BAR can cause spurious mappings to
> +            * addresses in the upper part of the 64-bit address space.  These
> +            * are never accessed by the CPU and beyond the address width of
> +            * some IOMMU hardware.  TODO: VDPA should tell us the IOMMU width.
> +            */
> +           section->offset_within_address_space & (1ULL << 63);
> +}
> +
> +static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
> +                              void *vaddr, bool readonly)
> +{
> +    struct vhost_msg_v2 msg;
> +    int fd = v->device_fd;
> +    int ret = 0;
> +
> +    msg.type = v->msg_type;
> +    msg.iotlb.iova = iova;
> +    msg.iotlb.size = size;
> +    msg.iotlb.uaddr = (uint64_t)vaddr;
> +    msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
> +    msg.iotlb.type = VHOST_IOTLB_UPDATE;
> +
> +    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
> +        error_report("failed to write, fd=%d, errno=%d (%s)",
> +            fd, errno, strerror(errno));
> +        return -EIO ;
> +    }
> +
> +    return ret;
> +}
> +
> +static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
> +                                hwaddr size)
> +{
> +    struct vhost_msg_v2 msg;
> +    int fd = v->device_fd;
> +    int ret = 0;
> +
> +    msg.type = v->msg_type;
> +    msg.iotlb.iova = iova;
> +    msg.iotlb.size = size;
> +    msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
> +
> +    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
> +        error_report("failed to write, fd=%d, errno=%d (%s)",
> +            fd, errno, strerror(errno));
> +        return -EIO ;
> +    }
> +
> +    return ret;
> +}
> +
> +static void vhost_vdpa_listener_region_add(MemoryListener *listener,
> +                                           MemoryRegionSection *section)
> +{
> +    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
> +    hwaddr iova;
> +    Int128 llend, llsize;
> +    void *vaddr;
> +    int ret;
> +
> +    if (vhost_vdpa_listener_skipped_section(section)) {
> +        return;
> +    }
> +
> +    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
> +                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> +        error_report("%s received unaligned region", __func__);
> +        return;
> +    }
> +
> +    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +    llend = int128_make64(section->offset_within_address_space);
> +    llend = int128_add(llend, section->size);
> +    llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> +
> +    if (int128_ge(int128_make64(iova), llend)) {
> +        return;
> +    }
> +
> +    memory_region_ref(section->mr);
> +
> +    /* Here we assume that memory_region_is_ram(section->mr)==true */
> +
> +    vaddr = memory_region_get_ram_ptr(section->mr) +
> +            section->offset_within_region +
> +            (iova - section->offset_within_address_space);
> +
> +    llsize = int128_sub(llend, int128_make64(iova));
> +
> +    ret = vhost_vdpa_dma_map(v, iova, int128_get64(llsize),
> +                             vaddr, section->readonly);
> +    if (ret) {
> +        error_report("vhost vdpa map fail!");
> +        if (memory_region_is_ram_device(section->mr)) {
> +            /* Allow unexpected mappings not to be fatal for RAM devices */
> +            error_report("map ram fail!");
> +          return ;
> +        }
> +        goto fail;
> +    }
> +
> +    return;
> +
> +fail:
> +    if (memory_region_is_ram_device(section->mr)) {
> +        error_report("failed to vdpa_dma_map. pci p2p may not work");
> +        return;
> +
> +    }
> +    /*
> +     * On the initfn path, store the first error in the container so we
> +     * can gracefully fail.  Runtime, there's not much we can do other
> +     * than throw a hardware error.
> +     */
> +    error_report("vhost-vdpa: DMA mapping failed, unable to continue");
> +    return;
> +
> +}
> +
> +static void vhost_vdpa_listener_region_del(MemoryListener *listener,
> +                                           MemoryRegionSection *section)
> +{
> +    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
> +    hwaddr iova;
> +    Int128 llend, llsize;
> +    int ret;
> +    bool try_unmap = true;
> +
> +    if (vhost_vdpa_listener_skipped_section(section)) {
> +        return;
> +    }
> +
> +    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
> +                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> +        error_report("%s received unaligned region", __func__);
> +        return;
> +    }
> +
> +    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +    llend = int128_make64(section->offset_within_address_space);
> +    llend = int128_add(llend, section->size);
> +    llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> +
> +    if (int128_ge(int128_make64(iova), llend)) {
> +        return;
> +    }
> +
> +    llsize = int128_sub(llend, int128_make64(iova));
> +
> +    if (try_unmap) {
> +        ret = vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
> +        if (ret) {
> +            error_report("vhost_vdpa dma unmap error!");
> +        }
> +    }
> +
> +    memory_region_unref(section->mr);
> +}
> +/*
> + * IOTLB API is used by vhost-vpda which requires incremental updating
> + * of the mapping. So we can not use generic vhost memory listener which
> + * depends on the addnop().
> + */
> +static const MemoryListener vhost_vdpa_memory_listener = {
> +    .region_add = vhost_vdpa_listener_region_add,
> +    .region_del = vhost_vdpa_listener_region_del,
> +};
> +
> +static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int request,
> +                             void *arg)
> +{
> +    struct vhost_vdpa *v = dev->opaque;
> +    int fd = v->device_fd;
> +
> +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
> +
> +    return ioctl(fd, request, arg);
> +}
> +
> +static void vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t status)
> +{
> +    uint8_t s;
> +
> +    if (vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s)) {
> +        return;
> +    }
> +
> +    s |= status;
> +
> +    vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &s);
> +}
> +
> +static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)
> +{
> +    struct vhost_vdpa *v;
> +    uint64_t features;
> +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
> +
> +    v = opaque;
> +    dev->opaque =  opaque ;
> +    vhost_vdpa_call(dev, VHOST_GET_FEATURES, &features);
> +    dev->backend_features = features;
> +    v->listener = vhost_vdpa_memory_listener;
> +    v->msg_type = VHOST_IOTLB_MSG_V2;
> +
> +    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> +                               VIRTIO_CONFIG_S_DRIVER);
> +
> +    return 0;
> +}
> +
> +static int vhost_vdpa_cleanup(struct vhost_dev *dev)
> +{
> +    struct vhost_vdpa *v;
> +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
> +    v = dev->opaque;
> +    memory_listener_unregister(&v->listener);
> +
> +    dev->opaque = NULL;
> +    return 0;
> +}
> +
> +static int vhost_vdpa_memslots_limit(struct vhost_dev *dev)
> +{
> +    return INT_MAX;
> +}
> +
> +static int vhost_vdpa_set_mem_table(struct vhost_dev *dev,
> +                                    struct vhost_memory *mem)
> +{
> +
> +    if (mem->padding) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_vdpa_set_features(struct vhost_dev *dev,
> +                                   uint64_t features)
> +{
> +    int ret;
> +    ret = vhost_vdpa_call(dev, VHOST_SET_FEATURES, &features);
> +    uint8_t status = 0;
> +    if (ret) {
> +        return ret;
> +    }
> +    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
> +    vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &status);
> +
> +    return !(status & VIRTIO_CONFIG_S_FEATURES_OK);
> +}
> +
> +int vhost_vdpa_get_device_id(struct vhost_dev *dev,
> +                                   uint32_t *device_id)
> +{
> +    return vhost_vdpa_call(dev, VHOST_VDPA_GET_DEVICE_ID, device_id);
> +}
> +
> +static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> +{
> +    uint8_t status = 0;
> +
> +    return vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
> +}
> +
> +static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
> +{
> +    assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
> +
> +    return idx - dev->vq_index;
> +}
> +
> +static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
> +{
> +    int i;
> +    for (i = 0; i < dev->nvqs; ++i) {
> +        struct vhost_vring_state state = {
> +            .index = dev->vq_index + i,
> +            .num = 1,
> +        };
> +        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> +    }
> +    return 0;
> +}
> +
> +static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t *data,
> +                                   uint32_t offset, uint32_t size,
> +                                   uint32_t flags)
> +{
> +    struct vhost_vdpa_config *config;
> +    int ret;
> +    unsigned long config_size = offsetof(struct vhost_vdpa_config, buf);
> +    config = g_malloc(size + config_size);
> +    if (config == NULL) {
> +        return -1;
> +    }
> +    config->off = offset;
> +    config->len = size;
> +    memcpy(config->buf, data, size);
> +    ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_CONFIG, config);
> +    g_free(config);
> +    return ret;
> +}
> +
> +static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
> +                                   uint32_t config_len)
> +{
> +    struct vhost_vdpa_config *v_config;
> +    unsigned long config_size = offsetof(struct vhost_vdpa_config, buf);
> +    int ret;
> +
> +    v_config = g_malloc(config_len + config_size);
> +    if (v_config == NULL) {
> +        return -1;
> +    }
> +    v_config->len = config_len;
> +    v_config->off = 0;
> +    ret = vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
> +    memcpy(config, v_config->buf, config_len);
> +    g_free(v_config);
> +    return ret;
> + }
> +
> +static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
> +{
> +    struct vhost_vdpa *v = dev->opaque;
> +    if (started) {
> +        uint8_t status = 0;
> +        memory_listener_register(&v->listener, &address_space_memory);
> +        vhost_vdpa_set_vring_ready(dev);
> +        vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> +        vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &status);
> +
> +        return !(status & VIRTIO_CONFIG_S_DRIVER_OK);
> +    } else {
> +        vhost_vdpa_reset_device(dev);
> +        vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> +                                   VIRTIO_CONFIG_S_DRIVER);
> +        memory_listener_unregister(&v->listener);
> +
> +        return 0;
> +    }
> +}
> +
> +static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
> +                                     struct vhost_log *log)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_LOG_BASE, &base);
> +}
> +
> +static int vhost_vdpa_set_vring_addr(struct vhost_dev *dev,
> +                                       struct vhost_vring_addr *addr)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_ADDR, addr);
> +}
> +
> +static int vhost_vdpa_set_vring_num(struct vhost_dev *dev,
> +                                      struct vhost_vring_state *ring)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_NUM, ring);
> +}
> +
> +static int vhost_vdpa_set_vring_base(struct vhost_dev *dev,
> +                                       struct vhost_vring_state *ring)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_BASE, ring);
> +}
> +
> +static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
> +                                       struct vhost_vring_state *ring)
> +{
> +    return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
> +}
> +
> +static int vhost_vdpa_set_vring_kick(struct vhost_dev *dev,
> +                                       struct vhost_vring_file *file)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_KICK, file);
> +}
> +
> +static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,
> +                                       struct vhost_vring_file *file)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_VRING_CALL, file);
> +}
> +
> +static int vhost_vdpa_get_features(struct vhost_dev *dev,
> +                                     uint64_t *features)
> +{
> +    return vhost_vdpa_call(dev, VHOST_GET_FEATURES, features);
> +}
> +
> +static int vhost_vdpa_set_owner(struct vhost_dev *dev)
> +{
> +    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
> +}
> +
> +static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
> +                    struct vhost_vring_addr *addr, struct vhost_virtqueue *vq)
> +{
> +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
> +    addr->desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
> +    addr->avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
> +    addr->used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
> +    return 0;
> +}
> +
> +const VhostOps vdpa_ops = {
> +        .backend_type = VHOST_BACKEND_TYPE_VDPA,
> +        .vhost_backend_init = vhost_vdpa_init,
> +        .vhost_backend_cleanup = vhost_vdpa_cleanup,
> +        .vhost_set_log_base = vhost_vdpa_set_log_base,
> +        .vhost_set_vring_addr = vhost_vdpa_set_vring_addr,
> +        .vhost_set_vring_num = vhost_vdpa_set_vring_num,
> +        .vhost_set_vring_base = vhost_vdpa_set_vring_base,
> +        .vhost_get_vring_base = vhost_vdpa_get_vring_base,
> +        .vhost_set_vring_kick = vhost_vdpa_set_vring_kick,
> +        .vhost_set_vring_call = vhost_vdpa_set_vring_call,
> +        .vhost_get_features = vhost_vdpa_get_features,
> +        .vhost_set_owner = vhost_vdpa_set_owner,
> +        .vhost_set_vring_endian = NULL,
> +        .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
> +        .vhost_set_mem_table = vhost_vdpa_set_mem_table,
> +        .vhost_set_features = vhost_vdpa_set_features,
> +        .vhost_reset_device = vhost_vdpa_reset_device,
> +        .vhost_get_vq_index = vhost_vdpa_get_vq_index,
> +        .vhost_get_config  = vhost_vdpa_get_config,
> +        .vhost_set_config = vhost_vdpa_set_config,
> +        .vhost_requires_shm_log = NULL,
> +        .vhost_migration_done = NULL,
> +        .vhost_backend_can_merge = NULL,
> +        .vhost_net_set_mtu = NULL,
> +        .vhost_set_iotlb_callback = NULL,
> +        .vhost_send_device_iotlb_msg = NULL,
> +        .vhost_dev_start = vhost_vdpa_dev_start,
> +        .vhost_get_device_id = vhost_vdpa_get_device_id,
> +         .vhost_vq_get_addr = vhost_vdpa_vq_get_addr,
> +};
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1e083a8976..bcaa66e0d2 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -808,7 +808,9 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
>           features |= 0x1ULL << VHOST_F_LOG_ALL;
>       }
>       if (!vhost_dev_has_iommu(dev)) {
> -        features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> +        if (dev->vhost_ops->backend_type != VHOST_BACKEND_TYPE_VDPA) {
> +            features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> +        }


Let's add a vhost_ops here if we want to force IOMMU_PLATFORM.


>       }
>       r = dev->vhost_ops->vhost_set_features(dev, features);
>       if (r < 0) {
> @@ -1701,9 +1703,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
>               goto fail_log;
>           }
>       }
> +


Unnecessary change.


>       if (vhost_dev_has_iommu(hdev) &&
>           hdev->vhost_ops->vhost_set_iotlb_callback) {
> -            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
> +        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);


This change should belong to patch 5

Thanks


>   
>           /* Update used ring information for IOTLB to work correctly,
>            * vhost-kernel code requires for this.*/
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
> index bfc24207e2..01f7c0d46f 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -17,7 +17,8 @@ typedef enum VhostBackendType {
>       VHOST_BACKEND_TYPE_NONE = 0,
>       VHOST_BACKEND_TYPE_KERNEL = 1,
>       VHOST_BACKEND_TYPE_USER = 2,
> -    VHOST_BACKEND_TYPE_MAX = 3,
> +    VHOST_BACKEND_TYPE_VDPA = 3,
> +    VHOST_BACKEND_TYPE_MAX = 4,
>   } VhostBackendType;
>   
>   typedef enum VhostSetConfigType {
> @@ -167,6 +168,7 @@ typedef struct VhostOps {
>   } VhostOps;
>   
>   extern const VhostOps user_ops;
> +extern const VhostOps vdpa_ops;
>   
>   int vhost_set_backend_type(struct vhost_dev *dev,
>                              VhostBackendType backend_type);
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
> new file mode 100644
> index 0000000000..6455663388
> --- /dev/null
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -0,0 +1,26 @@
> +/*
> + * vhost-vdpa.h
> + *
> + * Copyright(c) 2017-2018 Intel Corporation.
> + * Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef HW_VIRTIO_VHOST_VDPA_H
> +#define HW_VIRTIO_VHOST_VDPA_H
> +
> +#include "hw/virtio/virtio.h"
> +
> +typedef struct vhost_vdpa {
> +    int device_fd;
> +    uint32_t msg_type;
> +    MemoryListener listener;
> +} VhostVDPA;
> +
> +extern AddressSpace address_space_memory;
> +extern int vhost_vdpa_get_device_id(struct vhost_dev *dev,
> +                                   uint32_t *device_id);
> +#endif
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 085450c6f8..767a95ec0b 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -92,6 +92,13 @@ struct vhost_dev {
>       const VhostDevConfigOps *config_ops;
>   };
>   
> +struct vhost_net {
> +    struct vhost_dev dev;
> +    struct vhost_virtqueue vqs[2];
> +    int backend;
> +    NetClientState *nc;
> +};
> +
>   int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                      VhostBackendType backend_type,
>                      uint32_t busyloop_timeout);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 196f468786..fa1b19de4c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2418,6 +2418,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>   #ifdef CONFIG_POSIX
>       "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
>       "                configure a vhost-user network, backed by a chardev 'dev'\n"
> +#endif
> +#ifdef __linux__
> +    "-netdev vhost-vdpa,id=str,vhostdev=/path/to/dev\n"
> +    "                configure a vhost-vdpa network,Establish a vhost-vdpa netdev\n"
>   #endif
>       "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
>       "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
> @@ -2897,6 +2901,14 @@ SRST
>                -netdev type=vhost-user,id=net0,chardev=chr0 \
>                -device virtio-net-pci,netdev=net0
>   
> +``-netdev vhost-vdpa,vhostdev=/path/to/dev``
> +    Establish a vhost-vdpa netdev.
> +
> +    vDPA device is a device that uses a datapath which complies with
> +    the virtio specifications with a vendor specific control path.
> +    vDPA devices can be both physically located on the hardware or
> +    emulated by software.
> +
>   ``-netdev hubport,id=id,hubid=hubid[,netdev=nd]``
>       Create a hub port on the emulated hub with ID hubid.
>   


