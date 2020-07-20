Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90769C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B97D20729
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzOrkIob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B97D20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVno-0006hq-Ls
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1jxVn3-0006Hl-Q8
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:25:09 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e]:35967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1jxVn2-0002wQ-3T
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:25:09 -0400
Received: by mail-qt1-x82e.google.com with SMTP id x62so12896195qtd.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bKY4XsCvOTySWaVXgClJQulhs6qBbepkIgDk+vnGSLU=;
 b=dzOrkIobbr5sck25NZyVLB1ycip+6nfEejVbtLkrhQCwp3hjiw+9HOHY5NeKMfWRUj
 RvWOGIDpZUH/BCeNpkFr4fGn6DvVsPUKXPU4eupaWhvotECYf1kiVX06Wjj5t9iHDAv2
 O9ctkBRJ7NGnWnrk907gSlHwcZf1yT7gpxEE9/2ET/Jgo50+cepGIbyEAYxzH3xMqemN
 9flmHfYaBiuCIybKglxaRfhlsI++Y+0qz9DgsIKc+QHIjtB+CoeA3Ctq4Q6xL1yEZob4
 /C2rAyuFHym5bHKlzItIIDrnX8pI5Bg04/Q1o1jzAX35hc66VSdEM0IraBm1DQLLt7zc
 Aiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bKY4XsCvOTySWaVXgClJQulhs6qBbepkIgDk+vnGSLU=;
 b=UMf9JEck+zHqiZH9t+SamvcAOQYJNN5MxE55MPWGkJwGjwi00FZS2aLpbwYE7CQHaX
 0OroM3kMKMj2iGWlkkjcfJqKWNmK5wjy4AWGyk2oZKL6/mnkt3U4hHlqz9DWMalicyUl
 zPyrAvtq9aI1RwA61paPXEXjcZ8DhbTZC0RoZoo/je73GLCaquUkoPxQbsIAschqwVXi
 2f+SbzvZXh2qwRS53CAoIVLxONyk0H6FD1OhI4EPOYXc03OImcTJaiV4/1L6vQ4CGSSa
 6I3JSZqOXWJuzg78bOB6HKokBwuues6C/ln6Yv6qzX7BcdioekWr8ceBa4B9NuVI6Xlu
 JFJA==
X-Gm-Message-State: AOAM531XSolYaEdyMrs4CviT11LPi47WfVsCdKmQy1bkBIm2qrVAeEuC
 HQIG+EetaDWbnLcYI+GnI7qdWtjIw2u5XTkGVjE=
X-Google-Smtp-Source: ABdhPJwZBzoJgQlA9lfdhLu2eiZf4tzuXhPLxn/YAt97Ifww0S3ivNCjd9+v7N75EyIx/anULT+TL8I3u5tUrN1cH3U=
X-Received: by 2002:aed:32e5:: with SMTP id z92mr23639610qtd.282.1595251506768; 
 Mon, 20 Jul 2020 06:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200714164257.23330-1-f4bug@amsat.org>
In-Reply-To: <20200714164257.23330-1-f4bug@amsat.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 20 Jul 2020 16:24:30 +0300
Message-ID: <CAK4993j2jvhC_puPHWmH7+t2w3xQReSYwXBwDVhYP1nX1pAfiQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 0/4] misc: Document qemu_find_file and fix memory
 leak in avr_load_firmware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000063708e05aadf6f3e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=mrolnik@gmail.com; helo=mail-qt1-x82e.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000063708e05aadf6f3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Michael Rolnik <mrolnik@gmail.com>


On Tue, Jul 14, 2020 at 7:42 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Fix the memory leak reported by Coverity (CID 1430449).
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   qemu/osdep: Document os_find_datadir() return value
>   qemu/osdep: Reword qemu_get_exec_dir() documentation
>   qemu-common: Document qemu_find_file()
>   hw/avr/boot: Fix memory leak in avr_load_firmware()
>
>  include/qemu-common.h | 14 ++++++++++++++
>  include/qemu/osdep.h  |  5 ++++-
>  hw/avr/boot.c         |  2 +-
>  os-posix.c            |  3 +++
>  os-win32.c            |  7 ++++++-
>  5 files changed, 28 insertions(+), 3 deletions(-)
>
> --
> 2.21.3
>
>

--=20
Best Regards,
Michael Rolnik

--00000000000063708e05aadf6f3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-il">Reviewed</span>-<span class=3D"gm=
ail-il">by</span>: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">=
mrolnik@gmail.com</a>&gt;<br><div><br></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 14, 2020 at 7:42 PM=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@a=
msat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Fix the memory leak reported by Coverity (CID 1430449).<br>
<br>
Philippe Mathieu-Daud=C3=A9 (4):<br>
=C2=A0 qemu/osdep: Document os_find_datadir() return value<br>
=C2=A0 qemu/osdep: Reword qemu_get_exec_dir() documentation<br>
=C2=A0 qemu-common: Document qemu_find_file()<br>
=C2=A0 hw/avr/boot: Fix memory leak in avr_load_firmware()<br>
<br>
=C2=A0include/qemu-common.h | 14 ++++++++++++++<br>
=C2=A0include/qemu/osdep.h=C2=A0 |=C2=A0 5 ++++-<br>
=C2=A0hw/avr/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0os-posix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +++<br>
=C2=A0os-win32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++++++-=
<br>
=C2=A05 files changed, 28 insertions(+), 3 deletions(-)<br>
<br>
-- <br>
2.21.3<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000063708e05aadf6f3e--

