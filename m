Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3172CC2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047F420753
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047F420753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbE6-0006ez-3N
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jYbDJ-00068s-IL; Tue, 12 May 2020 16:09:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jYbDI-0001uT-Fv; Tue, 12 May 2020 16:09:17 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N95mR-1j4Kz23MmN-0163pk; Tue, 12 May 2020 22:09:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Tomas Krcka <tomas.krcka@gmail.com>, qemu-devel@nongnu.org
References: <20200506132114.76406-1-tomas.krcka@gmail.com>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/2] linux-user: add do_setsockopt SOL_CAN_RAW
 CAN_RAW_FILTER support
Message-ID: <5cf6dee4-7bfa-76b2-9f44-14bfc7f3d510@vivier.eu>
Date: Tue, 12 May 2020 22:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506132114.76406-1-tomas.krcka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Kr5cnNnJP3am184o777Aa5utcB0Tmo2301IiygVZsBYt84NCmJu
 7T+WVTkaaFGFo1BfK8bSeB5Way22Xe/2mCtVSX+gmx71EHOwRk/K3VHfblcUrieHAyO8iK8
 xfEWEwvhuuyTIXlkD1lKFx4RBDrnxWXU2TY1jXTSVQ97kPuvzrCRYTeNs2fpD/I+pVvTUUj
 wRM691FWMtgSIn95cqzlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M+y3S525V0s=:fvKI0FSswwktw5Et6OHnLs
 JroHuECTiDCdQhWDvOft1CJXFw1hHwKBbSw7U/mxsDVO170lTNGlrDUe3Rso4MX2YGFzjzdxQ
 oqJt+Bb2fEnLpyvtWINfVQXAI4Mcto8g7yASP/E08vSmhRyPtAF/82oF9zT9dlbnwROeYtaQ6
 n1WGvI8Qm4En/Cv3u35pbu8DBtxv9EzqiUxU1QU/pxaf1XE7coYBAk2kxOwdRpmK+yKl87YRJ
 ZUf8StjzdAIS2En8zcv+SDI0tEfu30uV8e7PR+kd22PcOn4016u3wS5gxb7v/1LNIcay5QvaY
 vdGivX0QyperQ1j9J46ZUyN31+ljn4ItslcLrd97YXuAyt8Z0BDMdSNDQIWuDfo/Q7F9hgBSr
 xwpwRRFLTW0caJUFTLV0fl/cMNrWKiqDNdBurciRNy0q/ltvClpgNM5+dqu4MiE5juAFppmqw
 azOQ29yF6FjM0CF7Dl0Vclh/6Q/5sKFhU4oF9JdYf5KW7FwiGASePCa+q0GngrVGJV0M4OVIk
 zf/0siJb4pVGNQ+2ICCglnOcjba9rRfnfyYtBwhl2dDn/ymMW1NLtgp4gwRbEhC4hymq4w3iC
 JHFMseXMXr1zoZsU1ke+KEsVPpyBXHZ5QWtGKBJDbJxFqg5WwV8Ciu6EOU9WvOlfldZ7yxa+0
 bXqQFLV1l1v85xKmY7Mc5gc4W4YCEZzpKzQCuu86SLqs0lC49xkC07TWj+3SnXANpwlBwdLy/
 3gsVFkqDukX1BJFcQlQHzyZw+Ag0duxpU99afm+IMA69bSHtUZ/ezvzX2Z4MTMm+D3f5Uvs3o
 rfxBpvp6EdlI2rtVOQObn7TWUGIH6IwjLRvUf2E3hoUUAK1wNXBQixUMq/9k1eLiHhq0Tgt
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 16:09:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/05/2020 à 15:21, Tomas Krcka a écrit :
> Signed-off-by: Tomas Krcka <tomas.krcka@gmail.com>
> ---
>  linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..88d4c85b70 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -56,6 +56,7 @@
>  #include <linux/wireless.h>
>  #include <linux/icmp.h>
>  #include <linux/icmpv6.h>
> +#include <linux/can/raw.h>
>  #include <linux/errqueue.h>
>  #include <linux/random.h>
>  #ifdef CONFIG_TIMERFD
> @@ -2111,6 +2112,39 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>              goto unimplemented;
>          }
>          break;
> +    case SOL_CAN_RAW:
> +        switch (optname) {
> +        case CAN_RAW_FILTER:
> +        {
> +            if (optlen % sizeof(struct can_filter) != 0) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            struct can_filter  *can_filters = NULL;

Move the declaration to the top of the block.

> +            if (optlen != 0) {

If you check, like in kernel, "optlen > CAN_RAW_FILTER_MAX *
sizeof(struct can_filter)", you can exit here (and no need to set
can_filters to NULL).

> +                can_filters = g_new0(struct can_filter, optlen);
> +
> +                if (!can_filters) {

no need to check the result, g_new0() aborts in case of problem.

> +                    return -TARGET_ENOMEM;
> +                }
> +                if (copy_from_user(can_filters, optval_addr, optlen)) {
> +                    g_free(can_filters);
> +                    return -TARGET_EFAULT;
> +                }

It would be cleaner not to use the copy_from_user() as we need to
byte-swap all the fields in the loop below (I know it's done like that
in SOL_ICMPV6...)

> +                for (val = 0; val < optlen / sizeof(struct can_filter); val++) {
> +                    can_filters[val].can_id = tswap32(can_filters[val].can_id);
> +                    can_filters[val].can_mask = tswap32(can_filters[val].can_mask);
> +                }

So, something like:

target_can_filters = lock_user(VERIFY_READ, optval_addr, optlen, 1);
for (val = 0; val < optlen / sizeof(struct can_filter); val++) {
    __get_user(can_filters[val].can_id, \
               &target_can_filters[val].can_id);
    __get_user(can_filters[val].can_mask, \
               &target_can_filters[val].can_mask);
}
unlock_user(target_can_filters);

> +            }
> +            ret = get_errno(setsockopt(sockfd, level, optname,
> +                                        can_filters, optlen));
> +            g_free(can_filters);
> +            break;
> +        }
> +        default:
> +            goto unimplemented;
> +        }
> +        break;
>      case SOL_RAW:
>          switch (optname) {
>          case ICMP_FILTER:
> 

Could you also update getsockopt()?

Thanks,
Laurent



