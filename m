Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C80C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 20:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A0520720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 20:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2Rf+WTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A0520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxyv1-0004WD-Lx
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 16:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuanzi@google.com>) id 1jxytT-0003XR-JP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 16:29:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuanzi@google.com>) id 1jxytR-0007We-Jd
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 16:29:43 -0400
Received: by mail-ot1-x342.google.com with SMTP id c25so137410otf.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JpvAN9MEmNkIt+HpFcNWzuaU0XCeMjHtj1xjEbLqkB0=;
 b=Q2Rf+WToNMSz8Nlhw/fbkP+KgvR2lu5CYFwHwie+gHAV0MYlqSHWTd3jLnMl9jsEAU
 6ROCVgYaCHlzVoZlJraqHOrHHbVWfbPRtAdtsWStWxl2Op26GMlxAg7vlqpJtnZceIZR
 YMKijPiCu274EbbVkNeNhOFrI9RPxDOjNFTtnC/paDgwnjzUYvH1muEd5/qZib/pyjGO
 M4jFL9BCyaF4sXRJWXsQs4OyfpLaQYlgb794kizAATf5wUrjNHussMN6BueZWjbk5QU8
 Qf0t7+wzaZfDYLnzjDC4PmZq87j9mbWt3Kwo+adKzUimzAQGUfxhc5wopH3P1as8qxLC
 XOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JpvAN9MEmNkIt+HpFcNWzuaU0XCeMjHtj1xjEbLqkB0=;
 b=mFxS3OCAXQw7LQJXuvAw1fBS0snuN55vg8skpuOD8i8FH8UDInd5j1s/INWHyps6sW
 kQtwik7jfGGrkxUCtTJhq56Suw+F8iUmC0Zbh61VCWztCZeT7wP5jn/ORsIyEVSf3h6Q
 tOQn2P82Q3I/KRCcXNX2EVYxGnGZa6//cTnb6IFc2G6fLQ4WdhSfR1o6iuA4jS/psY9l
 I1E/UWDWAUC1vUGePW5zRZT+EIbvtNN7uhkzitwoXn6ugItF6zhh0kme+Cxw4nm6qnSW
 ZRydGC7i+3bfVW1nmbDEDsUYAk/P+3SlGZFhK9Ok/jnGGBRlFSyxKYDDk0+BuQmGynJf
 PpSA==
X-Gm-Message-State: AOAM533td7JYDcTDKJf3XYvokzPolTqOolDxv+4HLmnCcPfhF0LIr/Oq
 S38SKrjunZ80YcRCtRby4TO7T4RLDGLqMJHQD50d2g==
X-Google-Smtp-Source: ABdhPJxQEorG1XZXzpTpc7cYJ8zzMk24FzBU+D8HNrDPcMONAlgtzuPdJNS/pJtmah3zZVewoaVmobCGjoodDqipoyQ=
X-Received: by 2002:a05:6830:45a:: with SMTP id
 d26mr24009017otc.252.1595363379960; 
 Tue, 21 Jul 2020 13:29:39 -0700 (PDT)
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
 <CADjx4CJNhZv2guePFckf-ijPz1OYfMofJFfeUvC+bHwjtF4JYg@mail.gmail.com>
 <878sfcve9l.fsf@linaro.org>
In-Reply-To: <878sfcve9l.fsf@linaro.org>
From: Lirong Yuan <yuanzi@google.com>
Date: Tue, 21 Jul 2020 13:29:28 -0700
Message-ID: <CADjx4C+EO7qEv7=8PSA+TG6-d9U9rGuREKpqfm_QrWrKtebR2w@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Shu-Chun Weng <scw@google.com>, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=yuanzi@google.com; helo=mail-ot1-x342.google.com
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

On Tue, Jul 21, 2020 at 12:50 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>
> Lirong Yuan <yuanzi@google.com> writes:
>
> > On Tue, Mar 31, 2020 at 12:20 AM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
> >>
> >>
> >> Lirong Yuan <yuanzi@google.com> writes:
> >>
> >> > On Mon, Mar 30, 2020 at 12:47 PM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
> >> >
> >> >>
> >> >> Lirong Yuan <yuanzi@google.com> writes:
> >> >>
> >> >> > On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org>
> >> >> wrote:
> >> >> >
> >> >> >>
> >> >> >> Lirong Yuan <yuanzi@google.com> writes:
> >> >> >>
> >> >> >> > On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.bennee@=
linaro.org>
> >> >> >> wrote:
> >> >> >> <snip>
> >> >> >> >>
> >> >> >> >> Sorry I missed this on my radar. There was a minor re-factor =
of
> >> >> gdbstub
> >> >> >> >> that was just merged which will mean this patch needs a re-ba=
se to
> >> >> use
> >> >> >> >> g_string_* functions to expand stings.
> >> >> >> >>
> >> >> >> >> Also we have some simple gdbstub tests now - could we come up=
 with a
> >> >> >> >> multiarch gdbstub test to verify this is working properly?
> >> >> >> >>
> >> >> >> <snip>
> >> >> >> > For sure, I will re-base this patch to use g_string_* function=
s.
> >> >> >> >
> >> >> >> > Currently we are using qemu aarch64. I am not sure how to do t=
his yet,
> >> >> >> but
> >> >> >> > I could try to add something to
> >> >> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdb=
stub
> >> >> >>
> >> >> >> If the auxv support is appropriate to all linux-user targets you=
 can
> >> >> >> plumb it into the multiarch tests - you can even use the existin=
g
> >> >> >> binaries.
> >> >> >>
> >> >> >> So you need:
> >> >> >>
> >> >> >>   - a stanza in the makefiles to launch the test (see
> >> >> >>     tests/tcg/aarch64/Makefile.target)
> >> >> >>
> >> >> >>   - a .py test script that manipulates gdbstub to check things a=
re
> >> >> working
> >> >> >>
> >> >> >> So something like:
> >> >> >>
> >> >> >> .PHONY: gdbstub-foo-binary
> >> >> >> run-gdbstub-foo-binary: foo-binary
> >> >> >>         $(call run-test, $@, $(GDB_SCRIPT) \
> >> >> >>                 --gdb $(HAVE_GDB_BIN) \
> >> >> >>                 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> >> >> >>                 --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-fo=
o.py, \
> >> >> >>         "basic gdbstub FOO support")
> >> >> >>
> >> >> >>
> >> >> >> >
> >> >> >> > Does this sound good?
> >> >> >>
> >> >> >> Hope that helps.
> >> >> >>
> >> >> >> >
> >> >> >> > Thanks!
> >> >> >> > Lirong
> >> >> >>
> >> >> >>
> >> >> >> --
> >> >> >> Alex Benn=C3=A9e
> >> >> >>
> >> >> >
> >> >> > Hi Alex,
> >> >> >
> >> >> > Thanks for the instructions, very helpful!
> >> >> >
> >> >> > I rebased this patch to use g_string_* functions, and the link to
> >> >> patchwork
> >> >> > is:
> >> >> > http://patchwork.ozlabs.org/patch/1264125/
> >> >> > Could you help take another look?
> >> >> >
> >> >> > Regarding testing, I looked at some instructions for running test=
s, e.g.
> >> >> > https://github.com/qemu/qemu/blob/master/docs/devel/testing.rst
> >> >> > https://wiki.qemu.org/Testing
> >> >> > However I still could not get the tests for aarch64 to run. Do yo=
u know
> >> >> how
> >> >> > to run the aarch64 or multi-arch tests?
> >> >>
> >> >> The aarch64 ones run with "make run-tcg-tests-aarch64-linux-user" a=
dd
> >> >> V=3D1 to see the details.
> >> >>
> >> >> > Also there aren't any existing gdb stub tests that try to read
> >> >> > uninterpreted bytes from the target=E2=80=99s special data area i=
dentified by a
> >> >> > keyword:
> >> >> >
> >> >> https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-Pac=
kets.html#qXfer-auxiliary-vector-read
> >> >> > I looked at some other gdb stub tests, but they did not seem to s=
end any
> >> >> > queries:
> >> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstu=
b
> >> >> > So I am not sure how to set up one for "Xfer:auxv:read:" packets.=
..
> >> >> > Are there plans to add more tests for other packets like
> >> >> > "Xfer:features:read:"?
> >> >> > I'd be happy to add a test if there is an example of how to do it=
. :)
> >> >>
> >> >> What would you do from a normal gdb command line. At the very least=
 you
> >> >> run the same command with gdb.execute(), e.g.:
> >> >>
> >> >>   gdb.execute("set confirm off")
> >> >>
> >> >> is the same as typing
> >> >>
> >> >>   set confirm off
> >> >>
> >> >> at the gdb command prompt.
> >> >>
> >> >> >
> >> >> > Thanks,
> >> >> > Lirong
> >> >>
> >> >>
> >> >> --
> >> >> Alex Benn=C3=A9e
> >> >>
> >> >
> >> > Hey Alex,
> >> >
> >> > I tried to run the test but they were skipped. Do you know if there'=
s any
> >> > other flag that needs to be set?
> >> >
> >> > $ make run-tcg-tests-aarch64-linux-user
> >> > make[1]: Entering directory '/usr/local/google/home/yuanzi/qemu/slir=
p'
> >> > make[1]: Nothing to be done for 'all'.
> >> > make[1]: Leaving directory '/usr/local/google/home/yuanzi/qemu/slirp=
'
> >> >   BUILD   TCG tests for aarch64-linux-user
> >> >   BUILD   aarch64-linux-user guest-tests SKIPPED
> >> >   RUN     TCG tests for aarch64-linux-user
> >> >   RUN     tests for aarch64-linux-user SKIPPED
> >>
> >> Ahh you either need to have docker enabled or the aarch64 compilers in
> >> your path when you run configure so the test programs can be built. Th=
e
> >> details are in docs/devel/testing.rst
> >>
> >> > I don't think any command needs to be run. It should just send the q=
uery
> >> > automatically.
> >> > Could we assume that it will work the same in the test?
> >>
> >> If that is enough to exercise the code. Can we not validate the data s=
omehow?
> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
> >
> > Hi Alex,
> >
> > Thanks for the suggestions! I just installed docker and ran the tests,
> > but got the following error messages for gdbstub tests:
> > $ make run-tcg-tests-aarch64-linux-user
> > ...
> > TEST    basic gdbstub support
> > warning: while parsing target description (at line 1): Target
> > description specified unknown architecture "aarch64"
> > warning: Could not load XML target description; ignoring
> > Truncated register 37 in remote 'g' packet
> > Traceback (most recent call last):
> >   File "/usr/local/google/home/yuanzi/Documents/gdbstub-patch/qemu/test=
s/tcg/multiarch/gdbstub/sha1.py",
> > line 68, in <module>
> >     if gdb.parse_and_eval('$pc') =3D=3D 0:
> > gdb.error: No registers.
> >   TEST    basic gdbstub SVE support
> > warning: while parsing target description (at line 1): Target
> > description specified unknown architecture "aarch64"
> > warning: Could not load XML target description; ignoring
> > Truncated register 37 in remote 'g' packet
> >
> > I'm not sure if there is any additional setup needed to make those
> > tests pass. Do you know how to fix those errors?
>
> The error is because the gdb you have installed doesn't understand
> foreign architectures. The test should have skipped in this case so I',
> not sure why it causes it to fail.
>
> You can either ensure you have multiarch capable gdb (this is
> binutils-multiarch on debian for example) or build your own gdb and
> point at it with --gdb in configure.
>
> >
> > Thanks,
> > Lirong
>
>
> --
> Alex Benn=C3=A9e

Hmm I installed binutils-multiarch but it still did not work. The
error messages are the same as the previous ones.

