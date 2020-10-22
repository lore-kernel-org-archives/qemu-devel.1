Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E91C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E81124182
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E81124182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdGi-0003EH-SZ
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVdET-00024h-OW
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:14:29 -0400
Received: from relay64.bu.edu ([128.197.228.104]:35722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVdER-0002vX-Qk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:14:29 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 09MGDpHU007181
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 22 Oct 2020 12:13:55 -0400
Date: Thu, 22 Oct 2020 12:13:51 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2] net: remove an assert call in eth_get_gso_type
Message-ID: <20201022161338.4ygjkcovznbn7cj3@mozz.bu.edu>
References: <20201020140050.1623109-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020140050.1623109-1-ppandit@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 12:14:26
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.502, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Gaoning Pan <pgn@zju.edu.cn>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also reported here in May: https://bugs.launchpad.net/qemu/+bug/1878067
-Alex

On 201020 1930, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> eth_get_gso_type() routine returns segmentation offload type based on
> L3 protocol type. It calls g_assert_not_reached if L3 protocol is
> unknown, making the following return statement unreachable. Remove the
> g_assert call, as it maybe triggered by a guest user.
> 
> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  net/eth.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Update v2: add qemu_log()
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg05576.html
> 
> diff --git a/net/eth.c b/net/eth.c
> index 0c1d413ee2..fd76e349eb 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -16,6 +16,7 @@
>   */
> 
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "net/eth.h"
>  #include "net/checksum.h"
>  #include "net/tap.h"
> @@ -71,9 +72,7 @@ eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto)
>              return VIRTIO_NET_HDR_GSO_TCPV6 | ecn_state;
>          }
>      }
> -
> -    /* Unsupported offload */
> -    g_assert_not_reached();
> +    qemu_log("Probably not GSO frame, unknown L3 protocol: %hd\n", l3_proto);
> 
>      return VIRTIO_NET_HDR_GSO_NONE | ecn_state;
>  }
> --
> 2.26.2
> 
> 

