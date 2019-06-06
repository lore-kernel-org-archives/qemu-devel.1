Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F5C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B135620665
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="V2fLumuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B135620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33199 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYtLI-0006e2-R4
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 10:26:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hYtK2-0005xj-CC
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hYtK1-00024Z-8a
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:24:54 -0400
Received: from spheron.uni-paderborn.de ([131.234.189.16]:45248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1hYtK0-0001pS-L0
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.uni-paderborn.de; s=20170601;
	h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FJGga+xSC7i+s2MmPh9iGSs3F7f5LDhMQDMshjJHN8Y=;
	b=V2fLumuLwedIcqBDb+vadC5H8Y
	/dYJyUvQCIsQvJaQDMA+9G2IFWN+3otyYa95/XYHu+b7mgt1OI5rAfhqmz18aW03SLGugAhX7NnCJ
	mnFum0H2NyHtulhK4EVDn6tOr/QtFSjcWvV7TBre7Z4qlGsqY4nqlgsQUNEODCuxA/GM=; 
To: "Hofstetter, Georg (EFS-GH2)" <Georg.Hofstetter@efs-auto.de>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
	<20190605061126.10244-6-david.brenken@efs-auto.org>
	<aaf05b6e-fb2b-1aa8-da49-b6ce29616073@mail.uni-paderborn.de>
	<69A9BBE82CEA98469F7BA51850C5B89CDC412063@AUDIINSX0364.audi.vwg>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <66321909-d917-c52e-1416-0d76389ba903@mail.uni-paderborn.de>
Date: Thu, 6 Jun 2019 16:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <69A9BBE82CEA98469F7BA51850C5B89CDC412063@AUDIINSX0364.audi.vwg>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
	Antispam-Data: 2019.6.6.141817, AntiVirus-Engine: 5.63.0,
	AntiVirus-Data: 2019.6.4.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.16
Subject: Re: [Qemu-devel] [PATCH 5/5] tricore: reset DisasContext before
 generating code
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Georg,

On 6/6/19 1:44 PM, Hofstetter, Georg (EFS-GH2) wrote:
> Hi Sebastian,
>
> in translate.c:gen_mtcr() code accesses hflags within the structure:
>      if ((ctx->hflags & TRICORE_HFLAG_KUU) == TRICORE_HFLAG_SM) {
>          /* since we're caching PSW make this a special case */
>
> The code expects the HFLAG set for kernel mode in (i guess) preparation for supporting operation modes.
> There is no code modifying these flags.
> The flags were introduced in 0aaeb11 and there it looks like it was expected to be zeroed - maybe you know a bit more.

Yep, the ctx->hflags is supposed to be synced by tb->flags (which is 
normally synced with CPUTriCoreState via cpu_get_tb_cpu_state()) in 
gen_intermediate_code(). Somehow I forgot to add the first sync. So, the 
proper fix is:

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 06c4485e55..44296b3fb1 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8804,6 +8804,7 @@ void gen_intermediate_code(CPUState *cs, 
TranslationBlock *tb, int max_insns)
      ctx.singlestep_enabled = cs->singlestep_enabled;
      ctx.bstate = BS_NONE;
      ctx.mem_idx = cpu_mmu_index(env, false);
+    ctx.hflags = (uint32_t)tb->flags;


      tcg_clear_temp_count();
      gen_tb_start(tb);


Cheers,

Bastian


