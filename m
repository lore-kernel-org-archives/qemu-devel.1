Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5DCC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8446D20708
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baD+n1OL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8446D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwBT-0001b3-EG
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kFw9O-0006XU-A7; Wed, 09 Sep 2020 05:12:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kFw9M-0003SF-6S; Wed, 09 Sep 2020 05:12:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so1574587wmb.4;
 Wed, 09 Sep 2020 02:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OEanYeiC82A+3ot71du748eCZMw0kY/d9DfT9fq/vS4=;
 b=baD+n1OL3xV7vsIf6vWFvkAQ5K37GWlXJ2QdPZ3RpMot904T+Qt1xsdjd/axw6VV0V
 WeAxVHhKI4BqCEC1+dZZQYsMnvUyW++nn175WRMT+CM4x+guk2za56piG79gMCnJ3v/j
 d+OVCMibKia3LnJ3BHcHOL+t6yCprc/OXQcWHy1acut7c1L7mmMtQLmXMTbfXQBZYUmR
 L8LM7vxt/dYnRz7oXAFrjt+znEqguqByRJExhs/nnHuFIyc91AM7SHrygWYPKht6EBB/
 S+nQOI8+QDeUCYPn15t74zEQyZfFYkBs2gQzu3eIjurZxEKy4ilzWIGky2yLFCc2cgtR
 QBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OEanYeiC82A+3ot71du748eCZMw0kY/d9DfT9fq/vS4=;
 b=p6u1LzGZPTcbasFnfIePqTwsJ4XBkZLirs2o28jbMBjiAMCThrXnmdnrlZKQcqa+bV
 gQnb4gtMNIhlOZ+PtT+5T9M1SJRbArOkljXeUl9/JUJrZQEWk87RPbBBlz8VdDCsCN5H
 JWFZK6U8nRDlHQC5L9n5RfsCnC7t6i3iYHTnOITweAEqbiSRUS1tZiOd2vrEC0nL2m+7
 EqwT7P0/G4lWKiHnpxCrTYplovAfFWTeRLf+T9XvfhdpyKp8CXsSphDI1fEkCfzN5CcF
 MIZjNTCaKGtQsOTx4Y5ah+t/rQUhB8U6mFgIEpOn98y336FktFyM4XJsC+IiXvBlwGbk
 aFgQ==
X-Gm-Message-State: AOAM531eJPU3iDBxErgbr/nOMMvt9MvxhSx/jv/er6JCgMat6cuALdtx
 TUXnEMCF9FrAMJ7fJB9Ge2yMEgmJSmTkCQ==
X-Google-Smtp-Source: ABdhPJyjpmI68Cs0Bq5vW3+5Jj70xkWjD+5HRTDuep/lN0vYYqUSF+58b77sueIScu7jsRQhFN/8Lw==
X-Received: by 2002:a1c:dd87:: with SMTP id u129mr2572370wmg.172.1599642738289; 
 Wed, 09 Sep 2020 02:12:18 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 92sm3424597wra.19.2020.09.09.02.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:12:17 -0700 (PDT)
Date: Tue, 8 Sep 2020 15:25:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dima Stepanov <dimastep@yandex-team.ru>
Subject: Re: [PATCH v4 1/7] vhost: recheck dev state in the
 vhost_migration_log routine
Message-ID: <20200908142520.GC7154@stefanha-x1.localdomain>
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <a1b11c7dcad14542d0f313e3eddd57656dc4a6c8.1599211479.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <a1b11c7dcad14542d0f313e3eddd57656dc4a6c8.1599211479.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 fengli@smartx.com, yc-core@yandex-team.ru, pbonzini@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 12:31:13PM +0300, Dima Stepanov wrote:
> vhost-user devices can get a disconnect in the middle of the VHOST-USER
> handshake on the migration start. If disconnect event happened right
> before sending next VHOST-USER command, then the vhost_dev_set_log()
> call in the vhost_migration_log() function will return error. This error
> will lead to the assert() and close the QEMU migration source process.
> For the vhost-user devices the disconnect event should not break the
> migration process, because:
>   - the device will be in the stopped state, so it will not be changed
>     during migration
>   - if reconnect will be made the migration log will be reinitialized as
>     part of reconnect/init process:
>     #0  vhost_log_global_start (listener=3D0x563989cf7be0)
>     at hw/virtio/vhost.c:920
>     #1  0x000056398603d8bc in listener_add_address_space (listener=3D0x56=
3989cf7be0,
>         as=3D0x563986ea4340 <address_space_memory>)
>     at softmmu/memory.c:2664
>     #2  0x000056398603dd30 in memory_listener_register (listener=3D0x5639=
89cf7be0,
>         as=3D0x563986ea4340 <address_space_memory>)
>     at softmmu/memory.c:2740
>     #3  0x0000563985fd6956 in vhost_dev_init (hdev=3D0x563989cf7bd8,
>         opaque=3D0x563989cf7e30, backend_type=3DVHOST_BACKEND_TYPE_USER,
>         busyloop_timeout=3D0)
>     at hw/virtio/vhost.c:1385
>     #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=3D0x563989cf799=
0)
>     at hw/block/vhost-user-blk.c:315
>     #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=3D0x563989cf79=
90,
>         event=3DCHR_EVENT_OPENED)
>     at hw/block/vhost-user-blk.c:379
> Update the vhost-user-blk device with the internal started_vu field which
> will be used for initialization (vhost_user_blk_start) and clean up
> (vhost_user_blk_stop). This additional flag in the VhostUserBlk structure
> will be used to track whether the device really needs to be stopped and
> cleaned up on a vhost-user level.
> The disconnect event will set the overall VHOST device (not vhost-user) to
> the stopped state, so it can be used by the general vhost_migration_log
> routine.
> Such approach could be propogated to the other vhost-user devices, but
> better idea is just to make the same connect/disconnect code for all the
> vhost-user devices.
>=20
> This migration issue was slightly discussed earlier:
>   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
>   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
>=20
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/block/vhost-user-blk.c          | 19 ++++++++++++++++---
>  hw/virtio/vhost.c                  | 27 ++++++++++++++++++++++++---
>  include/hw/virtio/vhost-user-blk.h | 10 ++++++++++
>  3 files changed, 50 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 39aec42..a076b1e 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -150,6 +150,7 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
>          error_report("Error starting vhost: %d", -ret);
>          goto err_guest_notifiers;
>      }
> +    s->started_vu =3D true;
> =20
>      /* guest_notifier_mask/pending not used yet, so just unmask
>       * everything here. virtio-pci will do the right thing by
> @@ -175,6 +176,11 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      int ret;
> =20
> +    if (!s->started_vu) {
> +        return;
> +    }
> +    s->started_vu =3D false;
> +
>      if (!k->set_guest_notifiers) {
>          return;
>      }
> @@ -341,9 +347,7 @@ static void vhost_user_blk_disconnect(DeviceState *de=
v)
>      }
>      s->connected =3D false;
> =20
> -    if (s->dev.started) {
> -        vhost_user_blk_stop(vdev);
> -    }
> +    vhost_user_blk_stop(vdev);
> =20
>      vhost_dev_cleanup(&s->dev);
>  }
> @@ -399,6 +403,15 @@ static void vhost_user_blk_event(void *opaque, QEMUC=
hrEvent event)
>                      NULL, NULL, false);
>              aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, o=
paque);
>          }
> +
> +        /*
> +         * Move vhost device to the stopped state. The vhost-user device
> +         * will be clean up and disconnected in BH. This can be useful in
> +         * the vhost migration code. If disconnect was caught there is an
> +         * option for the general vhost code to get the dev state without
> +         * knowing its type (in this case vhost-user).
> +         */
> +        s->dev.started =3D false;
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:

Hi Dima,
Is it possible to move this logic into the vhost_*() API so that all
devices benefit from it? This seems like a generic vhost-user issue
rather than a vhost-user-blk issue.

In other words, it would be great if the vhost APIs in QEMU are designed
in a way so that the user doesn't need to think about this.

Stefan

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9XlFAACgkQnKSrs4Gr
c8ij9Af9Gn41JWd3dqJTio6VwQpgXLRVhERYW/DnFS40EQ5o3urNv2dxXHcoZ6sY
JQRzEh7Qb0xXYJoG9tkcKhxClFzlvDgzx0WdGuHCh++wXhFfhN2/1UyzmmYES5A0
pZYjEvZhwxOWAiOjWea3F0vDTiXLXgQiE1/ooygW2EOKGAqcBRFPkn20YO4kZ3KA
acrdYgg9B/BMnKuWagugBxy/kitxOF0YnFEKt74CQyYvAbsIrPMvZ9HMsoHTLpgP
HIayap0XqNzkATgGEVOF6xWP7Wg4kZOs2yoa5qPrdoFZHjzvZM/y5X6ulVywFOQB
vQqShCGtqvDp7EqrRPQUiNR6VCH7yg==
=tlMa
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

