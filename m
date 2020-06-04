Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2480CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4320206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh9gnXQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4320206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgrBZ-0000WW-12
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgrAj-0008Hi-7g
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:48:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgrAh-0003Xl-IE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:48:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so6454247wru.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5GcStV6ZzpZBcn32nvVuiy79ft6mGv/2LVgYcwWDD2Q=;
 b=Oh9gnXQ0XbYQBMNgvk2DBUTRpNjTJ9RBQmxTs90mknIF5tm1heMR3JULVygGUre0Iz
 cwmuRHVQdKKlGvfTwsnAZMIzza4+DhPK4/VyMHIgob8eQAGBfZFS+8cYtcsLZ/c7U18T
 e3JqPbZQU2oiks9QC8Sk9K2b3PS4CqL01ymLROShbXhJr2VBID2S3tXASQqqfXUMPwME
 82x/qdGP1AVvWcQivtDNBT/uAPOgjT+dvF4rD6wuVuYdxNnfLSOXxiu2QymqyiCtKoeN
 0G38fTlwBfWIVRHGZqD2nCxwnpM/ekB+NKiRGOJ2QhRq0pJWjrfJllR1wOT0kag8Uzkj
 N4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5GcStV6ZzpZBcn32nvVuiy79ft6mGv/2LVgYcwWDD2Q=;
 b=nIJMm3dhjNezwRkli+Ed8O4+RauGHorcU+RVLBcq/XG/P02copxyliIAcyKZCVUV4s
 XOINyZEItWj//2+UsYojqLc9wNw1viGIiD0Gt70xtTd+LkemuxEoj6ErZ4+YaRWh/9Ux
 gTh6h9utA0Xy8BUu0JorG9SaWx8nJdOfThbnvFoxCLhe1+lmZyZeOccmm2VcuJk/+Pq0
 UWJ3qh/C5aS6/LN8LUgF9RyrIgPMxhMgSWjpTcN7nS7VKDUvbcHxHDKN+yfmMj1ujd50
 xUjYLQ2gG4VAG6d2uLzHPGctdQKayDOE94muooKOrmam/LWHBCTC9/aVrfstS9RTcBEO
 eeLQ==
X-Gm-Message-State: AOAM532MvPsobAuP6tlh7LlqzyliuzCn4pGAcdIKTCdeV7Gyqf5pDv7S
 b11Z5iukuv0ZSSWR5qri4BrajBRKKUTOX4lVdi5aaahjtfk=
X-Google-Smtp-Source: ABdhPJzauwcembwmcQcvQBaidsq/ah8+2Xo+ZVpfScQFzJJHItmnKvSsx0iUhtnwFhcZECjuUPbVhXU6yKFHrLbtJHc=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr4944019wrr.96.1591282121985;
 Thu, 04 Jun 2020 07:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
 <1588533678-23450-7-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1588533678-23450-7-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Jun 2020 16:48:30 +0200
Message-ID: <CAJ+F1CK1=UqTA2FzyvVz7UcspYQhSG1NO5mph3DmS-_mieDj_Q@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] Refactor out libvhost-user fault generation logic
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: multipart/alternative; boundary="0000000000009e534105a7433d44"
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
Cc: Raphael Norwitz <raphael.s.norwitz@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009e534105a7433d44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 21, 2020 at 7:00 AM Raphael Norwitz <raphael.norwitz@nutanix.co=
m>
wrote:

> In libvhost-user, the incoming postcopy migration path for setting the
> backend's memory tables has become convolued. In particular, moving the
> logic which starts generating faults, having received the final ACK from
> qemu can be moved to a separate function. This simplifies the code
> substantially.
>
> This logic will also be needed by the postcopy path once the
> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS feature is supported.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  contrib/libvhost-user/libvhost-user.c | 147
> ++++++++++++++++++----------------
>  1 file changed, 79 insertions(+), 68 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index 3bca996..cccfa22 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -584,6 +584,84 @@ map_ring(VuDev *dev, VuVirtq *vq)
>  }
>
>  static bool
> +generate_faults(VuDev *dev) {
> +    int i;
> +    for (i =3D 0; i < dev->nregions; i++) {
> +        VuDevRegion *dev_region =3D &dev->regions[i];
> +        int ret;
> +#ifdef UFFDIO_REGISTER
> +        /*
> +         * We should already have an open ufd. Mark each memory
> +         * range as ufd.
> +         * Discard any mapping we have here; note I can't use MADV_REMOV=
E
> +         * or fallocate to make the hole since I don't want to lose
> +         * data that's already arrived in the shared process.
> +         * TODO: How to do hugepage
> +         */
> +        ret =3D madvise((void *)(uintptr_t)dev_region->mmap_addr,
> +                      dev_region->size + dev_region->mmap_offset,
> +                      MADV_DONTNEED);
> +        if (ret) {
> +            fprintf(stderr,
> +                    "%s: Failed to madvise(DONTNEED) region %d: %s\n",
> +                    __func__, i, strerror(errno));
> +        }
> +        /*
> +         * Turn off transparent hugepages so we dont get lose wakeups
> +         * in neighbouring pages.
> +         * TODO: Turn this backon later.
> +         */
> +        ret =3D madvise((void *)(uintptr_t)dev_region->mmap_addr,
> +                      dev_region->size + dev_region->mmap_offset,
> +                      MADV_NOHUGEPAGE);
> +        if (ret) {
> +            /*
> +             * Note: This can happen legally on kernels that are
> configured
> +             * without madvise'able hugepages
> +             */
> +            fprintf(stderr,
> +                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
> +                    __func__, i, strerror(errno));
> +        }
> +        struct uffdio_register reg_struct;
> +        reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
> +        reg_struct.range.len =3D dev_region->size + dev_region->mmap_off=
set;
> +        reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> +
> +        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
> +            vu_panic(dev, "%s: Failed to userfault region %d "
> +                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
> +                     __func__, i,
> +                     dev_region->mmap_addr,
> +                     dev_region->size, dev_region->mmap_offset,
> +                     dev->postcopy_ufd, strerror(errno));
> +            return false;
> +        }
> +        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
> +            vu_panic(dev, "%s Region (%d) doesn't support COPY",
> +                     __func__, i);
> +            return false;
> +        }
> +        DPRINT("%s: region %d: Registered userfault for %"
> +               PRIx64 " + %" PRIx64 "\n", __func__, i,
> +               (uint64_t)reg_struct.range.start,
> +               (uint64_t)reg_struct.range.len);
> +        /* Now it's registered we can let the client at it */
> +        if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
> +                     dev_region->size + dev_region->mmap_offset,
> +                     PROT_READ | PROT_WRITE)) {
> +            vu_panic(dev, "failed to mprotect region %d for postcopy
> (%s)",
> +                     i, strerror(errno));
> +            return false;
> +        }
> +        /* TODO: Stash 'zero' support flags somewhere */
> +#endif
> +    }
> +
> +    return true;
> +}
> +
> +static bool
>  vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      int i;
> @@ -655,74 +733,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev,
> VhostUserMsg *vmsg)
>      }
>
>      /* OK, now we can go and register the memory and generate faults */
> -    for (i =3D 0; i < dev->nregions; i++) {
> -        VuDevRegion *dev_region =3D &dev->regions[i];
> -        int ret;
> -#ifdef UFFDIO_REGISTER
> -        /* We should already have an open ufd. Mark each memory
> -         * range as ufd.
> -         * Discard any mapping we have here; note I can't use MADV_REMOV=
E
> -         * or fallocate to make the hole since I don't want to lose
> -         * data that's already arrived in the shared process.
> -         * TODO: How to do hugepage
> -         */
> -        ret =3D madvise((void *)(uintptr_t)dev_region->mmap_addr,
> -                      dev_region->size + dev_region->mmap_offset,
> -                      MADV_DONTNEED);
> -        if (ret) {
> -            fprintf(stderr,
> -                    "%s: Failed to madvise(DONTNEED) region %d: %s\n",
> -                    __func__, i, strerror(errno));
> -        }
> -        /* Turn off transparent hugepages so we dont get lose wakeups
> -         * in neighbouring pages.
> -         * TODO: Turn this backon later.
> -         */
> -        ret =3D madvise((void *)(uintptr_t)dev_region->mmap_addr,
> -                      dev_region->size + dev_region->mmap_offset,
> -                      MADV_NOHUGEPAGE);
> -        if (ret) {
> -            /* Note: This can happen legally on kernels that are
> configured
> -             * without madvise'able hugepages
> -             */
> -            fprintf(stderr,
> -                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
> -                    __func__, i, strerror(errno));
> -        }
> -        struct uffdio_register reg_struct;
> -        reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
> -        reg_struct.range.len =3D dev_region->size + dev_region->mmap_off=
set;
> -        reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> -
> -        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
> -            vu_panic(dev, "%s: Failed to userfault region %d "
> -                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
> -                     __func__, i,
> -                     dev_region->mmap_addr,
> -                     dev_region->size, dev_region->mmap_offset,
> -                     dev->postcopy_ufd, strerror(errno));
> -            return false;
> -        }
> -        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
> -            vu_panic(dev, "%s Region (%d) doesn't support COPY",
> -                     __func__, i);
> -            return false;
> -        }
> -        DPRINT("%s: region %d: Registered userfault for %"
> -               PRIx64 " + %" PRIx64 "\n", __func__, i,
> -               (uint64_t)reg_struct.range.start,
> -               (uint64_t)reg_struct.range.len);
> -        /* Now it's registered we can let the client at it */
> -        if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
> -                     dev_region->size + dev_region->mmap_offset,
> -                     PROT_READ | PROT_WRITE)) {
> -            vu_panic(dev, "failed to mprotect region %d for postcopy
> (%s)",
> -                     i, strerror(errno));
> -            return false;
> -        }
> -        /* TODO: Stash 'zero' support flags somewhere */
> -#endif
> -    }
> +    (void)generate_faults(dev);
>

>      return false;
>  }
> --
> 1.8.3.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000009e534105a7433d44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, May 21, 2020 at 7:00 AM Raphael Norwi=
tz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com">raphael.norwitz@nutan=
ix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">In libvhost-user, the incoming postcopy migration path for setting th=
e<br>
backend&#39;s memory tables has become convolued. In particular, moving the=
<br>
logic which starts generating faults, having received the final ACK from<br=
>
qemu can be moved to a separate function. This simplifies the code<br>
substantially.<br>
<br>
This logic will also be needed by the postcopy path once the<br>
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS feature is supported.<br>
<br>
Signed-off-by: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutani=
x.com" target=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br></blockquot=
e><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div>=
<div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0contrib/libvhost-user/libvhost-user.c | 147 ++++++++++++++++++-------=
---------<br>
=C2=A01 file changed, 79 insertions(+), 68 deletions(-)<br>
<br>
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c<br>
index 3bca996..cccfa22 100644<br>
--- a/contrib/libvhost-user/libvhost-user.c<br>
+++ b/contrib/libvhost-user/libvhost-user.c<br>
@@ -584,6 +584,84 @@ map_ring(VuDev *dev, VuVirtq *vq)<br>
=C2=A0}<br>
<br>
=C2=A0static bool<br>
+generate_faults(VuDev *dev) {<br>
+=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;nregions; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VuDevRegion *dev_region =3D &amp;dev-&gt;regio=
ns[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
+#ifdef UFFDIO_REGISTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We should already have an open ufd. Ma=
rk each memory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* range as ufd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Discard any mapping we have here; note=
 I can&#39;t use MADV_REMOVE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or fallocate to make the hole since I =
don&#39;t want to lose<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* data that&#39;s already arrived in the=
 shared process.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: How to do hugepage<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D madvise((void *)(uintptr_t)dev_region-=
&gt;mmap_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_region-&gt;size + dev_region-&gt;mmap_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MADV_DONTNEED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%s: Failed to madvise(DONTNEED) region %d: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fu=
nc__, i, strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Turn off transparent hugepages so we d=
ont get lose wakeups<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in neighbouring pages.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: Turn this backon later.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D madvise((void *)(uintptr_t)dev_region-=
&gt;mmap_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_region-&gt;size + dev_region-&gt;mmap_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MADV_NOHUGEPAGE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Note: This can happen le=
gally on kernels that are configured<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* without madvise&#39;able=
 hugepages<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fu=
nc__, i, strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct uffdio_register reg_struct;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_struct.range.start =3D (uintptr_t)dev_regi=
on-&gt;mmap_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_struct.range.len =3D dev_region-&gt;size +=
 dev_region-&gt;mmap_offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSI=
NG;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ioctl(dev-&gt;postcopy_ufd, UFFDIO_REGISTE=
R, &amp;reg_struct)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;%s: Failed t=
o userfault region %d &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__func__, i,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dev_region-&gt;mmap_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dev_region-&gt;size, dev_region-&gt;mmap_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dev-&gt;postcopy_ufd, strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(reg_struct.ioctls &amp; ((__u64)1 &lt;&l=
t; _UFFDIO_COPY))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;%s Region (%=
d) doesn&#39;t support COPY&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__func__, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINT(&quot;%s: region %d: Registered userfau=
lt for %&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PRIx64 &quot; + %&q=
uot; PRIx64 &quot;\n&quot;, __func__, i,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t)reg_struc=
t.range.start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t)reg_struc=
t.range.len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Now it&#39;s registered we can let the clie=
nt at it */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mprotect((void *)(uintptr_t)dev_region-&gt=
;mmap_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dev_region-&gt;size + dev_region-&gt;mmap_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PROT_READ | PROT_WRITE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;failed to mp=
rotect region %d for postcopy (%s)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0i, strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Stash &#39;zero&#39; support flags so=
mewhere */<br>
+#endif<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool<br>
=C2=A0vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
@@ -655,74 +733,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMs=
g *vmsg)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* OK, now we can go and register the memory and genera=
te faults */<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;nregions; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VuDevRegion *dev_region =3D &amp;dev-&gt;regio=
ns[i];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
-#ifdef UFFDIO_REGISTER<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We should already have an open ufd. Mark ea=
ch memory<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* range as ufd.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Discard any mapping we have here; note=
 I can&#39;t use MADV_REMOVE<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or fallocate to make the hole since I =
don&#39;t want to lose<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* data that&#39;s already arrived in the=
 shared process.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: How to do hugepage<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D madvise((void *)(uintptr_t)dev_region-=
&gt;mmap_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_region-&gt;size + dev_region-&gt;mmap_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MADV_DONTNEED);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%s: Failed to madvise(DONTNEED) region %d: %s\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fu=
nc__, i, strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Turn off transparent hugepages so we dont g=
et lose wakeups<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in neighbouring pages.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: Turn this backon later.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D madvise((void *)(uintptr_t)dev_region-=
&gt;mmap_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_region-&gt;size + dev_region-&gt;mmap_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MADV_NOHUGEPAGE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Note: This can happen legally=
 on kernels that are configured<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* without madvise&#39;able=
 hugepages<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fu=
nc__, i, strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct uffdio_register reg_struct;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_struct.range.start =3D (uintptr_t)dev_regi=
on-&gt;mmap_addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_struct.range.len =3D dev_region-&gt;size +=
 dev_region-&gt;mmap_offset;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSI=
NG;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ioctl(dev-&gt;postcopy_ufd, UFFDIO_REGISTE=
R, &amp;reg_struct)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;%s: Failed t=
o userfault region %d &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n&quot;,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__func__, i,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dev_region-&gt;mmap_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dev_region-&gt;size, dev_region-&gt;mmap_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dev-&gt;postcopy_ufd, strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(reg_struct.ioctls &amp; ((__u64)1 &lt;&l=
t; _UFFDIO_COPY))) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;%s Region (%=
d) doesn&#39;t support COPY&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__func__, i);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINT(&quot;%s: region %d: Registered userfau=
lt for %&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PRIx64 &quot; + %&q=
uot; PRIx64 &quot;\n&quot;, __func__, i,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t)reg_struc=
t.range.start,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t)reg_struc=
t.range.len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Now it&#39;s registered we can let the clie=
nt at it */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mprotect((void *)(uintptr_t)dev_region-&gt=
;mmap_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dev_region-&gt;size + dev_region-&gt;mmap_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PROT_READ | PROT_WRITE)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;failed to mp=
rotect region %d for postcopy (%s)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0i, strerror(errno));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Stash &#39;zero&#39; support flags so=
mewhere */<br>
-#endif<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 (void)generate_faults(dev);<br></blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000009e534105a7433d44--

