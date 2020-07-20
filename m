Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8B0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194FA22CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHynaLnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194FA22CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxW1C-00022o-9C
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1jxW0D-0001aC-Vd
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:38:46 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:42753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1jxW0C-0004lq-9s
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:38:45 -0400
Received: by mail-qk1-x735.google.com with SMTP id b79so1478468qkg.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=leRZAPXTwlXN2U+tGFJi3YHzjO7yE8G+7yl0RR2z9Jc=;
 b=jHynaLnPcZ35+m2e1udev/LYvr6JV5Hmx4/vTZNV42klzxLg/G4faNdlLomcOIdbUz
 cJ1gPbFSHzmDH4CwX+RT7tQcjTCjQGHOjaIAHDW8tiFPZhd1+XWV4IRRes07WdgaUATq
 Ot7I68CJPDxqWF9itx8vdeWa12eGp+qVzb2bUqeqfmemAGfyn215TtHXeAb9mQgIxQdq
 9s1NEwGgFQC3YjginkH9dvM5SJ0/mBdoDqxZqUtJQlyszSDYm6W7HDte2mQ9KxtyER1Y
 PoEe6/lMhpRSoJqCU4wppqHfG4zfVrMaDODZzzkkspEcX7S8fJttfXVcqSY0CqCh9ruy
 6u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=leRZAPXTwlXN2U+tGFJi3YHzjO7yE8G+7yl0RR2z9Jc=;
 b=aMa2P1VGFGzv0+huaei9HkDP9aWEbTOkxOTcQqjjwIWpGejYqd9cMVqnhVbzQGYujz
 EJKGDh9XfPQnyrj78yJbNxqf+UdLvkzS5kQbOISYihC7U/EemkNF+S2siG6nvo0MPNTn
 gO4SxAIwNXEFQcFTjmk6la/n2o5oxgjhuw/elrE01j1LO1f79U4szZrkah6QIB5BpJ4F
 SoT2Fp+SMFIU9Yn7y4TKpnzR2PPAkpgeA9PUZC9jYRnPWrbz9xaAPdfxfC5ORbNL3dS8
 UB2agMiYwADqsfhfY+ySZm/n90xVZi+SRPkAwFnhG7Q1vGkNjURIoK8uEwVIabnKDQkt
 sYCQ==
X-Gm-Message-State: AOAM530HyjQ+gyIkxdDECogPVX2zqigQfyupZ7DKOmgG8x40o3oYF3nI
 JVtSvjzWWF4he3cum7Bwi7cfChvSQy7/4ew/iFY=
X-Google-Smtp-Source: ABdhPJzaEMENyxSxa9nrHhMp2uwvHh4w5HjRSrxWmaeAgKy0zh9FosTEsIalOqIb1QpQQATqoMiVLeGgGr4WDzqWTq8=
X-Received: by 2002:a37:34f:: with SMTP id 76mr8983697qkd.68.1595252319280;
 Mon, 20 Jul 2020 06:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200714164257.23330-1-f4bug@amsat.org>
 <CAK4993j2jvhC_puPHWmH7+t2w3xQReSYwXBwDVhYP1nX1pAfiQ@mail.gmail.com>
In-Reply-To: <CAK4993j2jvhC_puPHWmH7+t2w3xQReSYwXBwDVhYP1nX1pAfiQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 20 Jul 2020 16:38:02 +0300
Message-ID: <CAK4993jRdMhppGnbSWkNsG5JGb1EazcH=AzMnZEkA5SU_YFgmg@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 0/4] misc: Document qemu_find_file and fix memory
 leak in avr_load_firmware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000d163db05aadf9fc7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=mrolnik@gmail.com; helo=mail-qk1-x735.google.com
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

--000000000000d163db05aadf9fc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Michael Rolnik <mrolnik@gmail.com>

I mean I got the patch, built and then ran *make check-qtest-avr* and *make
check-acceptance*

On Mon, Jul 20, 2020 at 4:24 PM Michael Rolnik <mrolnik@gmail.com> wrote:

> Reviewed-by: Michael Rolnik <mrolnik@gmail.com>
>
>
> On Tue, Jul 14, 2020 at 7:42 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
> wrote:
>
>> Fix the memory leak reported by Coverity (CID 1430449).
>>
>> Philippe Mathieu-Daud=C3=A9 (4):
>>   qemu/osdep: Document os_find_datadir() return value
>>   qemu/osdep: Reword qemu_get_exec_dir() documentation
>>   qemu-common: Document qemu_find_file()
>>   hw/avr/boot: Fix memory leak in avr_load_firmware()
>>
>>  include/qemu-common.h | 14 ++++++++++++++
>>  include/qemu/osdep.h  |  5 ++++-
>>  hw/avr/boot.c         |  2 +-
>>  os-posix.c            |  3 +++
>>  os-win32.c            |  7 ++++++-
>>  5 files changed, 28 insertions(+), 3 deletions(-)
>>
>> --
>> 2.21.3
>>
>>
>
> --
> Best Regards,
> Michael Rolnik
>


--=20
Best Regards,
Michael Rolnik

--000000000000d163db05aadf9fc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gm=
ail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br><div><br></div><div=
>I mean I got the patch, built and then ran <b><font face=3D"monospace">mak=
e check-qtest-avr</font></b> and <b><font face=3D"monospace">make check-acc=
eptance</font></b>=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Jul 20, 2020 at 4:24 PM Michael Rolni=
k &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr=
"><span>Reviewed</span>-<span>by</span>: Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br><div><=
br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Jul 14, 2020 at 7:42 PM Philippe Mathieu-Daud=C3=A9 &lt;<a=
 href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fix the m=
emory leak reported by Coverity (CID 1430449).<br>
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
>Best Regards,<br>Michael Rolnik</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000d163db05aadf9fc7--

