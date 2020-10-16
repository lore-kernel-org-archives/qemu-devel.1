Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D01C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF37E206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF37E206E5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDab-000476-Na
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTDZk-0003aT-Cg; Thu, 15 Oct 2020 20:26:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:24849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTDZi-00084B-OT; Thu, 15 Oct 2020 20:26:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id F3EE5747613;
 Fri, 16 Oct 2020 02:26:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D3A277475FA; Fri, 16 Oct 2020 02:26:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D2465746383;
 Fri, 16 Oct 2020 02:26:24 +0200 (CEST)
Date: Fri, 16 Oct 2020 02:26:24 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 2/3] grackle: use qdev gpios for PCI IRQs
In-Reply-To: <4b25afd1-0ce5-0832-a3f0-1b58b3aa7b32@ilande.co.uk>
Message-ID: <a5bf7f6-ace0-72e9-52df-e5b421b4e1c5@eik.bme.hu>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
 <c882279b-a561-2c3a-a6b5-b27446fddb02@amsat.org>
 <79df54b3-d9e5-145e-e277-24468b121ba0@ilande.co.uk>
 <91a24667-5f72-d3d9-8e47-6453268d2b78@eik.bme.hu>
 <4b25afd1-0ce5-0832-a3f0-1b58b3aa7b32@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:17:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Thu, 15 Oct 2020, Mark Cave-Ayland wrote:
> I've queued the grackle/uninorth patches to my qemu-macppc branch, however 
> when I try to apply patches from the above series git fails with the 
> following message:
>
> Applying: mac_oldworld: Drop a variable, use get_system_memory() directly
> error: sha1 information is lacking or useless (hw/ppc/mac_oldworld.c).
> error: could not build fake ancestor

Maybe because these were based on your screamer branch but I could 
cherry-pick them from there to your qemu-macppc branch without issue.

> Any chance you can rebase and repost? I'm happy to take patches 3 and 4, and

I've just posted the rebased series.

> if my suggestion of casting the return address via target_ulong works then I 
> think 1 and 2 are also fine.

Your original comment was:

"Given that this needs to work with both qemu-system-ppc and 
qemu-system-ppc64 would casting bios_addr to target_ulong work?"

This cast only appears in mac_oldworld.c which is qemu-system-ppc only (or 
not different in qemu-system-ppc64 unlike mac_newworld.c) so target_ulong 
there is basically uint32_t. I've changed the cast accordingly but I think 
it does not really matter.

> The I2C stuff I can't really review, and weren't 
> there still issues with the SPD data in patch 8 reporting the wrong RAM size?

As said in previous message the i2c and SPD patches are not quite ready 
yet so I've omitted those from this series, I may rework them later once 
this part is merged and can rebase the rest on top of that. We would also 
need your screamer patches to get the Mac ROM working, what is still 
missing for those?

Regards,
BALATON Zoltan

