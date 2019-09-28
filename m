Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF34C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 17:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE3320863
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 17:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAxc0ICn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEGpE-00025W-9D
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 13:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iEGnH-0001YH-Tw
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 13:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iEGnG-0004de-Cp
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 13:46:07 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:43309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iEGnB-0004Nt-Ra; Sat, 28 Sep 2019 13:46:02 -0400
Received: by mail-ot1-x334.google.com with SMTP id o44so5003898ota.10;
 Sat, 28 Sep 2019 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=1qvsdEu2h+e8lIOH6xj3uU8yj9PpBQl/3jKWLql9DlU=;
 b=NAxc0ICnQHY7UlKtyOPzYaVplt59USy6kyPRouPc60vvoCnDNRJlh3VEGR56gn63xG
 2Q4y3TCcvI9l4p0Y5BwTRWkLBCA1ymKb35ZwgkzocD5PGU2py8ZsZGaDPJv+5GHoXoM6
 Y8nK4V1bFUarfDknl8j/boydz4QBpIwatDBubnA0+mqVt4BkgiNM260mM9OLFK6L2KMp
 PtMm3OuTEkP6MNHGLoQnuiJlu43WHv+Bnh7srv+o2HrzO5Foy4tyy5iv47Sh0wVG93k2
 ++CEnAhdsnsmGDdvUDDUOyq1G/ptQE/YXljnrkcOIUyj0KSfFC+WAa4vNEXThC5DpqIw
 2nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=1qvsdEu2h+e8lIOH6xj3uU8yj9PpBQl/3jKWLql9DlU=;
 b=jmmkZm8MbuhlwcAHfjf7h6KVSnnRqMLaUaY8xJGNMDxDVUV/EQZLeRMIY51+V9AnjC
 EEtK/CNCIh61S1H7eMvkICuV+D7dJMlZQCAjO7MPjC4743YhePbHCmJ55X2tT/NICuZf
 8wtCa1NcIvvdB/mYqI0WEGDth5vYl1lyu+eDSm8Ibq+if41W1dcLEuaMZ/h6CJq68hQs
 mrfeyUOZF0mhngNtZseUb/pqQ0IeDyEwv7xrDX4TYzmK1DgyjY2brHn1mGiW/P2udoEa
 XJ7zU+NZkvT/vEPuBHU7Q6zUgT3yJAR2ceNo9D2biVunyxiVOkPTxWyNf2NYpEWSTfMF
 OxUw==
X-Gm-Message-State: APjAAAVkOIK9ZwBpTqIwDDJM07fSQ1OwM457VXXkMA8LgIv2pAnbZmsr
 99/hGTY5RUwuPBdSR0xb0WwgG5LzRgWQYAtp7io=
X-Google-Smtp-Source: APXvYqzPrbEHp7xWfhIr1mtX7eOSJ0X5gloy14RjO0cPb4ngbL+W8UoG2t/DSvWGH6R+/a5dOmCE3khILF20JW/pMxE=
X-Received: by 2002:a9d:6b19:: with SMTP id g25mr7612129otp.64.1569692760124; 
 Sat, 28 Sep 2019 10:46:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 28 Sep 2019 10:45:59
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 28 Sep 2019 10:45:59
 -0700 (PDT)
In-Reply-To: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 28 Sep 2019 19:45:59 +0200
Message-ID: <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
Subject: Re: target/ppc: bug in optimised vsl/vsr implementation?
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000005faf5a0593a0936a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: stefan.brankovic@rt-rk.com, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005faf5a0593a0936a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

26.09.2019. 20.14, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> As part of the investigation into the DFP number issue reported at
> https://bugs.launchpad.net/qemu/+bug/1841990 it appears that there may
also be a bug
> introduced by the new optimised vsl/vsr implementation:
>
> commit 4e6d0920e7547e6af4bbac5ffe9adfe6ea621822
> Author: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> Date: Mon Jul 15 16:22:48 2019 +0200
>
>     target/ppc: Optimize emulation of vsl and vsr instructions
>
>

(sorry in advance if the format of this message looks odd, I have some
problems with mail settings related to recent qemu-devel mailer settings
changes; I will adjust my mail settings in next few days)

Mark and Paul (and Stefan),

Thanks for spotting this and pinpointing the culprit commit. I guess Stefan
is going to respond soon, but, in the meantime, I took a look at the commit
in question:

https://github.com/qemu/qemu/commit/4e6d0920e7547e6af4bbac5ffe9adfe6ea62182=
2

I don't have at the moment any dev/test environment handy, but I did manual
inspection of the code, and here is what I found (in order of importance,
perceived by me):

1. The code will not work correctly if the shift ammount (variable 'sh') is
0. This is because, in that case, one of succeeding invocations of TCG
shift functions will be required to shift a 64-bit TCG variable by 64 bits,
and the result of such TCG operation is undefined (shift amount must be 63
or less) - see https://github.com/qemu/qemu/blob/master/tcg/README.

2. Variable naming is better in the old helper than in the new translator.
In that light, I would advise Stefan to change 'sh' to 'shift', and
'shifted' to 'carry'.

3. Lines

tcg_gen_andi_i64(shifted, shifted, 0x7fULL);

and

tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);

appear to be spurious (albait in a harmless way). Therefore, they should be
deleted, or, alternatevely, a justification for them should be provided.

4. In the commit message, variable names were used without quotation mark,
resulting in puzzling and unclear wording.

5. (a question for Mark) After all recent changes, does get_avr64(..., ...,
true) always (for any endian configuration) return the "high" half of an
Altivec register, and get_avr64(..., ..., false) the "low" one?

Given all these circumstances, perhaps the most reasonable solution would
be to revert the commit in question, and allow Stefan enough dev and test
time to hopefully submit a new, better, version later on.

Sincerely,
Aleksandar

--0000000000005faf5a0593a0936a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
26.09.2019. 20.14, &quot;Mark Cave-Ayland&quot; &lt;<a href=3D"mailto:mark.=
cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; As part of the investigation into the DFP number issue reported at<br>
&gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1841990">https://bugs.=
launchpad.net/qemu/+bug/1841990</a> it appears that there may also be a bug=
<br>
&gt; introduced by the new optimised vsl/vsr implementation:<br>
&gt;<br>
&gt; commit 4e6d0920e7547e6af4bbac5ffe9adfe6ea621822<br>
&gt; Author: Stefan Brankovic &lt;<a href=3D"mailto:stefan.brankovic@rt-rk.=
com">stefan.brankovic@rt-rk.com</a>&gt;<br>
&gt; Date: Mon Jul 15 16:22:48 2019 +0200<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 target/ppc: Optimize emulation of vsl and vsr instructio=
ns<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 </p>
<p dir=3D"ltr">(sorry in advance if the format of this message looks odd, I=
 have some problems with mail settings related to recent qemu-devel mailer =
settings changes; I will adjust my mail settings in next few days)</p>
<p dir=3D"ltr">Mark and Paul (and Stefan),</p>
<p dir=3D"ltr">Thanks for spotting this and pinpointing the culprit commit.=
 I guess Stefan is going to respond soon, but, in the meantime, I took a lo=
ok at the commit in question:</p>
<p dir=3D"ltr"><a href=3D"https://github.com/qemu/qemu/commit/4e6d0920e7547=
e6af4bbac5ffe9adfe6ea621822">https://github.com/qemu/qemu/commit/4e6d0920e7=
547e6af4bbac5ffe9adfe6ea621822</a></p>
<p dir=3D"ltr">I don&#39;t have at the moment any dev/test environment hand=
y, but I did manual inspection of the code, and here is what I found (in or=
der of importance, perceived by me):</p>
<p dir=3D"ltr">1. The code will not work correctly if the shift ammount (va=
riable &#39;sh&#39;) is 0. This is because, in that case, one of succeeding=
 invocations of TCG shift functions will be required to shift a 64-bit TCG =
variable by 64 bits, and the result of such TCG operation is undefined (shi=
ft amount must be 63 or less) - see <a href=3D"https://github.com/qemu/qemu=
/blob/master/tcg/README">https://github.com/qemu/qemu/blob/master/tcg/READM=
E</a>.</p>
<p dir=3D"ltr">2. Variable naming is better in the old helper than in the n=
ew translator. In that light, I would advise Stefan to change &#39;sh&#39; =
to &#39;shift&#39;, and &#39;shifted&#39; to &#39;carry&#39;.</p>
<p dir=3D"ltr">3. Lines</p>
<p dir=3D"ltr">tcg_gen_andi_i64(shifted, shifted, 0x7fULL);</p>
<p dir=3D"ltr">and</p>
<p dir=3D"ltr">tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);</=
p>
<p dir=3D"ltr">appear to be spurious (albait in a harmless way). Therefore,=
 they should be deleted, or, alternatevely, a justification for them should=
 be provided.</p>
<p dir=3D"ltr">4. In the commit message, variable names were used without q=
uotation mark, resulting in puzzling and unclear wording.</p>
<p dir=3D"ltr">5. (a question for Mark) After all recent changes, does get_=
avr64(..., ..., true) always (for any endian configuration) return the &quo=
t;high&quot; half of an Altivec register, and get_avr64(..., ..., false) th=
e &quot;low&quot; one?</p>
<p dir=3D"ltr">Given all these circumstances, perhaps the most reasonable s=
olution would be to revert the commit in question, and allow Stefan enough =
dev and test time to hopefully submit a new, better, version later on.</p>
<p dir=3D"ltr">Sincerely,<br>
Aleksandar<br><br></p>

--0000000000005faf5a0593a0936a--

