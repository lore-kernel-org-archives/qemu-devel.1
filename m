Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB742071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSquWVgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB742071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdon-0007ys-HM
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAdoC-0007E7-6R; Tue, 25 Aug 2020 14:36:36 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:39977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAdoA-0000NH-D9; Tue, 25 Aug 2020 14:36:35 -0400
Received: by mail-il1-x141.google.com with SMTP id p18so11293393ilm.7;
 Tue, 25 Aug 2020 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nNMGJ8xTfGTyUXEn2oN8kj031o1bG+MC1KAomMk8Uz0=;
 b=dSquWVgftCLT5TdH9VB2eMvW92bDuJkVmmWgwXGxxSjLRbx2sU168l2CxrxW/DWoQd
 NA23Gc1Ehs7Ye3IK4DDyZj24J60S9/ZKSvjCFEesM+BCV7ru9Z6kMHoso6XYn0N3gVdX
 pU/lr2eVFQ9NCxB2HGss+/dZsfAgIl6UlYWVkKfxy1Et4Y3Ez4zzdyY5dYPq3AtwrKXn
 uAQsO2gF7mvtQkiN4OmaONllQzadRFFZUbgJ7CXKjyDxPI7LBdN789PUPJMWNb1RKHyz
 lhpZ/R0canrqm6MtUUWJT+4JeoiOc7I36O8pMhtQElOSaUwqeUT1mrZ0wEBHhrwwIuYF
 wyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nNMGJ8xTfGTyUXEn2oN8kj031o1bG+MC1KAomMk8Uz0=;
 b=e+b2D9lql5YGHrCigLFg11Mo4K/HX0L4uDssoCLSXhXgW6huWfPmsyjUJPuZd7IFrV
 pVWzOsIOe78VweRfY2B+UVsHDgAXKMyLfcvTMOMHtDQ1t8IIeMZ0FnGyRX3ziTP8L8/4
 QkRnE2fGm6AynpKluTInwYa4hkjlzSyeRhBvSl4Nh9iYuc/G/AsKj4y2jNMIxz8DpiMS
 LE8hLMsKtat/vJFJL/LACcpxaGrbABD+8vGs/59y67adb6YdCieEbEqqOct+DNndKdE2
 c43xUWEDBfKQqu5qb6AHSm/aq4VmNZecaMPJ/K/jAoB4/lvdJzwuSoh9yq/K4lwEAY+z
 OZJQ==
X-Gm-Message-State: AOAM531DlAuVOzDHeSBUlD4k2ljGCi4NuyZtskeoL88ZXkTzIVemzqCr
 RbFUrpTObSClDjLqN6FyVM95mTEJb+OV8+uWNOY=
X-Google-Smtp-Source: ABdhPJxcZIvmex0pn0y3n40Uf9SDD92svEIJ0iFRWdC3GD1RM8XDIyxUkGkPJAbiafBVpO/qA2tZWqJlLfC8sxRB+Dg=
X-Received: by 2002:a05:6e02:ef3:: with SMTP id
 j19mr10754695ilk.227.1598380591762; 
 Tue, 25 Aug 2020 11:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200822180950.1343963-1-f4bug@amsat.org>
 <20200822180950.1343963-2-f4bug@amsat.org>
In-Reply-To: <20200822180950.1343963-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Aug 2020 11:25:49 -0700
Message-ID: <CAKmqyKNXCFS1fBFJ=j4rk7_xds0BU1hdTGCJVZ3KV4AH-e7APw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] util/hexdump: Convert to take a void pointer
 argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Zhang Chen <chen.zhang@intel.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 22, 2020 at 11:10 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Most uses of qemu_hexdump() do not take an array of char
> as input, forcing use of cast. Since we can use this
> helper to dump any kind of buffer, use a pointer to void
> argument instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Since v1:
> - renamed argument 'bufptr' (Peter Maydell)
> ---
>  include/qemu-common.h    |  3 ++-
>  hw/dma/xlnx_dpdma.c      |  2 +-
>  hw/net/fsl_etsec/etsec.c |  2 +-
>  hw/sd/sd.c               |  2 +-
>  hw/usb/redirect.c        |  2 +-
>  net/colo-compare.c       | 12 ++++++------
>  net/net.c                |  2 +-
>  util/hexdump.c           |  4 +++-
>  8 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index bb9496bd80f..6834883822f 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -138,7 +138,8 @@ int os_parse_cmd_args(int index, const char *optarg);
>   * Hexdump a buffer to a file. An optional string prefix is added to eve=
ry line
>   */
>
> -void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t =
size);
> +void qemu_hexdump(const void *bufptr, FILE *fp,
> +                  const char *prefix, size_t size);
>
>  /*
>   * helper to parse debug environment variables
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index b40c897de2c..d75a8069426 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -388,7 +388,7 @@ static void xlnx_dpdma_dump_descriptor(DPDMADescripto=
r *desc)
>  {
>      if (DEBUG_DPDMA) {
>          qemu_log("DUMP DESCRIPTOR:\n");
> -        qemu_hexdump((char *)desc, stdout, "", sizeof(DPDMADescriptor));
> +        qemu_hexdump(desc, stdout, "", sizeof(DPDMADescriptor));
>      }
>  }
>
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index 7035cf4eb97..c817a28decd 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -357,7 +357,7 @@ static ssize_t etsec_receive(NetClientState *nc,
>
>  #if defined(HEX_DUMP)
>      fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
> -    qemu_hexdump((void *)buf, stderr, "", size);
> +    qemu_hexdump(buf, stderr, "", size);
>  #endif
>      /* Flush is unnecessary as are already in receiving path */
>      etsec->need_flush =3D false;
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index fad9cf1ee7a..190e4cf1232 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1781,7 +1781,7 @@ send_response:
>      }
>
>  #ifdef DEBUG_SD
> -    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
> +    qemu_hexdump(response, stderr, "Response", rsplen);
>  #endif
>
>      return rsplen;
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 417a60a2e68..09edb0d81c0 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -240,7 +240,7 @@ static void usbredir_log_data(USBRedirDevice *dev, co=
nst char *desc,
>      if (dev->debug < usbredirparser_debug_data) {
>          return;
>      }
> -    qemu_hexdump((char *)data, stderr, desc, len);
> +    qemu_hexdump(data, stderr, desc, len);
>  }
>
>  /*
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 2c20de1537d..550272b3baa 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -494,9 +494,9 @@ sec:
>          g_queue_push_head(&conn->secondary_list, spkt);
>
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE=
)) {
> -            qemu_hexdump((char *)ppkt->data, stderr,
> +            qemu_hexdump(ppkt->data, stderr,
>                          "colo-compare ppkt", ppkt->size);
> -            qemu_hexdump((char *)spkt->data, stderr,
> +            qemu_hexdump(spkt->data, stderr,
>                          "colo-compare spkt", spkt->size);
>          }
>
> @@ -535,9 +535,9 @@ static int colo_packet_compare_udp(Packet *spkt, Pack=
et *ppkt)
>          trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size=
);
>          trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->si=
ze);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE=
)) {
> -            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri p=
kt",
> +            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
>                           ppkt->size);
> -            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec p=
kt",
> +            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
>                           spkt->size);
>          }
>          return -1;
> @@ -578,9 +578,9 @@ static int colo_packet_compare_icmp(Packet *spkt, Pac=
ket *ppkt)
>          trace_colo_compare_icmp_miscompare("Secondary pkt size",
>                                             spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE=
)) {
> -            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri p=
kt",
> +            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
>                           ppkt->size);
> -            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec p=
kt",
> +            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
>                           spkt->size);
>          }
>          return -1;
> diff --git a/net/net.c b/net/net.c
> index bbaedb3c7a6..f3e5d533fd7 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -636,7 +636,7 @@ static ssize_t qemu_send_packet_async_with_flags(NetC=
lientState *sender,
>
>  #ifdef DEBUG_NET
>      printf("qemu_send_packet_async:\n");
> -    qemu_hexdump((const char *)buf, stdout, "net", size);
> +    qemu_hexdump(buf, stdout, "net", size);
>  #endif
>
>      if (sender->link_down || !sender->peer) {
> diff --git a/util/hexdump.c b/util/hexdump.c
> index f879ff0ad6b..053f05d4160 100644
> --- a/util/hexdump.c
> +++ b/util/hexdump.c
> @@ -16,8 +16,10 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>
> -void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t =
size)
> +void qemu_hexdump(const void *bufptr, FILE *fp,
> +                  const char *prefix, size_t size)
>  {
> +    const char *buf =3D bufptr;
>      unsigned int b, len, i, c;
>
>      for (b =3D 0; b < size; b +=3D 16) {
> --
> 2.26.2
>
>

