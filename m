Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C0E20862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwZKW/l1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C0E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP02V-00023q-2Z
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iOzxn-0001Q9-GL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iOzxm-00072n-6e
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:01:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iOzxm-00071c-17
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:01:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id b19so3718987otq.10
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jvy9yhjUB7jtHPPdv445hWuM0aMCW0LFbuGUJZBXGKg=;
 b=FwZKW/l1oVB7hOevt5zvcl1yHLTg9ouk5ncvEUHdaZ6J36Zt3JoFbBmnx3R4ht8Uo2
 R26HQCvwU2rqG4DH8m5DoQ0N2OXFOo4cjzZvkYAXuPgUkM9drsjK3C36vvj6iP+1nzGe
 pAdEbAjiDnU0RdK/27PSJP/4xZsVXwQxd3tPyULhldepo3fw+JNgVTAS4n5MD+YcGukk
 VVo826TyXsn08M3RW9BLGQLwvmyt1boB0+nOpRyCh6Azy6C6htzC1COWFFNuT2c4bqek
 3dYGBRjcrNGYcyIw+lxJNSG2jjAeZhrr86dHYOqzHpCZuUzS5Vd+oEWHUKqO0/WDBdwa
 8Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jvy9yhjUB7jtHPPdv445hWuM0aMCW0LFbuGUJZBXGKg=;
 b=UAacgCVkHpBdZR6gGtT5XdApxsls1bQ7G0QoijS7m3gotCzMolYm2TwR5qK7xcaSVj
 DX6HREqgIL25HU9N9ZuyCpKEHFwZHkjfxzsZyzCkxM4h3ieG95gq1Pm5nrefE/TLY++X
 KhpzOSG1SS2xOsKKs2jGtq+8yUm0EzajLVbltnPoMu1u6rVteMAU0udV1a7YplqEaoVS
 +usv9hleUHgwhkWnO+O65/Bv8Wg/l7b4Bn0MljTFo6M6Yb/Ec59ookPWHHrFKkve4WdX
 FfUB28Tnyrj/gxjIf/t7pmxiMysl8YXlF2/Xobs/QvEdYpz7YlTn99lqnnipsqmIAPBh
 Q6PA==
X-Gm-Message-State: APjAAAV+b84TyktajDg/KcLMPGyIKIdg8yRzExEcrhtlJ0/cW+a52AVO
 kIaNhhjYjB68GW8bOGzfm73C7kensQs9UHr8vPI=
X-Google-Smtp-Source: APXvYqyYRMh2OZM6d+FKfzuMajImCV6waThbpDHqqIZYZ6JHIApROU3EeiBQ2a/SS8LSMdbaJXgwlCeKuFkIqbZ71pU=
X-Received: by 2002:a05:6830:1d8f:: with SMTP id
 y15mr4099241oti.121.1572249677003; 
 Mon, 28 Oct 2019 01:01:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 28 Oct 2019 01:01:16
 -0700 (PDT)
In-Reply-To: <20191028073441.6448-4-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-4-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 28 Oct 2019 09:01:16 +0100
Message-ID: <CAL1e-=iDs5v4S5A8_-0XmjvTEbhJ71+yH=nKJT_ZvtQF3idPeQ@mail.gmail.com>
Subject: Re: [PATCH 03/26] tests/acceptance: Fixe wait_for_console_pattern()
 hangs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007f20e50595f3e751"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fabien Chouteau <chouteau@adacore.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007f20e50595f3e751
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Because of a possible deadlock (QEMU waiting for the socket to
> become writable) let's close the console socket as soon as we
> stop to use it.
>
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 1 +
>  1 file changed, 1 insertion(+)
>
>
Fixe -> Fix

You missed my r-b again, given in:

https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06376.html

A.



> diff --git a/tests/acceptance/avocado_qemu/__init__.py
> b/tests/acceptance/avocado_qemu/__init__.py
> index e3101cba30..a0450e5263 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -74,6 +74,7 @@ def wait_for_console_pattern(test, success_message,
> failure_message=3DNone):
>          if success_message in msg:
>              break
>          if failure_message and failure_message in msg:
> +            console.close()
>              fail =3D 'Failure message found in console: %s' %
> failure_message
>              test.fail(fail)
>
> --
> 2.21.0
>
>
>

--0000000000007f20e50595f3e751
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Because of a possible deadlock (QEMU waiting for the=
 socket to<br>
become writable) let&#39;s close the console socket as soon as we<br>
stop to use it.<br>
<br>
Suggested-by: Cleber Rosa &lt;<a href=3D"mailto:crosa@redhat.com">crosa@red=
hat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/avocado_qemu/<wbr>__init__.py | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br></blockquote><div><br></div><div>Fixe -&gt; Fix</div><div><br></div><di=
v>You missed my r-b again, given in:</div><div><br></div><div><a href=3D"ht=
tps://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06376.html">https://=
lists.gnu.org/archive/html/qemu-devel/2019-10/msg06376.html</a><br></div><d=
iv><br></div><div>A.</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
diff --git a/tests/acceptance/avocado_<wbr>qemu/__init__.py b/tests/accepta=
nce/avocado_<wbr>qemu/__init__.py<br>
index e3101cba30..a0450e5263 100644<br>
--- a/tests/acceptance/avocado_<wbr>qemu/__init__.py<br>
+++ b/tests/acceptance/avocado_<wbr>qemu/__init__.py<br>
@@ -74,6 +74,7 @@ def wait_for_console_pattern(test, success_message, failu=
re_message=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if success_message in msg:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if failure_message and failure_message in=
 msg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 console.close()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail =3D &#39;Failure messa=
ge found in console: %s&#39; % failure_message<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test.fail(fail)<br>
=C2=A0<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--0000000000007f20e50595f3e751--

