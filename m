Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35868206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLwErTll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35868206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgr6b-00051Z-Ow
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr4k-0003hV-Di
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:42:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgr4i-0002hg-SK
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:42:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so6425097wro.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A8HLuVof9xbk0kFV3aSBfQwKybXJWBpGxgO/8sPsfN4=;
 b=MLwErTllMNYxQ17dvrssHWGbaMi2L6PdjZDBE4B1ZjfVkn1pb9/cM2A4PEg0EQuFMN
 U+JbrcCW7J2wvzhKovMnQH8RUHJnAQmpE5FAMQ4r34KZKSelfh3zPdpUwxE2pGQB/wC3
 PaWl+A6fiX/QMEeVzRbwNuaML9TWwizxRMdHuXHVdYzXurErFJrKG3GP5guInFk+MHfu
 YzT+nPRB0zgvoepEKrxhwFe9eQ/vi70Tn2yws8uhIQRT1WpjrkmlG9JDKV8ckxqTMFiM
 KviMapjukDkvAF3s/0tnyng5FrvKT+1QGcYYTGRfDXaUcmTI3X6f33t1GSnfQHY9Gh5G
 B/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A8HLuVof9xbk0kFV3aSBfQwKybXJWBpGxgO/8sPsfN4=;
 b=LxLpksXWuFOBnHPxMmZFmxiG/4Rmsx3gA4AlY5Vp2MHh97awcyrcjY9Li/faYcYqgz
 dUHMJ8z17gAbzlBL8RUWLqyr2bArQ2ryMNIkMKTnIvYx++dRYIqFBGwO6nBCW52fgB7y
 fuTeFHnYE0UGRdjXZzlfx9+frCSosYLksnSaCWWjyhiOUQ0w3MOZTLG3bMWZhSkpZwnV
 g3LfM7WZNX5bLzWzLxfBlCBkNHVofhdgSuZ4YK67XUCOFNYwhV7FBKMq3bLkoICuONYj
 P7sFqAINLfVVtao4jYgRDLGijSXMFUmGnwRckIQh3PMboEU+vaOQdOYn8nh3ZQ13grKg
 WvFw==
X-Gm-Message-State: AOAM531a7cTTpVqO2w/fdGejeC74SeWDPKiF3W8h5pCIMw+ywOb8RsuF
 UXCWjK1InjJ8WlQ6WJD4Akg95T44MSANmTMibw0=
X-Google-Smtp-Source: ABdhPJxsRRLjamNjR9DK7sdrYYCWbvWKERffkVC6lRp0qG2DbZsJ3DFiMkHLW90/dvULQkktxzDsooumq9Cy0Ye4wuQ=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr4919175wrr.96.1591281751117;
 Thu, 04 Jun 2020 07:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
 <1588533678-23450-4-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1588533678-23450-4-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Jun 2020 16:42:19 +0200
Message-ID: <CAJ+F1C+crOfXTL6R=bCF7i1f=CscZzhe=HwdPDGf4MTFL3MJOQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: multipart/alternative; boundary="0000000000008354e805a7432710"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008354e805a7432710
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 21, 2020 at 7:00 AM Raphael Norwitz <raphael.norwitz@nutanix.co=
m>
wrote:

> This change introduces a new feature to the vhost-user protocol allowing
> a backend device to specify the maximum number of ram slots it supports.
>
> At this point, the value returned by the backend will be capped at the
> maximum number of ram slots which can be supported by vhost-user, which
> is currently set to 8 because of underlying protocol limitations.
>
> The returned value will be stored inside the VhostUserState struct so
> that on device reconnect we can verify that the ram slot limitation
> has not decreased since the last time the device connected.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  docs/interop/vhost-user.rst    | 16 ++++++++++++++
>  hw/virtio/vhost-user.c         | 49
> ++++++++++++++++++++++++++++++++++++++++--
>  include/hw/virtio/vhost-user.h |  1 +
>  3 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 3b1b660..b3cf5c3 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -815,6 +815,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
>    #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
>    #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
> +  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>
>  Master message types
>  --------------------
> @@ -1263,6 +1264,21 @@ Master message types
>
>    The state.num field is currently reserved and must be set to 0.
>
> +``VHOST_USER_GET_MAX_MEM_SLOTS``
> +  :id: 36
> +  :equivalent ioctl: N/A
> +  :slave payload: u64
> +
> +  When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol
> +  feature has been successfully negotiated, this message is submitted
> +  by master to the slave. The slave should return the message with a
> +  u64 payload containing the maximum number of memory slots for
> +  QEMU to expose to the guest. At this point, the value returned
> +  by the backend will be capped at the maximum number of ram slots
> +  which can be supported by vhost-user. Currently that limit is set
> +  at VHOST_USER_MAX_RAM_SLOTS =3D 8 because of underlying protocol
> +  limitations.
> +
>  Slave message types
>  -------------------
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 442b0d6..0af593f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -59,6 +59,8 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
>      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
>      VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
> +    /* Feature 14 reserved for
> VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
> +    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS =3D 15,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>
> @@ -100,6 +102,8 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_INFLIGHT_FD =3D 32,
>      VHOST_USER_GPU_SET_SOCKET =3D 33,
>      VHOST_USER_RESET_DEVICE =3D 34,
> +    /* Message number 35 reserved for VHOST_USER_VRING_KICK. */
> +    VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> @@ -895,6 +899,23 @@ static int vhost_user_set_owner(struct vhost_dev *de=
v)
>      return 0;
>  }
>
> +static int vhost_user_get_max_memslots(struct vhost_dev *dev,
> +                                       uint64_t *max_memslots)
> +{
> +    uint64_t backend_max_memslots;
> +    int err;
> +
> +    err =3D vhost_user_get_u64(dev, VHOST_USER_GET_MAX_MEM_SLOTS,
> +                             &backend_max_memslots);
> +    if (err < 0) {
> +        return err;
> +    }
> +
> +    *max_memslots =3D backend_max_memslots;
> +
> +    return 0;
> +}
> +
>  static int vhost_user_reset_device(struct vhost_dev *dev)
>  {
>      VhostUserMsg msg =3D {
> @@ -1392,7 +1413,7 @@ static int
> vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>
>  static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
>  {
> -    uint64_t features, protocol_features;
> +    uint64_t features, protocol_features, ram_slots;
>      struct vhost_user *u;
>      int err;
>
> @@ -1454,6 +1475,27 @@ static int vhost_user_backend_init(struct vhost_de=
v
> *dev, void *opaque)
>                           "slave-req protocol features.");
>              return -1;
>          }
> +
> +        /* get max memory regions if backend supports configurable RAM
> slots */
> +        if (!virtio_has_feature(dev->protocol_features,
> +
> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
> +            u->user->memory_slots =3D VHOST_MEMORY_MAX_NREGIONS;
> +        } else {
> +            err =3D vhost_user_get_max_memslots(dev, &ram_slots);
> +            if (err < 0) {
> +                return err;
> +            }
> +
> +            if (ram_slots < u->user->memory_slots) {
> +                error_report("The backend specified a max ram slots limi=
t
> "
> +                             "of %lu, when the prior validated limit was
> %d. "
> +                             "This limit should never decrease.",
> ram_slots,
> +                             u->user->memory_slots);
> +                return -1;
> +            }
> +
> +            u->user->memory_slots =3D MIN(ram_slots,
> VHOST_MEMORY_MAX_NREGIONS);
> +        }
>      }
>
>      if (dev->migration_blocker =3D=3D NULL &&
> @@ -1519,7 +1561,9 @@ static int vhost_user_get_vq_index(struct vhost_dev
> *dev, int idx)
>
>  static int vhost_user_memslots_limit(struct vhost_dev *dev)
>  {
> -    return VHOST_MEMORY_MAX_NREGIONS;
> +    struct vhost_user *u =3D dev->opaque;
> +
> +    return u->user->memory_slots;
>  }
>
>  static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
> @@ -1904,6 +1948,7 @@ bool vhost_user_init(VhostUserState *user,
> CharBackend *chr, Error **errp)
>          return false;
>      }
>      user->chr =3D chr;
> +    user->memory_slots =3D 0;
>      return true;
>  }
>
> diff --git a/include/hw/virtio/vhost-user.h
> b/include/hw/virtio/vhost-user.h
> index 811e325..a9abca3 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -20,6 +20,7 @@ typedef struct VhostUserHostNotifier {
>  typedef struct VhostUserState {
>      CharBackend *chr;
>      VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
> +    int memory_slots;
>  } VhostUserState;
>
>  bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error
> **errp);
> --
> 1.8.3.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000008354e805a7432710
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, May 21, 2020 at 7:00 AM Raphael Norwi=
tz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com">raphael.norwitz@nutan=
ix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">This change introduces a new feature to the vhost-user protocol allow=
ing<br>
a backend device to specify the maximum number of ram slots it supports.<br=
>
<br>
At this point, the value returned by the backend will be capped at the<br>
maximum number of ram slots which can be supported by vhost-user, which<br>
is currently set to 8 because of underlying protocol limitations.<br>
<br>
The returned value will be stored inside the VhostUserState struct so<br>
that on device reconnect we can verify that the ram slot limitation<br>
has not decreased since the last time the device connected.<br>
<br>
Signed-off-by: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutani=
x.com" target=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br>
Signed-off-by: Peter Turschmid &lt;<a href=3D"mailto:peter.turschm@nutanix.=
com" target=3D"_blank">peter.turschm@nutanix.com</a>&gt;<br></blockquote><d=
iv><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto=
:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div=
> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0docs/interop/vhost-user.rst=C2=A0 =C2=A0 | 16 ++++++++++++++<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 49 ++++++++=
++++++++++++++++++++++++++++++++--<br>
=C2=A0include/hw/virtio/vhost-user.h |=C2=A0 1 +<br>
=C2=A03 files changed, 64 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst<br>
index 3b1b660..b3cf5c3 100644<br>
--- a/docs/interop/vhost-user.rst<br>
+++ b/docs/interop/vhost-user.rst<br>
@@ -815,6 +815,7 @@ Protocol features<br>
=C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD=C2=A0 =C2=A0 =C2=
=A0 =C2=A012<br>
=C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_RESET_DEVICE=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A013<br>
=C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14<br>
+=C2=A0 #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS=C2=A0 15<br>
<br>
=C2=A0Master message types<br>
=C2=A0--------------------<br>
@@ -1263,6 +1264,21 @@ Master message types<br>
<br>
=C2=A0 =C2=A0The state.num field is currently reserved and must be set to 0=
.<br>
<br>
+``VHOST_USER_GET_MAX_MEM_SLOTS``<br>
+=C2=A0 :id: 36<br>
+=C2=A0 :equivalent ioctl: N/A<br>
+=C2=A0 :slave payload: u64<br>
+<br>
+=C2=A0 When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol<br>
+=C2=A0 feature has been successfully negotiated, this message is submitted=
<br>
+=C2=A0 by master to the slave. The slave should return the message with a<=
br>
+=C2=A0 u64 payload containing the maximum number of memory slots for<br>
+=C2=A0 QEMU to expose to the guest. At this point, the value returned<br>
+=C2=A0 by the backend will be capped at the maximum number of ram slots<br=
>
+=C2=A0 which can be supported by vhost-user. Currently that limit is set<b=
r>
+=C2=A0 at VHOST_USER_MAX_RAM_SLOTS =3D 8 because of underlying protocol<br=
>
+=C2=A0 limitations.<br>
+<br>
=C2=A0Slave message types<br>
=C2=A0-------------------<br>
<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 442b0d6..0af593f 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -59,6 +59,8 @@ enum VhostUserProtocolFeature {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,<br>
+=C2=A0 =C2=A0 /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTI=
FICATIONS. */<br>
+=C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS =3D 15,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_PROTOCOL_F_MAX<br>
=C2=A0};<br>
<br>
@@ -100,6 +102,8 @@ typedef enum VhostUserRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_SET_INFLIGHT_FD =3D 32,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GPU_SET_SOCKET =3D 33,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_RESET_DEVICE =3D 34,<br>
+=C2=A0 =C2=A0 /* Message number 35 reserved for VHOST_USER_VRING_KICK. */<=
br>
+=C2=A0 =C2=A0 VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_MAX<br>
=C2=A0} VhostUserRequest;<br>
<br>
@@ -895,6 +899,23 @@ static int vhost_user_set_owner(struct vhost_dev *dev)=
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+static int vhost_user_get_max_memslots(struct vhost_dev *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t =
*max_memslots)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t backend_max_memslots;<br>
+=C2=A0 =C2=A0 int err;<br>
+<br>
+=C2=A0 =C2=A0 err =3D vhost_user_get_u64(dev, VHOST_USER_GET_MAX_MEM_SLOTS=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;backend_max_memslots);<br>
+=C2=A0 =C2=A0 if (err &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 *max_memslots =3D backend_max_memslots;<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
=C2=A0static int vhost_user_reset_device(struct vhost_dev *dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VhostUserMsg msg =3D {<br>
@@ -1392,7 +1413,7 @@ static int vhost_user_postcopy_notifier(NotifierWithR=
eturn *notifier,<br>
<br>
=C2=A0static int vhost_user_backend_init(struct vhost_dev *dev, void *opaqu=
e)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 uint64_t features, protocol_features;<br>
+=C2=A0 =C2=A0 uint64_t features, protocol_features, ram_slots;<br>
=C2=A0 =C2=A0 =C2=A0struct vhost_user *u;<br>
=C2=A0 =C2=A0 =C2=A0int err;<br>
<br>
@@ -1454,6 +1475,27 @@ static int vhost_user_backend_init(struct vhost_dev =
*dev, void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;slave-req protocol features.&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* get max memory regions if backend supports =
configurable RAM slots */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_has_feature(dev-&gt;protocol_featu=
res,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_=
SLOTS)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;user-&gt;memory_slots =3D =
VHOST_MEMORY_MAX_NREGIONS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D vhost_user_get_max_memsl=
ots(dev, &amp;ram_slots);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ram_slots &lt; u-&gt;user-&g=
t;memory_slots) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot=
;The backend specified a max ram slots limit &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;of %lu, when the prior validated limit=
 was %d. &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;This limit should never decrease.&quot=
;, ram_slots,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u-&gt;user-&gt;memory_slots);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u-&gt;user-&gt;memory_slots =3D =
MIN(ram_slots, VHOST_MEMORY_MAX_NREGIONS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dev-&gt;migration_blocker =3D=3D NULL &amp;&amp;<br=
>
@@ -1519,7 +1561,9 @@ static int vhost_user_get_vq_index(struct vhost_dev *=
dev, int idx)<br>
<br>
=C2=A0static int vhost_user_memslots_limit(struct vhost_dev *dev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return VHOST_MEMORY_MAX_NREGIONS;<br>
+=C2=A0 =C2=A0 struct vhost_user *u =3D dev-&gt;opaque;<br>
+<br>
+=C2=A0 =C2=A0 return u-&gt;user-&gt;memory_slots;<br>
=C2=A0}<br>
<br>
=C2=A0static bool vhost_user_requires_shm_log(struct vhost_dev *dev)<br>
@@ -1904,6 +1948,7 @@ bool vhost_user_init(VhostUserState *user, CharBacken=
d *chr, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0user-&gt;chr =3D chr;<br>
+=C2=A0 =C2=A0 user-&gt;memory_slots =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.=
h<br>
index 811e325..a9abca3 100644<br>
--- a/include/hw/virtio/vhost-user.h<br>
+++ b/include/hw/virtio/vhost-user.h<br>
@@ -20,6 +20,7 @@ typedef struct VhostUserHostNotifier {<br>
=C2=A0typedef struct VhostUserState {<br>
=C2=A0 =C2=A0 =C2=A0CharBackend *chr;<br>
=C2=A0 =C2=A0 =C2=A0VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];<br>
+=C2=A0 =C2=A0 int memory_slots;<br>
=C2=A0} VhostUserState;<br>
<br>
=C2=A0bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **=
errp);<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000008354e805a7432710--

