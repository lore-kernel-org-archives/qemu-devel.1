Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EA0C1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 20:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E53207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 20:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E53207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCVNT-0007KJ-Db
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 16:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCTKZ-0007Ub-Hr
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCTKY-0006ZH-AB
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:45:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCTKT-0006WP-Ia; Mon, 23 Sep 2019 14:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90020308624A;
 Mon, 23 Sep 2019 18:44:56 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D7E81001B05;
 Mon, 23 Sep 2019 18:44:29 +0000 (UTC)
Subject: Re: [RFC v2 5/9] net/net: fix local variable shadowing in
 net_client_init
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20190923161231.22028-1-vsementsov@virtuozzo.com>
 <20190923161231.22028-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <ce58d998-cc75-9eae-1bab-7e1c7c3737d1@redhat.com>
Date: Mon, 23 Sep 2019 13:44:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923161231.22028-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 23 Sep 2019 18:44:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Mailman-Approved-At: Mon, 23 Sep 2019 16:51:49 -0400
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
Cc: stefanha@redhat.com, codyprime@gmail.com, jan.kiszka@siemens.com,
 berto@igalia.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, samuel.thibault@ens-lyon.org, philmd@redhat.com,
 green@moxielogic.com, lvivier@redhat.com, ehabkost@redhat.com,
 xiechanglong.d@gmail.com, pl@kamp.de, dgilbert@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, ronniesahlberg@gmail.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, andrew@aj.id.au,
 crwulff@gmail.com, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 david@redhat.com, palmer@sifive.com, thuth@redhat.com, jcmvbkbc@gmail.com,
 den@openvz.org, hare@suse.com, sstabellini@kernel.org, arei.gonglei@huawei.com,
 namei.unix@gmail.com, atar4qemu@gmail.com, farman@linux.ibm.com,
 amit@kernel.org, sw@weilnetz.de, groug@kaod.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, clg@kaod.org, shorne@gmail.com,
 qemu-riscv@nongnu.org, cohuck@redhat.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, pburton@wavecomp.com, sagark@eecs.berkeley.edu,
 jasowang@redhat.com, kraxel@redhat.com, edgar.iglesias@gmail.com,
 gxt@mprc.pku.edu.cn, ari@tuxera.com, quintela@redhat.com,
 mdroth@linux.vnet.ibm.com, lersek@redhat.com, borntraeger@de.ibm.com,
 antonynpavlov@gmail.com, dillaman@redhat.com, joel@jms.id.au,
 xen-devel@lists.xenproject.org, integration@gluster.org, rjones@redhat.com,
 Andrew.Baumann@microsoft.com, mreitz@redhat.com, walling@linux.ibm.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, v.maffione@gmail.com,
 marex@denx.de, armbru@redhat.com, marcandre.lureau@redhat.com,
 alistair@alistair23.me, paul.durrant@citrix.com, pavel.dovgaluk@ispras.ru,
 g.lettieri@iet.unipi.it, rizzo@iet.unipi.it, david@gibson.dropbear.id.au,
 akrowiak@linux.ibm.com, berrange@redhat.com, xiaoguangrong.eric@gmail.com,
 pmorel@linux.ibm.com, wencongyang2@huawei.com, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 11:12 AM, Vladimir Sementsov-Ogievskiy wrote:
> Don't shadow Error *err: it's a bad thing. This patch also simplifies
> following Error propagation conversion.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  net/net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Can be applied independently of the rest of this series.

> 
> diff --git a/net/net.c b/net/net.c
> index 84aa6d8d00..5fc72511c1 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1128,10 +1128,10 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>  
>              if (substrings[1]) {
>                  /* User-specified prefix length.  */
> -                int err;
> +                int ret2;
>  
> -                err = qemu_strtoul(substrings[1], NULL, 10, &prefix_len);
> -                if (err) {
> +                ret2 = qemu_strtoul(substrings[1], NULL, 10, &prefix_len);
> +                if (ret2) {

In fact, you don't need ret2; you could just:

if (qemu_strtoul(...)) {

at which point you could then join:

if (substrings[1] &&
    qemus_strtoul(...)) {

>                      error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                                 "ipv6-prefixlen", "a number");
>                      goto out;
> 

Either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

