Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8230C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 17:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C44720880
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 17:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="MKbdkT5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C44720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFiWJ-0005uL-TU
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 13:02:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFiVR-0005Uc-RB
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 13:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFiVQ-0001Fb-Qh
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 13:01:25 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:60688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1hFiVO-0001Ca-4i; Sun, 14 Apr 2019 13:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
	; s=25047;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NoiXC5BCNmOuRNj7yF8M7HwcPkrlqqbvsR91rHmmpTM=;
	b=MKbdkT5oB6zdR9cBMl0fVtQf7R
	YCEn+zOGaZiwazUHXlL/svSgN/Ogiw9+A4DFjKMoG+sdVGAbYmgkRl6Y9XKWeLRcUU2pmu0+HB0Ls
	G4KrwzDhVHYzWl7UivWO7eLSp3MyKhQXOuTVL94WeSlOiSeDL0mJnCv/1drW4vWWHc7o=; 
Received: from rob92-5-82-227-227-196.fbx.proxad.net ([82.227.227.196]
	helo=[192.168.0.35]) by iserv.reactos.org with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <hpoussin@reactos.org>)
	id 1hFiVL-0007Lr-0e; Sun, 14 Apr 2019 17:01:19 +0000
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
Date: Sun, 14 Apr 2019 19:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base
 year
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
Cc: qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414170118.DNm7_p1W54ygSVzJT96BRxfvJEUvuHollgpVSniuy48@z>

Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
> 
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   hw/isa/i82378.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> index a5d67bc..546c928 100644
> --- a/hw/isa/i82378.c
> +++ b/hw/isa/i82378.c
> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>       isa = isa_create_simple(isabus, "i82374");
>   
>       /* timer */
> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
> +    isa = isa_create(isabus, TYPE_MC146818_RTC);
> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
> +    qdev_init_nofail(DEVICE(isa));

I am not sure the base_year should be hardcoded in i82378. I can assume other machines with a i82378 can have another base_year.
Maybe you can you add a base_year property to i82378, and forward it to mc146818 with object_property_add_alias?
Then, change 40p machine to set it to 1900, without changing it for prep machine.

>   }
>   
>   static void i82378_init(Object *obj)
> 

Hervé

