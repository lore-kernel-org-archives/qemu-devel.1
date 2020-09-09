Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10B6C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA2820936
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW2eR2t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA2820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0f9-0004qN-DM
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kG0e8-0003iv-5a
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:00:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:45686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kG0e4-0000ii-UP
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:00:23 -0400
Received: by mail-ej1-x62a.google.com with SMTP id i26so3667527ejb.12
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6DwJ9J8YqZUXNrEY2yeRuXNOcrGN45BT7n5oddIV2+Y=;
 b=SW2eR2t/LyzhAg/WRYT+JOGNoY5S1OrN+BOE+7/dgkPQyXYYRs6DLLXUTAy52tRQbr
 JJJlqh0Gn5sgGNe9VyJw8MaZtWKCo7AHj/SlAp+ZnHb4PhU1uxv1ZVNLjHAB8yMyxOw0
 64nxZbdl7qkHHIjQJkKRGPIlN8ZXuk77AEAuf0+ckZIqMOly5Jlh419N0EVEdqYVTw83
 WH5GpB5BO/PAduKRMeutXPbijlvjadvxpsdhqU+l0IWk+T4QceUljZgMWyV6ZAKt8xmK
 5JHQ1gQt4X3ZF8XfWYJOPmtqIhAysOvEUDksjUV1FNM1PA3ZpfDyodx1F3rgPSuTkRHA
 E2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6DwJ9J8YqZUXNrEY2yeRuXNOcrGN45BT7n5oddIV2+Y=;
 b=euUcXZi/eJ1BVXRUsutg3YbZHMrdt/hkNn2BCxCUiwsQ6IuUMuI7P84QclKoBQlT3y
 MqiIGb8++q76rJqfEt1g0UEx/gE4o9/LzPC01GuuNVtKaNeI6aw/0oeMsIBsOqcJxz+W
 UAN75l1AtCs2yghKHpR7DAkWpnIyUjV6B8LFH6PE9Q3PiCUTZcNECNTaBmLtt2NxBCSr
 kUzjPaKBWhRQHfUPM4Zl0G+qT6H1WVqfSO0f4ifwHS+wSB2mACqH4hcYEoV+l5DNthI/
 h60YbrYH1ixneztBD9Fkl5bo3+p8r7+NzxLv8wK9RQlX+Fc8YNeHOnI0LE4TMVOFC6GE
 tw+Q==
X-Gm-Message-State: AOAM533j3NoslhsLcCJMA7xCW6N7bra/l9dCJQcZeDk2cicltTRompIa
 N0exCzS6EGkFqZPgqWFTWw2O6d5w179tyLa0okk=
X-Google-Smtp-Source: ABdhPJw0FpxqdCzSXliwQC/j+0U0GLxB0PpIdRUcwHReUgit1PwkvwsrH026x7WfSG9ItFJDOTclkwSXJACBStkYIS4=
X-Received: by 2002:a17:906:4a51:: with SMTP id
 a17mr3673382ejv.381.1599660019019; 
 Wed, 09 Sep 2020 07:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <87pn6vw2he.fsf@dusky.pond.sub.org>
In-Reply-To: <87pn6vw2he.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 9 Sep 2020 18:00:06 +0400
Message-ID: <CAJ+F1C+Ro0rVsxfdMXa-0gn=LGdc8XRm9NNzjvv0ArvRZBq7-w@mail.gmail.com>
Subject: Re: Meson can't recover from deletion of generated QAPI file(s)
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000031f3e505aee1dfc7"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000031f3e505aee1dfc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Sep 9, 2020 at 4:37 PM Markus Armbruster <armbru@redhat.com> wrote:

> Watch this:
>
>     $ rm qapi/qapi-types-error.h
>     $ make
>     Generating qemu-version.h with a meson_exe.py custom command
>     Compiling C object qom/libqom.fa.p/object_interfaces.c.o
>     In file included from ../qom/object_interfaces.c:4:
>     /work/armbru/qemu/include/qapi/error.h:275:10: fatal error:
> qapi/qapi-types-error.h: No such file or directory
>       275 | #include "qapi/qapi-types-error.h"
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>     make: *** [Makefile.ninja:348: qom/libqom.fa.p/object_interfaces.c.o]
> Error 1
>
> To recover, I have to run qapi-gen.py manually and exactly right, or
> blow away the build tree and start over.
>
> The old build system did what a build system should: it remade the files
> that are missing or out of date.
>
> I'm still too clueless about Meson to debug this, but I hope I can learn
> from watching you fix it.
>

It looks like the ninja build handles that fine, so this is most likely a
ninja2make conversion issue.


--=20
Marc-Andr=C3=A9 Lureau

--00000000000031f3e505aee1dfc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:37 PM Mark=
us Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Wat=
ch this:<br>
<br>
=C2=A0 =C2=A0 $ rm qapi/qapi-types-error.h <br>
=C2=A0 =C2=A0 $ make<br>
=C2=A0 =C2=A0 Generating qemu-version.h with a meson_exe.py custom command<=
br>
=C2=A0 =C2=A0 Compiling C object qom/libqom.fa.p/object_interfaces.c.o<br>
=C2=A0 =C2=A0 In file included from ../qom/object_interfaces.c:4:<br>
=C2=A0 =C2=A0 /work/armbru/qemu/include/qapi/error.h:275:10: fatal error: q=
api/qapi-types-error.h: No such file or directory<br>
=C2=A0 =C2=A0 =C2=A0 275 | #include &quot;qapi/qapi-types-error.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~=
~~~~~~~~~~~~~~~~~~~~~<br>
=C2=A0 =C2=A0 compilation terminated.<br>
=C2=A0 =C2=A0 make: *** [Makefile.ninja:348: qom/libqom.fa.p/object_interfa=
ces.c.o] Error 1<br>
<br>
To recover, I have to run qapi-gen.py manually and exactly right, or<br>
blow away the build tree and start over.<br>
<br>
The old build system did what a build system should: it remade the files<br=
>
that are missing or out of date.<br>
<br>
I&#39;m still too clueless about Meson to debug this, but I hope I can lear=
n<br>
from watching you fix it.<br></blockquote><div><br></div><div>It looks like=
 the ninja build handles that fine, so this is most likely a ninja2make con=
version issue. <br></div></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000031f3e505aee1dfc7--

