Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B0EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7625B20673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUa4B32f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7625B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsVE-0006hQ-AH
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:32:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hYsTr-00065B-Cu
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hYsTa-0004gv-RO
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:30:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hYsTa-0004Zc-Ek; Thu, 06 Jun 2019 09:30:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id b17so1345029wrq.11;
	Thu, 06 Jun 2019 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=NclMiI9dNCtXTcVd2vBcghCgJYacivIg8AK4Wn8pWto=;
	b=LUa4B32f1ZU6csxVlwgSzomkpKvkn7Q+eP4XKOJFw+1id0q+PBRbKyeZPxKBAw6sWD
	Wuxn0UxKsKcj20Rtu8z8vBk4obYACDDVMqmutBAc6SYrsUIAFuaxvuPxm5fp3pLRHw2C
	hSw5zSJ95Andgzm/XZ/m30ShhMblcBPqWFG0eQLosUKQyW1plpz49iFRf04XtjQGi2ou
	NEA6j0+JPFEp0CvuiRC5J/TVBom3f1KfZnzo0KIa7SGjpvI4jMxgGjcZnNSlGWrcQt3h
	wDYrICXBbFLlnr8SED7GyyeyaPvUi0U1h5wSwvEJmC2u/0kztGzGbWonuL262qYo7Zxo
	sgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=NclMiI9dNCtXTcVd2vBcghCgJYacivIg8AK4Wn8pWto=;
	b=REnkCdPnB1UD8FpYkwi08u4DqSOfkJ3hITms9D9keSAapaWdRlR9rPux4F23GDul6I
	owMOLxlkDN6H1R21w6LjuofHNWmXn9017ixKzJRpTGtxF6hDKAFiolNpcygFK2Nv4Lle
	3eUnPTwJ5zCoG9M2SnnsKxvYyP2m5liihztas5S/0H5V4Nr0z1VMOH7gIrg9xgwJ5yuZ
	xMQYpqDk8Ak644aE78zk8ZfpQapnEitT/VnvgAWAGrlHzO84Yt4clAPLAWbktVgNxgwS
	gR9L9XVR1bNQVIWaYT97Uu3mN7sEeKsK37HgWCLXJeoYPUxaInzfpYkhWZFDOzGnFaG1
	R/tw==
X-Gm-Message-State: APjAAAVVa1ld5jUXx8RV8Z6WlxF5IvD1yK1FGLjFR9ANRkxO5UXhAAPl
	M49uBIIWBOaHBIJp5CxgfbISd/TJ79drPdBbQYY=
X-Google-Smtp-Source: APXvYqyRJF1utCtBoqHB9/CbcgecAju6oAl9db8XrP09vcwrSKMOdKZbkecm3GvP40DTWnQheYpvu0FepnhO4tPo6Po=
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr28065335wrv.186.1559827841014; 
	Thu, 06 Jun 2019 06:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190426061815.6384-1-tiwei.bie@intel.com>
In-Reply-To: <20190426061815.6384-1-tiwei.bie@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Jun 2019 15:30:29 +0200
Message-ID: <CAJ+F1CKjHprs15oqrB8K2COUunjeGx-y7kBvAtaxJ17n5yt+iQ@mail.gmail.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix reconnection support for
 host notifier
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: cunming.liang@intel.com, qemu-stable <qemu-stable@nongnu.org>,
	QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Apr 26, 2019 at 8:32 AM Tiwei Bie <tiwei.bie@intel.com> wrote:
>
> We need to destroy the host notifiers when cleaning up
> the backend. Otherwise, some resources are not released
> after the connection is closed, and it may prevent the
> external backend from reopening them (e.g. VFIO files)
> during restart.
>
> Fixes: 44866521bd6e ("vhost-user: support registering external host notif=
iers")
> Cc: qemu-stable@nongnu.org
>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  hw/virtio/vhost-user.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 553319c7ac..56656629c0 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1454,10 +1454,24 @@ static int vhost_user_backend_init(struct vhost_d=
ev *dev, void *opaque)
>  static int vhost_user_backend_cleanup(struct vhost_dev *dev)
>  {
>      struct vhost_user *u;
> +    VhostUserState *user;
> +    int i;
>
>      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
>
>      u =3D dev->opaque;
> +
> +    if (dev->vq_index =3D=3D 0) {
> +        user =3D u->user;
> +        for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> +            if (user->notifier[i].addr) {
> +                object_unparent(OBJECT(&user->notifier[i].mr));
> +                munmap(user->notifier[i].addr, qemu_real_host_page_size)=
;
> +                user->notifier[i].addr =3D NULL;
> +            }
> +        }
> +    }

Why not call vhost_user_cleanup() ? Alternatively, factor the notifier
code in a seperate vhost_user_notifiers_cleanup() ?

> +
>      if (u->postcopy_notifier.notify) {
>          postcopy_remove_notifier(&u->postcopy_notifier);
>          u->postcopy_notifier.notify =3D NULL;
> @@ -1881,6 +1895,8 @@ bool vhost_user_init(VhostUserState *user, CharBack=
end *chr, Error **errp)
>          error_setg(errp, "Cannot initialize vhost-user state");
>          return false;
>      }
> +
> +    memset(user, 0, sizeof(*user));

This looks superflous. Is it really needed?

I wish there would be some basic tests for external host notifiers. Is
it too much to ask to add it in vhost-user-test.c ?


>      user->chr =3D chr;
>      return true;
>  }
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

