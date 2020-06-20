Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 09:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDE620739
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 09:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIb3jmBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDE620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmZb7-0001WM-Ac
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 05:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmZaS-000124-0W
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 05:14:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmZaQ-0006aZ-3u
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 05:14:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so10505236wmj.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=IRmeTh2jsLZu/75ayKTH+vLDqUGuFwhOkXkTdVub5qw=;
 b=BIb3jmBAfm7ozoVzWNcRrCY0BDW8ayMLmujO1R2qC2ULpLU8bXhmXKFUcNM6Uo1175
 1S2FU7FcZuGaPQSV8YeAI6IutaPgeme1/HWPsu+oXR91qXhWcgpTxFyvuAlyxsb9FHI5
 x5H5EtCpGepMdLiNJfIxvYM5ID1tpm7bErgktkLHytPj0M6UBB7PVUAORLO3WC2xxuzP
 t3xK1DaA1xCz4yL+zzQ/4ixc9W/ZD+o6+GXoe5GbqVjFUbQp1rJoEPpwpyyIphYi6VFl
 licM/fuJUqNYtm7UA9tYSRaBQYa1BGG8+W8dT8DdLyjGx145CrOTtr5SnolNKXJ86tsd
 vvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=IRmeTh2jsLZu/75ayKTH+vLDqUGuFwhOkXkTdVub5qw=;
 b=mG6v2Js810iuL2qpqDg2SpLeZWnRi/BlrKFcoPggB/LUcAy1JoUIzim0KIKpO0lkOH
 L/ZW62LQ/76RpqVuXbdy0DbO/aoRNXIDWOLmzUfwuqGBcPgn7P7uB1pre8kba0CUgzJj
 CBreTixk1R+zVs91pFww/rIVBguhtwm0IxBPNtxHDvv+8Ak9ZtOSrXL0KH5YVLJWNpjC
 o09AfJOHfw7TkKzxmEK3ulYSogmluQLJQ/DCrrd692QtI2a354jDywxiBfjTPSX3bQih
 1iHLeJUzGrZwcIjUfEFNXq7K8jvvs641QJrKNFwfuArDWWrfQy8R4FGpeqUvftEkYC+6
 iahA==
X-Gm-Message-State: AOAM532fR/NOSTbvernNZotuNUn086v0A5T4KCb36DLxLGBNj/BoJHek
 nA42bWI+wqc2AJcmZy7S5fxmb0HP2Jzhw6ZaqOk=
X-Google-Smtp-Source: ABdhPJzQWDBx8/0R7343AeDzLakU+MOi0wXUvQI42ZraaBGN1SQIMA2XQssjMc9vNnGEz60dVQ7f6AhwaAQ2RyXDdmQ=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr8400261wmb.168.1592644492173; 
 Sat, 20 Jun 2020 02:14:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Sat, 20 Jun 2020 02:14:51 -0700 (PDT)
In-Reply-To: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
References: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 20 Jun 2020 11:14:51 +0200
Message-ID: <CAHiYmc4DLJA7Us06hOPAfi-A6b+vFk4DKtd++8ytmdkbQzYHrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add Scripts for Finding Top 25 Executed Functions
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000035a73305a880718c"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000035a73305a880718c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=B5=D1=82=D0=B0=D0=BA, 19. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman=
 <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Greetings,
>
> This series implements the improvements and changes requested to be
> added to the two scripts.
>
> Thanks to Mr. Aleksandar Markovic, Mr. Alex Benn=C3=A9e, and Mr. Eric Bla=
ke
> for their valuable feedback.
>
> First version of the series:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg04868.html
>
>
The cover letters for v2, v3,... should repeat the core text of the
original cover letter. You can keep this link above, but you must repeat
the almost all text of v1 cover letter in v2, v3,... too. Any version of
any series should be a stand-alone unit, and the reader should not be
forced to look at the previous versions to find out what the series is
really about, which is the case now for this v2 of your series.

Thanks,
Aleksandar

Best regards,
> Ahmed Karaman
>
> v1->v2:
> - Add an empty line at the end of the MAINTAINERS file.
> - Move MAINTAINERS patch to be the last in the series.
> - Allow custom number of top functions to be specified.
> - Check for vallgrind and perf before executing the scripts.
> - Ensure sufficient permissions when running the topN_perf script.
> - Use subprocess instead of os.system
> - Use os.unlink() for deleting intermediate files.
> - Spread out the data extraction steps.
> - Enable execution permission for the scripts.
> - Add script example output in the commit message.
>
> Ahmed Karaman (3):
>   scripts/performance: Add topN_perf.py script
>   scripts/performance: Add topN_callgrind.py script
>   MAINTAINERS: Add 'Performance Tools and Tests' subsection
>
>  MAINTAINERS                           |   7 ++
>  scripts/performance/topN_callgrind.py | 131 ++++++++++++++++++++++++++
>  scripts/performance/topN_perf.py      | 115 ++++++++++++++++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100755 scripts/performance/topN_callgrind.py
>  create mode 100755 scripts/performance/topN_perf.py
>
> --
> 2.17.1
>
>

--00000000000035a73305a880718c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=B5=D1=82=D0=B0=D0=BA, 19. =D1=98=D1=83=D0=BD 2020., Ahmed=
 Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledkar=
aman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Greetings,<br>
<br>
This series implements the improvements and changes requested to be<br>
added to the two scripts.<br>
<br>
Thanks to Mr. Aleksandar Markovic, Mr. Alex Benn=C3=A9e, and Mr. Eric Blake=
<br>
for their valuable feedback.<br>
<br>
First version of the series:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg0486=
8.html" target=3D"_blank">https://lists.nongnu.org/<wbr>archive/html/qemu-d=
evel/2020-<wbr>06/msg04868.html</a><br>
<br></blockquote><div><br></div><div>The cover letters for v2, v3,... shoul=
d repeat the core text of the original cover letter. You can keep this link=
 above, but you must repeat the almost all text of v1 cover letter in v2, v=
3,... too. Any version of any series should be a stand-alone unit, and the =
reader should not be forced to look at the previous versions to find out wh=
at the series is really about, which is the case now for this v2 of your se=
ries.</div><div><br></div><div>Thanks,</div><div>Aleksandar</div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
Best regards,<br>
Ahmed Karaman<br>
<br>
v1-&gt;v2:<br>
- Add an empty line at the end of the MAINTAINERS file.<br>
- Move MAINTAINERS patch to be the last in the series.<br>
- Allow custom number of top functions to be specified.<br>
- Check for vallgrind and perf before executing the scripts.<br>
- Ensure sufficient permissions when running the topN_perf script.<br>
- Use subprocess instead of os.system<br>
- Use os.unlink() for deleting intermediate files.<br>
- Spread out the data extraction steps.<br>
- Enable execution permission for the scripts.<br>
- Add script example output in the commit message.<br>
<br>
Ahmed Karaman (3):<br>
=C2=A0 scripts/performance: Add topN_perf.py script<br>
=C2=A0 scripts/performance: Add topN_callgrind.py script<br>
=C2=A0 MAINTAINERS: Add &#39;Performance Tools and Tests&#39; subsection<br=
>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 ++<br>
=C2=A0scripts/performance/topN_<wbr>callgrind.py | 131 ++++++++++++++++++++=
++++++<br>
=C2=A0scripts/performance/topN_perf.<wbr>py=C2=A0 =C2=A0 =C2=A0 | 115 +++++=
+++++++++++++++++<br>
=C2=A03 files changed, 253 insertions(+)<br>
=C2=A0create mode 100755 scripts/performance/topN_<wbr>callgrind.py<br>
=C2=A0create mode 100755 scripts/performance/topN_perf.<wbr>py<br>
<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--00000000000035a73305a880718c--

