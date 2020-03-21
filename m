Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E06CC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 13:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6033A20754
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 13:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZDdAdBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6033A20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFecR-0006JP-FS
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jFebp-0005sx-7P
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jFebn-0005ep-Pp
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:56:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jFebn-0005dC-BG
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:56:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id c187so9434484wme.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
 :date:mime-version:content-transfer-encoding;
 bh=ZafcH+DwkL/AMMqK5bC8oPK3+j9uqrvaddbO0mPp09k=;
 b=lZDdAdBwonymPAOrxePFIKjDOGFL+aHk8kWc14kONfQjPShq4OLqa2+slF0MPCDbPc
 y8VeZNdtB3hNMTa4sCFfLHkfhudqAI2llJwK/8JqvsN4J1AC01SHwKVVq7t+nvxiQiYJ
 wzuUu6ORpdEKveD5g0TR1uqOzLErcCM2Eu6XgdUOueCk4GVAIVC+YKFtSgnyhfZPybg9
 Syp2AyUvi+w1GSKaMHQDWd36NStOThTuL+itJVo8nt+fKjOeL3fYVl75wV3xBhhkUG9Y
 J7OPQqoFgzuHqFeGG770cGIUQkvOS+HLZKLqKKid/65L8hSn1RzFOgHsePJ2wTdIyjIY
 AHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
 bh=ZafcH+DwkL/AMMqK5bC8oPK3+j9uqrvaddbO0mPp09k=;
 b=YPzVXZ21lhp15hDcgKpqBxBGBpjel/hq7YJmvD/Rl5DXA7wDykmbxYSMo/f7IHCg3O
 v0UlGcLSTPgtUymQbwKPIiyO3tVVIv/dz1MR03bnAPJSjuaWDQnY+1RqRsY6eWn7Qhtf
 T/PQIZ0y3nCwZ2ouV2DMM0Gs6CZ6GNoJe4S/5yzDuyHmRXcSnDSi7JXgvASVM0K5faQw
 apDPM5zz+vvZWwKeF2ABXqJdu1gOQ1ji7ZYqqqwbwIaQieR/ZcRdl02ONEVPU58UdoQw
 szNh0Np1hO8vOcSX0x14gjslXFylE+o5mYVORkFeeJ0U6nFEY6fwqlTWB3/NHdtwnSxm
 edoA==
X-Gm-Message-State: ANhLgQ0afCxO/snEBrmzO3TniRIHTnbZ6ALUc27CyxwvZMbPqJ7EH4P+
 ZqXhohkfUPt991coCVqa9uyZkQ==
X-Google-Smtp-Source: ADFU+vu7aZH+u61ymBAsPgtxMojWV/+Khrc+eAIGTKZGwKrKYP8uXiX7TOJgLJrHowGoF4lTeqX4nA==
X-Received: by 2002:a1c:23c8:: with SMTP id
 j191mr16586943wmj.117.1584798973767; 
 Sat, 21 Mar 2020 06:56:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q72sm12517615wme.31.2020.03.21.06.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 06:56:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 627E51FF7E;
 Sat, 21 Mar 2020 13:56:11 +0000 (GMT)
References: <20200307010051.97022-1-yuanzi@google.com>
 <CADjx4CKDPY9J7Zr1YTLv78Ku6mQS6zrMu7oX7-ujU3PGxvHA4w@mail.gmail.com>
 <87imizidwc.fsf@linaro.org>
 <CADjx4CJJdQep+K3ibfhjin7Eo6uCEFGQ6R6yVC0OcNo8MsfvJw@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lirong Yuan <yuanzi@google.com>
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
In-reply-to: <CADjx4CJJdQep+K3ibfhjin7Eo6uCEFGQ6R6yVC0OcNo8MsfvJw@mail.gmail.com>
Message-ID: <87d095u804.fsf@linaro.org>
Date: Sat, 21 Mar 2020 13:56:11 +0000
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
Cc: Josh Kunz <jkz@google.com>,
 Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Lirong Yuan <yuanzi@google.com> writes:

> On Fri, Mar 20, 2020 at 2:17 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
<snip>
>>
>> Sorry I missed this on my radar. There was a minor re-factor of gdbstub
>> that was just merged which will mean this patch needs a re-base to use
>> g_string_* functions to expand stings.
>>
>> Also we have some simple gdbstub tests now - could we come up with a
>> multiarch gdbstub test to verify this is working properly?
>>
<snip>
> For sure, I will re-base this patch to use g_string_* functions.
>
> Currently we are using qemu aarch64. I am not sure how to do this yet, but
> I could try to add something to
> https://github.com/qemu/qemu/tree/master/tests/tcg/aarch64/gdbstub

If the auxv support is appropriate to all linux-user targets you can
plumb it into the multiarch tests - you can even use the existing
binaries.

So you need:

  - a stanza in the makefiles to launch the test (see
    tests/tcg/aarch64/Makefile.target)

  - a .py test script that manipulates gdbstub to check things are working

So something like:

.PHONY: gdbstub-foo-binary
run-gdbstub-foo-binary: foo-binary
	$(call run-test, $@, $(GDB_SCRIPT) \
		--gdb $(HAVE_GDB_BIN) \
		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-foo.py, \
	"basic gdbstub FOO support")


>
> Does this sound good?

Hope that helps.

>
> Thanks!
> Lirong


--=20
Alex Benn=C3=A9e

