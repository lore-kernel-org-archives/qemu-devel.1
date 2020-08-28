Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAADC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CE8208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/Wb3D0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CE8208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBb9C-00085A-CX
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kBb8c-0007GS-Dd; Fri, 28 Aug 2020 05:57:38 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:39107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kBb8a-0008Tz-LV; Fri, 28 Aug 2020 05:57:38 -0400
Received: by mail-oo1-xc44.google.com with SMTP id m4so129696oos.6;
 Fri, 28 Aug 2020 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jQ0veCTMiRXpwXeE5aYaK9LCfJZeYU8q1ATj3ASz1Gg=;
 b=Q/Wb3D0s04VXQ0fWexx0EoIg1xNvzWp9XwFWCKPJVX3ts2Vv8XYgkbf7YFK7L2jM+J
 lQAnkNIgS7HBOqFM4U8wyg852DeXGRHxZTeQRHiPut5rgs0lNnVa5rDN/91/8FH0EraV
 ba2rMiYXe1efsPCdbHqFyguE4pvSnt1u4PmrvrBh4JP6GavGVezdGeHGrZfa24/2a+hN
 rnQeuMeevYlN4TwG2w7rI9wHGQjFJOtTuptj+TeVDXg5qrCCPwiNjAG/egwmt2AJDuYT
 ajbFcEsQCK1NNRwLXoB9HBR7FEECwWYcoOHtEK/GpX4T+4PVTYS0c06rPkn9BDqMViKm
 870w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jQ0veCTMiRXpwXeE5aYaK9LCfJZeYU8q1ATj3ASz1Gg=;
 b=snYUsFVr5PcRXTSg3A0R77H9OEKcmECcZ/s0/wDNj24N2VArK3fucKpCZuZwoWL/yg
 83Jca9jLlotHK6kazcVruJJncTTL3zGtGrZZs2YMDRXAc5d1WjtMj5P3Ox1rzwrIVyic
 b3RmLm3mZJz+3dnwhEDA73Aj+J8KkTi9F+nSuJOFrSB5iQQLe6epDrsiPwi3G43Dsxe+
 VEcswAQA8rNe6QH29XrKZ03hyHgwHPk+iFYeuR4PUUiqyL0YJjdY5TM2/E9UaaJIkJkr
 LbTd3WR4A2Dj+lv722ZqZ95QAyZVZQ9noeOADGe7PdryeiGA534+CMi1wkGuaivDofUD
 NH+w==
X-Gm-Message-State: AOAM530Oolr6yjAximJjpr83U8azNNq4+jBsMOsYY02Ymk0cZ0mkriDf
 0Pub2JpKLZAhz7BGkz6qNnFDyuWhkirr91JQHvg=
X-Google-Smtp-Source: ABdhPJz/M2KbBsxKSJ4GATfjpD90baYYVm7s0FTp4LOo5kzYNNhWyNyrRHdHoLUhzrEfFDlyfiyQ3pwzNuDbdrihnGI=
X-Received: by 2002:a4a:be0c:: with SMTP id l12mr590082oop.22.1598608653835;
 Fri, 28 Aug 2020 02:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200822180950.1343963-1-f4bug@amsat.org>
 <20200822180950.1343963-2-f4bug@amsat.org>
In-Reply-To: <20200822180950.1343963-2-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 28 Aug 2020 17:56:57 +0800
Message-ID: <CAKXe6SLwoUJ76QRCYkOi5pRZ+ROmAwXV6QsR7TUkZLaF7kA4Lg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] util/hexdump: Convert to take a void pointer
 argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc44.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Qemu Developers <qemu-devel@nongnu.org>, Zhang Chen <chen.zhang@intel.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B48=E6=9C=
=8823=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=882:11=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Most uses of qemu_hexdump() do not take an array of char
> as input, forcing use of cast. Since we can use this
> helper to dump any kind of buffer, use a pointer to void
> argument instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

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

