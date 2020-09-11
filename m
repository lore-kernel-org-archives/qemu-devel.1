Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52754C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA28C208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA28C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlN0-0004YY-Tf
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGlLr-0002sN-Pm; Fri, 11 Sep 2020 11:52:39 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGlLn-0002nY-K4; Fri, 11 Sep 2020 11:52:39 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M734j-1kAPQC02XP-008eBz; Fri, 11 Sep 2020 17:52:19 +0200
Subject: Re: [PATCH v2 2/2] util/hexdump: Reorder qemu_hexdump() arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200822180950.1343963-1-f4bug@amsat.org>
 <20200822180950.1343963-3-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d17ad1ff-d6c1-6e7a-e0c3-e50010662092@vivier.eu>
Date: Fri, 11 Sep 2020 17:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200822180950.1343963-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zR73WDw++W1aM464o+vpUhEsCz4pEOxpW2nA5lGCwjl/NhSyVDI
 RWxeZqQttg5UWLqvIyKrt6a/ykL7tSYuN5pkKopfpwGArdJpbQslfnKcN+L5gmZg7yKYuZF
 +cCBp3zyb/pKl8lm9xfrNgZ7AoKFJTAX+mCERUHQq0b3oPtV0YoSD6VcSMphFXjxDbd8tmg
 BzBMtMf58LLq+qF+nDnrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ld7WVYgCvMc=:0JErR6lBii3lvsxjyDnexf
 hhojjoH3Itd/YeOU8KYudyk9r7j0hQKFk8tvvvbU0aKPRhGS4G3ELc7vV0i3HBmvbXgX0uN9L
 w70C/2LyxYcn/iWba/rbYAU2Afh+7YhbNt7pT1vP/epl0ZzbKUR8Liov6/ewZG26BYI9ou04T
 DypXZ/sn84lDv0Rol7/iVFyQij13Ay2HjjDYbGn6PS5v6fP7XPToEl6mBHqlqEYm+/DI1sC1U
 alaUzMhxBwd4oHCJ49b6x04gj6ftIiQencjKscEe86AppFtQ379sbXzVz0w3rn0HycVBPtbaP
 2PCn8W69duyN8BYrL96EyMNOwz0EKvPylbvmN8qxzSjd89Xn6LRuqfmk/GTYOyJP8VxTJ4t77
 l5Sujg9YFtQxSw0Ne5dc5oy0Gtx6cYGxqN3yk3qtZkRvLzP9wlam+cx03efOdvYjQts3/d/iT
 HDKINAO/r8Z+n8xaE5zgF8zntqKTNqHp2BIZ8yF1SveNVhGVIZQQ1G2Yi/E88pWTdJpzOboIg
 TeoaoR0DaH58GkwqquanasSF0LkKffiVsKmwDgZ7AkLO/4KME4nGeV9p81s9918mX9q8O4D+Q
 uFAykJzRaMlcxYimgKftD3n3A+Mq/XK8XQaARsBo849BRC5owxtWy/Np42KItlhRIpKP+Ow5S
 id7Id+WrsdkhaGdn7OLboHgOOChA0uBSfuYTVrVOauCEnDKyebbF6YBXmNZTFkh+k6SuNk8Dq
 gcJ3mNs7z7gdUQIgZQiJqFcgBnIyXJp/InejqddAkRKBMZT+4l+BDbH5opG9i5FHDYEQqlUZc
 pwt9Hu0Zro3Mjg4iLt+oQ/IDzRXHcoJ/jpkci6Tqf8gIHsUqI3OwkQf94Q3d0nczRRSPHk4
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
> qemu_hexdump()'s pointer to the buffer and length of the
> buffer are closely related arguments but are widely separated
> in the argument list order (also, the format of <stdio.h>
> function prototypes is usually to have the FILE* argument
> coming first).
> 
> Reorder the arguments as "fp, prefix, buf, size" which is
> more logical.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/qemu-common.h    |  4 ++--
>  hw/dma/xlnx_dpdma.c      |  2 +-
>  hw/net/fsl_etsec/etsec.c |  2 +-
>  hw/net/fsl_etsec/rings.c |  2 +-
>  hw/sd/sd.c               |  2 +-
>  hw/usb/redirect.c        |  2 +-
>  net/colo-compare.c       | 24 ++++++++++++------------
>  net/net.c                |  2 +-
>  util/hexdump.c           |  4 ++--
>  util/iov.c               |  2 +-
>  10 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 6834883822f..9cfd62669bf 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -138,8 +138,8 @@ int os_parse_cmd_args(int index, const char *optarg);
>   * Hexdump a buffer to a file. An optional string prefix is added to every line
>   */
>  
> -void qemu_hexdump(const void *bufptr, FILE *fp,
> -                  const char *prefix, size_t size);
> +void qemu_hexdump(FILE *fp, const char *prefix,
> +                  const void *bufptr, size_t size);
>  
>  /*
>   * helper to parse debug environment variables
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index d75a8069426..967548abd31 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -388,7 +388,7 @@ static void xlnx_dpdma_dump_descriptor(DPDMADescriptor *desc)
>  {
>      if (DEBUG_DPDMA) {
>          qemu_log("DUMP DESCRIPTOR:\n");
> -        qemu_hexdump(desc, stdout, "", sizeof(DPDMADescriptor));
> +        qemu_hexdump(stdout, "", desc, sizeof(DPDMADescriptor));
>      }
>  }
>  
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index c817a28decd..c5edb25dc9f 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -357,7 +357,7 @@ static ssize_t etsec_receive(NetClientState *nc,
>  
>  #if defined(HEX_DUMP)
>      fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
> -    qemu_hexdump(buf, stderr, "", size);
> +    qemu_hexdump(stderr, "", buf, size);
>  #endif
>      /* Flush is unnecessary as are already in receiving path */
>      etsec->need_flush = false;
> diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
> index 337a55fc957..628648a9c37 100644
> --- a/hw/net/fsl_etsec/rings.c
> +++ b/hw/net/fsl_etsec/rings.c
> @@ -269,7 +269,7 @@ static void process_tx_bd(eTSEC         *etsec,
>  
>  #if defined(HEX_DUMP)
>              qemu_log("eTSEC Send packet size:%d\n", etsec->tx_buffer_len);
> -            qemu_hexdump(etsec->tx_buffer, stderr, "", etsec->tx_buffer_len);
> +            qemu_hexdump(stderr, "", etsec->tx_buffer, etsec->tx_buffer_len);
>  #endif  /* ETSEC_RING_DEBUG */
>  
>              if (etsec->first_bd.flags & BD_TX_TOEUN) {
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 190e4cf1232..6508939b1f4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1781,7 +1781,7 @@ send_response:
>      }
>  
>  #ifdef DEBUG_SD
> -    qemu_hexdump(response, stderr, "Response", rsplen);
> +    qemu_hexdump(stderr, "Response", response, rsplen);
>  #endif
>  
>      return rsplen;
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 09edb0d81c0..48f38d33912 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -240,7 +240,7 @@ static void usbredir_log_data(USBRedirDevice *dev, const char *desc,
>      if (dev->debug < usbredirparser_debug_data) {
>          return;
>      }
> -    qemu_hexdump(data, stderr, desc, len);
> +    qemu_hexdump(stderr, desc, data, len);
>  }
>  
>  /*
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 550272b3baa..4a5ed642e9a 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -494,10 +494,10 @@ sec:
>          g_queue_push_head(&conn->secondary_list, spkt);
>  
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump(ppkt->data, stderr,
> -                        "colo-compare ppkt", ppkt->size);
> -            qemu_hexdump(spkt->data, stderr,
> -                        "colo-compare spkt", spkt->size);
> +            qemu_hexdump(stderr, "colo-compare ppkt",
> +                         ppkt->data, ppkt->size);
> +            qemu_hexdump(stderr, "colo-compare spkt",
> +                         spkt->data, spkt->size);
>          }
>  
>          colo_compare_inconsistency_notify(s);
> @@ -535,10 +535,10 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>          trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
>          trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
> -                         ppkt->size);
> -            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
> -                         spkt->size);
> +            qemu_hexdump(stderr, "colo-compare pri pkt",
> +                         ppkt->data, ppkt->size);
> +            qemu_hexdump(stderr, "colo-compare sec pkt",
> +                         spkt->data, spkt->size);
>          }
>          return -1;
>      } else {
> @@ -578,10 +578,10 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>          trace_colo_compare_icmp_miscompare("Secondary pkt size",
>                                             spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
> -                         ppkt->size);
> -            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
> -                         spkt->size);
> +            qemu_hexdump(stderr, "colo-compare pri pkt",
> +                         ppkt->data, ppkt->size);
> +            qemu_hexdump(stderr, "colo-compare sec pkt",
> +                         spkt->data, spkt->size);
>          }
>          return -1;
>      } else {
> diff --git a/net/net.c b/net/net.c
> index f3e5d533fd7..7a2a0fb5ac6 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -636,7 +636,7 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
>  
>  #ifdef DEBUG_NET
>      printf("qemu_send_packet_async:\n");
> -    qemu_hexdump(buf, stdout, "net", size);
> +    qemu_hexdump(stdout, "net", buf, size);
>  #endif
>  
>      if (sender->link_down || !sender->peer) {
> diff --git a/util/hexdump.c b/util/hexdump.c
> index 053f05d4160..0b4662e701d 100644
> --- a/util/hexdump.c
> +++ b/util/hexdump.c
> @@ -16,8 +16,8 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  
> -void qemu_hexdump(const void *bufptr, FILE *fp,
> -                  const char *prefix, size_t size)
> +void qemu_hexdump(FILE *fp, const char *prefix,
> +                  const void *bufptr, size_t size)
>  {
>      const char *buf = bufptr;
>      unsigned int b, len, i, c;
> diff --git a/util/iov.c b/util/iov.c
> index 45ef3043eec..ae61d696aae 100644
> --- a/util/iov.c
> +++ b/util/iov.c
> @@ -237,7 +237,7 @@ void iov_hexdump(const struct iovec *iov, const unsigned int iov_cnt,
>      size = size > limit ? limit : size;
>      buf = g_malloc(size);
>      iov_to_buf(iov, iov_cnt, 0, buf, size);
> -    qemu_hexdump(buf, fp, prefix, size);
> +    qemu_hexdump(fp, prefix, buf, size);
>      g_free(buf);
>  }
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent



