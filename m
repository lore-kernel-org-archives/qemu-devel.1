Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE6C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 17:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5E02053B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 17:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6jtTCsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5E02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilz9m-0002Ir-6s
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 12:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ilz8f-00018u-CI
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ilz8d-00089u-Mp
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:47:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25447
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ilz8d-00089d-Jv
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577728051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MJStdeV/YujZAu6ZNEHr5cAMDE1K9kOphOPj3BCNNbs=;
 b=N6jtTCshfIkN8WZGyWWWpAfq5KsEjGZTQxjZYkaLpumlou6ZQOCTpfgCVQNLvd45qd+r/5
 ZUOf9k8KpVGy1tJ7o4uMItT05fdv3ImIFUEmFxlfaKb+ltRI/I3mkRkcQJEK9as91LRqJm
 qoMxU5Q/h9tIPkmI3yGrYB4v7ZGpy50=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-jhNW16N0OT-PpvGRvbYFWg-1; Mon, 30 Dec 2019 12:47:27 -0500
Received: by mail-ed1-f71.google.com with SMTP id w9so10891657eds.4
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 09:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MJStdeV/YujZAu6ZNEHr5cAMDE1K9kOphOPj3BCNNbs=;
 b=C4UWiCZZERqc7N/KHV7BtDqbHKmRyd2By6SI0ZH6R7xAhF9yMNn8U1EOJaJe6pwXcw
 AW9ZtuVCVhSy2/to7hkoP/hF1lmYQft1ZIR+3Ke6xlzIz/WlIL2yjJQcejd6IArE168k
 HB9aBg/E8mbmXNyyL8rX+nRHHdK3FbH6m1Sa9tkqxHQhCBOWQNx4CGtumEKc3JdLt7lk
 i9zZNsNjh7zJDwAoBQD76EOQGdNiGrMImO4gFRRyME+DHxjDvPCvx0Gbt7LcopBGRyCN
 QlhqlbZbuWSzpwlnze+R9RfVxn5bpu3ER/emTHWGOlEpxLXfjAlxA4aV01xpzPUxSWcu
 wxkQ==
X-Gm-Message-State: APjAAAVHNKg12u5OylCWb0GeVejrvgiChiyeKfK1PB3PC6o5g+VvAMcI
 IkzdvCWuN+lQT+Y7heVgE+hlMPE4PGkRu6mjff4bha1sJKy8ok5yoaW36oKDlZ+QEQDI4X0mU9T
 DgeNmaDSzP8Su/tObDzJOJPz7ZuDy/qs=
X-Received: by 2002:aa7:d9c6:: with SMTP id v6mr72198537eds.107.1577728046094; 
 Mon, 30 Dec 2019 09:47:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqZ1wCnv2+UU94l9WCkgm0AhWdAWlM9y7C1eMgbU9R91PpZZoZ+bMWivxkmpNuVXjfIt0cXlAv+6Iz1hz2+r8=
X-Received: by 2002:aa7:d9c6:: with SMTP id v6mr72198492eds.107.1577728045890; 
 Mon, 30 Dec 2019 09:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20191230090900.446-1-philmd@redhat.com>
 <20191230090900.446-2-philmd@redhat.com>
 <273bf2e5-1223-3d01-f930-394195c037e4@weilnetz.de>
 <64c2434d-3b2b-1a3e-5358-e4b5acfbe8e8@redhat.com>
 <CABgObfYahQbbteCAsMfKAYjPLDUpGJExO9mWyRw15mm=VWHsbQ@mail.gmail.com>
 <cd2746d2-8f88-2012-def9-dfce47d8e764@redhat.com>
 <CAP+75-WjOfJeFooQnrhC8y73dCWrfJbHhtYUG3LzZRxpbhTwCA@mail.gmail.com>
In-Reply-To: <CAP+75-WjOfJeFooQnrhC8y73dCWrfJbHhtYUG3LzZRxpbhTwCA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Dec 2019 18:46:37 +0100
Message-ID: <CABgObfaVHsdmRxN4eE=QhUmMGtMM5gZ1uuQ+LUfsB4EWvBTsJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcg: Search includes from the project root source
 directory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: jhNW16N0OT-PpvGRvbYFWg-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000ba6063059aef6f6f"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ba6063059aef6f6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, of course (I thought it would be clear from the message, but perhaps
it was a bit implicit).

Paolo

Il lun 30 dic 2019, 16:48 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> h=
a
scritto:

> On Mon, Dec 30, 2019 at 3:02 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> > On 12/30/19 11:33 AM, Paolo Bonzini wrote:
> > > Il lun 30 dic 2019, 09:59 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com
> > > <mailto:philmd@redhat.com>> ha scritto:
> > >
> > >      > I'd prefer not changing those files.
> > >
> > >     OK, I'll wait to see what Richard/Markus prefer.
> > >
> > >
> > > I think it's best if you keep the include directives as-is for files
> > > only needed from tcg/, and move the other headers (those that are
> needed
> > > from other directories only) to include/tcg.
>
> Assuming we don't want to add include/tcg/ in the path search list, we
> still need to update the tcg/*.c include directives to use "tcg/":
>
> tcg/tcg-op-gvec.c:21:10: fatal error: tcg.h: No such file or directory
>    21 | #include "tcg.h"
>       |          ^~~~~~~
> compilation terminated.
> make[1]: *** [rules.mak:69: tcg/tcg-op-gvec.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      mips64el-softmmu/accel/tcg/translate-all.o
> tcg/optimize.c:27:10: fatal error: tcg-op.h: No such file or directory
>    27 | #include "tcg-op.h"
>       |          ^~~~~~~~~~
> compilation terminated.
> make[1]: *** [rules.mak:69: tcg/optimize.o] Error 1
> tcg/tcg-op-vec.c:22:10: fatal error: tcg.h: No such file or directory
>    22 | #include "tcg.h"
>       |          ^~~~~~~
> compilation terminated.
> make[1]: *** [rules.mak:69: tcg/tcg-op-vec.o] Error 1
> tcg/tcg-common.c:35:10: fatal error: tcg-opc.h: No such file or directory
>    35 | #include "tcg-opc.h"
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[1]: *** [rules.mak:69: tcg/tcg-common.o] Error 1
> tcg/tcg-op.c:28:10: fatal error: tcg.h: No such file or directory
>    28 | #include "tcg.h"
>       |          ^~~~~~~
> compilation terminated.
> make[1]: *** [rules.mak:69: tcg/tcg-op.o] Error 1
> tcg/tcg.c:51:10: fatal error: tcg-op.h: No such file or directory
>    51 | #include "tcg-op.h"
>       |          ^~~~~~~~~~
> compilation terminated.
>
> > I thought moving headers to include/tcg would diverge too much from
> > libtcg, but this project already did it, so why not:
> > https://github.com/S2E/libtcg/tree/master/include/tcg
>
>

--000000000000ba6063059aef6f6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, of course (I thought it would be clear from the mess=
age, but perhaps it was a bit implicit).<div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">Il lun 30 dic 2019, 16:48 Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; ha scri=
tto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On Mon, Dec 30, 2019 at 3:02 P=
M Philippe Mathieu-Daud=C3=A9<br>
&lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank" rel=3D"noreferre=
r">philmd@redhat.com</a>&gt; wrote:<br>
&gt; On 12/30/19 11:33 AM, Paolo Bonzini wrote:<br>
&gt; &gt; Il lun 30 dic 2019, 09:59 Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com" target=3D"_blank" rel=3D"noreferrer">philmd@r=
edhat.com</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">philmd@redhat.com</a>&gt;&gt; ha scritto:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;d prefer not changing those files.=
<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0OK, I&#39;ll wait to see what Richard/Markus p=
refer.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I think it&#39;s best if you keep the include directives as-is fo=
r files<br>
&gt; &gt; only needed from tcg/, and move the other headers (those that are=
 needed<br>
&gt; &gt; from other directories only) to include/tcg.<br>
<br>
Assuming we don&#39;t want to add include/tcg/ in the path search list, we<=
br>
still need to update the tcg/*.c include directives to use &quot;tcg/&quot;=
:<br>
<br>
tcg/tcg-op-gvec.c:21:10: fatal error: tcg.h: No such file or directory<br>
=C2=A0 =C2=A021 | #include &quot;tcg.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~<br>
compilation terminated.<br>
make[1]: *** [rules.mak:69: tcg/tcg-op-gvec.o] Error 1<br>
make[1]: *** Waiting for unfinished jobs....<br>
=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 mips64el-softmmu/accel/tcg/translate-all.o<br=
>
tcg/optimize.c:27:10: fatal error: tcg-op.h: No such file or directory<br>
=C2=A0 =C2=A027 | #include &quot;tcg-op.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>
compilation terminated.<br>
make[1]: *** [rules.mak:69: tcg/optimize.o] Error 1<br>
tcg/tcg-op-vec.c:22:10: fatal error: tcg.h: No such file or directory<br>
=C2=A0 =C2=A022 | #include &quot;tcg.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~<br>
compilation terminated.<br>
make[1]: *** [rules.mak:69: tcg/tcg-op-vec.o] Error 1<br>
tcg/tcg-common.c:35:10: fatal error: tcg-opc.h: No such file or directory<b=
r>
=C2=A0 =C2=A035 | #include &quot;tcg-opc.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~<br>
compilation terminated.<br>
make[1]: *** [rules.mak:69: tcg/tcg-common.o] Error 1<br>
tcg/tcg-op.c:28:10: fatal error: tcg.h: No such file or directory<br>
=C2=A0 =C2=A028 | #include &quot;tcg.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~<br>
compilation terminated.<br>
make[1]: *** [rules.mak:69: tcg/tcg-op.o] Error 1<br>
tcg/tcg.c:51:10: fatal error: tcg-op.h: No such file or directory<br>
=C2=A0 =C2=A051 | #include &quot;tcg-op.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>
compilation terminated.<br>
<br>
&gt; I thought moving headers to include/tcg would diverge too much from<br=
>
&gt; libtcg, but this project already did it, so why not:<br>
&gt; <a href=3D"https://github.com/S2E/libtcg/tree/master/include/tcg" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/S2E/libtcg/=
tree/master/include/tcg</a><br>
<br>
</blockquote></div>

--000000000000ba6063059aef6f6f--


