Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DB0C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826A32072A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826A32072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QRZ-00056P-Cn
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j9QQs-0004cG-Bi
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j9QQr-0001va-AP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:35:14 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36785)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j9QQr-0001rO-1D
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:35:13 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Ma1oK-1iv09t15Ua-00W0O0; Wed, 04 Mar 2020 10:35:05 +0100
Subject: Re: [PATCH] dp8393x: Mask EOL bit from descriptor addresses, take 2
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang <jasowang@redhat.com>
References: <alpine.LNX.2.22.394.2003041421280.12@nippy.intranet>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <78bc18b8-817e-fafe-5c31-69c7cedc18fb@vivier.eu>
Date: Wed, 4 Mar 2020 10:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.394.2003041421280.12@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OfDBASz8S8es5SEvuz+OrgDtiDXKi+u1UnsK+9ClaxhS3n7zaVU
 ozTba7lavh+G9kYQV3vFkjlalUSN8iSnfu1jf046jCPuFQNofSs1zbwHaBeVFbg2jfbgDI7
 Lk9GbKrfGdWUZDsEuokyBNKMEJUoOXqFBV26k5E8/vIYnYViOgWycuNajI0iYyfcpYCqMog
 fq5TEA/1Aomx/rhXC4kyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LfGfrP2ufbY=:pkfLM7NzTnewEK/pKXGQ5o
 XO/dgiaokyhwi1xJyO4+OzT/NgqZsKAZMMCk0kqZGWNQepprVb1eX0J4C1FrkAJYNSrNWPvgi
 ijGxg92sqQ60u0Y71eK6cCMZ2/c5k5zz52gY7sLqUcXRuq8I4ypqIlG+3rhyzoJBwnFkR/7TV
 U908oZ4n5814lDZHOj5JpJFt69uRjqQICOouRy0X7+0a6oF6/hywYbN8SmL56TqluyZT1/qgR
 7sW0vpFOnV6sXLPDNB6EWWktU0OGqasTSR+L7g8c6jo3hOWKACrs/RqkO+dkQArbdvMqpckDc
 hAk4QVkKqrGH+AbMScxTZhSxU72fdiVPXR7E8HBdNdn/MJtQ2rew02umRJhJcM9yNR5VyEqVH
 Rr0CVG5EJjTdsUwtRdHRN3NFfiRxZzFsvuWLKiRxn2QLzWKzubkUH3wYrkeeD4s2lNwwX0tYI
 rNS/jddAGKrmnDB7yRvRXT7be9VvgEeZOyndY35/UBhNEY/sO3h166dYD2BCbVYpzyxGKbQ9X
 vnzUu6fnU4VW+KUEcGCv5k13D2d1PCbZQZkQa6cxlH1G+1HNrmsvHeuNMGPaz3ykb9ukMxc/N
 Uu+t3p3YwxcB1okAmOm4eZ5JCKqRNwdnukHU5RBUpJaNbQQN/oWuvZiuCFDuQnCwTZhYA81gL
 bt8OQ1bswcBN9T7ZQufyDJhJ6OJyC8CmNbz3ofBAsbe19PSJDgrTwavoJcEkYpYN3ZwW3E0fi
 IvxweDAhiHRlskwBq4BLknX6xolBd9dPgJXacZUJ8biSDuo16w3RG23oEGe1ZQ4wvAMyJ19E/
 PI87O9ZZImcMUwX4hJm0cfOFKKYKWke3wu0uvjBut8084DOSyHZ8uQfVXefMI2+lp6ZXp3R
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/03/2020 à 04:23, Finn Thain a écrit :
> A portion of a recent patch got lost due to a merge snafu. That patch is
> now commit 88f632fbb1 ("dp8393x: Mask EOL bit from descriptor addresses").
> This patch restores the portion that got lost.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  hw/net/dp8393x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 8a3504d962..81fc13ee9f 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -525,8 +525,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>                                   * (4 + 3 * s->regs[SONIC_TFC]),
>                                 MEMTXATTRS_UNSPECIFIED, s->data,
>                                 size);
> -            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
> -            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
> +            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0);
> +            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
>                  /* EOL detected */
>                  break;
>              }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

