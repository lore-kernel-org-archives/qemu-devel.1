Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DC1C2D0F1
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C922E206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRolLSu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C922E206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ2eQ-0005qv-0k
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 18:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1jJ2dZ-0005FB-9u
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1jJ2dX-0002B2-Bz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:12:05 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:35547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1jJ2dW-0002Ae-K9
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:12:03 -0400
Received: by mail-ot1-x334.google.com with SMTP id v2so15352775oto.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QsfSyeey6IKMTIsvS9fpxWYe9W8eB/dguTWdyeTrrmo=;
 b=SRolLSu62FsnoqYlLwlF5Go7YqSDAEkJaX9J9VrT5csekcw0GZyilXIDjk89JnyRZa
 GIfpsiw91EVFmiqoNBwZZ2/fSgsI3PJIZyOoYzqgwyrjz9D8MrfKHQhmuCt+/5ijWVw9
 IiQLsSpe5ou0DnenE5XWujW2s63RYE1+pV0d9jgC0y86vDf3QzOo97BcLTtmpDJICTgH
 5DjZaEVaq14rBzX2kERLdgrU4L3cJHwtLB/tfQ0rEEK0nUBMk8dELm4ZYkX19w+ebYqn
 cdbxEDFdt+zZN5p5QMz4uBSnDRFPfTjbg/AagcgTdWt1Imf/tlJa6s+GJguByoexAxZV
 kFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QsfSyeey6IKMTIsvS9fpxWYe9W8eB/dguTWdyeTrrmo=;
 b=XMofIauhFKe+qVNeTiEPV52brirBpMOt82aJ9QVlSREdUBIY3Nky03aicBacWNpUQC
 rSZxfrYza9kqlTGRBItBfA94WAKcwQWy6UL7H3aan3wzS9K1ru2os6zzUv99Y22g/kcU
 s7yTAkjAPsbTDtPqe+XO17/LWs2TeqWTs7ygf0UAH7WXz2yit5SDm4rONwLrHniEYWqk
 +A+vyctwzrJ3y0RtIbaIuVtcmI23CnppGohdbrfmde/d+nHIUi9HW6mHN4AL8DwejRga
 Ib3t8ReTUZe9ru/uva1dbJUZzSb0BrOldElpPgjtU3T/SrWvtoZjvSnYmUj7dpLaLyAs
 nHQg==
X-Gm-Message-State: ANhLgQ2vW3u6JPdmbKY1sLuUNYXnhbycWT7vDPsr+4cWzcS47v1ieMth
 s3KnZEs537k8CnHww+tGasT/dFLL4E5nFAureRmV/A==
X-Google-Smtp-Source: ADFU+vthrTFmTnLmW72wnoJeO47HmryA+qRDsRAGbJirC9n2vkcM90YD7WzVKveDkUat2rQIa0UV4+1lfWLaUEpEvEY=
X-Received: by 2002:a9d:6a92:: with SMTP id l18mr9970808otq.252.1585606321299; 
 Mon, 30 Mar 2020 15:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200307010051.97022-1-yuanzi@google.com>
 <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
 <87imizidwc.fsf@linaro.org>
 <CADjx4CJJdQep+K3ibfhjin7Eo6uCEFGQ6R6yVC0OcNo8MsfvJw@mail.gmail.com>
 <87d095u804.fsf@linaro.org>
 <CADjx4CKhoikcZanqYCs11ubGY+6tOeNjToiCgjnp8V_rzZcDHw@mail.gmail.com>
 <87tv25fwvz.fsf@linaro.org>
In-Reply-To: <87tv25fwvz.fsf@linaro.org>
From: Lirong Yuan <yuanzi@google.com>
Date: Mon, 30 Mar 2020 15:11:49 -0700
Message-ID: <CADjx4CK-NtPP9iRmao_J9A+25y-MUjco=sM+sKwHfpWXzSV_yA@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Shu-Chun Weng <scw@google.com>, Josh Kunz <jkz@google.com>
Content-Type: multipart/alternative; boundary="000000000000894aa905a219bd52"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000894aa905a219bd52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 12:47 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

>
> Lirong Yuan <yuanzi@google.com> writes:
>
> > On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> >
> >>
> >> Lirong Yuan <yuanzi@google.com> writes:
> >>
> >> > On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.bennee@linaro=
.org>
> >> wrote:
> >> <snip>
> >> >>
> >> >> Sorry I missed this on my radar. There was a minor re-factor of
> gdbstub
> >> >> that was just merged which will mean this patch needs a re-base to
> use
> >> >> g_string_* functions to expand stings.
> >> >>
> >> >> Also we have some simple gdbstub tests now - could we come up with =
a
> >> >> multiarch gdbstub test to verify this is working properly?
> >> >>
> >> <snip>
> >> > For sure, I will re-base this patch to use g_string_* functions.
> >> >
> >> > Currently we are using qemu aarch64. I am not sure how to do this ye=
t,
> >> but
> >> > I could try to add something to
> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub
> >>
> >> If the auxv support is appropriate to all linux-user targets you can
> >> plumb it into the multiarch tests - you can even use the existing
> >> binaries.
> >>
> >> So you need:
> >>
> >>   - a stanza in the makefiles to launch the test (see
> >>     tests/tcg/aarch64/Makefile.target)
> >>
> >>   - a .py test script that manipulates gdbstub to check things are
> working
> >>
> >> So something like:
> >>
> >> .PHONY: gdbstub-foo-binary
> >> run-gdbstub-foo-binary: foo-binary
> >>         $(call run-test, $@, $(GDB_SCRIPT) \
> >>                 --gdb $(HAVE_GDB_BIN) \
> >>                 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> >>                 --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-foo.py, =
\
> >>         "basic gdbstub FOO support")
> >>
> >>
> >> >
> >> > Does this sound good?
> >>
> >> Hope that helps.
> >>
> >> >
> >> > Thanks!
> >> > Lirong
> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
> >>
> >
> > Hi Alex,
> >
> > Thanks for the instructions, very helpful!
> >
> > I rebased this patch to use g_string_* functions, and the link to
> patchwork
> > is:
> > http://patchwork.ozlabs.org/patch/1264125/
> > Could you help take another look?
> >
> > Regarding testing, I looked at some instructions for running tests, e.g=
.
> > https://github.com/qemu/qemu/blob/master/docs/devel/testing.rst
> > https://wiki.qemu.org/Testing
> > However I still could not get the tests for aarch64 to run. Do you know
> how
> > to run the aarch64 or multi-arch tests?
>
> The aarch64 ones run with "make run-tcg-tests-aarch64-linux-user" add
> V=3D1 to see the details.
>
> > Also there aren't any existing gdb stub tests that try to read
> > uninterpreted bytes from the target=E2=80=99s special data area identif=
ied by a
> > keyword:
> >
> https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-Packets.h=
tml#qXfer-auxiliary-vector-read
> > I looked at some other gdb stub tests, but they did not seem to send an=
y
> > queries:
> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub
> > So I am not sure how to set up one for "Xfer:auxv:read:" packets...
> > Are there plans to add more tests for other packets like
> > "Xfer:features:read:"?
> > I'd be happy to add a test if there is an example of how to do it. :)
>
> What would you do from a normal gdb command line. At the very least you
> run the same command with gdb.execute(), e.g.:
>
>   gdb.execute("set confirm off")
>
> is the same as typing
>
>   set confirm off
>
> at the gdb command prompt.
>
> >
> > Thanks,
> > Lirong
>
>
> --
> Alex Benn=C3=A9e
>

Hey Alex,

I tried to run the test but they were skipped. Do you know if there's any
other flag that needs to be set?

$ make run-tcg-tests-aarch64-linux-user
make[1]: Entering directory '/usr/local/google/home/yuanzi/qemu/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/local/google/home/yuanzi/qemu/slirp'
  BUILD   TCG tests for aarch64-linux-user
  BUILD   aarch64-linux-user guest-tests SKIPPED
  RUN     TCG tests for aarch64-linux-user
  RUN     tests for aarch64-linux-user SKIPPED

I don't think any command needs to be run. It should just send the query
automatically.
Could we assume that it will work the same in the test?

--000000000000894aa905a219bd52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 30, 2020 at 12:47 PM Alex Ben=
n=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><br>
Lirong Yuan &lt;<a href=3D"mailto:yuanzi@google.com" target=3D"_blank">yuan=
zi@google.com</a>&gt; writes:<br>
<br>
&gt; On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Lirong Yuan &lt;<a href=3D"mailto:yuanzi@google.com" target=3D"_bl=
ank">yuanzi@google.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &lt;snip&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Sorry I missed this on my radar. There was a minor re-fac=
tor of gdbstub<br>
&gt;&gt; &gt;&gt; that was just merged which will mean this patch needs a r=
e-base to use<br>
&gt;&gt; &gt;&gt; g_string_* functions to expand stings.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Also we have some simple gdbstub tests now - could we com=
e up with a<br>
&gt;&gt; &gt;&gt; multiarch gdbstub test to verify this is working properly=
?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &lt;snip&gt;<br>
&gt;&gt; &gt; For sure, I will re-base this patch to use g_string_* functio=
ns.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Currently we are using qemu aarch64. I am not sure how to do =
this yet,<br>
&gt;&gt; but<br>
&gt;&gt; &gt; I could try to add something to<br>
&gt;&gt; &gt; <a href=3D"https://github.com/qemu/qemu/tree/master/tests/tcg=
/aarch64/gdbstub" rel=3D"noreferrer" target=3D"_blank">https://github.com/q=
emu/qemu/tree/master/tests/tcg/aarch64/gdbstub</a><br>
&gt;&gt;<br>
&gt;&gt; If the auxv support is appropriate to all linux-user targets you c=
an<br>
&gt;&gt; plumb it into the multiarch tests - you can even use the existing<=
br>
&gt;&gt; binaries.<br>
&gt;&gt;<br>
&gt;&gt; So you need:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- a stanza in the makefiles to launch the test (see<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0tests/tcg/aarch64/Makefile.target)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- a .py test script that manipulates gdbstub to check =
things are working<br>
&gt;&gt;<br>
&gt;&gt; So something like:<br>
&gt;&gt;<br>
&gt;&gt; .PHONY: gdbstub-foo-binary<br>
&gt;&gt; run-gdbstub-foo-binary: foo-binary<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(call run-test, $@, $(GDB_SCRIPT=
) \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--gdb=
 $(HAVE_GDB_BIN) \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--qem=
u $(QEMU) --qargs &quot;$(QEMU_OPTS)&quot; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--bin=
 $&lt; --test $(MULTIARCH_SRC)/gdbstub/test-foo.py, \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;basic gdbstub FOO support&q=
uot;)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Does this sound good?<br>
&gt;&gt;<br>
&gt;&gt; Hope that helps.<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks!<br>
&gt;&gt; &gt; Lirong<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Alex Benn=C3=A9e<br>
&gt;&gt;<br>
&gt;<br>
&gt; Hi Alex,<br>
&gt;<br>
&gt; Thanks for the instructions, very helpful!<br>
&gt;<br>
&gt; I rebased this patch to use g_string_* functions, and the link to patc=
hwork<br>
&gt; is:<br>
&gt; <a href=3D"http://patchwork.ozlabs.org/patch/1264125/" rel=3D"noreferr=
er" target=3D"_blank">http://patchwork.ozlabs.org/patch/1264125/</a><br>
&gt; Could you help take another look?<br>
&gt;<br>
&gt; Regarding testing, I looked at some instructions for running tests, e.=
g.<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/master/docs/devel/testing=
.rst" rel=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qemu/blo=
b/master/docs/devel/testing.rst</a><br>
&gt; <a href=3D"https://wiki.qemu.org/Testing" rel=3D"noreferrer" target=3D=
"_blank">https://wiki.qemu.org/Testing</a><br>
&gt; However I still could not get the tests for aarch64 to run. Do you kno=
w how<br>
&gt; to run the aarch64 or multi-arch tests?<br>
<br>
The aarch64 ones run with &quot;make run-tcg-tests-aarch64-linux-user&quot;=
 add<br>
V=3D1 to see the details.<br>
<br>
&gt; Also there aren&#39;t any existing gdb stub tests that try to read<br>
&gt; uninterpreted bytes from the target=E2=80=99s special data area identi=
fied by a<br>
&gt; keyword:<br>
&gt; <a href=3D"https://sourceware.org/gdb/current/onlinedocs/gdb/General-Q=
uery-Packets.html#qXfer-auxiliary-vector-read" rel=3D"noreferrer" target=3D=
"_blank">https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-Pa=
ckets.html#qXfer-auxiliary-vector-read</a><br>
&gt; I looked at some other gdb stub tests, but they did not seem to send a=
ny<br>
&gt; queries:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/=
gdbstub" rel=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qemu/=
tree/master/tests/tcg/aarch64/gdbstub</a><br>
&gt; So I am not sure how to set up one for &quot;Xfer:auxv:read:&quot; pac=
kets...<br>
&gt; Are there plans to add more tests for other packets like<br>
&gt; &quot;Xfer:features:read:&quot;?<br>
&gt; I&#39;d be happy to add a test if there is an example of how to do it.=
 :)<br>
<br>
What would you do from a normal gdb command line. At the very least you<br>
run the same command with gdb.execute(), e.g.:<br>
<br>
=C2=A0 gdb.execute(&quot;set confirm off&quot;)<br>
<br>
is the same as typing<br>
<br>
=C2=A0 set confirm off<br>
<br>
at the gdb command prompt.<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lirong<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br></blockquote><div><br></div><div>Hey Alex,</div><div><b=
r></div><div>I tried to run the test but they were skipped.=C2=A0Do you kno=
w if there&#39;s any other flag that needs to be set?</div><div><br></div>$=
 make run-tcg-tests-aarch64-linux-user <br>make[1]: Entering directory &#39=
;/usr/local/google/home/yuanzi/qemu/slirp&#39;<br>make[1]: Nothing to be do=
ne for &#39;all&#39;.<br>make[1]: Leaving directory &#39;/usr/local/google/=
home/yuanzi/qemu/slirp&#39;<br>=C2=A0 BUILD =C2=A0 TCG tests for aarch64-li=
nux-user<br>=C2=A0 BUILD =C2=A0 aarch64-linux-user guest-tests SKIPPED<br>=
=C2=A0 RUN =C2=A0 =C2=A0 TCG tests for aarch64-linux-user<br><div>=C2=A0 RU=
N =C2=A0 =C2=A0 tests for aarch64-linux-user SKIPPED=C2=A0</div><div><br></=
div><div>I don&#39;t think any command needs to be run. It should just send=
 the query automatically.=C2=A0</div><div>Could we assume that it will work=
 the same in the test?</div><div><br></div></div></div>

--000000000000894aa905a219bd52--

