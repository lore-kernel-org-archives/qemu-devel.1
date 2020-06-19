Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F20C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76572080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvfYLev2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76572080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGdS-0004Y4-0M
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGc9-00041o-Fb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:59:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGc7-0008HA-SF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:59:25 -0400
Received: by mail-ot1-x344.google.com with SMTP id v13so7198355otp.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sSuLvvKjzi2Y6jWYpBFJevMTyP3Y677SbSR9aFukgBk=;
 b=lvfYLev2s48e9pMWoWwWtqeid37o3A6lGS6yfASJS/A6xH2jExeRM/rwgAB4L5nKgN
 dk64T18p7ABYfbl+ND6u2/s6Pun1pYxSjG/XhsrQJ07iwbM5dfO6J52QWxQ7YRKN73gp
 wdsUj3mkyaEXjxV5X5V4E92d2cs96jnFAFUbrNmFPd6HKG/eVyPwPqIioMD+ldywdIE4
 zifTTQaobEZ8ZHPsBLW5VRR5DXr1D+Hc800Nycey4AlZiK8WDpB9ryGiuEVESQS79mQA
 UK5rN8Oz86ytuzNRmAiL8lm5+WoTdVAl3Wyjw/3MJhy5F1JfW4+uRC7ipD2gXGqK3QJ/
 26vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sSuLvvKjzi2Y6jWYpBFJevMTyP3Y677SbSR9aFukgBk=;
 b=BxnBysyHXHbr8VsbWc4irACAW+ymJC7nymsqFsBKUFyiVzxBJb92UJVz6vt8oT5hi2
 Q3/ghc+OsHESxPa+Y/6aelaf6CO2W7UCQAH0NHtoLJqaFE189SpSstmf1ukhMnJ8NDaE
 fHr/n/nPaWmSNj8M2m7CGl7zwnNmY49Dv5pKhV+QQ72VJSFyVfvh1CMaVDZ/QJQB0aIf
 sgxwrFF/p5V4qsrvu1F8EPgMhwOtABn2EnP6XZQSNuLOYycyOE372CuItm9ed3Sbhjf/
 rNmzD0v7LpvtK7ZR7jx8C9XyuXDdHwB/ndAdVj1qKKU8udOdcygaSU79SWghambP8RTl
 1n9Q==
X-Gm-Message-State: AOAM533OvIEKka7q8n9mA42YQKE+BHz/HheqCIte/f9JJ477CPMEXoa4
 Kpjsj0hBmuuan3fKIxXvVRg7PpO/fs62LfvVlbCFvg==
X-Google-Smtp-Source: ABdhPJxAgndkzp1tWLO83f55NUtGjTSmEQT4kXoyAQE5Nh+UyL37felKCjrRwmaDbq6a+jN9u2sXGgVewqAi7nLgW/w=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr2944838ote.135.1592571562640; 
 Fri, 19 Jun 2020 05:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200612141917.9446-1-mst@redhat.com>
 <20200612141917.9446-37-mst@redhat.com>
In-Reply-To: <20200612141917.9446-37-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 13:59:11 +0100
Message-ID: <CAFEAcA_kvr4FRfExuxyjA_9=Fm09QMum-EC0fmgp5ki3SC0yzQ@mail.gmail.com>
Subject: Re: [PULL v2 36/58] Add helper to populate vhost-user message regions
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jun 2020 at 15:52, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Raphael Norwitz <raphael.norwitz@nutanix.com>
>
> When setting vhost-user memory tables, memory region descriptors must be
> copied from the vhost_dev struct to the vhost-user message. To avoid
> duplicating code in setting the memory tables, we should use a helper to
> populate this field. This change adds this helper.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Message-Id: <1588533678-23450-2-git-send-email-raphael.norwitz@nutanix.co=
m>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Hi; Coverity reports a problem with this patch (CID 1429804):

> ---
>  hw/virtio/vhost-user.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ec21e8fbe8..2e0552dd74 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -407,6 +407,15 @@ static int vhost_user_set_log_base(struct vhost_dev =
*dev, uint64_t base,
>      return 0;
>  }
>
> +static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
> +                                       struct vhost_memory_region *src)
> +{
> +    assert(src !=3D NULL && dst !=3D NULL);
> +    dst->userspace_addr =3D src->userspace_addr;
> +    dst->memory_size =3D src->memory_size;
> +    dst->guest_phys_addr =3D src->guest_phys_addr;

This function only initializes 3 of the 4 fields of
the VhostUserMemoryRegion struct...

> +}
> +
>  static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
>                                               struct vhost_dev *dev,
>                                               VhostUserMsg *msg,
> @@ -417,6 +426,7 @@ static int vhost_user_fill_set_mem_table_msg(struct v=
host_user *u,
>      ram_addr_t offset;
>      MemoryRegion *mr;
>      struct vhost_memory_region *reg;
> +    VhostUserMemoryRegion region_buffer;

...this variable starts uninitialized...

>
>      msg->hdr.request =3D VHOST_USER_SET_MEM_TABLE;
>
> @@ -441,12 +451,8 @@ static int vhost_user_fill_set_mem_table_msg(struct =
vhost_user *u,
>                  error_report("Failed preparing vhost-user memory table m=
sg");
>                  return -1;
>              }
> -            msg->payload.memory.regions[*fd_num].userspace_addr =3D
> -                reg->userspace_addr;
> -            msg->payload.memory.regions[*fd_num].memory_size =3D
> -                reg->memory_size;
> -            msg->payload.memory.regions[*fd_num].guest_phys_addr =3D
> -                reg->guest_phys_addr;
> +            vhost_user_fill_msg_region(&region_buffer, reg);
> +            msg->payload.memory.regions[*fd_num] =3D region_buffer;

...so this struct copy is copying uninitialized data...

>              msg->payload.memory.regions[*fd_num].mmap_offset =3D offset;

...which coverity complains about even though it happens that the
following line fills in that field in the target of the struct copy.

>              fds[(*fd_num)++] =3D fd;
>          } else if (track_ramblocks) {

Coverity also complains about both of the other places that call
this function for similar reasons. My suggested fix: make
vhost_user_fill_msg_region() take an extra argument "uint64_t mmap_offset",
which it uses to initialize the dst->mmap_offset. Then you can
pass in "offset" at this callsite and delete the manual initialization
of .mmap_offset; and similarly for the other two callsites.

thanks
-- PMM

