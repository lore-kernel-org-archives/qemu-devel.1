Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34050C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F078720663
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otw7cZuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F078720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1EVA-00019w-6b
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuanzi@google.com>) id 1k1ETw-0000Ze-FA
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:44:48 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuanzi@google.com>) id 1k1ETt-00067r-RM
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:44:48 -0400
Received: by mail-oi1-x241.google.com with SMTP id y22so24704820oie.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cPDwwDoGxO5fx6tyt89T8KCrjbYtsjuYRSbUiUfExPE=;
 b=otw7cZuSpO4CJkd7SVyZUF5GiKCXpEmyTGBvaQ91M+0dPH9irtMY2KonwT9qD6dhOQ
 H3lct0IeTFFZBtKjeiyOrG3KBwklSCN972cMvqmlIpV1nhwg3igYOf9fowp5Wm8oZ4nH
 6CRbUc1KZwtZblWYb8jCUqqz397RVolRzGT7sWNLJLuvt70C6dssTBk7hNgNRotxaqsY
 jlnKU9Lee/JzP9sfZr/B09WWb58jl+cpnDdLO9brluBQRciHD3u8fkpcvygypCxSSyUy
 Wpp4HCOuUFMA9Zgcu/vj+l0GWQw+sEweDZCmTJpuqEmK3s330LdPbuKOMQT3IP9DtHIn
 qpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cPDwwDoGxO5fx6tyt89T8KCrjbYtsjuYRSbUiUfExPE=;
 b=hzMQnZp/OpyYxdMbYBZzG8rSb4ZaG/cbr+dUczhmMFTKJQmNGX3rcCk9Ndx9+qV8O4
 4rsh53LoL47f6BEQWFqyIJyvO22XgOkVKkq2N4yQgSAmuynzXcg21rZkiHoaRPrX2qZO
 S9NtNHypDSBR6oC1KbwGqace+fDWslSEbn8iPxSJXsZ48zembfry3U3E87CxX7wntnHC
 cUN80ZMqdIPUBkEYGXEgGLdcdB79wD1ZAWW7/Zq3PURfzQ2aa9PZwgSYvnklgnSdUDRY
 /q7We3BHb7m2FRVRNPrsYpY35ftQmtPs1n7qV4q9o/nlg9fNN9tPDJ3ni9DzHu6MzNm/
 sEAA==
X-Gm-Message-State: AOAM533JrexokDA77CUti6ZHSFaaq2cNMa5snWepSMyo7Y1Eh86tc0Mh
 8o4oJ+hi651zbIThU+y9nBhOhR3LtFQ2ss2YbOaFFw==
X-Google-Smtp-Source: ABdhPJwpCy1QJwaJL1DQB6lSOvndbwjFxgs4Fq5jabE8ZCigw2JL/Y5enBlCF7pyUkp0QGceC37hdLrnx8kgn28S2M8=
X-Received: by 2002:aca:eb88:: with SMTP id j130mr495420oih.38.1596138282840; 
 Thu, 30 Jul 2020 12:44:42 -0700 (PDT)
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
 <CADjx4C+EO7qEv7=8PSA+TG6-d9U9rGuREKpqfm_QrWrKtebR2w@mail.gmail.com>
In-Reply-To: <CADjx4C+EO7qEv7=8PSA+TG6-d9U9rGuREKpqfm_QrWrKtebR2w@mail.gmail.com>
From: Lirong Yuan <yuanzi@google.com>
Date: Thu, 30 Jul 2020 12:44:31 -0700
Message-ID: <CADjx4C+1pDP_Y3CbHXpgFumhxE=P4f+MV_YcxQ7cMUXmEyhBzA@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Shu-Chun Weng <scw@google.com>, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=yuanzi@google.com; helo=mail-oi1-x241.google.com
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

On Tue, Jul 21, 2020 at 1:29 PM Lirong Yuan <yuanzi@google.com> wrote:
>
> On Tue, Jul 21, 2020 at 12:50 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
> >
> >
> > Lirong Yuan <yuanzi@google.com> writes:
> >
> > > On Tue, Mar 31, 2020 at 12:20 AM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
> > >>
> > >>
> > >> Lirong Yuan <yuanzi@google.com> writes:
> > >>
> > >> > On Mon, Mar 30, 2020 at 12:47 PM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
> > >> >
> > >> >>
> > >> >> Lirong Yuan <yuanzi@google.com> writes:
> > >> >>
> > >> >> > On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org>
> > >> >> wrote:
> > >> >> >
> > >> >> >>
> > >> >> >> Lirong Yuan <yuanzi@google.com> writes:
> > >> >> >>
> > >> >> >> > On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.benne=
e@linaro.org>
> > >> >> >> wrote:
> > >> >> >> <snip>
> > >> >> >> >>
> > >> >> >> >> Sorry I missed this on my radar. There was a minor re-facto=
r of
> > >> >> gdbstub
> > >> >> >> >> that was just merged which will mean this patch needs a re-=
base to
> > >> >> use
> > >> >> >> >> g_string_* functions to expand stings.
> > >> >> >> >>
> > >> >> >> >> Also we have some simple gdbstub tests now - could we come =
up with a
> > >> >> >> >> multiarch gdbstub test to verify this is working properly?
> > >> >> >> >>
> > >> >> >> <snip>
> > >> >> >> > For sure, I will re-base this patch to use g_string_* functi=
ons.
> > >> >> >> >
> > >> >> >> > Currently we are using qemu aarch64. I am not sure how to do=
 this yet,
> > >> >> >> but
> > >> >> >> > I could try to add something to
> > >> >> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/g=
dbstub
> > >> >> >>
> > >> >> >> If the auxv support is appropriate to all linux-user targets y=
ou can
> > >> >> >> plumb it into the multiarch tests - you can even use the exist=
ing
> > >> >> >> binaries.
> > >> >> >>
> > >> >> >> So you need:
> > >> >> >>
> > >> >> >>   - a stanza in the makefiles to launch the test (see
> > >> >> >>     tests/tcg/aarch64/Makefile.target)
> > >> >> >>
> > >> >> >>   - a .py test script that manipulates gdbstub to check things=
 are
> > >> >> working
> > >> >> >>
> > >> >> >> So something like:
> > >> >> >>
> > >> >> >> .PHONY: gdbstub-foo-binary
> > >> >> >> run-gdbstub-foo-binary: foo-binary
> > >> >> >>         $(call run-test, $@, $(GDB_SCRIPT) \
> > >> >> >>                 --gdb $(HAVE_GDB_BIN) \
> > >> >> >>                 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> > >> >> >>                 --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-=
foo.py, \
> > >> >> >>         "basic gdbstub FOO support")
> > >> >> >>
> > >> >> >>
> > >> >> >> >
> > >> >> >> > Does this sound good?
> > >> >> >>
> > >> >> >> Hope that helps.
> > >> >> >>
> > >> >> >> >
> > >> >> >> > Thanks!
> > >> >> >> > Lirong
> > >> >> >>
> > >> >> >>
> > >> >> >> --
> > >> >> >> Alex Benn=C3=A9e
> > >> >> >>
> > >> >> >
> > >> >> > Hi Alex,
> > >> >> >
> > >> >> > Thanks for the instructions, very helpful!
> > >> >> >
> > >> >> > I rebased this patch to use g_string_* functions, and the link =
to
> > >> >> patchwork
> > >> >> > is:
> > >> >> > http://patchwork.ozlabs.org/patch/1264125/
> > >> >> > Could you help take another look?
> > >> >> >
> > >> >> > Regarding testing, I looked at some instructions for running te=
sts, e.g.
> > >> >> > https://github.com/qemu/qemu/blob/master/docs/devel/testing.rst
> > >> >> > https://wiki.qemu.org/Testing
> > >> >> > However I still could not get the tests for aarch64 to run. Do =
you know
> > >> >> how
> > >> >> > to run the aarch64 or multi-arch tests?
> > >> >>
> > >> >> The aarch64 ones run with "make run-tcg-tests-aarch64-linux-user"=
 add
> > >> >> V=3D1 to see the details.
> > >> >>
> > >> >> > Also there aren't any existing gdb stub tests that try to read
> > >> >> > uninterpreted bytes from the target=E2=80=99s special data area=
 identified by a
> > >> >> > keyword:
> > >> >> >
> > >> >> https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-P=
ackets.html#qXfer-auxiliary-vector-read
> > >> >> > I looked at some other gdb stub tests, but they did not seem to=
 send any
> > >> >> > queries:
> > >> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbs=
tub
> > >> >> > So I am not sure how to set up one for "Xfer:auxv:read:" packet=
s...
> > >> >> > Are there plans to add more tests for other packets like
> > >> >> > "Xfer:features:read:"?
> > >> >> > I'd be happy to add a test if there is an example of how to do =
it. :)
> > >> >>
> > >> >> What would you do from a normal gdb command line. At the very lea=
st you
> > >> >> run the same command with gdb.execute(), e.g.:
> > >> >>
> > >> >>   gdb.execute("set confirm off")
> > >> >>
> > >> >> is the same as typing
> > >> >>
> > >> >>   set confirm off
> > >> >>
> > >> >> at the gdb command prompt.
> > >> >>
> > >> >> >
> > >> >> > Thanks,
> > >> >> > Lirong
> > >> >>
> > >> >>
> > >> >> --
> > >> >> Alex Benn=C3=A9e
> > >> >>
> > >> >
> > >> > Hey Alex,
> > >> >
> > >> > I tried to run the test but they were skipped. Do you know if ther=
e's any
> > >> > other flag that needs to be set?
> > >> >
> > >> > $ make run-tcg-tests-aarch64-linux-user
> > >> > make[1]: Entering directory '/usr/local/google/home/yuanzi/qemu/sl=
irp'
> > >> > make[1]: Nothing to be done for 'all'.
> > >> > make[1]: Leaving directory '/usr/local/google/home/yuanzi/qemu/sli=
rp'
> > >> >   BUILD   TCG tests for aarch64-linux-user
> > >> >   BUILD   aarch64-linux-user guest-tests SKIPPED
> > >> >   RUN     TCG tests for aarch64-linux-user
> > >> >   RUN     tests for aarch64-linux-user SKIPPED
> > >>
> > >> Ahh you either need to have docker enabled or the aarch64 compilers =
in
> > >> your path when you run configure so the test programs can be built. =
The
> > >> details are in docs/devel/testing.rst
> > >>
> > >> > I don't think any command needs to be run. It should just send the=
 query
> > >> > automatically.
> > >> > Could we assume that it will work the same in the test?
> > >>
> > >> If that is enough to exercise the code. Can we not validate the data=
 somehow?
> > >>
> > >>
> > >> --
> > >> Alex Benn=C3=A9e
> > >
> > > Hi Alex,
> > >
> > > Thanks for the suggestions! I just installed docker and ran the tests=
,
> > > but got the following error messages for gdbstub tests:
> > > $ make run-tcg-tests-aarch64-linux-user
> > > ...
> > > TEST    basic gdbstub support
> > > warning: while parsing target description (at line 1): Target
> > > description specified unknown architecture "aarch64"
> > > warning: Could not load XML target description; ignoring
> > > Truncated register 37 in remote 'g' packet
> > > Traceback (most recent call last):
> > >   File "/usr/local/google/home/yuanzi/Documents/gdbstub-patch/qemu/te=
sts/tcg/multiarch/gdbstub/sha1.py",
> > > line 68, in <module>
> > >     if gdb.parse_and_eval('$pc') =3D=3D 0:
> > > gdb.error: No registers.
> > >   TEST    basic gdbstub SVE support
> > > warning: while parsing target description (at line 1): Target
> > > description specified unknown architecture "aarch64"
> > > warning: Could not load XML target description; ignoring
> > > Truncated register 37 in remote 'g' packet
> > >
> > > I'm not sure if there is any additional setup needed to make those
> > > tests pass. Do you know how to fix those errors?
> >
> > The error is because the gdb you have installed doesn't understand
> > foreign architectures. The test should have skipped in this case so I',
> > not sure why it causes it to fail.
> >
> > You can either ensure you have multiarch capable gdb (this is
> > binutils-multiarch on debian for example) or build your own gdb and
> > point at it with --gdb in configure.
> >
> > >
> > > Thanks,
> > > Lirong
> >
> >
> > --
> > Alex Benn=C3=A9e
>
> Hmm I installed binutils-multiarch but it still did not work. The
> error messages are the same as the previous ones.

Turns out that it can be fixed by installing gdb-multiarch and
rerunning configure.

I submitted a new patch, and here is the link to patchwork. :)
http://patchwork.ozlabs.org/project/qemu-devel/patch/20200730193932.3654677=
-1-yuanzi@google.com/

