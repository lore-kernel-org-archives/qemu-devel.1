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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653A3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA722176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLolmoXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA722176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMIf-00012Z-Vl
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iaMDG-0006QT-JK
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iaMD8-00075H-Ja
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:00:08 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iaMD8-0006Nr-AS; Thu, 28 Nov 2019 11:00:06 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so6303227wma.1;
 Thu, 28 Nov 2019 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Y7tiOWVlvG7Jnayaw/q0kgaDd3wbD55XfSsPP8vIjsU=;
 b=lLolmoXVRWBvsZv4JPJB3hKimzg21/FxzvBoII74prCn4gLFwVF1O0IuCjYINiBo8o
 8oNbS+FooVt3pnMGksdTMcqZMJMLp6PvKcEwYoE+6eJ0yJ36wq/MeEHnfMVrvCm+ryQC
 wpalcTxgwDLcMDB6cgyE+hcVJKBc/Q4hk94WOd0u2MLVstFxiHH5Ly47mXsSZT7p98XE
 bZr8B2QVX0E8xLC8NhR9nikoYITjd4/4C5u/IQ3eYbpEawYK8zcRqpc92PXqRToZ2H0N
 ikz5KoZEq+FWkWupERYqyNN3KaGGC+5DEQ/Zqeq+wG27yo7/gE2z5hF7cwu0ln/RyYTk
 u5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Y7tiOWVlvG7Jnayaw/q0kgaDd3wbD55XfSsPP8vIjsU=;
 b=at+vkuTGv38SutAYbh8h3bHuitxMKG9dlfZ/tJcIfep8l7ziFIuM7a/zLD3HWQeWlm
 K/T7f8DA3DqU/ijWHt8OqVicPqLqnAZF7sXWBuP8yWvKcvNsmfeCtxy2PohuZUZMYDvn
 1PLZLaI+EhkhMzdpczoBoktYUPxY8cHwEfCrp1rjc11H/7r3oNk8AIMx4EOpza9ImTWf
 t1sOVkJ++R2l11AZg1eCzazZAbycpJOQdR4YxdAOlFJjyZtR2484ThEYmudCfoCIUAWG
 Evz43gDS8GmbUAsaVdacJ3mD84drwGT/chxGEDIkGVh+PXC8crcESR5xDL2e/x1SDby5
 BcUw==
X-Gm-Message-State: APjAAAWC71OFUtCPEsAlBVsro/99AEhNpku1SpJAO/ITZLgswgQLr+E/
 DyaG0sGX1rpMBBHLZBsLH/I=
X-Google-Smtp-Source: APXvYqxTYLBcT+eI5rxOl6ILjwPGhhTH4KAkHHIkWHVnOvFwA732qlzYZwIeAuRIqWFapwkNKonUSQ==
X-Received: by 2002:a05:600c:21d9:: with SMTP id
 x25mr10851060wmj.50.1574956795294; 
 Thu, 28 Nov 2019 07:59:55 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id b17sm24331455wrp.49.2019.11.28.07.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 07:59:54 -0800 (PST)
Date: Thu, 28 Nov 2019 16:59:56 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
Subject: Re: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Message-ID: <20191128155956.GB29312@toto>
References: <2632212d4c8a40bead72ffdcf288e600@SVR-IES-MBX-03.mgc.mentorg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2632212d4c8a40bead72ffdcf288e600@SVR-IES-MBX-03.mgc.mentorg.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

On Thu, Nov 28, 2019 at 03:10:16PM +0000, Wasim, Bilal wrote:
> [PATCH] Updating the GEM MAC IP to properly filter out the multicast
> addresses. The current code makes a bad assumption that the most-significant
> byte of the MAC address is used to determine if the address is multicast or
> unicast, but in reality only a single bit is used to determine this. This
> caused IPv6 to not work.. Fix is now in place and has been tested with
> ZCU102-A53 / IPv6 on a TAP interface. Works well..

Hi Bilal,

The fix looks right to me but I have a few comments.

* Your patch seems a little wrongly formated.
[PATCH] goes into the Subject line for example and you're missing
path prefixes.

Do a git log -- hw/net/cadence_gem.c to see examples on how it should look.

* The patch will probably not pass checkpatch since you seem to have
long lines.

* We also need to update gem_receive_updatestats() to use the corrected macros.

More inline:

> 
> Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> ---
> hw/net/cadence_gem.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index b8be73d..f8bcbb3 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -315,6 +315,12 @@
>  #define GEM_MODID_VALUE 0x00020118
> +/* IEEE has specified that the most significant bit of the most significant byte be used for
> + * distinguishing between Unicast and Multicast addresses.
> + * If its a 1, that means multicast, 0 means unicast.   */
> +#define IS_MULTICAST(address)           (((address[0] & 0x01) == 0x01) ? 1 : 0)



This can be simplified:
#define IS_MULTICAST(address) (address[0] & 1)

Actually, looking closer, we already have functions to do these checks in:
include/net/eth.h

static inline int is_multicast_ether_addr(const uint8_t *addr)
static inline int is_broadcast_ether_addr(const uint8_t *addr)
static inline int is_unicast_ether_addr(const uint8_t *addr)



> +#define IS_UNICAST(address)             (!IS_MULTICAST(address))
> +
> static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
> {
>      uint64_t ret = desc[0];
> @@ -690,21 +696,21 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
>      }
>      /* Accept packets -w- hash match? */
> -    if ((packet[0] == 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> -        (packet[0] != 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
> +    if ((IS_MULTICAST(packet) && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> +        (IS_UNICAST(packet)   && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
>          unsigned hash_index;
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
> 2.9.3
> 

