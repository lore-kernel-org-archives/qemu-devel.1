Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E553BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B169F20675
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mva0r84X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B169F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ0Pm-0002LD-R5
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 15:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJ0NS-0000L8-J7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJ0NP-00079T-TB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:47:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJ0NP-00074w-CX
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:47:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id w10so23244706wrm.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6CNWyF1t/H8TJ1kexfrAAfUZIKUptVCqfnEyF6Ek0Xk=;
 b=Mva0r84Xkc0E2Nw1E6aEUegU1WqX8fIP0dkMaOmojpAyZKXSdsOw/tTUHI21YLoZ40
 XXvoPNbfmYgzAjcACQRNkpCVp1p8Ru+h0Lh3bv23PvZrG7Ym6xea39bmQEW2LcPFnrpQ
 OYJBVVzS94CbFJnH0LSDoy15iwNTSpkMY1b1gUkZFUpvGrXZ76DIElh3ItkVy6l6kQFl
 bvMwUOtgLp27B16VP9sEaJslx7+OtoDr/wYHjAayFznTYtTe6BNs53R1K4MFDZ6MAZNM
 xBACfhncKu+6JjNSdPAnJ0OhWPQPeFSy7G2D/cXSgU70EdvJOGo3UQXAaGC5MuheaKQf
 L2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6CNWyF1t/H8TJ1kexfrAAfUZIKUptVCqfnEyF6Ek0Xk=;
 b=Wtw0B9AQPecUrn+JHlz2c3JhwfJ1HNpdWvPJ8US5TfgdM2llrzyaWfdQH09IeAVMRk
 2kHdna6Pp2mRf+8KtEgcJVGTX8U5jXPXa7f2owudnE1PXSMzmMKbbB5EgeJpFpgkXP4q
 L6ybiTyw0cna0Gsb/iRnczi63fm1qK3igxZ7da+49Jas/IiJB5ECCrhGJahoxOrd5EsN
 gZ0qjrQhpiEWp/dALxLXFMNC1xcGuTT83TLd9tVLlri5WlsKFzDnLLeaV2UQDqH0mqHs
 PiUHbXczDbesaY694xr6SeVH+ISDtI6w2goMlDyWB6zJ8wMehvsqIWb+vENt4TIo2MiC
 e1Og==
X-Gm-Message-State: ANhLgQ2JBD4gfvg/tcGzSkCY8a8g7qxPXNwUUljEK05F6LkqUNC/mYgu
 VWqqce6D2YQ+nJRFvJfRHVVdcg==
X-Google-Smtp-Source: ADFU+vuFZfpyjyjaXJQ27C2bQv/I9IA7vS1B02tk7QAcCzQ9wBV7xj0L4NvM7D4IsMTbLsc6kaWXLw==
X-Received: by 2002:a5d:5447:: with SMTP id w7mr16337639wrv.299.1585597634241; 
 Mon, 30 Mar 2020 12:47:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 19sm674950wmi.32.2020.03.30.12.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 12:47:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4533F1FF7E;
 Mon, 30 Mar 2020 20:47:12 +0100 (BST)
References: <20200307010051.97022-1-yuanzi@google.com>
 <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
 <87imizidwc.fsf@linaro.org>
 <CADjx4CJJdQep+K3ibfhjin7Eo6uCEFGQ6R6yVC0OcNo8MsfvJw@mail.gmail.com>
 <87d095u804.fsf@linaro.org>
 <CADjx4CKhoikcZanqYCs11ubGY+6tOeNjToiCgjnp8V_rzZcDHw@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lirong Yuan <yuanzi@google.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
In-reply-to: <CADjx4CKhoikcZanqYCs11ubGY+6tOeNjToiCgjnp8V_rzZcDHw@mail.gmail.com>
Date: Mon, 30 Mar 2020 20:47:12 +0100
Message-ID: <87tv25fwvz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

> On Sat, Mar 21, 2020 at 6:56 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> Lirong Yuan <yuanzi@google.com> writes:
>>
>> > On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg>
>> wrote:
>> <snip>
>> >>
>> >> Sorry I missed this on my radar. There was a minor re-factor of gdbst=
ub
>> >> that was just merged which will mean this patch needs a re-base to use
>> >> g_string_* functions to expand stings.
>> >>
>> >> Also we have some simple gdbstub tests now - could we come up with a
>> >> multiarch gdbstub test to verify this is working properly?
>> >>
>> <snip>
>> > For sure, I will re-base this patch to use g_string_* functions.
>> >
>> > Currently we are using qemu aarch64. I am not sure how to do this yet,
>> but
>> > I could try to add something to
>> > https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub
>>
>> If the auxv support is appropriate to all linux-user targets you can
>> plumb it into the multiarch tests - you can even use the existing
>> binaries.
>>
>> So you need:
>>
>>   - a stanza in the makefiles to launch the test (see
>>     tests/tcg/aarch64/Makefile.target)
>>
>>   - a .py test script that manipulates gdbstub to check things are worki=
ng
>>
>> So something like:
>>
>> .PHONY: gdbstub-foo-binary
>> run-gdbstub-foo-binary: foo-binary
>>         $(call run-test, $@, $(GDB_SCRIPT) \
>>                 --gdb $(HAVE_GDB_BIN) \
>>                 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>>                 --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-foo.py, \
>>         "basic gdbstub FOO support")
>>
>>
>> >
>> > Does this sound good?
>>
>> Hope that helps.
>>
>> >
>> > Thanks!
>> > Lirong
>>
>>
>> --
>> Alex Benn=C3=A9e
>>
>
> Hi Alex,
>
> Thanks for the instructions, very helpful!
>
> I rebased this patch to use g_string_* functions, and the link to patchwo=
rk
> is:
> http://patchwork.ozlabs.org/patch/1264125/
> Could you help take another look?
>
> Regarding testing, I looked at some instructions for running tests, e.g.
> https://github.com/qemu/qemu/blob/master/docs/devel/testing.rst
> https://wiki.qemu.org/Testing
> However I still could not get the tests for aarch64 to run. Do you know h=
ow
> to run the aarch64 or multi-arch tests?

The aarch64 ones run with "make run-tcg-tests-aarch64-linux-user" add
V=3D1 to see the details.

> Also there aren't any existing gdb stub tests that try to read
> uninterpreted bytes from the target=E2=80=99s special data area identifie=
d by a
> keyword:
> https://sourceware.org/gdb/current/onlinedocs/gdb/General-Query-Packets.h=
tml#qXfer-auxiliary-vector-read
> I looked at some other gdb stub tests, but they did not seem to send any
> queries:
> https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub
> So I am not sure how to set up one for "Xfer:auxv:read:" packets...
> Are there plans to add more tests for other packets like
> "Xfer:features:read:"?
> I'd be happy to add a test if there is an example of how to do it. :)

What would you do from a normal gdb command line. At the very least you
run the same command with gdb.execute(), e.g.:

  gdb.execute("set confirm off")

is the same as typing

  set confirm off

at the gdb command prompt.

>
> Thanks,
> Lirong


--=20
Alex Benn=C3=A9e

