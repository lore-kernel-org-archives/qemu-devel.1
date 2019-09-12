Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FECCC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1FF208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbgmFws5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1FF208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8L2S-0006Lr-HE
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8L17-0005F4-D5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8L15-0006ed-RD
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:03:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8L15-0006eJ-Kh
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:03:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id o184so6655199wme.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=K6nP7CsymagXv00/qxdDIXKv42FlOE+jV31gE71dzdY=;
 b=xbgmFws5G2DG990U7ExzV0ZoKTk21gUPsiO4qTskf8Jk36mp9Fj26kRmz/z8T8p/qP
 aoE4UqvBXBZ76IRdNWeG0crHEyfDWE9CkdLXsdfVHtAq9rITQ6m1eB4wX/6Wd0ryR48o
 C+shxAJLwgmHILwauONVYUVWqSRra0zE24Lz09oW1FLik0JWw/iAa5Z0BQ/xgSl0T80H
 TDejcgv+7qvBYGUmUTSfDal46oi1qK37yW7XsM5JzFqE1nefR39EmQAeZVpTGAWmN7YM
 BdD8zd2ueeHo1xr6LUP4Off07ID+5pDmNjJFQ3Ii31C8/Yov1uIsvWIXJ1IN263v+oSR
 cjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=K6nP7CsymagXv00/qxdDIXKv42FlOE+jV31gE71dzdY=;
 b=XNPT/x5z2paw7ztQ/OiIcAL4u3Mmy7iy8HPsfvatXeVQnx2HezvA0OfkFm0jKt2W5K
 NZRlzHl3QYNpGSJJ56cWQEaYMKTvd6HpSPT0iOUs7a4w4X6o32Us7R+o1ZgPJoISMNHN
 zZXiYWGchVd5DTfxa5DjjHSFknle0b0gyvBL2X1n/RkZ/7W1JlJ0OZ2mFC6OKixyP5hL
 eH9VIoKJdEz0kMBMjy6nlphzGHCSketwuspFJcFwZhR0GkY8irs0WnWviWAUs/BckJ/H
 qgVGijoTr9K+l4mhvFefqzTFrtk0pUq+7wsZrPDyMHr5SDcwlp5wTmm2DELcqW8aVpS7
 GmMw==
X-Gm-Message-State: APjAAAWsZ54WKMMSWugEdVN0JSWvHWj8KJTXadASXfjhS+Rk7dm9rCkv
 mHCBi/dI6lJnLLKR0GAOFrrC3g==
X-Google-Smtp-Source: APXvYqydI9qFXJCEySA+Z4Wbg9h7NV+efSy6fdBOHOM15WY0H0bFg8mPHMm+9wxAOsDIW8P/Lobpbg==
X-Received: by 2002:a1c:a984:: with SMTP id s126mr650907wme.26.1568279030065; 
 Thu, 12 Sep 2019 02:03:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s9sm9044229wme.36.2019.09.12.02.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 02:03:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75AC71FF87;
 Thu, 12 Sep 2019 10:03:48 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <87d0g6dnbc.fsf_-_@dusky.pond.sub.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <87d0g6dnbc.fsf_-_@dusky.pond.sub.org>
Date: Thu, 12 Sep 2019 10:03:48 +0100
Message-ID: <87y2ytzy17.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: Re: [Qemu-devel] TCG plugins and the GPL (was: [PATCH v4 00/54]
 plugins for TCG)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 aaron@os.amperecomputing.com, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, bobby.prani@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
> [...]
>>> Please advise why TCG plugins don't undermine the GPL.  Any proposal to
>>> add a plugin interface needs to do that.
>>
>> I'm not sure what we can say about this apart from "ask your lawyer".
>
> I'm not asking for a legal argument, I'm asking for a pragmatic one.
>
>> I'm certainly not proposing we add any sort of language about what
>> should and shouldn't be allowed to use the plugin interface. I find it
>> hard to see how anyone could argue code written to interface with the
>> plugin API couldn't be considered a derived work.
>
> What makes that so?  Is writing a plugin without linking with QEMU code
> impractical?

The way a plugin works is by linking. The plugin itself would be useless
unless combined with the QEMU code to do its thing. It is a more
intimate binding than an IPC interface using some sort of protocol. The
argument goes that pretty much any kernel module is derived code - but
again it has never really been litigated in the courts which would be
the people to set the precedent.

>
>> There are two use cases I have in mind:
>>
>> The first is FLOSS developers writing interesting tools that can take
>> advantage of QEMU's control of the system to do experiments that are
>> tricky with other setups (Valgrind is limited to same-arch, Dynamo/Pin
>> are user-space only). I want these experiments to be easy to do without
>> having to keep hacking and re-hacking QEMU's core code. I would hope
>> QEMU developers would up-stream theirs into the QEMU source tree but I
>> can imagine academics will have open source code that will only ever sit
>> in their paper's repository.
>
> GPL'ed code that's not for upstream is 100% legitimate.
>
>> The other is users who currently maintain hacked up internal copies of
>> QEMU as a test bed for whatever piece of silicon they are brewing behind
>> closed doors. This code would never be distributed (hence never be a GPL
>> issue)
>
> Correct.  We can't force anybody to distribute, and that's only proper.
>
>>        and is generally kept private because it's IP sensitive
>> (e.g: experimenting with different cache models). If we can provide an
>> interface that allows them to keep their experiments private and
>> separate from changes to the core code then maybe apart from making
>> their lives a bit easier we will see some non-IP sensitive contributions
>> come back to the upstream. I live in hope ;-)
>
> I'm concerned about a third case: imlementing stuff as a plugin so you
> can distribute it with a GPL-incompatible license.  Particularly
> pernicious when that stuff could be useful upstream.

If someone were to do that it would depend on a copyright holder (i.e.
one of us) being willing to challenge that licensing. AIUI GCC used
additional language in the runtime exception clause:

  https://www.gnu.org/licenses/gcc-exception-3.1.html

which only allows use of the runtime exception if the code has gone
through GPL compatible code:

  A Compilation Process is "Eligible" if it is done using GCC, alone or
  with other GPL-compatible software, or if it is done without using any
  work based on GCC. For example, using non-GPL-compatible Software to
  optimize any GCC intermediate representations would not qualify as an
  Eligible Compilation Process.

> Are there any technical difficulties that could make distributing a
> plugins in binary form impractical?

Well the first thing will be we are not intending to offer a guaranteed
ABI. While we don't want to be changing it at a whim there shouldn't be
an expectation that the plugin interface will maintain backwards
compatibility (unlike the command line interface ;-). There should be an
expectation that plugins will likely need to be rebuilt against the
current source tree from time to time.

We could implement a more technical measure analogous to the kernels
module signing that would require the plugin to be rebuilt with
reference to the current QEMU source tree although that will be a pain
even for internally distributed blobs. I'm loathed to implement such a
system from v1 though given the problem of publicly distributed binary
blobs is currently only a theoretical problem.

--
Alex Benn=C3=A9e

