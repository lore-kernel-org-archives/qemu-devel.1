Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D37C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 17:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B5F20715
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 17:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEdoaCe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B5F20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaNuc-0006uv-CQ
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 12:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iaNeA-0007y9-Rr
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iaNe2-0002Za-OD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:32:01 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iaNe2-0001w9-E9; Thu, 28 Nov 2019 12:31:58 -0500
Received: by mail-wr1-x444.google.com with SMTP id a15so32078982wrf.9;
 Thu, 28 Nov 2019 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RUAtXCwHBRXukIu2vFZGce5SNLV3tHMb23DnTijKFks=;
 b=GEdoaCe3Dx6hEqHhO1xeFdxa4hXx95GFpr30ZQy51Msr7WNwS9nTtpxGio7Hc+9ldY
 s82mT+lxqx3A7MOyeVRk1gL4wXBZ32HkJCB33695878of8i7AvWq10gUWcicsXDgy729
 u2V6odTmkc7DLqRyStUKRdB22iJV1lIAtr+X+2Ze7sXQ8a8YfLf9tftNcCKcehlYKzlZ
 j3MW4Afb4bb/K4jl5ZgtXrMz6AXH0yevp8WIqo92LuU9ak/2D8ThWtB/qb9MKtOzZx4I
 J3DC4hkM1AHXqjEPpgPAXpL+GgFb7vA3j3884Dqf6l0D5CDa9Z88wZ8nu3QRTiSKhhUT
 k98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RUAtXCwHBRXukIu2vFZGce5SNLV3tHMb23DnTijKFks=;
 b=PMNo83k2eFu/jHkQL8M4HwpZbLUBi0QozuuFGqo+cZvZRBpw7P2/KNDmkj1+HMm68Y
 t2ms0Y+BMzpwyBAdm3SMWJCbvwk9fKD2GBKzi+085lNbTnn+5g1G0KBA4CU5lsB0Y1tN
 XJskmeJLVcTiXQz7y4F5u1t0LpHwGiglGXbVcgaHKrHaWTp734/HHYxxkvezKnQa0iM/
 +uU8GJ1XxGUL8rSELLfoXZT0t3LaWQD2/ojhxKO1IpcAuwkTBsJ9CindZfLtNcH7skxR
 Q35Q7lSgmrQejoON8/XTDZJ2XpMfyYyipAaNYrijEtcSZZzEp4WT7mZNUqrMhNmaRmOl
 qPEA==
X-Gm-Message-State: APjAAAVFra5pt9kzwY+AasfHwgmahNHXM8U9jEpbvJZszWLIM8c3bcVv
 mWeE5qF+DEufphUj/7Dh8gE=
X-Google-Smtp-Source: APXvYqyLUaQy9iFo+npHGAFtwj+0V0hnzDxJD3u4Dtsc0y34IcUfAAKANkv+seiTjwi7Kb79yQA1Zw==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr5473504wrp.110.1574962310277; 
 Thu, 28 Nov 2019 09:31:50 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id z8sm8041183wrq.22.2019.11.28.09.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 09:31:49 -0800 (PST)
Date: Thu, 28 Nov 2019 18:31:52 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
Subject: Re: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Message-ID: <20191128173152.GC29312@toto>
References: <2632212d4c8a40bead72ffdcf288e600@SVR-IES-MBX-03.mgc.mentorg.com>
 <20191128155956.GB29312@toto>
 <2b7a42487a5d4a258062bd209a0d13fa@SVR-IES-MBX-03.mgc.mentorg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7a42487a5d4a258062bd209a0d13fa@SVR-IES-MBX-03.mgc.mentorg.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 05:02:00PM +0000, Wasim, Bilal wrote:
> This was one of my first attempts, and so I was sure to miss something.. I've incorporated all the updates in this patch.. Let me know what you think about this.. 
> 
> net/cadence_gem: Updating the GEM MAC IP to properly filter out the multicast addresses.
> 
> The current code makes a bad assumption that the most-significant byte
> of the MAC address is used to determine if the address is multicast or
> unicast, but in reality only a single bit is used to determine this.
> This caused IPv6 to not work.. Fix is now in place and has been tested
> with ZCU102-A53 / IPv6 on a TAP interface. Works well..

Thanks Bilal,

This looks better but not quite there yet.

* You don't seem to be using git-send-email to post patches, try it,
it will make life easier wrt to formatting. The patch should be in a
separate email. The subject line should be the subject of the email.
git-format-patch and git-send-email will take care of that for you.

* You don't need to define IS_MULTICAST, you can directly
use is_multicast_ether_addr() and friends.

* The patch still has long lines (longer than 80 chars)
You can run scripts/checkpatch.pl on your commit before
posting the patch.

Cheers,
Edgar



> 
> Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> ---
>  hw/net/cadence_gem.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index b8be73dc55..98efb93f8a 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -34,6 +34,7 @@
>  #include "qemu/module.h"
>  #include "sysemu/dma.h"
>  #include "net/checksum.h"
> +#include "net/eth.h"
>  
>  #ifdef CADENCE_GEM_ERR_DEBUG
>  #define DB_PRINT(...) do { \
> @@ -315,6 +316,12 @@
>  
>  #define GEM_MODID_VALUE 0x00020118
>  
> +/* IEEE has specified that the most significant bit of the most significant byte be used for
> + * distinguishing between Unicast and Multicast addresses.
> + * If its a 1, that means multicast, 0 means unicast.   */
> +#define IS_MULTICAST(address)           is_multicast_ether_addr(address)
> +#define IS_UNICAST(address)             is_unicast_ether_addr(address)
> +
>  static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
>  {
>      uint64_t ret = desc[0];
> @@ -601,7 +608,7 @@ static void gem_receive_updatestats(CadenceGEMState *s, const uint8_t *packet,
>      }
>  
>      /* Error-free Multicast Frames counter */
> -    if (packet[0] == 0x01) {
> +    if (IS_MULTICAST(packet)) {
>          s->regs[GEM_RXMULTICNT]++;
>      }
>  
> @@ -690,21 +697,21 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
>      }
>  
>      /* Accept packets -w- hash match? */
> -    if ((packet[0] == 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> -        (packet[0] != 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
> +    if ((IS_MULTICAST(packet) && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> +        (IS_UNICAST(packet)   && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
>          unsigned hash_index;
>  
>          hash_index = calc_mac_hash(packet);
>          if (hash_index < 32) {
>              if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
> -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> +                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCEPT :
> +                                              GEM_RX_UNICAST_HASH_ACCEPT;
>              }
>          } else {
>              hash_index -= 32;
>              if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
> -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> +                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCEPT :
> +                                              GEM_RX_UNICAST_HASH_ACCEPT;
>              }
>          }
>      }
> -- 
> 2.19.1.windows.1
> 
> ------------------------------------------------------------------------------------------------------------------------------
> -----Original Message-----
> From: Edgar E. Iglesias [mailto:edgar.iglesias@gmail.com] 
> Sent: Thursday, November 28, 2019 9:00 PM
> To: Wasim, Bilal <Bilal_Wasim@mentor.com>
> Cc: qemu-devel@nongnu.org; alistair@alistair23.me; peter.maydell@linaro.org; qemu-arm@nongnu.org
> Subject: Re: [PATCH] Updating the GEM MAC IP to properly filter out the multicast addresses
> 
> On Thu, Nov 28, 2019 at 03:10:16PM +0000, Wasim, Bilal wrote:
> > [PATCH] Updating the GEM MAC IP to properly filter out the multicast 
> > addresses. The current code makes a bad assumption that the 
> > most-significant byte of the MAC address is used to determine if the 
> > address is multicast or unicast, but in reality only a single bit is 
> > used to determine this. This caused IPv6 to not work.. Fix is now in 
> > place and has been tested with
> > ZCU102-A53 / IPv6 on a TAP interface. Works well..
> 
> Hi Bilal,
> 
> The fix looks right to me but I have a few comments.
> 
> * Your patch seems a little wrongly formated.
> [PATCH] goes into the Subject line for example and you're missing path prefixes.
> 
> Do a git log -- hw/net/cadence_gem.c to see examples on how it should look.
> 
> * The patch will probably not pass checkpatch since you seem to have long lines.
> 
> * We also need to update gem_receive_updatestats() to use the corrected macros.
> 
> More inline:
> 
> > 
> > Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> > ---
> > hw/net/cadence_gem.c | 18 ++++++++++++------
> > 1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index 
> > b8be73d..f8bcbb3 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -315,6 +315,12 @@
> >  #define GEM_MODID_VALUE 0x00020118
> > +/* IEEE has specified that the most significant bit of the most 
> > +significant byte be used for
> > + * distinguishing between Unicast and Multicast addresses.
> > + * If its a 1, that means multicast, 0 means unicast.   */
> > +#define IS_MULTICAST(address)           (((address[0] & 0x01) == 0x01) ? 1 : 0)
> 
> 
> 
> This can be simplified:
> #define IS_MULTICAST(address) (address[0] & 1)
> 
> Actually, looking closer, we already have functions to do these checks in:
> include/net/eth.h
> 
> static inline int is_multicast_ether_addr(const uint8_t *addr) static inline int is_broadcast_ether_addr(const uint8_t *addr) static inline int is_unicast_ether_addr(const uint8_t *addr)
> 
> 
> 
> > +#define IS_UNICAST(address)             (!IS_MULTICAST(address))
> > +
> > static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t 
> > *desc) {
> >      uint64_t ret = desc[0];
> > @@ -690,21 +696,21 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
> >      }
> >      /* Accept packets -w- hash match? */
> > -    if ((packet[0] == 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> > -        (packet[0] != 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
> > +    if ((IS_MULTICAST(packet) && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> > +        (IS_UNICAST(packet)   && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
> >          unsigned hash_index;
> >          hash_index = calc_mac_hash(packet);
> >          if (hash_index < 32) {
> >              if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
> > -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
> > -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> > +                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCEPT :
> > +                                              
> > + GEM_RX_UNICAST_HASH_ACCEPT;
> >              }
> >          } else {
> >              hash_index -= 32;
> >              if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
> > -                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
> > -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> > +                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCEPT :
> > +                                              
> > + GEM_RX_UNICAST_HASH_ACCEPT;
> >              }
> >          }
> >      }
> > --
> > 2.9.3
> > 

