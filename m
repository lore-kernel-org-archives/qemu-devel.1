Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC42CC48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 04:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9411220659
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 04:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9411220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkLeS-0001Lj-Ty
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 00:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sw@weilnetz.de>) id 1hkLdy-0000uN-86
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 00:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sw@weilnetz.de>) id 1hkLdw-0001Jb-DG
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 00:52:49 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:54538
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1hkLds-0001Fz-Ea
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 00:52:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id BE7F8DB85DF;
 Mon,  8 Jul 2019 06:52:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id 3bsF8pbFGyWq; Mon,  8 Jul 2019 06:52:39 +0200 (CEST)
Received: from edv-macbook-pro.fritz.box (p57B4293C.dip0.t-ipconnect.de
 [87.180.41.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 1C264DB7F0B;
 Mon,  8 Jul 2019 06:52:39 +0200 (CEST)
To: Markus Armbruster <armbru@redhat.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
 <87imsdcf5l.fsf@dusky.pond.sub.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <7e6fb611-ef18-459a-4676-3c10c2f41249@weilnetz.de>
Date: Mon, 8 Jul 2019 06:52:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87imsdcf5l.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: Re: [Qemu-devel] Handling of fall through code
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

Am 08.07.19 um 06:40 schrieb Markus Armbruster:

> Stefan Weil <sw@weilnetz.de> writes:
>
>> - Some code is correct, but has no indication that the fallthrough is
>> intentional.
> I'd treat that as a bug.


Sure.


>
>> - There is also fallthrough code which is obviously not correct (even
>> in target/mips/translate.c).
> Bug.


Yes, of course.


>
>> I suggest to enable -Werror=3Dimplicit-fallthrough by default and add =
a
>> new macro to mark all fallthrough locations which are correct, but not
>> accepted by the compiler.
>>
>> This can be done with a definition for GCC compatible compilers in
>> include/qemu/compiler.h:
>>
>> #define QEMU_FALLTHROUGH __attribute__ ((fallthrough))
>>
>> Then fallthrough code would look like this:
>>
>>  =C2=A0=C2=A0=C2=A0 case 1:
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 do_something();
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 QEMU_FALLTHROUGH;
>>
>>  =C2=A0=C2=A0=C2=A0 case 2:
>>
>>
>> VIXL_FALLTHROUGH also needs a similar definition to work with gcc-8.3.=
0.
>>
>> Please comment. Would you prefer another macro name or a macro with
>> parentheses like this:
>>
>> #define QEMU_FALLTHROUGH() __attribute__ ((fallthrough))
> In my opinion, the macro is no clearer than proper comments.
>
> I'd prefer -Wimplicit-fallthrough=3D1 or 2.  The former makes gcc accep=
t
> any comment.  The latter makes it accept '.*falls?[ \t-]*thr(ough|u).*'=
,
> which should still match the majority of our comments.  Less churn than
> the macro.
[...]
> Another macro which is currently missing is a scanf variant of GCC_FMT_=
ATTR.
>
> I suggest to add and use a GCC_SCANF_ATTR macro:
>
> #define GCC_SCANF_ATTR(n, m) __attribute__((format(gnu_scanf, n, m)))
> Do we define our own scanf()-like functions?  If yes, decorating them
> with the attribute is a good idea.


xen_device_backend_scanf, xs_node_vscanf, xs_node_scanf,=20
xen_device_frontend_scanf

Maybe more. The compiler can tell you missing attributes.


>
> However, the gnu_ in gnu_scanf tells the compiler we're linking with th=
e
> GNU C Library, which seems unwise.  Hmm, we already use gnu_printf.
> Commit 9c9e7d51bf0:
>
>      Newer gcc versions support format gnu_printf which is
>      better suited for use in QEMU than format printf
>      (QEMU always uses standard format strings (even with mingw32)).
>
> Should we limit the use of gnu_printf to #ifdef _WIN32?


No, because we don't want lots of conditional code with different format=20
strings for POSIX and Windows (I made that commit 9 years ago).


>> A more regular solution would require renaming GCC_FMT_ATTR to
>> GCC_FMT_PRINTF and use GCC_FMT_SCANF for the new macro.
> Quite some churn, but regularity matters.


I could do that when adding the new macro, but would like to hear more=20
opinions on that.

Thank you,

Stefan


