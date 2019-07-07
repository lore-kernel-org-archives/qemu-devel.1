Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2A7C48BDE
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 20:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EF2206A2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 20:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EF2206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkDkj-000212-EP
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 16:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60648)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sw@weilnetz.de>) id 1hkDk1-0001a1-Q0
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 16:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sw@weilnetz.de>) id 1hkDk0-0003Iq-MQ
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 16:26:33 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:50116
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1hkDk0-0003HZ-DB
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 16:26:32 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id F3C69DB8568;
 Sun,  7 Jul 2019 22:26:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id MUhB0Xmefk1O; Sun,  7 Jul 2019 22:26:23 +0200 (CEST)
Received: from edv-macbook-pro.fritz.box (p57B4293C.dip0.t-ipconnect.de
 [87.180.41.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 54912DB8566;
 Sun,  7 Jul 2019 22:26:23 +0200 (CEST)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
Date: Sun, 7 Jul 2019 22:26:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] Handling of fall through code (was: [PATCH v8 04/87]
 target/mips: Mark switch fallthroughs with interpretable comments
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
Cc: peter.maydell@linaro.org, pburton@wavecomp.com, smarkovic@wavecomp.com,
 riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com,
 pjovanovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.08.18 um 19:52 schrieb Aleksandar Markovic:

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Mark switch fallthroughs with comments, in cases fallthroughs
> are intentional.


This is a general problem all over the QEMU code. I usually compile with=20
nearly all warnings enabled and get now lots of errors with the latest=20
code and after updating to gcc-8.3.0 (Debian buster). It should be=20
reproducible by enabling -Werror=3Dimplicit-fallthrough.

The current situation is like this:

- Some code has fallthrough comments which are accepted by the compiler.

- Other code has fallthrough comments which are not accepted (resulting=20
in a compiler error).

- Some code is correct, but has no indication that the fallthrough is=20
intentional.

- There is also fallthrough code which is obviously not correct (even in=20
target/mips/translate.c).


I suggest to enable -Werror=3Dimplicit-fallthrough by default and add a=20
new macro to mark all fallthrough locations which are correct, but not=20
accepted by the compiler.

This can be done with a definition for GCC compatible compilers in=20
include/qemu/compiler.h:

#define QEMU_FALLTHROUGH __attribute__ ((fallthrough))

Then fallthrough code would look like this:

 =C2=A0=C2=A0=C2=A0 case 1:
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 do_something();
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 QEMU_FALLTHROUGH;

 =C2=A0=C2=A0=C2=A0 case 2:


VIXL_FALLTHROUGH also needs a similar definition to work with gcc-8.3.0.

Please comment. Would you prefer another macro name or a macro with=20
parentheses like this:

#define QEMU_FALLTHROUGH() __attribute__ ((fallthrough))


As soon as there is consensus on the macro name and form, I can send a=20
patch which adds it (but would not mind if someone else adds it).

Then I suggest that the maintainers build with the fallthrough warning=20
enabled and fix all warnings, either by using the new macro or by adding=20
the missing break.

Finally we can enforce the warning by default.


Another macro which is currently missing is a scanf variant of GCC_FMT_AT=
TR.

I suggest to add and use a GCC_SCANF_ATTR macro:

#define GCC_SCANF_ATTR(n, m) __attribute__((format(gnu_scanf, n, m)))

A more regular solution would require renaming GCC_FMT_ATTR to=20
GCC_FMT_PRINTF and use GCC_FMT_SCANF for the new macro.


Regards
Stefan Weil



