Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E04BC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329C520673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329C520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnPJ-0005ZP-Q6
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCmr9-0004wU-LA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCmr6-0004av-Uz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCmr6-0004aO-Ms
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:35:56 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2ED7356DC
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:35:54 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o8so223397wmc.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QHTF5TZ3u6p0eTxztfRkWdp1fMmQkgylQz3ME9vePMM=;
 b=f5acdy9P/bXYZA2OQrb5S+L4QnZY3vE1Sx1qq2OUD/x1aPpMF3uwUAW1RgL7I3tCtk
 NF3wigeGaSfRXHz1tN3R1P6mvrcilkaXDJl4kYsgFJeWbWAAFk8JpT5/gUdWqeA8HoKG
 cDwJ+sazv+GeWIAQ2AsftnR8HbsKGqZhw/LtF4UdNgDkWMGls0WpiMDF0gp61d+eh04H
 1qQCKYzA4k02Se8SbH4qRsRtPWIa/f0gwcSeZQr0R9vBAtox/WFmrEE2nx0lgPJo//zw
 dX7PhLjpOdYgM5XjgxvU6tVCI5Bl2T/B32BKs7fdDUpJjH1Sp2tMvpV5stlzu6mEtwgk
 ay0g==
X-Gm-Message-State: APjAAAVAv2ElBUKfZ5PVKy6Uvatf0wNNeM0brIb3XjS6lqcCPj9GcBj9
 bbbGvT4PW6S5/MGfg9cpcb/j8iuzUJDPDtOs8/XT8vSBZD0TW6LMMDcINvbQjwWqRYWb805NGOi
 T1OcLz9AkeQr7oM0=
X-Received: by 2002:a1c:f714:: with SMTP id v20mr746883wmh.55.1569339353642;
 Tue, 24 Sep 2019 08:35:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGg3+adJOwFP+eM11P3r5a8I5fFFRyteVoe4K7ufjJlzPZ2ZAF6L8Clkji+dh/gdJJBW/dIQ==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr746869wmh.55.1569339353480;
 Tue, 24 Sep 2019 08:35:53 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b22sm353247wmj.36.2019.09.24.08.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 08:35:52 -0700 (PDT)
Subject: Re: [PATCH] COLO-compare: Fix incorrect `if` logic
To: Fan Yang <Fan_Yang@sjtu.edu.cn>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Jason Wang <jasowang@redhat.com>
References: <m2y2yd9482.fsf@Fans-Air.ipads-lab.se.sjtu.edu.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6d23190f-e68a-3000-c288-84f2e0d50b07@redhat.com>
Date: Tue, 24 Sep 2019 17:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <m2y2yd9482.fsf@Fans-Air.ipads-lab.se.sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Fan,

you forgot to Cc the maintainers (doing that for you):

./scripts/get_maintainer.pl -f net/colo-compare.c
Zhang Chen <chen.zhang@intel.com> (supporter:COLO Proxy)
Li Zhijian <lizhijian@cn.fujitsu.com> (supporter:COLO Proxy)
Jason Wang <jasowang@redhat.com> (maintainer:Network device ba...)
qemu-devel@nongnu.org (open list:All patches CC here)

On 9/24/19 4:08 PM, Fan Yang wrote:
> 'colo_mark_tcp_pkt' should return 'true' when packets are the same, and
> 'false' otherwise.  However, it returns 'true' when
> 'colo_compare_packet_payload' returns non-zero while
> 'colo_compare_packet_payload' is just a 'memcmp'.  The result is that
> COLO-compare reports inconsistent TCP packets when they are actually
> the same.
>=20

Fixes: f449c9e549c
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
> ---
>  net/colo-compare.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 7489840bde..7ee17f2cf8 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -319,7 +319,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet =
*spkt,
>      *mark =3D 0;
> =20
>      if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spk=
t->seq_end) {
> -        if (colo_compare_packet_payload(ppkt, spkt,
> +        if (!colo_compare_packet_payload(ppkt, spkt,
>                                          ppkt->header_size, spkt->heade=
r_size,
>                                          ppkt->payload_size)) {
>              *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_=
PRIMARY;
> @@ -329,7 +329,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet =
*spkt,
> =20
>      /* one part of secondary packet payload still need to be compared =
*/
>      if (!after(ppkt->seq_end, spkt->seq_end)) {
> -        if (colo_compare_packet_payload(ppkt, spkt,
> +        if (!colo_compare_packet_payload(ppkt, spkt,
>                                          ppkt->header_size + ppkt->offs=
et,
>                                          spkt->header_size + spkt->offs=
et,
>                                          ppkt->payload_size - ppkt->off=
set)) {
> @@ -348,7 +348,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet =
*spkt,
>          /* primary packet is longer than secondary packet, compare
>           * the same part and mark the primary packet offset
>           */
> -        if (colo_compare_packet_payload(ppkt, spkt,
> +        if (!colo_compare_packet_payload(ppkt, spkt,
>                                          ppkt->header_size + ppkt->offs=
et,
>                                          spkt->header_size + spkt->offs=
et,
>                                          spkt->payload_size - spkt->off=
set)) {
>=20

