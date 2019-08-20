Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092EAC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D379222DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D379222DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i070L-0001yN-Sj
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@jedlik.phy.bme.hu>) id 1i06zV-00016O-31
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@jedlik.phy.bme.hu>) id 1i06zT-0003a1-QG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:28:12 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83]:47356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1i06zT-0003Xa-KH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:28:11 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id F10CCA00EA; Tue, 20 Aug 2019 18:21:05 +0200 (CEST)
Date: Tue, 20 Aug 2019 18:21:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
Message-ID: <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 152.66.102.83
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Sorry to comment on this without really knowing what is it about but maybe 
my view is not completely useless if this is to be understood by people 
who don't know anything about it. If it is not useful just ignore.

On Tue, 20 Aug 2019, Richard Henderson wrote:
> Would it be clearer to use the x86 instruction name: SHRD (SHift Right Doubleword)?

Not unless you name it shr32 or something like that. SHRD does not look 
meaningful without knowing the instruction and elsewhere you use bit 
numbers instead of b, w, d letters. (I don't know if shr32 is actually a 
good name for this op, just commenting on the naming itself.)

> What if we use the AArch64 mnemonics: zxt (zero-extend) and sxt (sign-extend)?
> This would give us
>
>    tcg_gen_zxt8_i32
>    tcg_gen_sxt8_i32
>    (etc)
>    tcg_gen_zxt_i32_i64
>    tcg_gen_sxt_i32_i64

Again this might look familiar to those knowing AArch64 but not to someone 
who does not know that. Maybe zext sext is a bit more decypherable.

In general I think it would be best to name these to describe what they do 
not necessarily following any other ISA naming because that's only useful 
for those who know those particular instructions so maybe it should be 
consistent within TCG and does not have to match what CPUs call it.

Regards,
BALATON Zoltan

