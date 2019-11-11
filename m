Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EFBC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24E420679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2NZKZ7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24E420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUD7o-0000EG-5f
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUD4q-0006b7-TJ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUD4p-0006FC-FB
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:02:08 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUD4p-0006EG-7q
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:02:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id z26so34146wmi.4
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RA9cC7g7Eu9LrKE1HPtk5Ky9bYI2Ny0CcNKEWeM2CUQ=;
 b=I2NZKZ7izO0C6H0ZAHKckEdvcZM+UvcfXLmy3sEmMnVWQebbA9ZeB1yrNK7Ueqj5YN
 hk4x1PEoKJyLE/U1nLyDRgWfwcXUNjqu9Tg5ZN5YLBnEfDC4+p0dLtIb4JXz/F20ek/a
 4lTBvDmYvye51JdLeaRU3ucT1cSSZ8fhRGHU+VOsqc6Rup7PPFu7B/grPD4gfrpBDcS6
 B5ox8wdEmmzpWij3F4Dsdih53UQ992Jk6Qhpw7N5wQD9Er9PIZFXNF71rTiIHFAovNRz
 rW4mFIvw9votmyebvTSYLOahpVJPHOdBO/dTXgebIc55JGqcCPYBfCQLHSttV4lu5nrG
 6E4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RA9cC7g7Eu9LrKE1HPtk5Ky9bYI2Ny0CcNKEWeM2CUQ=;
 b=mQsJhvnQM8CWMNCP7FlzG9nM6qkaXEhSfYCvSTDr59eKzx0/QooEcvcIpDFGzLPnFM
 T+N8fE7X2396YQyBXMm7nnhivA/kBL9x3VgLEVeeXPQCKHn3SvUIV4S+LHs9Ou97urOD
 QWUNXffaQglXhI3j8PkxoIfZeu48tTOgU8M/yOtRV4NtQvAQLIqiDOquEXoWHlR/lC8I
 FnsH6HJCVmHwUlXvIYMr8KY+eeBnBEfvN4Mce85OGCsWWKJyTbCVjB6itkbztQQAwIen
 uz3qarcggKO+Kbax/hEPC1xCfC7qMgE+LCLG/5qEbdLpgPOMvb4b0HTl87auqW48n4PP
 g4Og==
X-Gm-Message-State: APjAAAWOGYwYBBmgSy8V1J19Oy7xaOZcMmlxhb5yZ9CGlywQE6PBNW4E
 ttncbn7gv6Y35R+67oxEv4k1Ng==
X-Google-Smtp-Source: APXvYqyAUqVcXnU6/PXuNGtnZHq25/k2nSbhmtDtxWen4qHYdujcD3tZrlq6m0H1gJ9jpJLz8IuQcA==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr11248767wmk.123.1573491724922; 
 Mon, 11 Nov 2019 09:02:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c4sm4584052wrp.86.2019.11.11.09.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 09:02:03 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C81A11FF87;
 Mon, 11 Nov 2019 17:02:02 +0000 (GMT)
References: <20191111125530.26579-1-alex.bennee@linaro.org>
 <cd4917d6-75b7-2c47-0c6b-07dda077c52e@redhat.com>
 <878soma4ev.fsf@linaro.org>
 <97fd0943-586c-035f-b33b-eb6b2eb3dde6@redhat.com>
 <CAFEAcA_F1gUOhTyVkd185ie=tgoFS08n62Nk425RnAW+w6o0XA@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/migration: use the common library function
In-reply-to: <CAFEAcA_F1gUOhTyVkd185ie=tgoFS08n62Nk425RnAW+w6o0XA@mail.gmail.com>
Date: Mon, 11 Nov 2019 17:02:02 +0000
Message-ID: <8736eu9wj9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Ber?= =?utf-8?Q?rang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 11 Nov 2019 at 14:41, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 11/11/2019 15.11, Alex Benn=C3=A9e wrote:
>> >
>> > Thomas Huth <thuth@redhat.com> writes:
>> >
>> >> On 11/11/2019 13.55, Alex Benn=C3=A9e wrote:
>> >>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >>
>> >> Could you please add at least a short patch description? (Why is this
>> >> change necessary / a good idea?)
>> >
>> > It's just a minor clean-up Dave happened to comment on last week. Using
>> > the helper function is preferable given it abstracts away any system
>> > differences for the same information.
>>
>> But this also changes the behavior on non-Linux systems (i.e. the *BSDs
>> and macOS), since they will now use getpid() instead of gettid ... is
>> that the intended change here?
>
> Does the 'stress' program work on those OSes? For that matter,
> does it work on Linux?
>
> As far as I can tell we don't compile stress.c on any host,
> since the only thing that depends on tests/migration/stress$(EXESUF)
> is tests/migration/initrd-stress.img, and nothing depends on that.
>
> Nothing creates tests/migration/ in the build dir so trying
> to build tests/migration/stress in an out-of-tree config fails:
>
>   CC      tests/migration/stress.o
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:359:=
1:
> fatal error: opening dependency file tests/migration/stress.d: No such
> file or directory
>  }
>  ^
> compilation terminated.
>
> ...and if I fix that by manually creating the directory then
> it fails to link:
>
>   CC      tests/migration/stress.o
>   LINK    tests/migration/stress
> tests/migration/stress.o: In function `get_command_arg_str':
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:107:
> undefined reference to `g_strndup'
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:109:
> undefined reference to `g_strdup'
> tests/migration/stress.o: In function `get_command_arg_ull':
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:129:
> undefined reference to `g_free'
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:132:
> undefined reference to `g_free'
> tests/migration/stress.o: In function `stress':
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:253:
> undefined reference to `pthread_create'
> collect2: error: ld returned 1 exit status
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/Makefile.include:849:
> recipe for target 'tests/migration/stress' failed
>
> Is this dead code ?

It was introduced around 3 years ago by Daniel for stress testing. The
instructions in:

  409437e16df273fc5f78f6cd1cb53023eaeb9b72
  Author:     Daniel P. Berrang=C3=A9 <berrange@redhat.com>
  AuthorDate: Wed Jul 20 14:23:13 2016 +0100
  Commit:     Amit Shah <amit.shah@redhat.com>
  CommitDate: Fri Jul 22 13:23:39 2016 +0530

  tests: introduce a framework for testing migration performance

say to use:

  make tests/migration/initrd-stress.img

And that has indeed bitrotted over time. All the other tweaks since are
passing through clean ups.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

