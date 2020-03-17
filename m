Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77E7C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB3620753
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiINNWTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB3620753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJ1w-0002Ex-PI
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mansourweb@gmail.com>) id 1jEJ0j-0000nZ-0j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mansourweb@gmail.com>) id 1jEJ0g-0001Pw-Vr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:40:24 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:41567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mansourweb@gmail.com>)
 id 1jEJ0g-00017S-Nf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:40:22 -0400
Received: by mail-lf1-x131.google.com with SMTP id u26so6175116lfu.8
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=q6W6dATC1dY65IVQ96i99f6AL59x7lL28EmyFVVXC3g=;
 b=TiINNWTJnX2y7JafHilom7hb42RJ2haIf5OVGHIhNq+wvOoXWUoXQb7v46OrPqPyO2
 zPy0JNGYAXwcGeJRNtoGJbwgabDGNbtvHkUX0iUtXDdXFww0TOdXW903mTEGe+wsUXKY
 kLxXftMe0Quu+lq8LoIf8CcdYlEthWU0viHD0qMvt3jA2Untzkhws6tRXKt91gALbMZ6
 rbU7Z9xEpWbYiBaX3yfEFNnV5/p4qZdd0uVppYxIVnr3XnMmMrk2l9DReuHQU5mQXJSL
 h7q2eoZ0B+D2Cv5gSaKQJVYHYkyTCq/3GQyQLYtahSOIc4yf/hRdpxTkkxWaIO6GcZnr
 /k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=q6W6dATC1dY65IVQ96i99f6AL59x7lL28EmyFVVXC3g=;
 b=t7ZyBnZ7SveHDTH4UCHS+FtRfNWJ4wxBUU/dpnY3/Cjcq3nOMJ+SN6CDYsfCVrofnD
 WFGTMOanCPHznIY5H3MMlYhTKd9k0Fmftp9pxIwihoxTH5icDtNlqq27fvQLhWFtjcnP
 BtQWq5ahdD+xvInmJZ114OJBVOTTupQWfYgZdfhf7Z22ptq9n1JVTsyuaHA2yW7F33LJ
 i3zOmFOAoiESLvirNi/UgbdhXyOhw3rN3fZn12OooH76XfYdB0Pgej0HjLwb+AfL3lb/
 BPRqSJuGcViJwebexN4z8985tm+2ewlw+AnDJ0Jso1XogBbERWzwM3jslLDUVwE/Ge9n
 cZ/A==
X-Gm-Message-State: ANhLgQ3yKemp8i9dwvuDYKUpYnMfFZl0HO+jRglXHVu3pM63pyg3jdCq
 tJUT9jOxbC3fLzOtZqkGsGS13fVuuT5oMd7IPWqCm6A5xwU=
X-Google-Smtp-Source: ADFU+vtH28asMw8ZAviZYbJvokgdRCiEKLLUtrtZtOAMqD38QIGJZFyVUYoAy2h8jkJ0fFUTWrkW9EnpJwg1z5OPplM=
X-Received: by 2002:a19:f611:: with SMTP id x17mr716627lfe.89.1584477620654;
 Tue, 17 Mar 2020 13:40:20 -0700 (PDT)
MIME-Version: 1.0
From: Mansour Ahmadi <ManSoSec@gmail.com>
Date: Tue, 17 Mar 2020 16:40:09 -0400
Message-ID: <CAGT9xrB039Q7_fG1NpKv7w3t1N0OH93U9HPNawtpq9TsNr5hfA@mail.gmail.com>
Subject: Missing Null check
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bbd9b005a112f1b9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::131
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bbd9b005a112f1b9
Content-Type: text/plain; charset="UTF-8"

Is a NULL check on 'drv1->format_name' missing here?
https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/block.c#L400-L403

if (!strcmp(drv1->format_name, format_name)) {

While it is checked in similar case:
https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/block.c#L797-L800

if (drv1->protocol_name && !strcmp(drv1->protocol_name, protocol)) {

--000000000000bbd9b005a112f1b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:garamond=
,serif;font-size:large">Is a NULL check on &#39;<span style=3D"color:rgb(36=
,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Men=
lo,monospace;font-size:12px;white-space:pre;background-color:rgb(255,251,22=
1)">drv1-&gt;</span><span class=3D"gmail-pl-smi" style=3D"box-sizing:border=
-box;color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberati=
on Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre">format_name</=
span>&#39; missing here?</div><div class=3D"gmail_default" style=3D"font-fa=
mily:garamond,serif;font-size:large"><a href=3D"https://github.com/qemu/qem=
u/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/block.c#L400-L403">https://=
github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/block.c#=
L400-L403</a><br></div><div class=3D"gmail_default" style=3D"font-family:ga=
ramond,serif;font-size:large"><br></div><div class=3D"gmail_default" style=
=3D"font-family:garamond,serif;font-size:large"><span class=3D"gmail-pl-k" =
style=3D"box-sizing:border-box;color:rgb(215,58,73);font-family:SFMono-Regu=
lar,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;whi=
te-space:pre">if</span><span style=3D"color:rgb(36,41,46);font-family:SFMon=
o-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12=
px;white-space:pre;background-color:rgb(255,251,221)"> (!</span><span class=
=3D"gmail-pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197);font-fa=
mily:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;fo=
nt-size:12px;white-space:pre">strcmp</span><span style=3D"color:rgb(36,41,4=
6);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mo=
nospace;font-size:12px;white-space:pre;background-color:rgb(255,251,221)">(=
drv1-&gt;</span><span class=3D"gmail-pl-smi" style=3D"box-sizing:border-box=
;color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation M=
ono&quot;,Menlo,monospace;font-size:12px;white-space:pre">format_name</span=
><span style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&qu=
ot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre;bac=
kground-color:rgb(255,251,221)">, format_name)) {</span><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:large"><b=
r></div><div class=3D"gmail_default" style=3D"font-family:garamond,serif;fo=
nt-size:large">While it is checked in similar case:</div><div class=3D"gmai=
l_default" style=3D"font-family:garamond,serif;font-size:large"><a href=3D"=
https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/=
block.c#L797-L800">https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e=
5564bdb2914e824600/block.c#L797-L800</a><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:garamond,serif;font-size:large"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:large"><=
span class=3D"gmail-pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,7=
3);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mo=
nospace;font-size:12px;white-space:pre">if</span><span style=3D"color:rgb(3=
6,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Me=
nlo,monospace;font-size:12px;white-space:pre;background-color:rgb(255,251,2=
21)"> (drv1-&gt;</span><span class=3D"gmail-pl-smi" style=3D"box-sizing:bor=
der-box;color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liber=
ation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre">protocol_n=
ame</span><span style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Con=
solas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-spac=
e:pre;background-color:rgb(255,251,221)"> &amp;&amp; !</span><span class=3D=
"gmail-pl-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197);font-famil=
y:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-=
size:12px;white-space:pre">strcmp</span><span style=3D"color:rgb(36,41,46);=
font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monos=
pace;font-size:12px;white-space:pre;background-color:rgb(255,251,221)">(drv=
1-&gt;</span><span class=3D"gmail-pl-smi" style=3D"box-sizing:border-box;co=
lor:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono=
&quot;,Menlo,monospace;font-size:12px;white-space:pre">protocol_name</span>=
<span style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quo=
t;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre;back=
ground-color:rgb(255,251,221)">, protocol)) {</span></div><div><div dir=3D"=
ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><span=
 style=3D"border-collapse:collapse;white-space:pre-wrap"><span style=3D"bor=
der-collapse:separate;white-space:normal"><font color=3D"#000000" size=3D"2=
"><div style=3D"font-family:Calibri"><div style=3D"font-family:arial,sans-s=
erif"></div></div></font></span></span></div></div></div></div></div></div>=
</div></div></div>

--000000000000bbd9b005a112f1b9--

