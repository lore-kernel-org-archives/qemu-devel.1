Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5632C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E10217BC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahGkdjdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E10217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia4B4-0002ll-Il
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 15:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ia49X-00020S-8S
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ia49U-0002mm-A1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:43:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ia49T-0002lx-Q0
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574887387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VtRa1Zz20b5b10jpSH5pRIv9rgjEaD1p8lzUZ+0jqY=;
 b=ahGkdjdl4hhJ/DnzJFPJH4HiQ7nnK/CBD7prfDB4tIBCA4e3O8uUtw/gDEDUeLoWuxlsks
 YDhg6VbY+cHaJS/anwILT59aLw4Rz21I9eMUmbNa5hC+y2LgYOK2QLe4W7Oz8oz58wiLwr
 jQ6CiGa4/bsDSHUHnACIp9zfIq6P2ks=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-9jAIgU25PuilP9ZZe-VYsg-1; Wed, 27 Nov 2019 15:43:05 -0500
Received: by mail-qk1-f200.google.com with SMTP id b72so9233705qkg.12
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 12:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IpiO73hZN5mV+C5Sl/ZBsA/NT2kVH34L2RQ1hX6wMwk=;
 b=pLLUreOjZobDcXFbMS0Dy3BvrkD05DfhxRy0XEAco1tjmcCBjdT/a4zdzSWB4/g4w3
 zzHiS1qvMXMDV/nQQbtWKeUAAvWR3dLrGt8TR5x1r0fbbW2ZNidvcrRMb+4Xeq7GC0x+
 VcE5tkEJ7d+Cl54T/9QGEOKt2INpDgyUnctr4MIkHpU7ViPb5urv9mSu6sFRmKpa2aJr
 OjPUZ0BA/r/000+NBfRgzsEUyYPkEmtdKVkRN9tMIyJSmqVg0i6qbWzq6d5aLZkcpLq4
 U7egwMor3hca+DMLwpeEjbtbcUn4onU2E9idnxVN30bZri3mS6uccIkc91a6FbwVHAzf
 Bt6w==
X-Gm-Message-State: APjAAAX2fjTf4zXGnHEEMb1w7aHH7hUcluWMSAnV5WyNplXXHl98YZS8
 TreyEvDzzwZIYTOrhFf9QhaM7kFvzwf5rjXWKi+bD096qFpKAcTb2PoZTK6/gsxZfhqbR6pa8pV
 8ySEJLU3aY3oIhY8=
X-Received: by 2002:ac8:53c4:: with SMTP id c4mr28703517qtq.305.1574887385364; 
 Wed, 27 Nov 2019 12:43:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPfDbPX7GkwQcGm4ohIai3j7SSNh11smpeg28a1YKbGYFJSsL7k0CmYXBmYl5+vHBhtVDfHQ==
X-Received: by 2002:ac8:53c4:: with SMTP id c4mr28703488qtq.305.1574887385088; 
 Wed, 27 Nov 2019 12:43:05 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id u67sm7279188qkf.115.2019.11.27.12.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 12:43:04 -0800 (PST)
Date: Wed, 27 Nov 2019 15:42:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Prashant Bhole <prashantbhole.linux@gmail.com>
Subject: Re: [RFC net-next 15/18] virtio_net: implement XDP prog offload
 functionality
Message-ID: <20191127153253-mutt-send-email-mst@kernel.org>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126100744.5083-16-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191126100744.5083-16-prashantbhole.linux@gmail.com>
X-MC-Unique: 9jAIgU25PuilP9ZZe-VYsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org,
 netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 07:07:41PM +0900, Prashant Bhole wrote:
> From: Jason Wang <jasowang@redhat.com>
>=20
> This patch implements bpf_prog_offload_ops callbacks and adds handling
> for XDP_SETUP_PROG_HW. Handling of XDP_SETUP_PROG_HW involves setting
> up struct virtio_net_ctrl_ebpf_prog and appending program instructions
> to it. This control buffer is sent to Qemu with class
> VIRTIO_NET_CTRL_EBPF and command VIRTIO_NET_BPF_CMD_SET_OFFLOAD.
> The expected behavior from Qemu is that it should try to load the
> program in host os and report the status.

That's not great e.g. for migration: different hosts might have
a different idea about what's allowed.
Device capabilities should be preferably exported through
feature bits or config space such that it's easy to
intercept and limit these as needed.

Also, how are we going to handle e.g. endian-ness here?

>=20
> It also adds restriction to have either driver or offloaded program
> at a time.

I'm not sure I understand what does the above say.
virtnet_xdp_offload_check?
Please add code comments so we remember what to do and when.

> This restriction can be removed later after proper testing.

What kind of testing is missing here?

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Co-developed-by: Prashant Bhole <prashantbhole.linux@gmail.com>
> Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>

Any UAPI changes need to be copied to virtio-dev@lists.oasis-open.org
(subscriber only) list please.

> ---
>  drivers/net/virtio_net.c        | 114 +++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_net.h |  27 ++++++++
>  2 files changed, 139 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a1088d0114f2..dddfbb2a2075 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -169,6 +169,7 @@ struct control_buf {
>  =09u8 allmulti;
>  =09__virtio16 vid;
>  =09__virtio64 offloads;
> +=09struct virtio_net_ctrl_ebpf_prog prog_ctrl;
>  };
> =20
>  struct virtnet_info {
> @@ -272,6 +273,8 @@ struct virtnet_bpf_bound_prog {
>  =09struct bpf_insn insnsi[0];
>  };
> =20
> +#define VIRTNET_EA(extack, msg)=09NL_SET_ERR_MSG_MOD((extack), msg)
> +
>  /* Converting between virtqueue no. and kernel tx/rx queue no.
>   * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
>   */
> @@ -2427,6 +2430,11 @@ static int virtnet_xdp_set(struct net_device *dev,=
 struct netdev_bpf *bpf)
>  =09if (!xdp_attachment_flags_ok(&vi->xdp, bpf))
>  =09=09return -EBUSY;
> =20
> +=09if (rtnl_dereference(vi->offload_xdp_prog)) {
> +=09=09VIRTNET_EA(bpf->extack, "program already attached in offload mode"=
);
> +=09=09return -EINVAL;
> +=09}
> +
>  =09if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)
>  =09    && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  =09        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> @@ -2528,17 +2536,114 @@ static int virtnet_bpf_verify_insn(struct bpf_ve=
rifier_env *env, int insn_idx,
> =20
>  static void virtnet_bpf_destroy_prog(struct bpf_prog *prog)
>  {
> +=09struct virtnet_bpf_bound_prog *state;
> +
> +=09state =3D prog->aux->offload->dev_priv;
> +=09list_del(&state->list);
> +=09kfree(state);
> +}
> +
> +static int virtnet_xdp_offload_check(struct virtnet_info *vi,
> +=09=09=09=09     struct netdev_bpf *bpf)
> +{
> +=09if (!bpf->prog)
> +=09=09return 0;
> +
> +=09if (!bpf->prog->aux->offload) {
> +=09=09VIRTNET_EA(bpf->extack, "xdpoffload of non-bound program");
> +=09=09return -EINVAL;
> +=09}
> +=09if (bpf->prog->aux->offload->netdev !=3D vi->dev) {
> +=09=09VIRTNET_EA(bpf->extack, "program bound to different dev");
> +=09=09return -EINVAL;
> +=09}
> +
> +=09if (rtnl_dereference(vi->xdp_prog)) {
> +=09=09VIRTNET_EA(bpf->extack, "program already attached in driver mode")=
;
> +=09=09return -EINVAL;
> +=09}
> +
> +=09return 0;
>  }
> =20
>  static int virtnet_xdp_set_offload(struct virtnet_info *vi,
>  =09=09=09=09   struct netdev_bpf *bpf)
>  {
> -=09return -EBUSY;
> +=09struct virtio_net_ctrl_ebpf_prog *ctrl;
> +=09struct virtnet_bpf_bound_prog *bound_prog =3D NULL;
> +=09struct virtio_device *vdev =3D vi->vdev;
> +=09struct bpf_prog *prog =3D bpf->prog;
> +=09void *ctrl_buf =3D NULL;
> +=09struct scatterlist sg;
> +=09int prog_len;
> +=09int err =3D 0;
> +
> +=09if (!xdp_attachment_flags_ok(&vi->xdp_hw, bpf))
> +=09=09return -EBUSY;
> +
> +=09if (prog) {
> +=09=09if (prog->type !=3D BPF_PROG_TYPE_XDP)
> +=09=09=09return -EOPNOTSUPP;
> +=09=09bound_prog =3D prog->aux->offload->dev_priv;
> +=09=09prog_len =3D prog->len * sizeof(bound_prog->insnsi[0]);
> +
> +=09=09ctrl_buf =3D kmalloc(GFP_KERNEL, sizeof(*ctrl) + prog_len);
> +=09=09if (!ctrl_buf)
> +=09=09=09return -ENOMEM;
> +=09=09ctrl =3D ctrl_buf;
> +=09=09ctrl->cmd =3D cpu_to_virtio32(vi->vdev,
> +=09=09=09=09=09    VIRTIO_NET_BPF_CMD_SET_OFFLOAD);
> +=09=09ctrl->len =3D cpu_to_virtio32(vi->vdev, prog_len);
> +=09=09ctrl->gpl_compatible =3D cpu_to_virtio16(vi->vdev,
> +=09=09=09=09=09=09       prog->gpl_compatible);
> +=09=09memcpy(ctrl->insns, bound_prog->insnsi,
> +=09=09       prog->len * sizeof(bound_prog->insnsi[0]));
> +=09=09sg_init_one(&sg, ctrl_buf, sizeof(*ctrl) + prog_len);
> +=09} else {
> +=09=09ctrl =3D &vi->ctrl->prog_ctrl;
> +=09=09ctrl->cmd  =3D cpu_to_virtio32(vi->vdev,
> +=09=09=09=09=09     VIRTIO_NET_BPF_CMD_UNSET_OFFLOAD);
> +=09=09sg_init_one(&sg, ctrl, sizeof(*ctrl));
> +=09}
> +
> +=09if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_EBPF,
> +=09=09=09=09  VIRTIO_NET_CTRL_EBPF_PROG,
> +=09=09=09=09  &sg)) {
> +=09=09dev_warn(&vdev->dev, "Failed to set bpf offload prog\n");
> +=09=09err =3D -EFAULT;
> +=09=09goto out;
> +=09}
> +
> +=09rcu_assign_pointer(vi->offload_xdp_prog, prog);
> +
> +=09xdp_attachment_setup(&vi->xdp_hw, bpf);
> +
> +out:
> +=09kfree(ctrl_buf);
> +=09return err;
>  }
> =20
>  static int virtnet_bpf_verifier_setup(struct bpf_prog *prog)
>  {
> -=09return -ENOMEM;
> +=09struct virtnet_info *vi =3D netdev_priv(prog->aux->offload->netdev);
> +=09size_t insn_len =3D prog->len * sizeof(struct bpf_insn);
> +=09struct virtnet_bpf_bound_prog *state;
> +
> +=09state =3D kzalloc(sizeof(*state) + insn_len, GFP_KERNEL);
> +=09if (!state)
> +=09=09return -ENOMEM;
> +
> +=09memcpy(&state->insnsi[0], prog->insnsi, insn_len);
> +
> +=09state->vi =3D vi;
> +=09state->prog =3D prog;
> +=09state->len =3D prog->len;
> +
> +=09list_add_tail(&state->list, &vi->bpf_bound_progs);
> +
> +=09prog->aux->offload->dev_priv =3D state;
> +
> +=09return 0;
>  }
> =20
>  static int virtnet_bpf_verifier_prep(struct bpf_prog *prog)
> @@ -2568,12 +2673,17 @@ static const struct bpf_prog_offload_ops virtnet_=
bpf_dev_ops =3D {
>  static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  {
>  =09struct virtnet_info *vi =3D netdev_priv(dev);
> +=09int err;
> +
>  =09switch (xdp->command) {
>  =09case XDP_SETUP_PROG:
>  =09=09return virtnet_xdp_set(dev, xdp);
>  =09case XDP_QUERY_PROG:
>  =09=09return xdp_attachment_query(&vi->xdp, xdp);
>  =09case XDP_SETUP_PROG_HW:
> +=09=09err =3D virtnet_xdp_offload_check(vi, xdp);
> +=09=09if (err)
> +=09=09=09return err;
>  =09=09return virtnet_xdp_set_offload(vi, xdp);
>  =09case XDP_QUERY_PROG_HW:
>  =09=09return xdp_attachment_query(&vi->xdp_hw, xdp);
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index a3715a3224c1..0ea2f7910a5a 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -261,4 +261,31 @@ struct virtio_net_ctrl_mq {
>  #define VIRTIO_NET_CTRL_GUEST_OFFLOADS   5
>  #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET        0
> =20
> +/*
> + * Control XDP offloads offloads
> + *
> + * When guest wants to offload XDP program to the device, it calls
> + * VIRTIO_NET_CTRL_EBPF_PROG along with VIRTIO_NET_BPF_CMD_SET_OFFLOAD
> + * subcommands. When offloading is successful, the device runs offloaded
> + * XDP program for each packet before sending it to the guest.
> + *
> + * VIRTIO_NET_BPF_CMD_UNSET_OFFLOAD removes the the offloaded program fr=
om
> + * the device, if exists.
> + */
> +
> +struct virtio_net_ctrl_ebpf_prog {
> +=09/* program length in bytes */
> +=09__virtio32 len;
> +=09__virtio16 cmd;
> +=09__virtio16 gpl_compatible;
> +=09__u8 insns[0];
> +};
> +
> +#define VIRTIO_NET_CTRL_EBPF 6
> + #define VIRTIO_NET_CTRL_EBPF_PROG 1
> +
> +/* Commands for VIRTIO_NET_CTRL_EBPF_PROG */
> +#define VIRTIO_NET_BPF_CMD_SET_OFFLOAD 1
> +#define VIRTIO_NET_BPF_CMD_UNSET_OFFLOAD 2
> +
>  #endif /* _UAPI_LINUX_VIRTIO_NET_H */
> --=20
> 2.20.1


