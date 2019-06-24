Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB16C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8BD20674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8BD20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfMGQ-0000cP-8I
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 06:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44665)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Stefan.Brankovic@rt-rk.com>) id 1hfMEf-0008Bt-0c
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Stefan.Brankovic@rt-rk.com>) id 1hfMEd-0006ep-M8
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:30:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51982 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Stefan.Brankovic@rt-rk.com>)
 id 1hfMEd-0005Gv-A4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:30:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 5AD031A1166;
 Mon, 24 Jun 2019 12:28:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: by mail.rt-rk.com (Postfix, from userid 492)
 id DB8E31A1FE3; Mon, 24 Jun 2019 12:28:55 +0200 (CEST)
in-reply-to: <1561371065-3637-1-git-send-email-stefan.brankovic@rt-rk.com>
to: hsp.cat7@gmail.com
from: "Stefan Brankovic" <Stefan.Brankovic@rt-rk.com>
message-id: <43c6-5d10a600-15-34dab4c0@176981179>
X-Forward: 127.0.0.1
date: Mon, 24 Jun 2019 12:28:55 +0200
MIME-Version: 1.0
User-Agent: SOGoMail 2.3.10
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] 
 =?utf-8?b?Pz09P3V0Zi04P3E/IFtQQVRDSCB2MyAwLzhdIHRh?=
 =?utf-8?q?rget/ppc=3A_Optimize_emulation_of_some_Altivec?=
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
Cc: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Howard,

Thanks for letting me know about compilation errors in my patch, I real=
ly appreciate it. Those should be fixed=C2=A0 in the latest version of =
this patch (v3), so please take a look and let me know if there is anyt=
hing else that should be changed.

Kind Regards,
Stefan

-------- Original Message --------
Subject: [PATCH v3 0/8] target/ppc: Optimize emulation of some Altivec
Date: Monday, June 24, 2019 12:10 CEST
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: stefan.brankovic@rt-rk.com


=C2=A0Optimize emulation of ten Altivec instructions: lvsl, lvsr, vsl, =
vsr, vpkpx,
vgbbd, vclzb, vclzh, vclzw and vclzd.

This series buils up on and complements recent work of Thomas Murta, Ma=
rk
Cave-Ayland and Richard Henderson in the same area. It is based on devi=
sing TCG
translation implementation for selected instructions rather than using =
helpers.
The selected instructions are most of the time idiosyncratic to ppc pla=
tform,
so relatively complex TCG translation (without direct mapping to host
instruction that is not possible in these cases) seems to be the best o=
ption,
and that approach is presented in this series. The performance improvem=
ents are
significant in all cases.

V3:

Fixed problem during build.

V2:

Addressed Richard's Henderson's suggestions.
Fixed problem during build on patch 2/8.
Rebased series to the latest qemu code.

Stefan Brankovic (8):
target/ppc: Optimize emulation of lvsl and lvsr instructions
target/ppc: Optimize emulation of vsl and vsr instructions
target/ppc: Optimize emulation of vpkpx instruction
target/ppc: Optimize emulation of vgbbd instruction
target/ppc: Optimize emulation of vclzd instruction
target/ppc: Optimize emulation of vclzw instruction
target/ppc: Optimize emulation of vclzh and vclzb instructions
target/ppc: Refactor emulation of vmrgew and vmrgow instructions

target/ppc/helper.h | 10 -
target/ppc/int=5Fhelper.c | 365 --------------------
target/ppc/translate/vmx-impl.inc.c | 642 +++++++++++++++++++++++++++++=
+++----
3 files changed, 573 insertions(+), 444 deletions(-)

--
2.7.4
=C2=A0
=C2=A0
