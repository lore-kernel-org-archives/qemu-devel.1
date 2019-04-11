Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09A6C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12E420850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12E420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54383 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEg2d-0003Sw-1N
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 16:11:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEg1k-0002VI-Oa
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEg1j-0005rS-N2
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:10:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEg1j-0005pd-9f; Thu, 11 Apr 2019 16:10:27 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MdNTs-1gfLH43frU-00ZSKJ; Thu, 11 Apr 2019 22:10:23 +0200
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>
References: <20190409053320.14612-1-sw@weilnetz.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <38f6dcce-2122-0516-01f6-a549f11da87f@vivier.eu>
Date: Thu, 11 Apr 2019 22:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190409053320.14612-1-sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:U3Ah2rNNRGktON+pkiuaivfx21iz6MSsTZgH2YrHBYoGcLte6tT
	AvkNIKv6FoFfZTTg0uFtIeeqRHDJX1BNGRlmCaiCUijSIZbsPOimxusKupQ7bhbQdkI63wU
	eI0Qn+gBOgihp0Kv/oy2OQNsy074mPUE5VhioM11xo4BT9YZ3ALw0VMuRKFgkcawjsCnFhO
	C13LJHqqLdhzal2gwE+Vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0OZISRCBkAM=:9wTzupUPhDvHg6lscAJzj6
	XZtNrUn1bWTsAHxX+1nZXxEmxHD0BQ5b5MrmxYEDn+0r5m3/6WjVjBZ3JOZa1sXyWcwmif3sL
	6gY+u1dJ0rCoG4KhpZnUNSah1NpTxeH5TSoyMyspY+R3w1Upu0qBMn7uI2yhRZ+4o9ymZ8EJe
	35ZMdy7joa7IFivfLj10jsTZ3c8aURAV/ovjKkYykSDgJVrvSdXhfU4+L/nlyBSf95qp0eD57
	WEJb70Q8ygEJiNmZ0BaaMZYYz7gF4RvkgYeNEja/HS64Fnp4u9UbZz05eQlCbn1EOX2utnflm
	1iQdHL9JG6PbGydA9VLofEtP4dwMTtqHZozeY+UQNUpmI8mGYZjxXZ+xTX9utW0bPRYqGUOoY
	gBsl5cF3fzeuZgGZZFmKRARDmy4JTGAOMqpWkToCgjd1F5P1W7qM3vkIhf7n/syfhU5eiC3uI
	8nQzq0vhYcElZpFAKuu1b9JvDnIMTHf/6jhv1DoUO9aGqY6td4b/27wXi6EKf03FHHnWrA39l
	Gs5qwQuK3If7ExYKwQvlHfnLPiYiyrsSyiO8c6thK0VrHFdQ0g1RbsFezyAoESNYVF2nBTjFK
	PAjt2QbvGEpqe4c/FRS01mF3kWJ0fAxTYxV36Rd6fP7+m9a60JPb6YZpja6Uji9L30o3ycmcg
	sFEtmu0E8MvyVJZaVrfIOsUEaXAqGXMacMW5twvuSRexwqCSg6CYojQxk3QO1fprzA9Li2iS6
	WPZ3wxA0GC71srjuJfl24xKZ2WLcJpsmQZW1TDc46vPQ8ui8TUJHogBu2Lc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Update configure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411201021.8Lnxdxg09wkoooDq8AwfFUDhgR5WlV4IuLm8benw7mE@z>

On 09/04/2019 07:33, Stefan Weil wrote:
> The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a7027..9c5d9a8c96 100755
> --- a/configure
> +++ b/configure
> @@ -7886,7 +7886,6 @@ LINKS="$LINKS python"
>  for bios_file in \
>      $source_path/pc-bios/*.bin \
>      $source_path/pc-bios/*.lid \
> -    $source_path/pc-bios/*.aml \
>      $source_path/pc-bios/*.rom \
>      $source_path/pc-bios/*.dtb \
>      $source_path/pc-bios/*.img \
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

