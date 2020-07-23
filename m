Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB809C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5B520723
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLYTZ5aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5B520723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySYQ-0006B1-Oo
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 00:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jySXi-0005l1-Ju
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 00:09:14 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jySXg-0006pY-Uw
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 00:09:14 -0400
Received: by mail-io1-xd44.google.com with SMTP id i4so4858522iov.11
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 21:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EDmXCuj3GyBTjIgoSsp9va5QPQnTgXUVMMZGJ0hNjyk=;
 b=QLYTZ5aCFvq6n4fIQ/NQYTgJWOM1fociRf4wmbN1ZN0vYST7It9/i5qotFdeQEtChU
 AfpYDfw2BwPGE887TBy/BN84vSevkQQ6w8nKnntla+N1oMMi8mwyZ49O7ZdgJVzoPZaG
 Zl7d9MHqp3Pk75ZAbaJRJfTtjTIdnYrvjpFoQykjtqBoYo8dw03lG40OrYpBhIDftW5X
 r65N7lwhiwG3sklPxeF6UUqalZ3w8geQWJDuhDB82j6iQuuoOafy45+mYfYvX1IgItpy
 qx/o0SKDINwCZgGVu+WverxKX9nzqttavakurzf2Fh4iosFXcOwnmdIRC9+5blw14PBd
 hqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EDmXCuj3GyBTjIgoSsp9va5QPQnTgXUVMMZGJ0hNjyk=;
 b=TaSxsjGRc7LgXJg1Sa0eScHY16/X8EfscOyOw7rvTH4PBgnQeGVlL/PtTLknYDhrUM
 6b3lVtV3v+q6XiBBrSkLsLnTcA+ZMVj5T0RZX5yTsv5nl2TuT0T/dIzq4Fo3SPRBze6L
 xLIiOmdWxbyva9ncbJbieIdkp2oxaTo4VJWhdm1YZ3dG2S8ZtPiQ/Vs/2RtG7Kn5609X
 3F1Y/5OUdXpD9kYzZOnMQS6I3PkOcPBdwwapPhnfzt6lQQM35w/nB7MdOJr6h8dp/5xU
 AH0nlZrD7SEClX+f9IornS5KaTCdq6B/zKUA+iAxomss1e2Jk1BEfFhdg5LNFlHYYu+U
 wTiQ==
X-Gm-Message-State: AOAM533qexeOTg5J+nhbvsbnSpP/cvZKy9KefZH4mT2ekxvb7NyHXkVl
 Z+L28v5eyw0WKpPyGEqIjUubCxGXkai1/Ig3fiY=
X-Google-Smtp-Source: ABdhPJzmmA0MOaTuPIrTq/kT92TFYFbhuQNXE5um5c0dOO9wPxLvyDgHnMz0b756MUSvwDGPuRYNHwXd4uop0V/EOmM=
X-Received: by 2002:a02:7f89:: with SMTP id r131mr2717356jac.98.1595477351211; 
 Wed, 22 Jul 2020 21:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <1594799958-31356-1-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1594799958-31356-1-git-send-email-raphael.norwitz@nutanix.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 22 Jul 2020 22:08:59 -0600
Message-ID: <CAFubqFs90JNBLD6fmgvRtbKbPAd8+zzY8nt9C6m3+bj0kPTCjg@mail.gmail.com>
Subject: Re: [PATCH] Fix vhost-user buffer over-read on ram hot-unplug
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Peter Turschmid <peter.turschm@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping


On Thu, Jul 16, 2020 at 10:21 PM Raphael Norwitz
<raphael.norwitz@nutanix.com> wrote:
>
> The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS vhost-user protocol
> feature introduced a shadow-table, used by the backend to dynamically
> determine how a vdev's memory regions have changed since the last
> vhost_user_set_mem_table() call. On hot-remove, a memmove() operation
> is used to overwrite the removed shadow region descriptor(s). The size
> parameter of this memmove was off by 1 such that if a VM with a backend
> supporting the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS filled it's
> shadow-table (by performing the maximum number of supported hot-add
> operatons) and attempted to remove the last region, Qemu would read an
> out of bounds value and potentially crash.
>
> This change fixes the memmove() bounds such that this erroneous read can
> never happen.
>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 3123121..d7e2423 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -672,7 +672,7 @@ static int send_remove_regions(struct vhost_dev *dev,
>          memmove(&u->shadow_regions[shadow_reg_idx],
>                  &u->shadow_regions[shadow_reg_idx + 1],
>                  sizeof(struct vhost_memory_region) *
> -                (u->num_shadow_regions - shadow_reg_idx));
> +                (u->num_shadow_regions - shadow_reg_idx - 1));
>          u->num_shadow_regions--;
>      }
>
> --
> 1.8.3.1
>
>

