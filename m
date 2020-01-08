Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9300FC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BF120692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BF120692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCws-00053I-6y
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ipCsY-0006P0-4T
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ipCsW-0001kE-UD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:04:14 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:37795)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ipCsR-0001bM-RC; Wed, 08 Jan 2020 10:04:08 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mlf8e-1jXa353r3i-00ikKx; Wed, 08 Jan 2020 16:03:50 +0100
Subject: Re: [PATCH v2] nbd: fix uninitialized variable warning
To: pannengyuan@huawei.com, eblake@redhat.com
References: <20200108025132.46956-1-pannengyuan@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3bf9f590-ba43-557e-649e-9da837f3e5a3@vivier.eu>
Date: Wed, 8 Jan 2020 16:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108025132.46956-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BqUJG+VnmwphTOS/RjKFpGe/RYaRo2kjI5mWVGRQZGX2Rt/9hDa
 /Ok2GY+BGXl/D/+C17ACT8UnxqpVaBd3j6myvsMzSXD5aaHskc+947VyyswsQdsMmkUItrS
 E3btSjzlRFWKcMJIqtkaC6s16pHthDzS3msF175g/1wXZc0y/CV2NuSNWsX8cXgBhAms3Vr
 tYWwOp2vNTqSqx0pPZoDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pmvKE7TU29o=:YmCFdudYCT6pEaT5tY1c+O
 PYcKGBXckyMAVdzSVwDWNUTY//2jUh+ICU4jZfugmw3Ra9/b85xD6pLrWPOS+ooP9m4LUyl+7
 S6T8hH8XIKtK5cjovn7KYfyk81f3FRTmpWISEORNzZAw0yYUdjWaNlIYGnMsze9DIYZo6+YkO
 Lqqj6txSXG9iquv6prsNVef72GnzqjW/T9DcPShEOawSHnwKz3Ij5l8YPz6T1CYMlhoZPHu3r
 YurB5rHyZP80wsx1QXN7mquQf8DhK2xUruCO9vhkMZFZrwDFXlJsE7Le6LEqprWqfgG+w8S0o
 +NspkIRLsdStFg/eg1xP5NXOKaUtzZwrFFBn1k6myUEJLuzEsExgGwxRXmULV11j0q5lApS/l
 ChHU3Zk9cmZT3Jztgg9f0KQequmehOcNICdT/YHFLSYDWecxqLgRueO++P44aGaokX1eNnSrX
 vEvj3+b2q5xx36iZMjSfh2Yryepa9x8UmHYaUWLVaCKgKrgyC3xeysS9ZkrzCbY2Fl/7ilKsa
 hUfbjnWC+QdbKrNO7TE8t1E00O8zn5UWgMkNUqjA+h/VauoQJQ41aWnsa2q5VXf2wgYnujih/
 w5aHkgKaxDMoyymWRXhHT1IbwVsqK1m6OfDRCpCL0FBOdju54+5BtlYV5TL0R/g9ndltyHnLV
 yhcn6nE8K9FZmUUjiHLbvAB+uZ5vfWY79W5Jjrn/MuSg0732MemV3ny+oYbLHA2T2pnTkoRUr
 5BCTbft45tNKttZENaRYN0eqDsiyoTA8rRK/CF/9fbm3u/zP04zih2mH4m9ETt+ykk+8UC516
 Bn6nlFKtXe8fADiZptFO5nMlvrlf6WVWpEQBZjtH4UAN4xYPtqyouSI+decC69fHIXe/lsDOH
 HH1zgq1EYL6FcU6AABpWKK9C1RF3T9fJTBVclE3eM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 08/01/2020 à 03:51, pannengyuan@huawei.com a écrit :
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Fixes:
> /mnt/sdb/qemu/nbd/server.c: In function 'nbd_handle_request':
> /mnt/sdb/qemu/nbd/server.c:2313:9: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      int ret;
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes v2 to v1:
> - change 'if(client->export_meta.bitmap)' into 'else' to fix uninitialized warning and clean up pointless code (suggested by Eric Blake)
> ---
>  nbd/server.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 24ebc1a805..87fcd2e7bf 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2384,20 +2384,12 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                                                 !client->export_meta.bitmap,
>                                                 NBD_META_ID_BASE_ALLOCATION,
>                                                 errp);
> -                if (ret < 0) {
> -                    return ret;
> -                }
> -            }
> -
> -            if (client->export_meta.bitmap) {
> +            } else {              /* client->export_meta.bitmap */
>                  ret = nbd_co_send_bitmap(client, request->handle,
>                                           client->exp->export_bitmap,
>                                           request->from, request->len,
>                                           dont_fragment,
>                                           true, NBD_META_ID_DIRTY_BITMAP, errp);
> -                if (ret < 0) {
> -                    return ret;
> -                }
>              }
>  
>              return ret;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

And applied to my trivial-patches branch.

Thanks,
Laurent


