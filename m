Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E46C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E4A22DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E4A22DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Mhb-0006a2-4M
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0MgH-0004tF-49
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0MgG-0004Wx-1h
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:13:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0MgF-0004Wa-SN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:13:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33EFD18C8919;
 Wed, 21 Aug 2019 09:13:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E96BB5C231;
 Wed, 21 Aug 2019 09:13:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E8D1716E1A; Wed, 21 Aug 2019 11:13:21 +0200 (CEST)
Date: Wed, 21 Aug 2019 11:13:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20190821091321.tr45eiaqxjm3csvw@sirius.home.kraxel.org>
References: <cover.1565907489.git.balaton@eik.bme.hu>
 <489ce252f9d5f902f7d240ff9895e77bb335f1a9.1565907489.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ce252f9d5f902f7d240ff9895e77bb335f1a9.1565907489.git.balaton@eik.bme.hu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 21 Aug 2019 09:13:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] ati-vga: Silence some noisy traces
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 12:18:09AM +0200, BALATON Zoltan wrote:
> Some registers are accessed very frequently so exclude these from
> traces to avoid flooding output with a lot of trace logs when traces
> are enabled thus helping debugging.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 5e2c4ba4aa..36d2a75f71 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -489,7 +489,14 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>      default:
>          break;
>      }
> -    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
> +    if ((addr < CUR_OFFSET || addr > CUR_CLR1 + 3 || (ATI_DEBUG_HW_CURSOR &&
> +        (addr >= CUR_OFFSET && addr <= CUR_CLR1 + 3))) &&
> +        (addr < GEN_INT_CNTL || addr > GEN_INT_STATUS + 3) &&
> +        (addr < GPIO_MONID || addr > GPIO_MONID + 3) &&
> +        (addr < AMCGPIO_MASK_MIR || addr > AMCGPIO_EN_MIR + 3) &&
> +        (addr < 0x908 || addr > 0x90f) && (addr < 0xc4c || addr > 0xc53) &&
> +        addr != RBBM_STATUS && addr != 0x1714 &&
> +        addr != 0x7b8 && addr > MM_DATA + 3) {
>          trace_ati_mm_read(size, addr, ati_reg_name(addr & ~3ULL), val);

I'd suggest to split the trace_ati_mm_read tracepoint, so this can be
tweaked at runtime without patching the source code.

One tracepoint per register is probably a bit over the top.  Grouping
registers by function (i2c, crtc, irq, cursor, ...) looks useful to me.

cheers,
  Gerd


