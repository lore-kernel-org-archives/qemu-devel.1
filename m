Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D7C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89208206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89208206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn0sS-0002RB-Hz
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hn0sH-0001zT-9K
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hn0sG-0000YT-0s
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hn0sF-0000Y1-Pb
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:18:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81CE830820EA;
 Mon, 15 Jul 2019 13:18:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE18E6090E;
 Mon, 15 Jul 2019 13:18:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7FE5011386A0; Mon, 15 Jul 2019 15:18:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190715113939.3256-1-armbru@redhat.com>
 <d7f33364-33dc-7b95-473d-b8d91b06395c@redhat.com>
Date: Mon, 15 Jul 2019 15:18:29 +0200
In-Reply-To: <d7f33364-33dc-7b95-473d-b8d91b06395c@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 15 Jul 2019 13:52:45
 +0200")
Message-ID: <87ef2rv3kq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 15 Jul 2019 13:18:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] include: Make headers more self-contained
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/15/19 1:39 PM, Markus Armbruster wrote:
>> Back in 2016, we discussed[1] rules for headers, and these were
>> generally liked:
>>=20
>> 1. Have a carefully curated header that's included everywhere first.  We
>>    got that already thanks to Peter: osdep.h.
>>=20
>> 2. Headers should normally include everything they need beyond osdep.h.
>>    If exceptions are needed for some reason, they must be documented in
>>    the header.  If all that's needed from a header is typedefs, put
>>    those into qemu/typedefs.h instead of including the header.
>>=20
>> 3. Cyclic inclusion is forbidden.
>>=20
>> This patch gets include/ closer to obeying 2.
>
> A step forward using precompiled headers?
>
> https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html

I doubt his can help a hypothetical future adoption of precompiled
headers in QEMU much.

Precompiled headers are a finicky.  From the GCC manual:

    A precompiled header file can be used only when these conditions
    apply:

        * Only one precompiled header can be used in a particular
          compilation.

        * A precompiled header cannot be used once the first C token is
          seen. You can have preprocessor directives before a
          precompiled header; you cannot include a precompiled header
          from inside another header.

        * The precompiled header file must be produced for the same
          language as the current compilation. You cannot use a C
          precompiled header for a C++ compilation.

        * The precompiled header file must have been produced by the
          same compiler binary as the current compilation is using.

        * Any macros defined before the precompiled header is included
          must either be defined in the same way as when the precompiled
          header was generated, or must not affect the precompiled
          header, which usually means that they don=E2=80=99t appear in the
          precompiled header at all.

          [Details...]

        [More conditions on compiler options...]

Since we always include qemu/osdep.h first, that's the header we could
precompile.  Last time I checked, a .c file that includes nothing but
that comes out well over half a Megabyte in ~20k lines preprocessed.
I'd welcome build time comparisons with and without precompiling
qemu/osdep.h.

We have headers that are included from almost everywhere.  Some of them
are due to undisciplined use of #include; that needs fixing.  But some
may actually be needed almost everywhere.  Inluding them from a
precompiled qemu/osdep.h might gain further build speedups.

Making headers self-contained makes reordering inclusions safe.  That's
about what this patch can contribute to precompiled header adoption.
Nice, but not essential; we can always fix up things as they break.

How widely used are precompiled headers?  I'm asking because underused
parts of tools tend to be buggy parts.

[...]

