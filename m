Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD4AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5BB20714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5BB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwru-0002g3-HS
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkwBl-00079g-C9; Mon, 15 Jun 2020 16:58:41 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:15169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkwBi-0003SO-5R; Mon, 15 Jun 2020 16:58:40 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9AF2674632B;
 Mon, 15 Jun 2020 22:58:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 775CE745702; Mon, 15 Jun 2020 22:58:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 760977456F8;
 Mon, 15 Jun 2020 22:58:33 +0200 (CEST)
Date: Mon, 15 Jun 2020 22:58:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 16/84] macio: Put "macio-nvram" device on the macio bus
In-Reply-To: <20200615204008.3069956-17-armbru@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2006152257240.23601@zero.eik.bme.hu>
References: <20200615204008.3069956-1-armbru@redhat.com>
 <20200615204008.3069956-17-armbru@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1222301319-1592254713=:23601"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 16:58:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1222301319-1592254713=:23601
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 15 Jun 2020, Markus Armbruster wrote:
> macio_oldworld_init() creates a "macio-nvram", sysbus device, but
> neglects to but it on a bus.

This letter   ^ is upside down :-) (but -> put).

Regards,
BALATON Zoltan

>
> Put it on the macio bus.  Affects machine g3beige.  Visible in "info
> qtree":
>
>             bus: macio.0
>               type macio-bus
>               [...]
>    +          dev: macio-nvram, id ""
>    +            size = 8192 (0x2000)
>    +            it_shift = 4 (0x4)
>
> This also makes it a QOM child of macio-oldworld.  Visible in "info
> qom-tree":
>
>     /machine (g3beige-machine)
>       [...]
>       /unattached (container)
>         [...]
>         /device[6] (macio-oldworld)
>           [...]
>    -    /device[7] (macio-nvram)
>    -      /macio-nvram[0] (qemu:memory-region)
>    +      /nvram (macio-nvram)
>    +        /macio-nvram[0] (qemu:memory-region)
>         [rest of device[*] renumbered...]
>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Message-Id: <20200609122339.937862-15-armbru@redhat.com>
> ---
> hw/misc/macio/macio.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index b3dddf8be7..ebc96cc8f6 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -245,7 +245,8 @@ static void macio_oldworld_init(Object *obj)
>
>     macio_init_child_obj(s, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA);
>
> -    object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
> +    macio_init_child_obj(s, "nvram", &os->nvram, sizeof(os->nvram),
> +                         TYPE_MACIO_NVRAM);
>     dev = DEVICE(&os->nvram);
>     qdev_prop_set_uint32(dev, "size", 0x2000);
>     qdev_prop_set_uint32(dev, "it_shift", 4);
>
--3866299591-1222301319-1592254713=:23601--

