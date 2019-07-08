Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D38C48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 04:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5C720665
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 04:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5C720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkLSn-00070M-UY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 00:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkLSK-0006ZD-G4
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 00:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkLSI-0004O1-Ms
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 00:40:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkLSI-0004J2-EM
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 00:40:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC30F30BDE49;
 Mon,  8 Jul 2019 04:40:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47E6019C68;
 Mon,  8 Jul 2019 04:40:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 997081132ABF; Mon,  8 Jul 2019 06:40:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
Date: Mon, 08 Jul 2019 06:40:38 +0200
In-Reply-To: <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de> (Stefan Weil's
 message of "Sun, 7 Jul 2019 22:26:22 +0200")
Message-ID: <87imsdcf5l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 08 Jul 2019 04:40:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Handling of fall through code (was: [PATCH v8
 04/87] target/mips: Mark switch fallthroughs with interpretable comments
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
 riku.voipio@iki.fi, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 laurent@vivier.eu, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com,
 pjovanovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Weil <sw@weilnetz.de> writes:

> Am 13.08.18 um 19:52 schrieb Aleksandar Markovic:
>
>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> Mark switch fallthroughs with comments, in cases fallthroughs
>> are intentional.
>
>
> This is a general problem all over the QEMU code. I usually compile
> with nearly all warnings enabled and get now lots of errors with the
> latest code and after updating to gcc-8.3.0 (Debian buster). It should
> be reproducible by enabling -Werror=3Dimplicit-fallthrough.
>
> The current situation is like this:
>
> - Some code has fallthrough comments which are accepted by the compiler.
>
> - Other code has fallthrough comments which are not accepted
> (resulting in a compiler error).
>
> - Some code is correct, but has no indication that the fallthrough is
> intentional.

I'd treat that as a bug.

> - There is also fallthrough code which is obviously not correct (even
> in target/mips/translate.c).

Bug.

> I suggest to enable -Werror=3Dimplicit-fallthrough by default and add a
> new macro to mark all fallthrough locations which are correct, but not
> accepted by the compiler.
>
> This can be done with a definition for GCC compatible compilers in
> include/qemu/compiler.h:
>
> #define QEMU_FALLTHROUGH __attribute__ ((fallthrough))
>
> Then fallthrough code would look like this:
>
> =C2=A0=C2=A0=C2=A0 case 1:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 do_something();
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 QEMU_FALLTHROUGH;
>
> =C2=A0=C2=A0=C2=A0 case 2:
>
>
> VIXL_FALLTHROUGH also needs a similar definition to work with gcc-8.3.0.
>
> Please comment. Would you prefer another macro name or a macro with
> parentheses like this:
>
> #define QEMU_FALLTHROUGH() __attribute__ ((fallthrough))

In my opinion, the macro is no clearer than proper comments.

I'd prefer -Wimplicit-fallthrough=3D1 or 2.  The former makes gcc accept
any comment.  The latter makes it accept '.*falls?[ \t-]*thr(ough|u).*',
which should still match the majority of our comments.  Less churn than
the macro.

> As soon as there is consensus on the macro name and form, I can send a
> patch which adds it (but would not mind if someone else adds it).
>
> Then I suggest that the maintainers build with the fallthrough warning
> enabled and fix all warnings, either by using the new macro or by
> adding the missing break.
>
> Finally we can enforce the warning by default.
>
>
> Another macro which is currently missing is a scanf variant of GCC_FMT_AT=
TR.
>
> I suggest to add and use a GCC_SCANF_ATTR macro:
>
> #define GCC_SCANF_ATTR(n, m) __attribute__((format(gnu_scanf, n, m)))

Do we define our own scanf()-like functions?  If yes, decorating them
with the attribute is a good idea.

However, the gnu_ in gnu_scanf tells the compiler we're linking with the
GNU C Library, which seems unwise.  Hmm, we already use gnu_printf.
Commit 9c9e7d51bf0:

    Newer gcc versions support format gnu_printf which is
    better suited for use in QEMU than format printf
    (QEMU always uses standard format strings (even with mingw32)).

Should we limit the use of gnu_printf to #ifdef _WIN32?

> A more regular solution would require renaming GCC_FMT_ATTR to
> GCC_FMT_PRINTF and use GCC_FMT_SCANF for the new macro.

Quite some churn, but regularity matters.

