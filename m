Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B86BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 19:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133E52072E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 19:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slaPH33R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133E52072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxyID-0004TC-9s
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 15:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxyHe-00042l-6r
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 15:50:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxyHc-0002HM-1V
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 15:50:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id 184so4062102wmb.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ps7UoK2FoTGRYCdHdEA6qFrx0m1hhz19wdqjjT4pS7g=;
 b=slaPH33RJeI4V+IF7dMoCI+I28y4Dztekc3ZUAHnROSQDRxNsXL+iLbZoBsiNx4Tjb
 tzhb+J01CN++sFpeFVOii1K2Y8fDQDpbbgEm7snDl7QGId5aCaA/tL9VABFTaXtiCDqq
 DPaaApB08k0WFzx5X7T4iQ6w6QanNIgbn36WQIYTUsIkPYQ62+LXmRySmYtCd0+5nhAz
 VVhxarCaBJXvY69pvCVCcr/NrR5Kk/seCsbaEUXeJ2M01yCciXCAkXM0Oo7f1w/lIQWW
 mXqBCgg/QBYyJMUfU6yoLq77CIlOLn4VLkxNSQjNNzYn4aDSlWFC5FrDGC6fHkEgQDpm
 vviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ps7UoK2FoTGRYCdHdEA6qFrx0m1hhz19wdqjjT4pS7g=;
 b=oiC5f3lQi9cUsLNCZwBhjqITzTq15ukiEB15khWpDRSgA6cERr0x3cCQVVEiBj08G1
 ATs5aaPa5DY2C0aSrGj4pzXML+VUlstK3M2uT6kSaPb40aeUIXF5Cc7SLkp9MQYSuNno
 h0ua7IQFg6WyVSpMCRMOkKmrt5a+h5seQSoVmWpHewG4w7emYvbv5ZZeoQ5XDtRT1iQ7
 m5o86CR60nzoTOFMCJd3oC7325vZf8giLVh3yyoEC8Wkq4Hzpl8Xg3N9DaOsAooWKFTm
 uInbC3NFxHzSj4SJ7eU2uy0qL1ghvsXg1LGuO6aoUeWZrwV7iXeR3fVByJaPwkqZfWuR
 Pq9A==
X-Gm-Message-State: AOAM530/ocGVrLkNg1v7AFpb6NXQWAlWx/MfMU4xJSpMSKGSInNKi9iU
 1EvMlek8khReduPOMooWqYUaVg==
X-Google-Smtp-Source: ABdhPJyunpb6gxUxS4UGUBOFalCgCKfmpfPAJcIfItTt4ymhMtdXUqlw6jtkBYnsBB+YWLhFTPJT4A==
X-Received: by 2002:a1c:5ac3:: with SMTP id o186mr5381401wmb.39.1595361033824; 
 Tue, 21 Jul 2020 12:50:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 129sm4573012wmd.48.2020.07.21.12.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 12:50:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A3FE11FF7E;
 Tue, 21 Jul 2020 20:50:30 +0100 (BST)
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
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lirong Yuan <yuanzi@google.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
In-reply-to: <CADjx4CJNhZv2guePFckf-ijPz1OYfMofJFfeUvC+bHwjtF4JYg@mail.gmail.com>
Date: Tue, 21 Jul 2020 20:50:30 +0100
Message-ID: <878sfcve9l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Josh Kunz <jkz@google.com>,
 Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Lirong Yuan <yuanzi@google.com> writes:

> On Tue, Mar 31, 2020 at 12:20 AM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>
>>
>> Lirong Yuan <yuanzi@google.com> writes:
>>
>> > On Mon, Mar 30, 2020 at 12:47 PM Alex Benn=C3=A9e <alex.bennee@linaro.=
org> wrote:
>> >
>> >>
>> >> Lirong Yuan <yuanzi@google.com> writes:
>> >>
>> >> > On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=C3=A9e <alex.bennee@linar=
o.org>
>> >> wrote:
>> >> >
>> >> >>
>> >> >> Lirong Yuan <yuanzi@google.com> writes:
>> >> >>
>> >> >> > On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.bennee@li=
naro.org>
>> >> >> wrote:
>> >> >> <snip>
>> >> >> >>
>> >> >> >> Sorry I missed this on my radar. There was a minor re-factor of
>> >> gdbstub
>> >> >> >> that was just merged which will mean this patch needs a re-base=
 to
>> >> use
>> >> >> >> g_string_* functions to expand stings.
>> >> >> >>
>> >> >> >> Also we have some simple gdbstub tests now - could we come up w=
ith a
>> >> >> >> multiarch gdbstub test to verify this is working properly?
>> >> >> >>
>> >> >> <snip>
>> >> >> > For sure, I will re-base this patch to use g_string_* functions.
>> >> >> >
>> >> >> > Currently we are using qemu aarch64. I am not sure how to do thi=
s yet,
>> >> >> but
>> >> >> > I could try to add something to
>> >> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbst=
ub
>> >> >>
>> >> >> If the auxv support is appropriate to all linux-user targets you c=
an
>> >> >> plumb it into the multiarch tests - you can even use the existing
>> >> >> binaries.
>> >> >>
>> >> >> So you need:
>> >> >>
>> >> >>   - a stanza in the makefiles to launch the test (see
>> >> >>     tests/tcg/aarch64/Makefile.target)
>> >> >>
>> >> >>   - a .py test script that manipulates gdbstub to check things are
>> >> working
>> >> >>
>> >> >> So something like:
>> >> >>
>> >> >> .PHONY: gdbstub-foo-binary
>> >> >> run-gdbstub-foo-binary: foo-binary
>> >> >>         $(call run-test, $@, $(GDB_SCRIPT) \
>> >> >>                 --gdb $(HAVE_GDB_BIN) \
>> >> >>                 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>> >> >>                 --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-foo.=
py, \
>> >> >>         "basic gdbstub FOO support")
>> >> >>
>> >> >>
>> >> >> >
>> >> >> > Does this sound good?
>> >> >>
>> >> >> Hope that helps.
>> >> >>
>> >> >> >
>> >> >> > Thanks!
>> >> >> > Lirong
>> >> >>
>> >> >>
>> >> >> --
>> >> >> Alex Benn=C3=A9e
>> >> >>
>> >> >
>> >> > Hi Alex,
>> >> >
>> >> > Thanks for the instructions, very helpful!
>> >> >
>> >> > I rebased this patch to use g_string_* functions, and the link to
>> >> patchwork
>> >> > is:
>> >> > http://patchwork.ozlabs.org/patch/1264125/
>> >> > Could you help take another look?
>> >> >
>> >> > Regarding testing, I looked at some instructions for running tests,=
 e.g.
>> >> > https://github.com/qemu/qemu/blob/master/docs/devel/testing.rst
>> >> > https://wiki.qemu.org/Testing
>> >> > However I still could not get the tests for aarch64 to run. Do you =
know
>> >> how
>> >> > to run the aarch64 or multi-arch tests?
>> >>
>> >> The aarch64 ones run with "make run-tcg-tests-aarch64-linux-user" add
>> >> V=3D1 to see the details.
>> >>
>> >> > Also there aren't any existing gdb stub tests that try to read
>> >> > uninterpreted bytes from the target=E2=80=99s special data area ide=
ntified by a
>> >> > keyword:
>> >> >
>> >> https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-Packe=
ts.html#qXfer-auxiliary-vector-read
>> >> > I looked at some other gdb stub tests, but they did not seem to sen=
d any
>> >> > queries:
>> >> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub
>> >> > So I am not sure how to set up one for "Xfer:auxv:read:" packets...
>> >> > Are there plans to add more tests for other packets like
>> >> > "Xfer:features:read:"?
>> >> > I'd be happy to add a test if there is an example of how to do it. =
:)
>> >>
>> >> What would you do from a normal gdb command line. At the very least y=
ou
>> >> run the same command with gdb.execute(), e.g.:
>> >>
>> >>   gdb.execute("set confirm off")
>> >>
>> >> is the same as typing
>> >>
>> >>   set confirm off
>> >>
>> >> at the gdb command prompt.
>> >>
>> >> >
>> >> > Thanks,
>> >> > Lirong
>> >>
>> >>
>> >> --
>> >> Alex Benn=C3=A9e
>> >>
>> >
>> > Hey Alex,
>> >
>> > I tried to run the test but they were skipped. Do you know if there's =
any
>> > other flag that needs to be set?
>> >
>> > $ make run-tcg-tests-aarch64-linux-user
>> > make[1]: Entering directory '/usr/local/google/home/yuanzi/qemu/slirp'
>> > make[1]: Nothing to be done for 'all'.
>> > make[1]: Leaving directory '/usr/local/google/home/yuanzi/qemu/slirp'
>> >   BUILD   TCG tests for aarch64-linux-user
>> >   BUILD   aarch64-linux-user guest-tests SKIPPED
>> >   RUN     TCG tests for aarch64-linux-user
>> >   RUN     tests for aarch64-linux-user SKIPPED
>>
>> Ahh you either need to have docker enabled or the aarch64 compilers in
>> your path when you run configure so the test programs can be built. The
>> details are in docs/devel/testing.rst
>>
>> > I don't think any command needs to be run. It should just send the que=
ry
>> > automatically.
>> > Could we assume that it will work the same in the test?
>>
>> If that is enough to exercise the code. Can we not validate the data som=
ehow?
>>
>>
>> --
>> Alex Benn=C3=A9e
>
> Hi Alex,
>
> Thanks for the suggestions! I just installed docker and ran the tests,
> but got the following error messages for gdbstub tests:
> $ make run-tcg-tests-aarch64-linux-user
> ...
> TEST    basic gdbstub support
> warning: while parsing target description (at line 1): Target
> description specified unknown architecture "aarch64"
> warning: Could not load XML target description; ignoring
> Truncated register 37 in remote 'g' packet
> Traceback (most recent call last):
>   File "/usr/local/google/home/yuanzi/Documents/gdbstub-patch/qemu/tests/=
tcg/multiarch/gdbstub/sha1.py",
> line 68, in <module>
>     if gdb.parse_and_eval('$pc') =3D=3D 0:
> gdb.error: No registers.
>   TEST    basic gdbstub SVE support
> warning: while parsing target description (at line 1): Target
> description specified unknown architecture "aarch64"
> warning: Could not load XML target description; ignoring
> Truncated register 37 in remote 'g' packet
>
> I'm not sure if there is any additional setup needed to make those
> tests pass. Do you know how to fix those errors?

The error is because the gdb you have installed doesn't understand
foreign architectures. The test should have skipped in this case so I',
not sure why it causes it to fail.

You can either ensure you have multiarch capable gdb (this is
binutils-multiarch on debian for example) or build your own gdb and
point at it with --gdb in configure.

>
> Thanks,
> Lirong


--=20
Alex Benn=C3=A9e

