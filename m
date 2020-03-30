Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260B2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54BF2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prMzBZaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54BF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyJ1-0001Yo-3S
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1jIyHj-0008B8-EB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1jIyHh-00085t-2k
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:33:14 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:42638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1jIyHf-00080D-BF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:33:11 -0400
Received: by mail-oi1-x231.google.com with SMTP id e4so16381563oig.9
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gqxBq/nEf1Zn8QD7HizVLTOpgS188n/mpya/oA3fjIM=;
 b=prMzBZaOTjKs/TusD724WPSPBl0XX88YPOblRqomyjvbh5Uh22sA+N6kWH/Kpz1vH6
 D5p86BCrDc3apFUocQBiFECFe/aPdE/RShcztdrCjLpCCsAKe1sz1AVUiWktK6GshQQA
 lIi9DudNYz1qLUT6YTkrT3E4LIIN5EWRS9VFn+0EfIxh788coNo8OjoADGAMpVJnidzz
 ci8ti5kv7iAfAGZXD/is4ZuUOsovVgtKwFtTln2/VvEEXpwbXClE3eTnXVpDWuWLyOml
 EdKAcHkr8xoF6Nnv720x0e1zCbIvSApBSTW04TUcPyceZlrUZVLEwEWjQ5nPEJM5kG31
 2+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gqxBq/nEf1Zn8QD7HizVLTOpgS188n/mpya/oA3fjIM=;
 b=HMvZ+SD6YpsGY33P1EsOL1F2pBO7B7k/OWIQOI0CVOP7meurW9t3NA8VkNSC05WfNp
 tZ/ArvywCLPgZ2aHxKHqYqRggVGFIcsHSNj0z+A4WB+H52mR/bDt6cqkd4la9OdNrpAV
 rsmvWM80lK22X1eI5+VpYiCVOlodmX4YXbWkiN+w9sITYrbDQp5p2kmyUfOihGmUF3sV
 DF00DynoLc+Rgci46kIGCxlMpsH0jrmObf0BYoIBB6hSR+3UmU6B16ANaAbLO5OAtvp2
 /rKp7p7b1onNa8JM5sz0uFkMLSIm5qHhDezJSwyCwPiZ6i4GTNWpqwXdYi/QKm48beY3
 sjBQ==
X-Gm-Message-State: ANhLgQ3JBmYEviEoXGWk4nJPwaf+33XpVUur4RfXlLjkyHtYOV/A0CJs
 Y0jJKEapMe6hI0NIphamypXQRW40Ji/OaFhdwtlm0A==
X-Google-Smtp-Source: ADFU+vsY0YGc8EakBF9v0PQ2orAtNrUvEdMs2DRYkjoYxpFfJf1h7EasSR+0Q/ub1sASD3d+diCXWJRNUS4Tq5vH0zw=
X-Received: by 2002:a05:6808:8:: with SMTP id u8mr298945oic.37.1585589587670; 
 Mon, 30 Mar 2020 10:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200307010051.97022-1-yuanzi@google.com>
 <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
 <87imizidwc.fsf@linaro.org>
 <CADjx4CJJdQep+K3ibfhjin7Eo6uCEFGQ6R6yVC0OcNo8MsfvJw@mail.gmail.com>
 <87d095u804.fsf@linaro.org>
In-Reply-To: <87d095u804.fsf@linaro.org>
From: Lirong Yuan <yuanzi@google.com>
Date: Mon, 30 Mar 2020 10:32:55 -0700
Message-ID: <CADjx4CKhoikcZanqYCs11ubGY+6tOeNjToiCgjnp8V_rzZcDHw@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Shu-Chun Weng <scw@google.com>, Josh Kunz <jkz@google.com>
Content-Type: multipart/alternative; boundary="000000000000226dfa05a215d8d7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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

--000000000000226dfa05a215d8d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Lirong Yuan <yuanzi@google.com> writes:
>
> > On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> <snip>
> >>
> >> Sorry I missed this on my radar. There was a minor re-factor of gdbstu=
b
> >> that was just merged which will mean this patch needs a re-base to use
> >> g_string_* functions to expand stings.
> >>
> >> Also we have some simple gdbstub tests now - could we come up with a
> >> multiarch gdbstub test to verify this is working properly?
> >>
> <snip>
> > For sure, I will re-base this patch to use g_string_* functions.
> >
> > Currently we are using qemu aarch64. I am not sure how to do this yet,
> but
> > I could try to add something to
> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub
>
> If the auxv support is appropriate to all linux-user targets you can
> plumb it into the multiarch tests - you can even use the existing
> binaries.
>
> So you need:
>
>   - a stanza in the makefiles to launch the test (see
>     tests/tcg/aarch64/Makefile.target)
>
>   - a .py test script that manipulates gdbstub to check things are workin=
g
>
> So something like:
>
> .PHONY: gdbstub-foo-binary
> run-gdbstub-foo-binary: foo-binary
>         $(call run-test, $@, $(GDB_SCRIPT) \
>                 --gdb $(HAVE_GDB_BIN) \
>                 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>                 --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-foo.py, \
>         "basic gdbstub FOO support")
>
>
> >
> > Does this sound good?
>
> Hope that helps.
>
> >
> > Thanks!
> > Lirong
>
>
> --
> Alex Benn=C3=A9e
>

Hi Alex,

Thanks for the instructions, very helpful!

I rebased this patch to use g_string_* functions, and the link to patchwork
is:
http://patchwork.ozlabs.org/patch/1264125/
Could you help take another look?

Regarding testing, I looked at some instructions for running tests, e.g.
https://github.com/qemu/qemu/blob/master/docs/devel/testing.rst
https://wiki.qemu.org/Testing
However I still could not get the tests for aarch64 to run. Do you know how
to run the aarch64 or multi-arch tests?

Also there aren't any existing gdb stub tests that try to read
uninterpreted bytes from the target=E2=80=99s special data area identified =
by a
keyword:
https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-Packets.htm=
l#qXfer-auxiliary-vector-read
I looked at some other gdb stub tests, but they did not seem to send any
queries:
https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub
So I am not sure how to set up one for "Xfer:auxv:read:" packets...
Are there plans to add more tests for other packets like
"Xfer:features:read:"?
I'd be happy to add a test if there is an example of how to do it. :)

Thanks,
Lirong

--000000000000226dfa05a215d8d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=
=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">ale=
x.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
Lirong Yuan &lt;<a href=3D"mailto:yuanzi@google.com" target=3D"_blank">yuan=
zi@google.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; w=
rote:<br>
&lt;snip&gt;<br>
&gt;&gt;<br>
&gt;&gt; Sorry I missed this on my radar. There was a minor re-factor of gd=
bstub<br>
&gt;&gt; that was just merged which will mean this patch needs a re-base to=
 use<br>
&gt;&gt; g_string_* functions to expand stings.<br>
&gt;&gt;<br>
&gt;&gt; Also we have some simple gdbstub tests now - could we come up with=
 a<br>
&gt;&gt; multiarch gdbstub test to verify this is working properly?<br>
&gt;&gt;<br>
&lt;snip&gt;<br>
&gt; For sure, I will re-base this patch to use g_string_* functions.<br>
&gt;<br>
&gt; Currently we are using qemu aarch64. I am not sure how to do this yet,=
 but<br>
&gt; I could try to add something to<br>
&gt; <a href=3D"https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/=
gdbstub" rel=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qemu/=
tree/master/tests/tcg/aarch64/gdbstub</a><br>
<br>
If the auxv support is appropriate to all linux-user targets you can<br>
plumb it into the multiarch tests - you can even use the existing<br>
binaries.<br>
<br>
So you need:<br>
<br>
=C2=A0 - a stanza in the makefiles to launch the test (see<br>
=C2=A0 =C2=A0 tests/tcg/aarch64/Makefile.target)<br>
<br>
=C2=A0 - a .py test script that manipulates gdbstub to check things are wor=
king<br>
<br>
So something like:<br>
<br>
.PHONY: gdbstub-foo-binary<br>
run-gdbstub-foo-binary: foo-binary<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(call run-test, $@, $(GDB_SCRIPT) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --gdb $(HAVE_GDB_BI=
N) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --qemu $(QEMU) --qa=
rgs &quot;$(QEMU_OPTS)&quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --bin $&lt; --test =
$(MULTIARCH_SRC)/gdbstub/test-foo.py, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;basic gdbstub FOO support&quot;)<br>
<br>
<br>
&gt;<br>
&gt; Does this sound good?<br>
<br>
Hope that helps.<br>
<br>
&gt;<br>
&gt; Thanks!<br>
&gt; Lirong<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br></blockquote><div><br></div><div>Hi Alex,</div><div><br=
></div><div>Thanks for the instructions, very helpful!</div><div><br></div>=
<div><div>I=C2=A0rebased this patch to use g_string_* functions, and the li=
nk to patchwork is:</div><div><a href=3D"http://patchwork.ozlabs.org/patch/=
1264125/">http://patchwork.ozlabs.org/patch/1264125/</a></div><div>Could yo=
u help take another look?</div></div><div><br></div><div>Regarding testing,=
 I looked at some instructions for running tests, e.g.=C2=A0</div><div><a h=
ref=3D"https://github.com/qemu/qemu/blob/master/docs/devel/testing.rst" tar=
get=3D"_blank">https://github.com/qemu/qemu/blob/master/docs/devel/testing.=
rst</a></div><div><a href=3D"https://wiki.qemu.org/Testing" target=3D"_blan=
k">https://wiki.qemu.org/Testing</a></div><div>However I still could not ge=
t the tests for aarch64 to run. Do you know how to run the aarch64 or multi=
-arch tests?</div><div><br></div><div>Also there aren&#39;t any existing gd=
b stub tests that try to read uninterpreted bytes from the target=E2=80=99s=
 special data area identified by a keyword:</div><div><a href=3D"https://so=
urceware.org/gdb/current/onlinedocs/gdb/General-Query-Packets.html#qXfer-au=
xiliary-vector-read">https://sourceware.org/gdb/current/onlinedocs/gdb/Gene=
ral-Query-Packets.html#qXfer-auxiliary-vector-read</a><br></div><div>I look=
ed at some other gdb stub tests, but they did not seem to send any queries:=
</div><div><a href=3D"https://github.com/qemu/qemu/tree/master/tests/tcg/aa=
rch64/gdbstub">https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/g=
dbstub</a><br></div><div>So I am not sure how to set up one for &quot;Xfer:=
auxv:read:&quot; packets...</div><div>Are there plans to add more tests for=
 other packets like &quot;Xfer:features:read:&quot;?</div><div>I&#39;d be h=
appy to add a test if there is an example of how to do it. :)</div><div><br=
></div><div>Thanks,</div><div>Lirong</div></div></div>

--000000000000226dfa05a215d8d7--

