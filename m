Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8236ACA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE89221925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUC/05k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE89221925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLr51-0007kP-4L
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr3o-00066r-Ad
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr3n-0006B1-5s
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:54:32 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLr3m-0006AE-VN; Sat, 19 Oct 2019 11:54:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id c10so7516084otd.9;
 Sat, 19 Oct 2019 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=/wi9tHf3MnS2dxc9XgroMhp7/I8JBCC/csRiTRi9bgs=;
 b=qUC/05k2GbK8u9gKSFT1HomS0s7WWACblBJh9xH+MocVVzOuhoYBSfz7Z7YsPL+eUP
 /E0rihWBNLlkMW5VjIXZa9zKVNvtbeLbz61ERTOwTIT+YZal0kQWzSqin/koth9heYUY
 KXsEctUEeQztcuJw2sWjaRo+LC7ju0ber0D+4m9UOaAf292ourmNLoC5KZ4XMh7hMtth
 SrLk1v1BIHqNHuWL94whaxVXjXCKKxG9wByWW1BSAHx6UFPTTRqRYOoBBWFcm6Zs+2ss
 88+AldoFPKSsYWu8fPllP4KUnaBdJkfUZFiUXAVwDKQAKPE2sfD2kGahQCE+8+bIbnNd
 p9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=/wi9tHf3MnS2dxc9XgroMhp7/I8JBCC/csRiTRi9bgs=;
 b=rGYYXu09TJZ7/LKhiSxCJm7Ppla9VNe/I8JbXqyPNfu9P6k475VtHpcgKgS5ZvzH9h
 efGCuxbec396UsfAg2xAG3v9Oj+oWeeTkz6I/CL9DdJVKRzio5mXNpb5pVzZLjFhg7Sb
 ySDbc6C5eyAu4ZOBqtQALaH3/wxHEzL8cFMieE6Ss4MFfja2sEPxhil386BXSdeaQkmA
 0xJxFyhT39akw5THUTJ6+E7HFwVzQl1O1fid60/I0o2aztXoY/pOMZTo2F1wdrS0TILl
 AwoGv2vFoqpF0blz593F5QZnE6IC26y2GpjsJfq7EEhggOF0i6zE0qLqrv/7HHXYAXaU
 EpxA==
X-Gm-Message-State: APjAAAX/tUbhU/ZHHkS5ebciGT7YcpaadU+9atl3/zjOObOEPPLc7Z/G
 D8bWGPPKZ7KCd1aAm3CIeMwS5VQ3UT6PTZOXYVA=
X-Google-Smtp-Source: APXvYqzVjVMWVHFMbVVvKU0QBD+truGhYNGEUM7MYC6bNBRaK5Q3Lw9qcXqzmkKJqdv7M/fWlniincVdDFIYTxWnBq4=
X-Received: by 2002:a05:6830:452:: with SMTP id
 d18mr12347505otc.295.1571500469717; 
 Sat, 19 Oct 2019 08:54:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 08:54:29
 -0700 (PDT)
In-Reply-To: <20191019120534.27479-2-ash@kambanaria.org>
References: <20191019120534.27479-1-ash@kambanaria.org>
 <20191019120534.27479-2-ash@kambanaria.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 17:54:29 +0200
Message-ID: <CAL1e-=gwJ-4Qv7n7tOPvtzPfnPd8VkR9D4gu-pVjt2RgvEqAwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Updated Bulgarian translation (19) - 4.1.0
To: Alexander Shopov <ash@kambanaria.org>
Content-Type: multipart/alternative; boundary="00000000000043102b059545779e"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>,
 Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pino Toscano <ptoscano@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Wei Huang <wehuang@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amos Kong <akong@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Dongsheng Song <songdongsheng@live.cn>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000043102b059545779e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Alexander Shopov <ash@kambanaria.org> wrote:

> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
>  po/bg.po | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

diff --git a/po/bg.po b/po/bg.po
> index 3d8c353372..98c57e5b22 100644
> --- a/po/bg.po
> +++ b/po/bg.po
> @@ -1,14 +1,14 @@
>  # Bulgarian translation of qemu po-file.
> -# Copyright (C) 2016 Alexander Shopov <ash@kambanaria.org>
> +# Copyright (C) 2016, 2019 Alexander Shopov <ash@kambanaria.org>
>  # This file is distributed under the same license as the qemu package.
> -# Alexander Shopov <ash@kambanaria.org>, 2016.
> +# Alexander Shopov <ash@kambanaria.org>, 2016, 2019.
>  #
>  msgid ""
>  msgstr ""
> -"Project-Id-Version: QEMU 2.6.50\n"
> +"Project-Id-Version: QEMU 4.1.0\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
>  "POT-Creation-Date: 2018-07-18 07:56+0200\n"
> -"PO-Revision-Date: 2016-06-09 15:54+0300\n"
> +"PO-Revision-Date: 2019-10-19 13:14+0200\n"
>  "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
>  "Language-Team: Bulgarian <dict@ludost.net>\n"
>  "Language: bg\n"
> @@ -66,7 +66,7 @@ msgid "Detach Tab"
>  msgstr "=D0=9A=D1=8A=D0=BC =D1=81=D0=B0=D0=BC=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D1=82=D0=B5=D0=BB=D0=B5=D0=BD =D0=BF=D0=BE=D0=B4=D0=BF=D1=80=D0=BE=D0=
=B7=D0=BE=D1=80=D0=B5=D1=86"
>
>  msgid "Show Menubar"
> -msgstr ""
> +msgstr "=D0=9B=D0=B5=D0=BD=D1=82=D0=B0 =D0=B7=D0=B0 =D0=BC=D0=B5=D0=BD=
=D1=8E=D1=82=D0=BE"
>
>  msgid "_Machine"
>  msgstr "_=D0=9C=D0=B0=D1=88=D0=B8=D0=BD=D0=B0"
> --
> 2.23.0
>
>
>

--00000000000043102b059545779e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Alexander Shopov &lt;<a href=3D"mail=
to:ash@kambanaria.org">ash@kambanaria.org</a>&gt; wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Signed-off-by: Alexander Shopov &lt;<a href=3D"mailto:ash@k=
ambanaria.org">ash@kambanaria.org</a>&gt;<br>
---<br>
=C2=A0po/bg.po | 10 +++++-----<br>
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:1=
4px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;=
</span><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/po/bg.po b/po/bg.po<br>
index 3d8c353372..98c57e5b22 100644<br>
--- a/po/bg.po<br>
+++ b/po/bg.po<br>
@@ -1,14 +1,14 @@<br>
=C2=A0# Bulgarian translation of qemu po-file.<br>
-# Copyright (C) 2016 Alexander Shopov &lt;<a href=3D"mailto:ash@kambanaria=
.org">ash@kambanaria.org</a>&gt;<br>
+# Copyright (C) 2016, 2019 Alexander Shopov &lt;<a href=3D"mailto:ash@kamb=
anaria.org">ash@kambanaria.org</a>&gt;<br>
=C2=A0# This file is distributed under the same license as the qemu package=
.<br>
-# Alexander Shopov &lt;<a href=3D"mailto:ash@kambanaria.org">ash@kambanari=
a.org</a>&gt;, 2016.<br>
+# Alexander Shopov &lt;<a href=3D"mailto:ash@kambanaria.org">ash@kambanari=
a.org</a>&gt;, 2016, 2019.<br>
=C2=A0#<br>
=C2=A0msgid &quot;&quot;<br>
=C2=A0msgstr &quot;&quot;<br>
-&quot;Project-Id-Version: QEMU 2.6.50\n&quot;<br>
+&quot;Project-Id-Version: QEMU 4.1.0\n&quot;<br>
=C2=A0&quot;Report-Msgid-Bugs-To: <a href=3D"mailto:qemu-devel@nongnu.org">=
qemu-devel@nongnu.org</a>\n&quot;<br>
=C2=A0&quot;POT-Creation-Date: 2018-07-18 07:56+0200\n&quot;<br>
-&quot;PO-Revision-Date: 2016-06-09 15:54+0300\n&quot;<br>
+&quot;PO-Revision-Date: 2019-10-19 13:14+0200\n&quot;<br>
=C2=A0&quot;Last-Translator: Alexander Shopov &lt;<a href=3D"mailto:ash@kam=
banaria.org">ash@kambanaria.org</a>&gt;\n&quot;<br>
=C2=A0&quot;Language-Team: Bulgarian &lt;<a href=3D"mailto:dict@ludost.net"=
>dict@ludost.net</a>&gt;\n&quot;<br>
=C2=A0&quot;Language: bg\n&quot;<br>
@@ -66,7 +66,7 @@ msgid &quot;Detach Tab&quot;<br>
=C2=A0msgstr &quot;=D0=9A=D1=8A=D0=BC =D1=81=D0=B0=D0=BC=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D1=82=D0=B5=D0=BB=D0=B5=D0=BD =D0=BF=D0=BE=D0=B4=D0=BF=D1=80=
=D0=BE=D0=B7=D0=BE=D1=80=D0=B5=D1=86&quot;<br>
<br>
=C2=A0msgid &quot;Show Menubar&quot;<br>
-msgstr &quot;&quot;<br>
+msgstr &quot;=D0=9B=D0=B5=D0=BD=D1=82=D0=B0 =D0=B7=D0=B0 =D0=BC=D0=B5=D0=
=BD=D1=8E=D1=82=D0=BE&quot;<br>
<br>
=C2=A0msgid &quot;_Machine&quot;<br>
=C2=A0msgstr &quot;_=D0=9C=D0=B0=D1=88=D0=B8=D0=BD=D0=B0&quot;<br>
-- <br>
2.23.0<br>
<br>
<br>
</blockquote>

--00000000000043102b059545779e--

