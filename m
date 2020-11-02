Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D31DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 22:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8305820786
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 22:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h21FUHF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8305820786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZiFJ-0001j9-64
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 17:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZiDx-00017C-Qw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 17:22:50 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZiDt-0002bC-Op
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 17:22:49 -0500
Received: by mail-ej1-x642.google.com with SMTP id i19so10029313ejx.9
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 14:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xoEU1zd0PDBdRgUsNJNp6o6DQIP3PghEcHYkQ4kfIx0=;
 b=h21FUHF8AjS/oqw2TWOYNRMgLKlF8g+d10ff3rdU7V13FdvmWPVTCMrKWLM4huTV2x
 DoQtXkzAzzDaUe2tRTSDge+1ncyoN/d1gamhGUEtUxBKDz13aWcfLN0sogsRjd5+y91y
 E5B4f4OpFuBEGDNSFLyMxHEugFjNbZlTcPvFykHVU8weq7P5dnMkW/ogyZqu/yWaSr3r
 pyntbU3jnNnUEWnrZK0K6E4d37OW1Ic1N/1tMSkqx+bOVmOzNUnQsgH2YqI2ot2XEjJb
 1SJf58BeOXWheylzABPxHFFVGAsuN+dQ2pnJdkg2RcXo9SODPJLUaOj1imEhSfXf090A
 FpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xoEU1zd0PDBdRgUsNJNp6o6DQIP3PghEcHYkQ4kfIx0=;
 b=BkDo51SpCWgmVuQyDd04pjhgkfUCmpS8tsFejxwXi/Bx/3CoSVx3/pRTRwVHlqP4fe
 SiCapww5M0b0Fsj/6/4lEhNIBLQLkc3boxMSgU7lUMm9ePp34nDdxfGbdYrnCRJbr0xY
 TeVyGIU8UkTV8DYzY6dFs9O5OTL5qbM48FB6UNSG1ngtVDzfAoHzKyzkwm2I/1g4VHxw
 nizsJYXlkNK2YHq2LMX3MyikEQ1rj1eWIZFufssNIRPG2XnRJl6SnY4Uv1EkMgm6+sNa
 lXctgxstdCe8e1lyQTxjgt3d63DRI5dmyKW4ACSTnAE/JPIlQFHiECHO0PKbc4sy3XAy
 m9Yw==
X-Gm-Message-State: AOAM531HrKdx5SVbTD2cu8boIfGU3kERR8YnQZ2P7lxT/dq7oRhg7d6s
 u4SeST8aUVjSfTU5d72+BgDAUPRiuFKP3MQQIHKpug==
X-Google-Smtp-Source: ABdhPJyTIhY8q09joIxfxGW5+KuOXDd6XVpKYwyspGj+KeQibMYt7AeQO+00ZdeaDQVffNCl++fWaRahzhqmWUwlAbY=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr17031876ejk.407.1604355759796; 
 Mon, 02 Nov 2020 14:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20201102203609.2228309-1-philmd@redhat.com>
In-Reply-To: <20201102203609.2228309-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 22:22:28 +0000
Message-ID: <CAFEAcA8a3UEf_e4jvEdemidrQ7g=V6Ar1dYROQVU5VrsUijJ8Q@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] hw/virtio/vhost-backend: Fix Coverity CID 1432871
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 20:36, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Fix uninitialized value issues reported by Coverity:
>
>   Field 'msg.reserved' is uninitialized when calling write().
>
> Reported-by: Coverity (CID 1432864: UNINIT)
> Fixes: c471ad0e9bd ("vhost_net: device IOTLB support")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/virtio/vhost-backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 88c8ecc9e03..222bbcc62de 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -257,7 +257,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct =
vhost_dev *dev,
>                                                struct vhost_iotlb_msg *im=
sg)
>  {
>      if (dev->backend_cap & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
> -        struct vhost_msg_v2 msg;
> +        struct vhost_msg_v2 msg =3D {};
>
>          msg.type =3D VHOST_IOTLB_MSG_V2;
>          msg.iotlb =3D *imsg;
> @@ -267,7 +267,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct =
vhost_dev *dev,
>              return -EFAULT;
>          }
>      } else {
> -        struct vhost_msg msg;
> +        struct vhost_msg msg =3D {};
>
>          msg.type =3D VHOST_IOTLB_MSG;
>          msg.iotlb =3D *imsg;

Coverity didn't mind about the struct vhost_msg because
it doesn't have a 'reserved' field like vhost_msg_v2; but it
doesn't hurt to initialize it and it makes the two parts of
the function consistent, which is good.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

