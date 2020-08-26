Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE4DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A682072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxao+wmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A682072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkNA-0006LN-7v
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 21:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAkML-0005JJ-5P; Tue, 25 Aug 2020 21:36:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAkMJ-0001vM-9l; Tue, 25 Aug 2020 21:36:16 -0400
Received: by mail-ot1-x343.google.com with SMTP id o8so235912otp.9;
 Tue, 25 Aug 2020 18:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iXS1oBUU229UiWdEGq5NH5JG/0Kua23SJq32uPoLw6s=;
 b=fxao+wmbvLT607E8Er4OQFKb2kiDKJlfgze6Fg4Nw/qiQ3U6pkVX4culrMQL+9FIko
 TbwbuEGnrRbzl3a4w7qyA1iGbmH1EuErGp65zkn9vg3oHDofIryvoIwm7prqDSjwWfq5
 K7kTsE0z+yWWASqntmV8iVuVYzpdlYiHmRTOwciU81923NZ+fHvcK9Zq1Xt52OE5cjT9
 2cAWeUiPukknWmCGBSGhNckKGyBzSzMViIpBNrkPE4KcXF1X+3FV74T8xiKswIV/WpmV
 VRZqpaa/Dnqt5ZFVFd/VAB3RJE/6i3YkfuzZRmVrj4d8j/ujOnnP5ZPNTNSTYyxxZT2g
 x1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iXS1oBUU229UiWdEGq5NH5JG/0Kua23SJq32uPoLw6s=;
 b=X9glatJCnPt31U13kv+6EcyPuafClYtz5JaRJ2hNUJ8p4urM/+DPrmqiGmGtPRspem
 63Pre7diaY+KRzLmXaz4l/jWbPsNOQcHTkKTAuI/jg2saRNNMFBBhJxj185CH384RHhD
 o/iloiGwYwjxY0fF9uimqfaiM16lxic3b3/h0f8WDWISWH/k3dVoLphWsoiEOEqWScqd
 Jdt+Vyv9cpFsgumHpkXxYSLp6joCTnv2Qv6YHdZYB2+SR1w10mXKqQSzlhdDPnVgKmBm
 yBpZ9wlrcf17HjQlcqgbi5yMUrW75wfvM2OQd7YtzUvRyralRacYpNWCFc5zzkaucOsV
 E2IA==
X-Gm-Message-State: AOAM533zEAF48co8X4+dw/Y0lDwSglSpF27bmixZJB6TFyblvp4JIRxl
 ad/NS3DRtYrG2bpp4krh1VnOCqXSAP4OlwPBPx0=
X-Google-Smtp-Source: ABdhPJylEFh7e+AXcA5//0KAkWMLUpDFycVUQBsmKg/DZGJrRbVEhczvsI+O6umqHs8x7KS3tAyPe0F2A4gRYri7xtI=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr5889267otn.333.1598405772684; 
 Tue, 25 Aug 2020 18:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-7-kuhn.chenqun@huawei.com>
In-Reply-To: <20200825112447.126308-7-kuhn.chenqun@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 09:35:35 +0800
Message-ID: <CAKXe6SLZi0-ZEdX90b+kmTSdOF5JN4wbKevVg3=nUqbJumrkZA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] hw/net/virtio-net:Remove redundant statement in
 virtio_net_rsc_tcp_ctrl_check()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chen Qun <kuhn.chenqun@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:32=E5=86=99=E9=81=93=EF=BC=9A
>
> Clang static code analyzer show warning:
> hw/net/virtio-net.c:2077:5: warning: Value stored to 'tcp_flag' is never =
read
>     tcp_flag &=3D VIRTIO_NET_TCP_FLAG;
>     ^           ~~~~~~~~~~~~~~~~~~~
>
> The 'VIRTIO_NET_TCP_FLAG' is '0x3F'. The last =E2=80=98tcp_flag=E2=80=99 =
assignment statement is
>  the same as that of the first two statements.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/virtio-net.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a1fe9e9285..cb0d27084c 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2075,7 +2075,6 @@ static int virtio_net_rsc_tcp_ctrl_check(VirtioNetR=
scChain *chain,
>      tcp_flag =3D htons(tcp->th_offset_flags);
>      tcp_hdr =3D (tcp_flag & VIRTIO_NET_TCP_HDR_LENGTH) >> 10;
>      tcp_flag &=3D VIRTIO_NET_TCP_FLAG;
> -    tcp_flag =3D htons(tcp->th_offset_flags) & 0x3F;
>      if (tcp_flag & TH_SYN) {
>          chain->stat.tcp_syn++;
>          return RSC_BYPASS;
> --
> 2.23.0
>
>

