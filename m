Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C0020717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RB1scyPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C0020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxwQF-0003sJ-RW
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 13:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuanzi@google.com>) id 1jxwPL-0003Mt-2T
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:50:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuanzi@google.com>) id 1jxwPI-00029C-A5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:50:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id g37so15682855otb.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=R/cIO52c46LllIfURZpK7++G+KkvQaHp/AdzCNz24wI=;
 b=RB1scyPBuYrNZEQTEezHS7fHzvRqyV1V6mkL1O1Is/GEE6Y5urcHyOxSsCAtlIBlpK
 9jZd/Dgjr60Y9QW2Qs4MP+sVmxqZAnfp9GOLAy0J1UiYS3gNKgOLuRyhP9NYNPBWtN+M
 pH2HrZXLlSGL+/sY20R+92ozqC2bSzCD105T6r/Z7upXltzIrU1hSzHZzDwdRHKPWJA0
 Lh/eiB18LFBVtNzMyhWZP0McJwv9anFhaUV/snt1GlzHuj7tyEZ8BNpi+ZvrP7YHWaQd
 RPdCdWSh5gNo89nZKXmyWga19oLX7LwMG9KJiV2L3DFf9ZiLKep5QXoanGh4Xjgz2CAs
 o8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R/cIO52c46LllIfURZpK7++G+KkvQaHp/AdzCNz24wI=;
 b=G5M7ByL3jbymH4AqLOL2jZWJ0uOT9kEH+47JGMBqnnGG3hTgae4lmqV9dud9B4VOZw
 XNOHPoRJ0KFzwQL/RnjRXLXvpNeH/veHWvy3qYX199XdrlnUmu+imPhgdxE1j1FCdmY+
 zElDfgBFzebG3D9Fg9NyVWnz83C3b+dFDdOzMmBjvaGKqG2beKSwF5bCNnvNMZP4Lja1
 Dc0ieZR/gocC9z2uo+uiE3ljSvy/b8GIi+4QrLqcznVdCl+zOY5J0fIAb8Tqj3nTmo4d
 Q29OCPkpNStUr7uDwPtxOAvjovTAOXPrcR4NP4kgwAiBi8Cuwr3u5NJj179OO48W+k5i
 Wmhw==
X-Gm-Message-State: AOAM530JH4xd8UEThnOdAhQrryo/V9e7UCuR2sqlPJ9eII90RM+gPCFH
 mcnGCekiKrt/aONRv5YHKMccQdNooU8SgqyxgofGpQ==
X-Google-Smtp-Source: ABdhPJxM6G8Uu11x1yOW5BOTUFjXi+K3QBFkAf++eQNgp6+Gn65fDiaMO0gGfJthk3tXlBvJQjDlfa7SVGRdXPszUAI=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr24128548otr.89.1595353821603; 
 Tue, 21 Jul 2020 10:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200307010051.97022-1-yuanzi@google.com>
 <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
 <87imizidwc.fsf@linaro.org>
 <CADjx4CJJdQep+K3ibfhjin7Eo6uCEFGQ6R6yVC0OcNo8MsfvJw@mail.gmail.com>
 <87d095u804.fsf@linaro.org>
 <CADjx4CKhoikcZanqYCs11ubGY+6tOeNjToiCgjnp8V_rzZcDHw@mail.gmail.com>
 <87tv25fwvz.fsf@linaro.org>
 <CADjx4CK-NtPP9iRmao_J9A+25y-MUjco=sM+sKwHfpWXzSV_yA@mail.gmail.com>
 <87o8sdf0sl.fsf@linaro.org>
In-Reply-To: <87o8sdf0sl.fsf@linaro.org>
From: Lirong Yuan <yuanzi@google.com>
Date: Tue, 21 Jul 2020 10:50:10 -0700
Message-ID: <CADjx4CJNhZv2guePFckf-ijPz1OYfMofJFfeUvC+bHwjtF4JYg@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Shu-Chun Weng <scw@google.com>, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=yuanzi@google.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 12:20 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>
> Lirong Yuan <yuanzi@google.com> writes:
>
> > On Mon, Mar 30, 2020 at 12:47 PM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
> >
> >>
> >> Lirong Yuan <yuanzi@google.com> writes:
> >>
> >> > On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=C3=A9e <alex.bennee@linaro=
.org>
> >> wrote:
> >> >
> >> >>
> >> >> Lirong Yuan <yuanzi@google.com> writes:
> >> >>
> >> >> > On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org>
> >> >> wrote:
> >> >> <snip>
> >> >> >>
> >> >> >> Sorry I missed this on my radar. There was a minor re-factor of
> >> gdbstub
> >> >> >> that was just merged which will mean this patch needs a re-base =
to
> >> use
> >> >> >> g_string_* functions to expand stings.
> >> >> >>
> >> >> >> Also we have some simple gdbstub tests now - could we come up wi=
th a
> >> >> >> multiarch gdbstub test to verify this is working properly?
> >> >> >>
> >> >> <snip>
> >> >> > For sure, I will re-base this patch to use g_string_* functions.
> >> >> >
> >> >> > Currently we are using qemu aarch64. I am not sure how to do this=
 yet,
> >> >> but
> >> >> > I could try to add something to
> >> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstu=
b
> >> >>
> >> >> If the auxv support is appropriate to all linux-user targets you ca=
n
> >> >> plumb it into the multiarch tests - you can even use the existing
> >> >> binaries.
> >> >>
> >> >> So you need:
> >> >>
> >> >>   - a stanza in the makefiles to launch the test (see
> >> >>     tests/tcg/aarch64/Makefile.target)
> >> >>
> >> >>   - a .py test script that manipulates gdbstub to check things are
> >> working
> >> >>
> >> >> So something like:
> >> >>
> >> >> .PHONY: gdbstub-foo-binary
> >> >> run-gdbstub-foo-binary: foo-binary
> >> >>         $(call run-test, $@, $(GDB_SCRIPT) \
> >> >>                 --gdb $(HAVE_GDB_BIN) \
> >> >>                 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> >> >>                 --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-foo.p=
y, \
> >> >>         "basic gdbstub FOO support")
> >> >>
> >> >>
> >> >> >
> >> >> > Does this sound good?
> >> >>
> >> >> Hope that helps.
> >> >>
> >> >> >
> >> >> > Thanks!
> >> >> > Lirong
> >> >>
> >> >>
> >> >> --
> >> >> Alex Benn=C3=A9e
> >> >>
> >> >
> >> > Hi Alex,
> >> >
> >> > Thanks for the instructions, very helpful!
> >> >
> >> > I rebased this patch to use g_string_* functions, and the link to
> >> patchwork
> >> > is:
> >> > http://patchwork.ozlabs.org/patch/1264125/
> >> > Could you help take another look?
> >> >
> >> > Regarding testing, I looked at some instructions for running tests, =
e.g.
> >> > https://github.com/qemu/qemu/blob/master/docs/devel/testing.rst
> >> > https://wiki.qemu.org/Testing
> >> > However I still could not get the tests for aarch64 to run. Do you k=
now
> >> how
> >> > to run the aarch64 or multi-arch tests?
> >>
> >> The aarch64 ones run with "make run-tcg-tests-aarch64-linux-user" add
> >> V=3D1 to see the details.
> >>
> >> > Also there aren't any existing gdb stub tests that try to read
> >> > uninterpreted bytes from the target=E2=80=99s special data area iden=
tified by a
> >> > keyword:
> >> >
> >> https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-Packet=
s.html#qXfer-auxiliary-vector-read
> >> > I looked at some other gdb stub tests, but they did not seem to send=
 any
> >> > queries:
> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub
> >> > So I am not sure how to set up one for "Xfer:auxv:read:" packets...
> >> > Are there plans to add more tests for other packets like
> >> > "Xfer:features:read:"?
> >> > I'd be happy to add a test if there is an example of how to do it. :=
)
> >>
> >> What would you do from a normal gdb command line. At the very least yo=
u
> >> run the same command with gdb.execute(), e.g.:
> >>
> >>   gdb.execute("set confirm off")
> >>
> >> is the same as typing
> >>
> >>   set confirm off
> >>
> >> at the gdb command prompt.
> >>
> >> >
> >> > Thanks,
> >> > Lirong
> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
> >>
> >
> > Hey Alex,
> >
> > I tried to run the test but they were skipped. Do you know if there's a=
ny
> > other flag that needs to be set?
> >
> > $ make run-tcg-tests-aarch64-linux-user
> > make[1]: Entering directory '/usr/local/google/home/yuanzi/qemu/slirp'
> > make[1]: Nothing to be done for 'all'.
> > make[1]: Leaving directory '/usr/local/google/home/yuanzi/qemu/slirp'
> >   BUILD   TCG tests for aarch64-linux-user
> >   BUILD   aarch64-linux-user guest-tests SKIPPED
> >   RUN     TCG tests for aarch64-linux-user
> >   RUN     tests for aarch64-linux-user SKIPPED
>
> Ahh you either need to have docker enabled or the aarch64 compilers in
> your path when you run configure so the test programs can be built. The
> details are in docs/devel/testing.rst
>
> > I don't think any command needs to be run. It should just send the quer=
y
> > automatically.
> > Could we assume that it will work the same in the test?
>
> If that is enough to exercise the code. Can we not validate the data some=
how?
>
>
> --
> Alex Benn=C3=A9e

Hi Alex,

Thanks for the suggestions! I just installed docker and ran the tests,
but got the following error messages for gdbstub tests:
$ make run-tcg-tests-aarch64-linux-user
...
TEST    basic gdbstub support
warning: while parsing target description (at line 1): Target
description specified unknown architecture "aarch64"
warning: Could not load XML target description; ignoring
Truncated register 37 in remote 'g' packet
Traceback (most recent call last):
  File "/usr/local/google/home/yuanzi/Documents/gdbstub-patch/qemu/tests/tc=
g/multiarch/gdbstub/sha1.py",
line 68, in <module>
    if gdb.parse_and_eval('$pc') =3D=3D 0:
gdb.error: No registers.
  TEST    basic gdbstub SVE support
warning: while parsing target description (at line 1): Target
description specified unknown architecture "aarch64"
warning: Could not load XML target description; ignoring
Truncated register 37 in remote 'g' packet

I'm not sure if there is any additional setup needed to make those
tests pass. Do you know how to fix those errors?

Thanks,
Lirong

