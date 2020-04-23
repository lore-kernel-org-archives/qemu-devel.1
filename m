Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E426C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561B220767
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ark1vaAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561B220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiBl-0000HD-EW
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRiAw-0007tj-7O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jRiAv-0001LG-EJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:10:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jRiAv-0001Kr-0R; Thu, 23 Apr 2020 16:10:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id g13so8141496wrb.8;
 Thu, 23 Apr 2020 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z9f4qcghqqChaKbIo/kHdmUzpLND5o5JoxABP/ZOgPI=;
 b=Ark1vaAicksms0fdtESlhzFjUbPjqXwvL5Q1VohhjtnV0i8VfjEA51P1MihNLEPjRc
 wrWAlDfk9BcCRh4Epf/U2248OPh73z1xwhNkNP0CPG7fAG2M2EhIVjaIRIewmcJUcLi5
 qyFqCLkZd6N2c4U2ts2/ymnwaR0XK1NO8B9UxNru4vd0VawUH3NlCGQYrjAV/yNOA86b
 11R8389GblE7qyRlAdpv0ar9yAQ0qOM52qTCSDGM7ZBaqlS115OvUco3ZFwHWf5IkrW9
 LymUmczyN+9/JdklyEsHzGDwJICjHe0VQd04ktFSSHQ4iuJf06BhG6bphpvGYF/3UpHR
 vL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z9f4qcghqqChaKbIo/kHdmUzpLND5o5JoxABP/ZOgPI=;
 b=dpwsuxD3EGvDxLzj3DsdcgGJ4AWkDaDHvkIIu+4x+N/Zc0rohBPZ6q9McTtdCCNPi9
 EAuQNxWka39F/+aytBzV7pFJmZgXR+Pw/bzCX0fazE5iOMHh2n2p2XzVbTJGWMkE1+ds
 wYuokAr3o7Ozb1+md15hCLrtmwRXH0a58HE6WGKlyytkTxwe+/tv9N/wp+NBK/izJcJA
 c+qRQA0zwmXgs4onjbcQs1b4iRKdpgq5I3JWIIMSgWw2FBHfhHTdxkLybIA85W8zk7qp
 mVOROSgmp0hnPDpaHUGGcC8iNqsmvu2pcRXJiWTy0oBDiw/dFXDfw7MWSUF2H+901OqL
 GQww==
X-Gm-Message-State: AGi0PuaipeTqJewuixp4NXCd+P2wlulaDUIbb7NfSoT5Cow2qlqhcSu5
 RUFyd+IITds96EU1aWk+0b/mkdCC7Zu3nZfpi9E=
X-Google-Smtp-Source: APiQypI/xx4SMBvT0VYcUHtLl8jb9rC2s+ceIeoF2lvcr18xlyToHJltrwEgxW2zu89Bz55ECysku+IKHpttShkYa9U=
X-Received: by 2002:adf:ed07:: with SMTP id a7mr7108690wro.2.1587672619124;
 Thu, 23 Apr 2020 13:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587667007.git.dimastep@yandex-team.ru>
 <045f356cec6f07300819d28457a2bb8876d1c887.1587667007.git.dimastep@yandex-team.ru>
In-Reply-To: <045f356cec6f07300819d28457a2bb8876d1c887.1587667007.git.dimastep@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Apr 2020 22:10:06 +0200
Message-ID: <CAJ+F1C+GhNOmArLKAzugNZ6EdyTi6frFJr0mAjah6Z=moePM5w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/7] char-socket: return -1 in case of disconnect
 during tcp_chr_write
To: Dima Stepanov <dimastep@yandex-team.ru>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Gonglei <arei.gonglei@huawei.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Apr 23, 2020 at 8:43 PM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
>
> During testing of the vhost-user-blk reconnect functionality the qemu
> SIGSEGV was triggered:
>  start qemu as:
>  x86_64-softmmu/qemu-system-x86_64 -m 1024M -M q35 \
>    -object memory-backend-file,id=3Dram-node0,size=3D1024M,mem-path=3D/de=
v/shm/qemu,share=3Don \
>    -numa node,cpus=3D0,memdev=3Dram-node0 \
>    -chardev socket,id=3Dchardev0,path=3D./vhost.sock,noserver,reconnect=
=3D1 \
>    -device vhost-user-blk-pci,chardev=3Dchardev0,num-queues=3D4 --enable-=
kvm
>  start vhost-user-blk daemon:
>  ./vhost-user-blk -s ./vhost.sock -b test-img.raw
>
> If vhost-user-blk will be killed during the vhost initialization
> process, for instance after getting VHOST_SET_VRING_CALL command, then
> QEMU will fail with the following backtrace:
>
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x00005555559272bb in vhost_user_read (dev=3D0x7fffef2d53e0, msg=3D0x7fff=
ffffd5b0)
>     at ./hw/virtio/vhost-user.c:260
> 260         CharBackend *chr =3D u->user->chr;
>
>  #0  0x00005555559272bb in vhost_user_read (dev=3D0x7fffef2d53e0, msg=3D0=
x7fffffffd5b0)
>     at ./hw/virtio/vhost-user.c:260
>  #1  0x000055555592acb8 in vhost_user_get_config (dev=3D0x7fffef2d53e0, c=
onfig=3D0x7fffef2d5394 "", config_len=3D60)
>     at ./hw/virtio/vhost-user.c:1645
>  #2  0x0000555555925525 in vhost_dev_get_config (hdev=3D0x7fffef2d53e0, c=
onfig=3D0x7fffef2d5394 "", config_len=3D60)
>     at ./hw/virtio/vhost.c:1490
>  #3  0x00005555558cc46b in vhost_user_blk_device_realize (dev=3D0x7fffef2=
d51a0, errp=3D0x7fffffffd8f0)
>     at ./hw/block/vhost-user-blk.c:429
>  #4  0x0000555555920090 in virtio_device_realize (dev=3D0x7fffef2d51a0, e=
rrp=3D0x7fffffffd948)
>     at ./hw/virtio/virtio.c:3615
>  #5  0x0000555555a9779c in device_set_realized (obj=3D0x7fffef2d51a0, val=
ue=3Dtrue, errp=3D0x7fffffffdb88)
>     at ./hw/core/qdev.c:891
>  ...
>
> The problem is that vhost_user_write doesn't get an error after
> disconnect and try to call vhost_user_read(). The tcp_chr_write()
> routine should return -1 in case of disconnect. Indicate the EIO error
> if this routine is called in the disconnected state.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  chardev/char-socket.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 185fe38..c128cca 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -175,14 +175,16 @@ static int tcp_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
>          if (ret < 0 && errno !=3D EAGAIN) {
>              if (tcp_chr_read_poll(chr) <=3D 0) {
>                  tcp_chr_disconnect_locked(chr);
> -                return len;
> +                /* Return an error since we made a disconnect. */
> +                return ret;

Looks ok, but this return was introduced in commit
b0a335e351103bf92f3f9d0bd5759311be8156ac ("qemu-char: socket backend:
disconnect on write error"). It doesn't say why it didn't return -1
though. Anton, could you review? thanks

>              } /* else let the read handler finish it properly */
>          }
>
>          return ret;
>      } else {
> -        /* XXX: indicate an error ? */
> -        return len;
> +        /* Indicate an error. */
> +        errno =3D EIO;
> +        return -1;
>      }
>  }
>
> --
> 2.7.4
>
>


--=20
Marc-Andr=C3=A9 Lureau

