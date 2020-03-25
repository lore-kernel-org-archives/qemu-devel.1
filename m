Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6783DC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E1420737
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCEZAcQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E1420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43363 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHDBC-0006mE-Bj
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 17:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHD8d-0003vq-F6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHD8c-0008PD-3u
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:00:35 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:40009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHD8b-0008Od-Uz; Wed, 25 Mar 2020 17:00:34 -0400
Received: by mail-vk1-xa41.google.com with SMTP id k63so1096451vka.7;
 Wed, 25 Mar 2020 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NSqU8zvJr9gAWOOehSSaghSwiKZ8629RmvA/2od8R9c=;
 b=QCEZAcQ+maX33q0z8x+o0TKyoiPi/Jrpc08n8Q9H6W4xqJI+xd0htKYtqfhB6XcRxZ
 7gU2wDDny0Ny4AmX1L2KPsYLOCDCr8vKIt9R1/hy3Hnxq8md9gemt0GPDqnIBXEaieJ9
 rwTSBDNODOTCz4C71R3MRlrGdueS3hvoa1HPcpwvDegKeVUpSb2vVLBF0+S3Yak4YioT
 PUOpn3ZZR5IU7Lxb3Zc4Kg9AB8V1qDNwtcXBjSXM0+LZFCPNd7W26bHXCOzejLJqUsd2
 uhSahT7nmFH2Y8y7Bdg5Ge/F9sHyMja21KCtw15WkhPywC5lE3SMtXBe9/mIkHaloUUA
 q7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NSqU8zvJr9gAWOOehSSaghSwiKZ8629RmvA/2od8R9c=;
 b=Pzg6/s1nloVpJgaQHGVrFbHAiekXbNk6xKdnGVFXGiYoTXEGS9gptkZDPy/Cy0CkDj
 NWkIhzCtrtH6WAEZ5NiJaoVHonemfW2a5KTzwEkZMswDCjBzBnVTGE+HNWpVsNXYKHln
 tP5X/bjU78+vNmAjic7IhBpHGpUEiI6ozyRTYf0YOftVBWxERkFPKXWCEGrLzNfG81nm
 QCy6VPGjyVZqqiiDIzId44QzcmQ+z63uyxN7p/UVJODtuyeH/enBlZsjxJdET5jgKKJZ
 5AKqgJuVMl3gx2XTrsO5nqRgqllNLGsDccqXfyVvDqi5VDUdM02q4aOrbjxI7b7g04re
 3WMw==
X-Gm-Message-State: ANhLgQ1r648mC+3uCOjC67a1JS5rvB/EIdu2/NBoE2/nOm2Xg75ehops
 tUoYD+JOp+CCxVqlRZFlM20Yu/aNAckPlg7xC2I=
X-Google-Smtp-Source: ADFU+vuKlGnMQQGbJw3B+5GLwgIquMf2b+ru/NEMH+Fv4CnCAXkNZgzU+Y8uh/Vo/E/ZMJ5B6QJNKHR0Z7e28AfTVAs=
X-Received: by 2002:a1f:eb04:: with SMTP id j4mr2477016vkh.16.1585170032898;
 Wed, 25 Mar 2020 14:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-12-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-12-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 13:52:33 -0700
Message-ID: <CAKmqyKM5dHo_7gxSWGwSWs1jPOQLB7Ewx4c-dEF72Gdej1gm7Q@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 11/12] hw/net/xilinx_axienet: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a41
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 12:26 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_link() hw/net/xilinx_axienet.c:969:4]]
>
> Add the missing error_propagate() after manual review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/xilinx_axienet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 704788811a..f11510a71e 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -948,39 +948,42 @@ static NetClientInfo net_xilinx_enet_info =3D {
>  static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>  {
>      XilinxAXIEnet *s =3D XILINX_AXI_ENET(dev);
>      XilinxAXIEnetStreamSlave *ds =3D XILINX_AXI_ENET_DATA_STREAM(&s->rx_=
data_dev);
>      XilinxAXIEnetStreamSlave *cs =3D XILINX_AXI_ENET_CONTROL_STREAM(
>                                                              &s->rx_contr=
ol_dev);
>      Error *local_err =3D NULL;
>
>      object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
>                               (Object **) &ds->enet,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &local_err);
>      object_property_add_link(OBJECT(cs), "enet", "xlnx.axi-ethernet",
>                               (Object **) &cs->enet,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &local_err);
>      if (local_err) {
>          goto xilinx_enet_realize_fail;
>      }
>      object_property_set_link(OBJECT(ds), OBJECT(s), "enet", &local_err);
> +    if (local_err) {
> +        goto xilinx_enet_realize_fail;
> +    }
>      object_property_set_link(OBJECT(cs), OBJECT(s), "enet", &local_err);
>      if (local_err) {
>          goto xilinx_enet_realize_fail;
>      }
>
>      qemu_macaddr_default_if_unset(&s->conf.macaddr);
>      s->nic =3D qemu_new_nic(&net_xilinx_enet_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), dev->id, s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>
>      tdk_init(&s->TEMAC.phy);
>      mdio_attach(&s->TEMAC.mdio_bus, &s->TEMAC.phy, s->c_phyaddr);
>
>      s->TEMAC.parent =3D s;
>
>      s->rxmem =3D g_malloc(s->c_rxmem);
>      return;
> --
> 2.21.1
>
>

