Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA9AC3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102952087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102952087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytFt-0000Cz-8I
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1iytEx-0007sE-Jg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1iytEw-0007zW-9Q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:07:23 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:45538 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
 id 1iytEv-0003c8-Uf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:07:22 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 2A76B1A1D7E;
 Tue,  4 Feb 2020 09:06:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: by mail.rt-rk.com (Postfix, from userid 492)
 id 2C48A1A1D87; Tue,  4 Feb 2020 09:06:16 +0100 (CET)
in-reply-to: <217483d9-14ad-25f0-e28d-791bd76ab00f@redhat.com>
to: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <764d-5e392600-1-7d355c00@99977617>
subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPULL?==?utf-8?q?_3=2F3=5D?=
 =?utf-8?q?_target=2Fmips=3A?= Separate FPU-related helpers into their own 
 file
X-Forward: 127.0.0.1
date: Tue, 04 Feb 2020 09:06:16 +0100
MIME-Version: 1.0
content-type: multipart/alternative;
 boundary="----=_=-_OpenGroupware_org_NGMime-30285-1580803576.141333-0------"
User-Agent: SOGoMail 2.3.10
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_=-_OpenGroupware_org_NGMime-30285-1580803576.141333-0------
content-type: text/plain; charset=utf-8
content-length: 1703
content-transfer-encoding: quoted-printable


> >
> > For clarity and easier maintenence, create target/mips/fpu=5Fhelper=
.c, and
> > move all FPU-related content form target/mips/op=5Fhelper.c to that=
 file.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > Message-Id: <1580745443-24650-3-git-send-email-aleksandar.markovic@=
rt-rk.com>
> > ---
> > target/mips/Makefile.objs | 2 +-
> > target/mips/fpu=5Fhelper.c | 1911 +++++++++++++++++++++++++++++++++=
++++++++++++
> > target/mips/op=5Fhelper.c | 1877 ----------------------------------=
----------
> > 3 files changed, 1912 insertions(+), 1878 deletions(-)
> > create mode 100644 target/mips/fpu=5Fhelper.c
> >
> > diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
> > index 3ca2bde..91eb691 100644
> > --- a/target/mips/Makefile.objs
> > +++ b/target/mips/Makefile.objs
> > @@ -1,5 +1,5 @@
> > obj-y +=3D translate.o cpu.o gdbstub.o helper.o
> > -obj-y +=3D op=5Fhelper.o cp0=5Fhelper.o
> > +obj-y +=3D op=5Fhelper.o cp0=5Fhelper.o fpu=5Fhelper.o
> > obj-y +=3D dsp=5Fhelper.o lmi=5Fhelper.o msa=5Fhelper.o
> > obj-$(CONFIG=5FSOFTMMU) +=3D mips-semi.o
> > obj-$(CONFIG=5FSOFTMMU) +=3D machine.o cp0=5Ftimer.o
> > diff --git a/target/mips/fpu=5Fhelper.c b/target/mips/fpu=5Fhelper.=
c
> > new file mode 100644
> > index 0000000..0d5769e
> > --- /dev/null
> > +++ b/target/mips/fpu=5Fhelper.c
> > @@ -0,0 +1,1911 @@
> > +/*
> > + * Helpers for emulation of CP0-related MIPS instructions.
>
> Isn't it "FPU"?
>

Damn, I did the change, but forgot to do "commit --amend", and that pas=
sed unnoticed during the rest of procedure.

I just sent PULL v2.

Thanks, Philippe.

Aleksandar

------=_=-_OpenGroupware_org_NGMime-30285-1580803576.141333-0------
content-type: text/html; charset=utf-8
content-length: 2254
content-transfer-encoding: quoted-printable

<html><br />&gt; &gt;<br />&gt; &gt; For clarity and easier maintenence=
, create target/mips/fpu=5Fhelper.c, and<br />&gt; &gt; move all FPU-re=
lated content form target/mips/op=5Fhelper.c to that file.<br />&gt; &g=
t;<br />&gt; &gt; Signed-off-by: Aleksandar Markovic &lt;amarkovic@wave=
comp.com&gt;<br />&gt; &gt; Reviewed-by: Aleksandar Rikalo &lt;aleksand=
ar.rikalo@rt-rk.com&gt;<br />&gt; &gt; Message-Id: &lt;1580745443-24650=
-3-git-send-email-aleksandar.markovic@rt-rk.com&gt;<br />&gt; &gt; ---<=
br />&gt; &gt; target/mips/Makefile.objs | 2 +-<br />&gt; &gt; target/m=
ips/fpu=5Fhelper.c | 1911 +++++++++++++++++++++++++++++++++++++++++++++=
<br />&gt; &gt; target/mips/op=5Fhelper.c | 1877 ----------------------=
----------------------<br />&gt; &gt; 3 files changed, 1912 insertions(=
+), 1878 deletions(-)<br />&gt; &gt; create mode 100644 target/mips/fpu=
=5Fhelper.c<br />&gt; &gt;<br />&gt; &gt; diff --git a/target/mips/Make=
file.objs b/target/mips/Makefile.objs<br />&gt; &gt; index 3ca2bde..91e=
b691 100644<br />&gt; &gt; --- a/target/mips/Makefile.objs<br />&gt; &g=
t; +++ b/target/mips/Makefile.objs<br />&gt; &gt; @@ -1,5 +1,5 @@<br />=
&gt; &gt; obj-y +=3D translate.o cpu.o gdbstub.o helper.o<br />&gt; &gt=
; -obj-y +=3D op=5Fhelper.o cp0=5Fhelper.o<br />&gt; &gt; +obj-y +=3D o=
p=5Fhelper.o cp0=5Fhelper.o fpu=5Fhelper.o<br />&gt; &gt; obj-y +=3D ds=
p=5Fhelper.o lmi=5Fhelper.o msa=5Fhelper.o<br />&gt; &gt; obj-$(CONFIG=5F=
SOFTMMU) +=3D mips-semi.o<br />&gt; &gt; obj-$(CONFIG=5FSOFTMMU) +=3D m=
achine.o cp0=5Ftimer.o<br />&gt; &gt; diff --git a/target/mips/fpu=5Fhe=
lper.c b/target/mips/fpu=5Fhelper.c<br />&gt; &gt; new file mode 100644=
<br />&gt; &gt; index 0000000..0d5769e<br />&gt; &gt; --- /dev/null<br =
/>&gt; &gt; +++ b/target/mips/fpu=5Fhelper.c<br />&gt; &gt; @@ -0,0 +1,=
1911 @@<br />&gt; &gt; +/*<br />&gt; &gt; + * Helpers for emulation of =
CP0-related MIPS instructions.<br />&gt;<br />&gt; Isn&#39;t it &quot;F=
PU&quot;?<br />&gt;<br /><br />Damn, I did the change, but forgot to do=
 &quot;commit --amend&quot;, and that passed unnoticed during the rest =
of procedure.<br /><br />I just sent PULL v2.<br /><br />Thanks, Philip=
pe.<br /><br />Aleksandar</html>

------=_=-_OpenGroupware_org_NGMime-30285-1580803576.141333-0--------


