Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43AAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1378C21D47
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1378C21D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlQH-0007pd-4Q
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGlLf-0002di-0s; Fri, 11 Sep 2020 11:52:27 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGlLc-0002mQ-O4; Fri, 11 Sep 2020 11:52:26 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mnq0K-1krU4G0Ywc-00pPP0; Fri, 11 Sep 2020 17:52:02 +0200
Subject: Re: [PATCH v2 1/2] util/hexdump: Convert to take a void pointer
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200822180950.1343963-1-f4bug@amsat.org>
 <20200822180950.1343963-2-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <13f8adc3-2ad1-41cc-803b-a8b9afd241c1@vivier.eu>
Date: Fri, 11 Sep 2020 17:51:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200822180950.1343963-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k0CBv2m4x4VxWg4vLeLOq7ocITgNU9ezsqcO2Wm7AHPHlJAjLTO
 RtUzLrJwBwQO8sS3r23sboEII18smqZh+acd78dFdKNqN+R1MnCKPJnQtCxIlQ11jr0SVm5
 JjqdenI8XLafRaD/2OitOV/+bw28v0o5eMX1fKU6i62A+p3gFfHRgP6aMzLHdyjRpnO8S/U
 zmc2Szjdlj+WugHtrkUwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:16PxyF/lV7o=:/FvPC6de3MI8jSabdOcn5d
 yCj4gbDjPge+vWMEbnjaWOlpI8iREauykizwm9H5RFwEhsmRL0J3GPfYYUA690G7dx6qXXBuG
 gxwY5Myf47KmJV4+NjCzNAPiirVmwBDVLEiLWPxuyrFzwCY5pbVnk+KZnBo/wKCRvdfVSp1iU
 rPehfyHiWr6fLO7uhu5qAOCXo4WWIp4Mvq1MtIKRM7vb+7JLrG3jOJEtj5xaS61tE2Rteztn8
 0LIbI89i3aOthIQ9sEgA6RMrDo+LVO2f+mOOl4TqQwH+iWfLBwBy0BMpWB9EFRvzSKEEgV3qV
 UKbjBqQZmit19l1jFVBGOafGX18YnvEZst1ApETZNr7tcq5djUBkI/5YgsfSYf6khClfwokkO
 FcUw7d2Y3BCRWMx/6HZ6X9WYr1kg8+l5ZqhIzGEBCSIUb2ReFYJvnqHsd/5G1qVMgpJkCQOIm
 NSJzMTT6OtrnIkZkW0tpzrHdFkkaqoFT9qiTsRCbuiA5Y+vgE5qDVK9cYAE+RXxwq66W5kWdE
 NixjXuUhgi/4WdVpyvbIgQgSuKUnK85r+wKs/O8RoVzu7chrQgUl/k49a1jf8jC1Kj+r2YYqJ
 0rRt2GLNlsmcc26KN8GIN122vz4xX4IQMGiuQ7KGWkQAV+fxJUZBz/MSllkpal//O5VE6Ah10
 uZYRUhn8o+4xCtRmtwDYGjyN+XiMr9nZhWB8giIkCtMUTzZpqIcw0djjMeOqmIKAfuS1cJtiX
 HI2kJioWPdB02R5GbJZet03bycRLFLnhjpGu8o58HBcbxg81QKhRa7OUa67xPnccFpAvx5s1r
 fxfiDMOOaDXGxnjVx6pKzQCSAnC1ktM2MLGoNZsvT83rBjDYbmIS0wuJq8WiERlSEe9cpCS
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 11:52:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 Zhang Chen <chen.zhang@intel.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 22/08/2020 à 20:09, Philippe Mathieu-Daudé a écrit :
> Most uses of qemu_hexdump() do not take an array of char
> as input, forcing use of cast. Since we can use this
> helper to dump any kind of buffer, use a pointer to void
> argument instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
>   * Hexdump a buffer to a file. An optional string prefix is added to every line
>   */
>  
> -void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
> +void qemu_hexdump(const void *bufptr, FILE *fp,
> +                  const char *prefix, size_t size);
>  
>  /*
>   * helper to parse debug environment variables
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index b40c897de2c..d75a8069426 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -388,7 +388,7 @@ static void xlnx_dpdma_dump_descriptor(DPDMADescriptor *desc)
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
>      etsec->need_flush = false;
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
> @@ -240,7 +240,7 @@ static void usbredir_log_data(USBRedirDevice *dev, const char *desc,
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
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump((char *)ppkt->data, stderr,
> +            qemu_hexdump(ppkt->data, stderr,
>                          "colo-compare ppkt", ppkt->size);
> -            qemu_hexdump((char *)spkt->data, stderr,
> +            qemu_hexdump(spkt->data, stderr,
>                          "colo-compare spkt", spkt->size);
>          }
>  
> @@ -535,9 +535,9 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>          trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
>          trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
> +            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
>                           ppkt->size);
> -            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
> +            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
>                           spkt->size);
>          }
>          return -1;
> @@ -578,9 +578,9 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>          trace_colo_compare_icmp_miscompare("Secondary pkt size",
>                                             spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
> +            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
>                           ppkt->size);
> -            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
> +            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
>                           spkt->size);
>          }
>          return -1;
> diff --git a/net/net.c b/net/net.c
> index bbaedb3c7a6..f3e5d533fd7 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -636,7 +636,7 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
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
> -void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size)
> +void qemu_hexdump(const void *bufptr, FILE *fp,
> +                  const char *prefix, size_t size)
>  {
> +    const char *buf = bufptr;
>      unsigned int b, len, i, c;
>  
>      for (b = 0; b < size; b += 16) {
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


