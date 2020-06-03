Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30676C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 21:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31E0207D0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 21:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31E0207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgbQ0-0000aS-5W
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 17:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgbPR-00009U-OK
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 17:58:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:46048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgbPP-0001FR-LJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 17:58:52 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 64505745712;
 Wed,  3 Jun 2020 23:58:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 449D9745702; Wed,  3 Jun 2020 23:58:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 42F167456F8;
 Wed,  3 Jun 2020 23:58:48 +0200 (CEST)
Date: Wed, 3 Jun 2020 23:58:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 1/2] ait-vga: check address before reading configuration
 bytes
In-Reply-To: <20200603202251.1199170-2-ppandit@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2006032349140.56892@zero.eik.bme.hu>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-2-ppandit@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 17:58:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While reading PCI configuration bytes, a guest may send an
> address towards the end of the configuration space. It may lead
> to an OOB access issue. Add check to ensure 'address + size' is
> within PCI configuration space.
>
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Yi Ren <c4tren@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
> hw/display/ati.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
> Update v2: add check to avoid OOB PCI configuration space access
>  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index bda4a2d816..6671959e5d 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -384,7 +384,10 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>         val = s->regs.crtc_pitch;
>         break;
>     case 0xf00 ... 0xfff:
> -        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
> +        addr = addr - 0xf00;

I'd write this as addr -= 0xf00 but modifying addr here breaks the trace 
print out at end of function so better drop this line and do

if (addr + size <= 0xfff) {

instead. Or is that really (addr + size - 1 <= 0xfff) considering that 
reading the last byte with addr = 0xfff size = 1 should probably be valid.

Regards,
BALATON Zoltan

> +        if (addr + size <= 0xff) {
> +            val = pci_default_read_config(&s->dev, addr, size);
> +        }
>         break;
>     case CUR_OFFSET:
>         val = s->regs.cur_offset;
>

