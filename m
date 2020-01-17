Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A1EC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC9F2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERoAxdLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC9F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSAH-0006O3-8V
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isS9G-0005Zy-LC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isS9F-0004d4-GY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:58:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1isS9F-0004cI-AS
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:58:53 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so22829804wrr.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/C17xT504bgxw8glxY+LD35gYufGnIssE3mtjVhHq/Y=;
 b=ERoAxdLnus2jkkPRwqgcWT+04TczPegXcCMcpnDo8ZZBZBNHx/HbTxdCiLQFvBrJn9
 SXsvIqTIhu6zaHfp9l1rLGW0XPBQUhK+wLr5yY81GBqNrQaR2mZM5MokqCPsYgx+X4dA
 xbLrYjjwKQyT//Z7C4yb377sCT1Bx0dKLbCYy42rs2Y575NOOqROU2PPdRMXH6ko0enU
 2yevmgmodm1o1QYOEMt/v9PZiaL9HZjmiOoEp7CpViLWCeKEt50k5S/AuTjyoFdel86d
 C8k4UNPkbVhacC5az+9fsTEs/RE7rIF8GW1jpA6z+bSiYXiSBPYcGYEkUt8zMFJ+ABmc
 9BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/C17xT504bgxw8glxY+LD35gYufGnIssE3mtjVhHq/Y=;
 b=dbm6whTTxFdmo5m/zhJECq9PzSOXnZQjNPrFPbrKwQapVwbCN3pyCOw6OJF3kpBbd6
 e2J2ZaUJpbBEm4n97ACjvtFSsnA0tZBsO8KW5/bNoCaH4iQ++U1kOzMVb9f1+8V3buhd
 V/YH9viGXdOuBqjjsGGO9f1f5GUqkLndGxJAsZyv2FFEOtXPxZkD+uIWv/JSzx4qwYRR
 fce0GezOX/Ov6TFyYgCHtLT+VgNdWkBmfqnq7KprSYoGrQNGUaN68hQXTk/6Dsv32/Eh
 7MLxlGFvawsBLjXlBY7+Zo7yXgnQKQhr2GtXOlXsP3uHsvAW0crb5evrvERDs412cr1C
 WRCA==
X-Gm-Message-State: APjAAAW4e3p3yIJOManaqIzZJj37JxGFK8XDbH5YhA/BcDVdK5EISe5m
 XRM4TumVQo/N1fON/DDuekf7ILTanfEqe8J0TXg=
X-Google-Smtp-Source: APXvYqwoBGRUtJxviZ/Ns4EIB+lpjQTWerarTtVDfZMqI/9yqlIdq1/ScUHIxHaavTGqRnWirABtA1VzguHf9FaIN/g=
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr3020005wrt.381.1579269532127; 
 Fri, 17 Jan 2020 05:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-92-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-92-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Jan 2020 17:58:39 +0400
Message-ID: <CAJ+F1CKRGS_bzm=HXQrswE2nVvP-Nfur80YZK790nO-xkCNxcg@mail.gmail.com>
Subject: Re: [PATCH 091/104] libvhost-user: Fix some memtable remap cases
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Dec 12, 2019 at 10:05 PM Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> If a new setmemtable command comes in once the vhost threads are
> running, it will remap the guests address space and the threads
> will now be looking in the wrong place.
>
> Fortunately we're running this command under lock, so we can
> update the queue mappings so that threads will look in the new-right
> place.
>
> Note: This doesn't fix things that the threads might be doing
> without a lock (e.g. a readv/writev!)  That's for another time.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 33 ++++++++++++++++++++-------
>  contrib/libvhost-user/libvhost-user.h |  3 +++
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 63e41062a4..b89bf18501 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -564,6 +564,21 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
>      return false;
>  }
>
> +static bool
> +map_ring(VuDev *dev, VuVirtq *vq)
> +{
> +    vq->vring.desc =3D qva_to_va(dev, vq->vra.desc_user_addr);
> +    vq->vring.used =3D qva_to_va(dev, vq->vra.used_user_addr);
> +    vq->vring.avail =3D qva_to_va(dev, vq->vra.avail_user_addr);
> +
> +    DPRINT("Setting virtq addresses:\n");
> +    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
> +    DPRINT("    vring_used  at %p\n", vq->vring.used);
> +    DPRINT("    vring_avail at %p\n", vq->vring.avail);
> +
> +    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
> +}
> +
>  static bool
>  vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>  {
> @@ -767,6 +782,14 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg=
)
>          close(vmsg->fds[i]);
>      }
>
> +    for (i =3D 0; i < dev->max_queues; i++) {
> +        if (dev->vq[i].vring.desc) {

The code usually checks for all (vq->vring.desc && vq->vring.used &&
vq->vring.avail).

Perhaps we should introduce a VQ_RING_IS_SET() macro?

> +            if (map_ring(dev, &dev->vq[i])) {
> +                vu_panic(dev, "remaping queue %d during setmemtable", i)=
;
> +            }
> +        }
> +    }
> +
>      return false;
>  }
>
> @@ -853,18 +876,12 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vm=
sg)
>      DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", vra->avail_user_a=
ddr);
>      DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", vra->log_guest_ad=
dr);
>
> +    vq->vra =3D *vra;
>      vq->vring.flags =3D vra->flags;
> -    vq->vring.desc =3D qva_to_va(dev, vra->desc_user_addr);
> -    vq->vring.used =3D qva_to_va(dev, vra->used_user_addr);
> -    vq->vring.avail =3D qva_to_va(dev, vra->avail_user_addr);
>      vq->vring.log_guest_addr =3D vra->log_guest_addr;
>
> -    DPRINT("Setting virtq addresses:\n");
> -    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
> -    DPRINT("    vring_used  at %p\n", vq->vring.used);
> -    DPRINT("    vring_avail at %p\n", vq->vring.avail);
>
> -    if (!(vq->vring.desc && vq->vring.used && vq->vring.avail)) {
> +    if (map_ring(dev, vq)) {
>          vu_panic(dev, "Invalid vring_addr message");
>          return false;
>      }
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 1844b6f8d4..5cb7708559 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -327,6 +327,9 @@ typedef struct VuVirtq {
>      int err_fd;
>      unsigned int enable;
>      bool started;
> +
> +    /* Guest addresses of our ring */
> +    struct vhost_vring_addr vra;
>  } VuVirtq;
>
>  enum VuWatchCondtion {
> --
> 2.23.0
>
>

Looks reasonable otherwise (assuming all running threads were flushed
somehow by other means)

--=20
Marc-Andr=C3=A9 Lureau

