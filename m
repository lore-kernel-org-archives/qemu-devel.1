Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADCBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0B821556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="GOxJfCkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0B821556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGfB-0002eU-UO
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kaGe0-000219-8h
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:08:00 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kaGdx-0007dj-0n
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:08:00 -0500
Received: by mail-ot1-x344.google.com with SMTP id z16so13789377otq.6
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RTv0Q3a+nhty33F8MH47BSPZITU0NU0UkB2RJDyVp7M=;
 b=GOxJfCkGfu6Ml+QKEC4mnQUuDkGTj9RplCLoqsoRwwKahbENjpj5KeSiqBO4XA2aOh
 ZBYGf8j1L/Dppe7H8TWmPWueOr3IMdFjXDIiVLXpRRcVUIEz3eBrjduJKMxbJsWsN5qD
 w2y1t0X8pEqXDNOWnWkbv+q3aSqxz7zQmbTv4xez8Mvg33tY/G/+HfNPDOmgXo56o6qE
 rxSmCAmnAAYcM4CUBXEqrdcT0izCOguTlpWcc1nDzeoLStelurRxDTmghG662idSRISH
 E4ZyB+yrHUl31C5rcKOQ9dRJ6bUeRZu9Pd56E0oaPtxBJgJHDS7z7r6hXcAwmgz9jB7y
 RbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RTv0Q3a+nhty33F8MH47BSPZITU0NU0UkB2RJDyVp7M=;
 b=FREhJe72OHq7KF0XJw3jqyRbxeC1SgidNyWzLOtQ5A7q+rFWKkKKKVqZDGoy90eSYe
 LL8KYBaEz7imVu9BYghWmxShTvhX4nFn5LKJi2pP/45lU2dlupVAq7Y/rbERT9ysOJeM
 hi8a05r0CtHPgRzHCUBrEStgtnOTkjtXDW1jTLsAH+daIk02NsS1NkDJK9XgF1aAb2r5
 /GgZpQALmg0inuYsYdbUsXNztqXtaeoGPvWyIvCV61uKjEn13R5pou6V5XbVaL6PWZ11
 xwst+dLZbU/r/jDOOxWWHcNuKMlyDPnB6rURQqI07xZA48PM0lxfHN0fQba8bxm/wZk4
 EM9Q==
X-Gm-Message-State: AOAM530LgXCCAKfsbUSV2KK2OTKV8NMPA8aEtxOR/Onc5110mU7/RfMK
 pRz/ueGFagne5pr9KMTBSaOwuJg6prGR7RmYZFdvcw==
X-Google-Smtp-Source: ABdhPJygaov2pFu/VyNHP68XvmUEtmWkYZP/OhsTHXeRkJ+GZ1UuyV1RfJ3/gLu1amR2QiO1BG0gzmau8QumMD+Dj+g=
X-Received: by 2002:a9d:61:: with SMTP id 88mr17424736ota.109.1604488072517;
 Wed, 04 Nov 2020 03:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <20201102185115.7425-6-andrew@daynix.com>
 <060630f2-d077-7b71-f1d7-86036dd8f38d@redhat.com>
In-Reply-To: <060630f2-d077-7b71-f1d7-86036dd8f38d@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 4 Nov 2020 13:07:41 +0200
Message-ID: <CAOEp5Oc7-1Dyj4ryF+S7BVP2YP=0ZrDRN89Qi0jajA3PE0Q6NA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] virtio-net: Added eBPF RSS to virtio-net.
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009c46d405b345fd36"
Received-SPF: none client-ip=2607:f8b0:4864:20::344;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Yan Vugenfirer <yan@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009c46d405b345fd36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2020 at 5:09 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:
> > From: Andrew <andrew@daynix.com>
> >
> > When RSS is enabled the device tries to load the eBPF program
> > to select RX virtqueue in the TUN. If eBPF can be loaded
> > the RSS will function also with vhost (works with kernel 5.8 and later)=
.
> > Software RSS is used as a fallback with vhost=3Doff when eBPF can't be
> loaded
> > or when hash population requested by the guest.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >   hw/net/vhost_net.c             |   2 +
> >   hw/net/virtio-net.c            | 120 +++++++++++++++++++++++++++++++-=
-
> >   include/hw/virtio/virtio-net.h |   4 ++
> >   net/vhost-vdpa.c               |   2 +
> >   4 files changed, 124 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 24d555e764..16124f99c3 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -71,6 +71,8 @@ static const int user_feature_bits[] =3D {
> >       VIRTIO_NET_F_MTU,
> >       VIRTIO_F_IOMMU_PLATFORM,
> >       VIRTIO_F_RING_PACKED,
> > +    VIRTIO_NET_F_RSS,
> > +    VIRTIO_NET_F_HASH_REPORT,
> >
> >       /* This bit implies RARP isn't sent by QEMU out of band */
> >       VIRTIO_NET_F_GUEST_ANNOUNCE,
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 277289d56e..afcc3032ec 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -698,6 +698,19 @@ static void virtio_net_set_queues(VirtIONet *n)
> >
> >   static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
> >
> > +static uint64_t fix_ebpf_vhost_features(uint64_t features)
> > +{
> > +    /* If vhost=3Don & CONFIG_EBPF doesn't set - disable RSS feature *=
/
> > +    uint64_t ret =3D features;
> > +#ifndef CONFIG_EBPF
> > +    virtio_clear_feature(&ret, VIRTIO_NET_F_RSS);
> > +#endif
> > +    /* for now, there is no solution for populating the hash from eBPF
> */
> > +    virtio_clear_feature(&ret, VIRTIO_NET_F_HASH_REPORT);
>
>
> I think we probably need to to something reverse since RSS is under the
> control on qemu cli, disable features like this may break migration.
>
>
How by design we add new features to qemu in light of possible migration to
older qemu version when the destination
qemu does not support these features?


> We need disable vhost instead when:
>
> 1) eBPF is not supported but RSS is required from command line
>
> or
>
> 2) HASH_REPORT is required from command line
>
> > +
> > +    return ret;
> > +}
> > +
> >   static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t
> features,
> >                                           Error **errp)
> >   {
> > @@ -732,9 +745,9 @@ static uint64_t virtio_net_get_features(VirtIODevic=
e
> *vdev, uint64_t features,
> >           return features;
> >       }
> >
> > -    virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> > -    virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
> > -    features =3D vhost_net_get_features(get_vhost_net(nc->peer),
> features);
> > +    features =3D fix_ebpf_vhost_features(
> > +            vhost_net_get_features(get_vhost_net(nc->peer), features))=
;
> > +
> >       vdev->backend_features =3D features;
> >
> >       if (n->mtu_bypass_backend &&
> > @@ -1169,12 +1182,75 @@ static int virtio_net_handle_announce(VirtIONet
> *n, uint8_t cmd,
> >       }
> >   }
> >
> > +static void virtio_net_unload_epbf_rss(VirtIONet *n);
> > +
> >   static void virtio_net_disable_rss(VirtIONet *n)
> >   {
> >       if (n->rss_data.enabled) {
> >           trace_virtio_net_rss_disable();
> >       }
> >       n->rss_data.enabled =3D false;
> > +
> > +    if (!n->rss_data.enabled_software_rss &&
> ebpf_rss_is_loaded(&n->ebpf_rss)) {
> > +        virtio_net_unload_epbf_rss(n);
> > +    }
> > +}
> > +
> > +static bool virtio_net_attach_steering_ebpf(NICState *nic, int prog_fd=
)
> > +{
> > +    NetClientState *nc =3D qemu_get_peer(qemu_get_queue(nic), 0);
> > +    if (nc =3D=3D NULL || nc->info->set_steering_ebpf =3D=3D NULL) {
> > +        return false;
> > +    }
> > +
> > +    return nc->info->set_steering_ebpf(nc, prog_fd);
> > +}
> > +
> > +static void rss_data_to_rss_config(struct VirtioNetRssData *data,
> > +                                   struct EBPFRSSConfig *config)
> > +{
> > +    config->redirect =3D data->redirect;
> > +    config->populate_hash =3D data->populate_hash;
> > +    config->hash_types =3D data->hash_types;
> > +    config->indirections_len =3D data->indirections_len;
> > +    config->default_queue =3D data->default_queue;
> > +}
> > +
> > +static bool virtio_net_load_epbf_rss(VirtIONet *n)
> > +{
> > +    struct EBPFRSSConfig config =3D {};
> > +
> > +    if (!n->rss_data.enabled) {
> > +        if (ebpf_rss_is_loaded(&n->ebpf_rss)) {
> > +            ebpf_rss_unload(&n->ebpf_rss);
> > +        }
> > +        return true;
> > +    }
> > +
> > +    if (!ebpf_rss_is_loaded(&n->ebpf_rss) &&
> !ebpf_rss_load(&n->ebpf_rss)) {
> > +        return false;
> > +    }
> > +
> > +    rss_data_to_rss_config(&n->rss_data, &config);
> > +
> > +    if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
> > +                          n->rss_data.indirections_table,
> n->rss_data.key)) {
> > +        ebpf_rss_unload(&n->ebpf_rss);
> > +        return false;
> > +    }
> > +
> > +    if (!virtio_net_attach_steering_ebpf(n->nic,
> n->ebpf_rss.program_fd)) {
> > +        ebpf_rss_unload(&n->ebpf_rss);
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +static void virtio_net_unload_epbf_rss(VirtIONet *n)
> > +{
> > +    virtio_net_attach_steering_ebpf(n->nic, -1);
> > +    ebpf_rss_unload(&n->ebpf_rss);
> >   }
> >
> >   static uint16_t virtio_net_handle_rss(VirtIONet *n,
> > @@ -1208,6 +1284,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *=
n,
> >           err_value =3D (uint32_t)s;
> >           goto error;
> >       }
> > +    n->rss_data.enabled_software_rss =3D false;
> >       n->rss_data.hash_types =3D virtio_ldl_p(vdev, &cfg.hash_types);
> >       n->rss_data.indirections_len =3D
> >           virtio_lduw_p(vdev, &cfg.indirection_table_mask);
> > @@ -1289,9 +1366,30 @@ static uint16_t virtio_net_handle_rss(VirtIONet
> *n,
> >           goto error;
> >       }
> >       n->rss_data.enabled =3D true;
> > +
> > +    if (!n->rss_data.populate_hash) {
> > +        /* load EBPF RSS */
> > +        if (!virtio_net_load_epbf_rss(n)) {
> > +            /* EBPF mast be loaded for vhost */
> > +            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
> > +                warn_report("Can't load eBPF RSS for vhost");
> > +                goto error;
> > +            }
> > +            /* fallback to software RSS */
> > +            warn_report("Can't load eBPF RSS - fallback to software
> RSS");
> > +            n->rss_data.enabled_software_rss =3D true;
> > +        }
> > +    } else {
> > +        /* use software RSS for hash populating */
> > +        /* and unload eBPF if was loaded before */
> > +        virtio_net_unload_epbf_rss(n);
> > +        n->rss_data.enabled_software_rss =3D true;
> > +    }
> > +
> >       trace_virtio_net_rss_enable(n->rss_data.hash_types,
> >                                   n->rss_data.indirections_len,
> >                                   temp.b);
> > +
> >       return queues;
> >   error:
> >       trace_virtio_net_rss_error(err_msg, err_value);
> > @@ -1674,7 +1772,7 @@ static ssize_t
> virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >           return -1;
> >       }
> >
> > -    if (!no_rss && n->rss_data.enabled) {
> > +    if (!no_rss && n->rss_data.enabled &&
> n->rss_data.enabled_software_rss) {
> >           int index =3D virtio_net_process_rss(nc, buf, size);
> >           if (index >=3D 0) {
> >               NetClientState *nc2 =3D qemu_get_subqueue(n->nic, index);
> > @@ -2780,6 +2878,18 @@ static int virtio_net_post_load_device(void
> *opaque, int version_id)
> >       }
> >
> >       if (n->rss_data.enabled) {
> > +        n->rss_data.enabled_software_rss =3D n->rss_data.populate_hash=
;
> > +        if (!n->rss_data.populate_hash) {
> > +            if (!virtio_net_load_epbf_rss(n)) {
> > +                if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
> > +                    error_report("Can't post-load eBPF RSS for vhost")=
;
> > +                } else {
> > +                    warn_report("Can't post-load eBPF RSS - fallback t=
o
> software RSS");
> > +                    n->rss_data.enabled_software_rss =3D true;
> > +                }
> > +            }
> > +        }
> > +
> >           trace_virtio_net_rss_enable(n->rss_data.hash_types,
> >                                       n->rss_data.indirections_len,
> >                                       sizeof(n->rss_data.key));
> > @@ -3453,6 +3563,8 @@ static void virtio_net_instance_init(Object *obj)
> >       device_add_bootindex_property(obj, &n->nic_conf.bootindex,
> >                                     "bootindex", "/ethernet-phy@0",
> >                                     DEVICE(n));
> > +
> > +    ebpf_rss_init(&n->ebpf_rss);
> >   }
> >
> >   static int virtio_net_pre_save(void *opaque)
> > diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
> > index f4852ac27b..4d29a577eb 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -21,6 +21,8 @@
> >   #include "qemu/option_int.h"
> >   #include "qom/object.h"
> >
> > +#include "ebpf/ebpf_rss.h"
> > +
> >   #define TYPE_VIRTIO_NET "virtio-net-device"
> >   OBJECT_DECLARE_SIMPLE_TYPE(VirtIONet, VIRTIO_NET)
> >
> > @@ -130,6 +132,7 @@ typedef struct VirtioNetRscChain {
> >
> >   typedef struct VirtioNetRssData {
> >       bool    enabled;
> > +    bool    enabled_software_rss;
>
>
> We probably need a better name of this since "software" is kind of
> confusing.
>
> No problem


>
> >       bool    redirect;
> >       bool    populate_hash;
> >       uint32_t hash_types;
> > @@ -214,6 +217,7 @@ struct VirtIONet {
> >       Notifier migration_state;
> >       VirtioNetRssData rss_data;
> >       struct NetRxPkt *rx_pkt;
> > +    struct EBPFRSSContext ebpf_rss;
> >   };
> >
> >   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 99c476db8c..feb5fa8624 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -54,6 +54,8 @@ const int vdpa_feature_bits[] =3D {
> >       VIRTIO_NET_F_MTU,
> >       VIRTIO_F_IOMMU_PLATFORM,
> >       VIRTIO_F_RING_PACKED,
> > +    VIRTIO_NET_F_RSS,
> > +    VIRTIO_NET_F_HASH_REPORT,
>
>
> This is fine but looks unrelated to eBPF RSS support.
>
> Usually it means the hardware can support RSS/hash reporting.
>
> As I see from
https://github.com/qemu/qemu/blob/master/hw/virtio/vhost.c#L1526:
If we do not add these features this means they are transparent to specific
vhost solution.
When in fact they are not. We need to ensure these features are not in use
in case of
vhost-vdpa or vhost-user.


> Thanks
>
>
> >       VIRTIO_NET_F_GUEST_ANNOUNCE,
> >       VIRTIO_NET_F_STATUS,
> >       VHOST_INVALID_FEATURE_BIT
>
>

--0000000000009c46d405b345fd36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 4, 2020 at 5:09 AM Jason =
Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:<br>
&gt; From: Andrew &lt;<a href=3D"mailto:andrew@daynix.com" target=3D"_blank=
">andrew@daynix.com</a>&gt;<br>
&gt;<br>
&gt; When RSS is enabled the device tries to load the eBPF program<br>
&gt; to select RX virtqueue in the TUN. If eBPF can be loaded<br>
&gt; the RSS will function also with vhost (works with kernel 5.8 and later=
).<br>
&gt; Software RSS is used as a fallback with vhost=3Doff when eBPF can&#39;=
t be loaded<br>
&gt; or when hash population requested by the guest.<br>
&gt;<br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/vhost_net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 120 +++++++++++++++++++++++++++++++--<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-net.h |=C2=A0 =C2=A04 ++<br>
&gt;=C2=A0 =C2=A0net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A04 files changed, 124 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c<br>
&gt; index 24d555e764..16124f99c3 100644<br>
&gt; --- a/hw/net/vhost_net.c<br>
&gt; +++ b/hw/net/vhost_net.c<br>
&gt; @@ -71,6 +71,8 @@ static const int user_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_NET_F_MTU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_F_IOMMU_PLATFORM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_F_RING_PACKED,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_RSS,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_HASH_REPORT,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* This bit implies RARP isn&#39;t sent by Q=
EMU out of band */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_NET_F_GUEST_ANNOUNCE,<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 277289d56e..afcc3032ec 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -698,6 +698,19 @@ static void virtio_net_set_queues(VirtIONet *n)<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void virtio_net_set_multiqueue(VirtIONet *n, int mu=
ltiqueue);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static uint64_t fix_ebpf_vhost_features(uint64_t features)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* If vhost=3Don &amp; CONFIG_EBPF doesn&#39;t set - di=
sable RSS feature */<br>
&gt; +=C2=A0 =C2=A0 uint64_t ret =3D features;<br>
&gt; +#ifndef CONFIG_EBPF<br>
&gt; +=C2=A0 =C2=A0 virtio_clear_feature(&amp;ret, VIRTIO_NET_F_RSS);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 /* for now, there is no solution for populating the has=
h from eBPF */<br>
&gt; +=C2=A0 =C2=A0 virtio_clear_feature(&amp;ret, VIRTIO_NET_F_HASH_REPORT=
);<br>
<br>
<br>
I think we probably need to to something reverse since RSS is under the <br=
>
control on qemu cli, disable features like this may break migration.<br>
<br></blockquote><div><br></div><div>How by design we add new features to q=
emu in light of possible migration to older qemu version when the destinati=
on</div><div>qemu does not support these features?</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
We need disable vhost instead when:<br>
<br>
1) eBPF is not supported but RSS is required from command line<br>
<br>
or<br>
<br>
2) HASH_REPORT is required from command line<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +<b=
r>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static uint64_t virtio_net_get_features(VirtIODevice *vdev=
, uint64_t features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Error **errp)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -732,9 +745,9 @@ static uint64_t virtio_net_get_features(VirtIODevi=
ce *vdev, uint64_t features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return features;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 virtio_clear_feature(&amp;features, VIRTIO_NET_F_RSS);<=
br>
&gt; -=C2=A0 =C2=A0 virtio_clear_feature(&amp;features, VIRTIO_NET_F_HASH_R=
EPORT);<br>
&gt; -=C2=A0 =C2=A0 features =3D vhost_net_get_features(get_vhost_net(nc-&g=
t;peer), features);<br>
&gt; +=C2=A0 =C2=A0 features =3D fix_ebpf_vhost_features(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net_get_features(get_=
vhost_net(nc-&gt;peer), features));<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;backend_features =3D features;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (n-&gt;mtu_bypass_backend &amp;&amp;<br>
&gt; @@ -1169,12 +1182,75 @@ static int virtio_net_handle_announce(VirtIONe=
t *n, uint8_t cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void virtio_net_unload_epbf_rss(VirtIONet *n);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void virtio_net_disable_rss(VirtIONet *n)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (n-&gt;rss_data.enabled) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_virtio_net_rss_disable()=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;rss_data.enabled =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!n-&gt;rss_data.enabled_software_rss &amp;&amp; ebp=
f_rss_is_loaded(&amp;n-&gt;ebpf_rss)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_unload_epbf_rss(n);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool virtio_net_attach_steering_ebpf(NICState *nic, int prog_f=
d)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 NetClientState *nc =3D qemu_get_peer(qemu_get_queue(nic=
), 0);<br>
&gt; +=C2=A0 =C2=A0 if (nc =3D=3D NULL || nc-&gt;info-&gt;set_steering_ebpf=
 =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return nc-&gt;info-&gt;set_steering_ebpf(nc, prog_fd);<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static void rss_data_to_rss_config(struct VirtioNetRssData *data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct EBPFRSSConfi=
g *config)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 config-&gt;redirect =3D data-&gt;redirect;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;populate_hash =3D data-&gt;populate_hash;<br=
>
&gt; +=C2=A0 =C2=A0 config-&gt;hash_types =3D data-&gt;hash_types;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;indirections_len =3D data-&gt;indirections_l=
en;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;default_queue =3D data-&gt;default_queue;<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static bool virtio_net_load_epbf_rss(VirtIONet *n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct EBPFRSSConfig config =3D {};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!n-&gt;rss_data.enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ebpf_rss_is_loaded(&amp;n-&gt;ebpf_rs=
s)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ebpf_rss_unload(&amp;n-&gt;=
ebpf_rss);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!ebpf_rss_is_loaded(&amp;n-&gt;ebpf_rss) &amp;&amp;=
 !ebpf_rss_load(&amp;n-&gt;ebpf_rss)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rss_data_to_rss_config(&amp;n-&gt;rss_data, &amp;config=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!ebpf_rss_set_all(&amp;n-&gt;ebpf_rss, &amp;config,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.indirections_table, n-&gt;rss_data.key=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ebpf_rss_unload(&amp;n-&gt;ebpf_rss);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!virtio_net_attach_steering_ebpf(n-&gt;nic, n-&gt;e=
bpf_rss.program_fd)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ebpf_rss_unload(&amp;n-&gt;ebpf_rss);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void virtio_net_unload_epbf_rss(VirtIONet *n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 virtio_net_attach_steering_ebpf(n-&gt;nic, -1);<br>
&gt; +=C2=A0 =C2=A0 ebpf_rss_unload(&amp;n-&gt;ebpf_rss);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static uint16_t virtio_net_handle_rss(VirtIONet *n,<br>
&gt; @@ -1208,6 +1284,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet =
*n,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err_value =3D (uint32_t)s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rss_data.enabled_software_rss =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;rss_data.hash_types =3D virtio_ldl_p(v=
dev, &amp;cfg.hash_types);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;rss_data.indirections_len =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_lduw_p(vdev, &amp;cfg.i=
ndirection_table_mask);<br>
&gt; @@ -1289,9 +1366,30 @@ static uint16_t virtio_net_handle_rss(VirtIONet=
 *n,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;rss_data.enabled =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!n-&gt;rss_data.populate_hash) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* load EBPF RSS */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_net_load_epbf_rss(n)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* EBPF mast be loaded for =
vhost */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_vhost_net(qemu_get_=
queue(n-&gt;nic)-&gt;peer)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&=
quot;Can&#39;t load eBPF RSS for vhost&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fallback to software RSS=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;Can&#39;t=
 load eBPF RSS - fallback to software RSS&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.enabled_soft=
ware_rss =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* use software RSS for hash populating *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* and unload eBPF if was loaded before *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_unload_epbf_rss(n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.enabled_software_rss =3D t=
rue;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_virtio_net_rss_enable(n-&gt;rss_data.h=
ash_types,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;rss_data.indir=
ections_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp.b);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return queues;<br>
&gt;=C2=A0 =C2=A0error:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_virtio_net_rss_error(err_msg, err_valu=
e);<br>
&gt; @@ -1674,7 +1772,7 @@ static ssize_t virtio_net_receive_rcu(NetClientS=
tate *nc, const uint8_t *buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (!no_rss &amp;&amp; n-&gt;rss_data.enabled) {<br>
&gt; +=C2=A0 =C2=A0 if (!no_rss &amp;&amp; n-&gt;rss_data.enabled &amp;&amp=
; n-&gt;rss_data.enabled_software_rss) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int index =3D virtio_net_proce=
ss_rss(nc, buf, size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (index &gt;=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NetClientState *=
nc2 =3D qemu_get_subqueue(n-&gt;nic, index);<br>
&gt; @@ -2780,6 +2878,18 @@ static int virtio_net_post_load_device(void *op=
aque, int version_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (n-&gt;rss_data.enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.enabled_software_rss =3D n=
-&gt;rss_data.populate_hash;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!n-&gt;rss_data.populate_hash) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_net_load_epbf_r=
ss(n)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_vhost=
_net(qemu_get_queue(n-&gt;nic)-&gt;peer)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 error_report(&quot;Can&#39;t post-load eBPF RSS for vhost&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 warn_report(&quot;Can&#39;t post-load eBPF RSS - fallback to software RSS&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 n-&gt;rss_data.enabled_software_rss =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_virtio_net_rss_enable(n-=
&gt;rss_data.hash_types,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;=
rss_data.indirections_len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof=
(n-&gt;rss_data.key));<br>
&gt; @@ -3453,6 +3563,8 @@ static void virtio_net_instance_init(Object *obj=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0device_add_bootindex_property(obj, &amp;n-&g=
t;nic_conf.bootindex,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;bootind=
ex&quot;, &quot;/ethernet-phy@0&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEVICE(n));<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ebpf_rss_init(&amp;n-&gt;ebpf_rss);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int virtio_net_pre_save(void *opaque)<br>
&gt; diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio=
-net.h<br>
&gt; index f4852ac27b..4d29a577eb 100644<br>
&gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; @@ -21,6 +21,8 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/option_int.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qom/object.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#include &quot;ebpf/ebpf_rss.h&quot;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#define TYPE_VIRTIO_NET &quot;virtio-net-device&quot;<br>
&gt;=C2=A0 =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(VirtIONet, VIRTIO_NET)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -130,6 +132,7 @@ typedef struct VirtioNetRscChain {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0typedef struct VirtioNetRssData {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 enabled;<br>
&gt; +=C2=A0 =C2=A0 bool=C2=A0 =C2=A0 enabled_software_rss;<br>
<br>
<br>
We probably need a better name of this since &quot;software&quot; is kind o=
f <br>
confusing.<br>
<br></blockquote><div>No problem</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 redirect;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 populate_hash;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t hash_types;<br>
&gt; @@ -214,6 +217,7 @@ struct VirtIONet {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Notifier migration_state;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtioNetRssData rss_data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct NetRxPkt *rx_pkt;<br>
&gt; +=C2=A0 =C2=A0 struct EBPFRSSContext ebpf_rss;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void virtio_net_set_netclient_name(VirtIONet *n, const cha=
r *name,<br>
&gt; diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c<br>
&gt; index 99c476db8c..feb5fa8624 100644<br>
&gt; --- a/net/vhost-vdpa.c<br>
&gt; +++ b/net/vhost-vdpa.c<br>
&gt; @@ -54,6 +54,8 @@ const int vdpa_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_NET_F_MTU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_F_IOMMU_PLATFORM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_F_RING_PACKED,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_RSS,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_HASH_REPORT,<br>
<br>
<br>
This is fine but looks unrelated to eBPF RSS support.<br>
<br>
Usually it means the hardware can support RSS/hash reporting.<br>
<br></blockquote><div>As I see from=C2=A0<a href=3D"https://github.com/qemu=
/qemu/blob/master/hw/virtio/vhost.c#L1526">https://github.com/qemu/qemu/blo=
b/master/hw/virtio/vhost.c#L1526</a>:</div><div>If we do not add these feat=
ures this means they are transparent to specific vhost solution.</div><div>=
When in fact they are not. We need to ensure these features are not in use =
in case of</div><div>vhost-vdpa or vhost-user.</div><div>=C2=A0<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
Thanks<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_NET_F_GUEST_ANNOUNCE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_NET_F_STATUS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_INVALID_FEATURE_BIT<br>
<br>
</blockquote></div></div>

--0000000000009c46d405b345fd36--

