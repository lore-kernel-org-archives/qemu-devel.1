Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEABCC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636DC212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636DC212F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfNg4-0001nG-I6
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 08:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Stefan.Brankovic@rt-rk.com>) id 1hfNeA-00012L-2u
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Stefan.Brankovic@rt-rk.com>) id 1hfNe7-00083j-MH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:00:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41315 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Stefan.Brankovic@rt-rk.com>)
 id 1hfNe7-0007r2-9T
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:00:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D38FE1A20BF;
 Mon, 24 Jun 2019 14:00:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: by mail.rt-rk.com (Postfix, from userid 492)
 id BB8E81A491D; Mon, 24 Jun 2019 14:00:12 +0200 (CEST)
in-reply-to: <CABLmASF=aftaoCa_JBS-DstcmWnRCp8ajQSsaJjhp4iQA0t2tA@mail.gmail.com>
to: "Howard Spoelstra" <hsp.cat7@gmail.com>
from: "Stefan Brankovic" <Stefan.Brankovic@rt-rk.com>
message-id: <53c0-5d10bb80-1-33a06ec0@196763601>
X-Forward: 127.0.0.1
date: Mon, 24 Jun 2019 14:00:12 +0200
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Howard,

Would you be so kind to send me exact qemu command line and applicable =
files(OS images or similar) that you used to bring this exact situation=
 up. Thanks in advance.

Kind Regards,
Stefan

-------- Original Message --------
Subject: Re: [PATCH v3 0/8] target/ppc: Optimize emulation of some Alti=
vec
Date: Monday, June 24, 2019 13:20 CEST
From: Howard Spoelstra <hsp.cat7@gmail.com>
To: Stefan Brankovic <Stefan.Brankovic@rt-rk.com>
CC: qemu-devel qemu-devel <qemu-devel@nongnu.org>
References: <1561371065-3637-1-git-send-email-stefan.brankovic@rt-rk.co=
m> <43c6-5d10a600-15-34dab4c0@176981179>


=C2=A0=C2=A0=C2=A0On Mon, Jun 24, 2019 at 12:28 PM Stefan Brankovic <St=
efan.Brankovic@rt-rk.com> wrote:Hi Howard,

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
To: stefan.brankovic@rt-rk.com=C2=A0Hi Stefan,=C2=A0V3 applies and buil=
ds cleanly on top of current master. The resulting qemu-system-ppc show=
s graphical distortions with OSX 10.2-4 guests. Mac OS 9.x guests seem =
OK.Please see screen dump.=C2=A0Best,Howard=C2=A0=C2=A0
=C2=A0
