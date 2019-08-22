Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D229F2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D229F2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ryW-00011s-QH
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1i0rvr-0007aX-Kv
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1i0rvo-00076I-VK
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:35:34 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:53492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1i0rvn-00073J-S8; Thu, 22 Aug 2019 14:35:32 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 4A088F6E6;
 Thu, 22 Aug 2019 20:35:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5_gnTVnfr9K; Thu, 22 Aug 2019 20:35:28 +0200 (CEST)
Received: from function (lfbn-bor-1-306-163.w109-215.abo.wanadoo.fr
 [109.215.28.163])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 65A82F6E2;
 Thu, 22 Aug 2019 20:35:28 +0200 (CEST)
Received: from samy by function with local (Exim 4.92.1)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1i0rtZ-0000ml-Vh; Thu, 22 Aug 2019 20:33:13 +0200
Date: Thu, 22 Aug 2019 20:33:13 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190822183313.pptfwjsnrpdi6tfp@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@gnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 slirp@lists.freedesktop.org, Petr Matousek <pmatouse@redhat.com>,
 Vishnu Dev TJ <vishnudevtj@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Prasad J Pandit <ppandit@redhat.com>
References: <20190822144134.23521-1-philmd@redhat.com>
 <20190822144134.23521-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190822144134.23521-2-philmd@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: Re: [Qemu-devel] [Slirp] [PATCH 1/2] Do not reassemble fragments
 pointing outside of the original payload
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
Cc: slirp@lists.freedesktop.org, Petr Matousek <pmatouse@redhat.com>,
 qemu-devel@nongnu.org, Vishnu Dev TJ <vishnudevtj@gmail.com>,
 qemu-stable@nongnu.org, Prasad J Pandit <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Philippe Mathieu-Daud=C3=A9, le jeu. 22 ao=C3=BBt 2019 16:41:33 +0200, a =
ecrit:
>   Later the newly calculated pointer q is converted into ip structure
>   and values are modified, Due to the wrong calculation of the delta,
>   ip will be pointing to incorrect location and ip_src and ip_dst can
>   be used to write controlled data onto the calculated location. This
>   may also crash qemu if the calculated ip is located in unmaped area.

That does not seem to be related to this:

> Do not queue fragments pointing out of the original payload to avoid
> to calculate the variable delta.

I don't understand the relation with having to calculate delta.

> diff --git a/src/ip_input.c b/src/ip_input.c
> index 7364ce0..ee52085 100644
> --- a/src/ip_input.c
> +++ b/src/ip_input.c
> @@ -304,6 +304,19 @@ static struct ip *ip_reass(Slirp *slirp, struct ip=
 *ip, struct ipq *fp)
>          ip_deq(q->ipf_prev);
>      }
> =20
> +    /*
> +     * If we received the first fragment, we know the original
> +     * payload size.

? We only know the total payload size when receiving the last fragment
(payload =3D offset*8 + size).

> Verify fragments are within our payload.

By construction of the protocol, fragments can only be within the
payload, since it's the last fragment which provides the payload size.

> +    for (q =3D fp->frag_link.next; q !=3D (struct ipasfrag*)&fp->frag_=
link;
> +            q =3D q->ipf_next) {
> +        if (!q->ipf_off && q->ipf_len) {
> +            if (ip->ip_off + ip->ip_len >=3D q->ipf_len) {
> +                goto dropfrag;
> +            }
> +        }
> +    }

Fragments are kept in order, there is no need to go around the list to
find the fragment with offset zero, if it is there it is the first one.

Did you make your test with commit 126c04acbabd ("Fix heap overflow in
ip_reass on big packet input") applied?

Samuel

