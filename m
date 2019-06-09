Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE18C28EBD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 13:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF85220868
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 13:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF85220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZy4N-0003mO-1B
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 09:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hZy2g-00032S-V0
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 09:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hZy2e-0008GB-HL
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 09:39:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54009)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hZy2c-0008Ey-AH; Sun, 09 Jun 2019 09:39:22 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MDQqe-1hQeNk0vHa-00AZoY; Sun, 09 Jun 2019 15:39:18 +0200
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, qemu-devel@nongnu.org
References: <20190606234125.GA4830@localhost.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7272c10f-3959-ed77-4f26-90e818278e8a@vivier.eu>
Date: Sun, 9 Jun 2019 15:39:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606234125.GA4830@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ixn9FAziCxuy3P4CINRCKDDbgFE2TbHnGrTwVWzj4szIW4BJAKP
 C68D1PbwvkR+Y3H/xZoO8/AJB4ppz6mdiR+f/tpgEctSgPdGYErZA9GDd4/rlvD9dXJUvzZ
 X7Mvq+0H6skfucVAWBVo66nQFyQXwIIepERYTuAMOJkBMzu6D07j9UMpmG0zdfGMcG1tJ4g
 aesspg3Q1qqk0cvnHgAFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8xGVlntOEdc=:9f6oG+ZPzlEZDhtRx2GO+V
 WSGc3l7LxtN5kosGqyQAqizun9W8U4XqKctG27LZ2568mke4N8nFjrUT1fDN3sIbnW0e5rsih
 MaGtJ6hmqr6fQDTWE6bhsF1fHDt8YWpE0TjRQgw1ZuJBxkOlGUbwOROlo9dYrRiUT5ridaKKv
 mfAeUvufgWlWpFsjIwFMW/WZ5L3M/vkJ/1ZliXpg56aA73d1oPtBrR8vDcogymiUZW3WBbs94
 zHssi4wn08OX4GNAE9EZ/ffQA7Xe/IKuW9feMTP43OFHoCgeooYpC3AHgKQnTGy15CPlo7z6y
 CT2bb/tyTMKTZnwLvy0SpqwtG4An3njalI9KFVArIgxhuK0ehGSohFGCfDlPQeREcJj2Asz/L
 MBg9rimgBmd0vzK0pqrEjwIRizWsjlL+6tKvwafl2epIxFYe9LL1Lfy1NkF1P6vNItRiA9R0v
 M5XkIFO3fln9mlV3OIEUgs2uArXTRUtotP3Ghgq/TGpWCsgcNivBfwDgS9G7Cctta3qWK0+Ar
 /ol+w+2BhvExYdLFimnmirrz0AgCAh8LnjK0fUFJ8v4BrIY+2ms+EWjGwxz3qNvBA3tEHVw20
 Mplb9pjG/ZR+EV+0mgu45EowHe/otyLj7O/h763IAN1HURsPPE4sLiqK0C8tEfErXL+ACgmno
 W4QvTchWiFmzgFoGy8w/iQfa7yl+RgPQ2WRIkGLT0RYVIB8QdNiaQxIpcfkfUVDQvfRQk34xe
 ZmVpFjl3puHHnujcGxlH18UOYUUPfjUecnvhMJAm1BVEbpSFihwdwUEtyts=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH v2] m68k comments break patch submission
 due to being incorrectly formatted
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/06/2019 à 01:41, Lucien Murray-Pitts a écrit :
> Altering all comments in target/m68k to match Qemu coding styles so that future
> patches wont fail due to style breaches.
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
> ---
> 
> Notes:
>     v1->v2
>      - incorrectly made split-single line comments multiple single lines
>      - added corrections for /** comments as well as /*----...
>      - caught some other malformed comments that had been missed out
> 
>  target/m68k/cpu-qom.h               |   2 +-
>  target/m68k/cpu.c                   |   6 +-
>  target/m68k/cpu.h                   |  32 ++--
>  target/m68k/fpu_helper.c            |   6 +-
>  target/m68k/gdbstub.c               |   6 +-
>  target/m68k/helper.c                |  16 +-
>  target/m68k/m68k-semi.c             |  24 ++-
>  target/m68k/op_helper.c             |  58 ++++---
>  target/m68k/softfloat.c             | 181 ++++++++++----------
>  target/m68k/softfloat.h             |   3 +-
>  target/m68k/softfloat_fpsp_tables.h |   3 +-
>  target/m68k/translate.c             | 246 ++++++++++++++++++----------
>  12 files changed, 355 insertions(+), 228 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


