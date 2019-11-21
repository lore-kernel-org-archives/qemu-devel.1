Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B30C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B4F20718
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kSK6WRUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B4F20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXhk9-0006G0-Eo
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iXhge-0005LO-72
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iXhgc-0003nm-Vf
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:19:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:50951)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iXhgc-0003kb-Id
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574324366;
 bh=TY5iWRbXOqN2Up4k/3Gnhmq/FMKHFi/M9gZlKERT3q8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=kSK6WRUVo1XjS7Jd5lbxKZSrtYY0WXB2Ky4DVv7feda16+V/iHD34M23F7U3lSr5X
 bwJeEr+99PEHH772BIRZEv0WG+hOn8ZFi+hHxa3y4q9dCwcRASnsfmiIuG/H5p3Roj
 BI6vULmG4rr14BG9u1Kxmd8nDEvKevc1+vT6ZQfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.156.18]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1i4Bpi343A-00pv4s; Thu, 21
 Nov 2019 09:19:26 +0100
Subject: Re: [PATCH v2] linux-user/strace: Improve output of various syscalls
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120145724.GA15677@ls3530.fritz.box>
 <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
 <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <015ab947-57ba-6d73-d99d-2e3263226c02@gmx.de>
Date: Thu, 21 Nov 2019 09:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3pnwdgqaMEkXw1XFQLG6g1qshu6o/gprwdU9cXr19+amAsdBycE
 I1fp9WWrY4hsp7vmK+bcjgmoZE9OL9m7X+Kj4mEYzfUaiiwl3pPfEIvZgdfkBy3S8mYsrLl
 EXdGmy6IvxoKHF10C7brhtcoM25pZWu8gWoUvUuHyqx/wQeINNV/mZ1gJZl6y3ANQ51oTXd
 d9NBbsh48b4hW6bqRhSmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qsbS9V7u8Ls=:3bLnoryI4TXFUOKmyQRvaz
 fI7sCLkAxM2wu0aQy7frxEWJUgDjijuUplXJjfpb4rtge+zGgWPC8GmZs6TmAG3uxhABlprKU
 61z0uZVUseXwdaVaml1QSy7n/V/VxfrRO56ILUCfsifdKwnA6YWDQh/zDO+0U3pVIrCSTmRKX
 HgcPRRQliUvDgD2wqFalAisQmZCIQszQmZGvc3Lo/HN7qd81Nq5hEjzBbLmLpm5P92vrYzjx6
 bwJImdRI6ig1NyP9X/HUvZHdkZFc7oIQ74cVRauNL3SdaEOlw32nUaFg8FJ9ACE4CDHoLs0z5
 BCZrhvyVwGlvxmfAhWoM86YFM260rMqTsfVaF3PW3DBNk3uXQyzynjk/SBuI4Qfbu4N73mUKN
 lbWI71r7/wAen+fvs5pOStpD9Q4dnHL7/cg+92IrtC7Pentw+r4B9uNZkW1aoH8jBqGH6qgew
 ppskklYzd2IvW2qvgj2msTd2kwYI/16rEx1CSEIhnFR9Z9fqFx/JSVFvlnKenVVfTBJxTCTIP
 xWTQ0qE0WaFoCFp0HaYEfpX938TMwgm4Fp4xrPWh7Wj4nEabZXBMSoZUiNCDGLQaj2k0doyjQ
 dhpNrBr0eFrjtUa0piPa29FkElIKKwwOmZiqpgGmAyC6Ix0BqRLDFR3J9vRMdtomEojEJc3La
 WSAI+0rh0qvQSiwmIjBvkfvXrYxpRmiomun7ghkwW/rl3jraH75YwJeGdVOrOcZdg6wW3MJnY
 JZUHczZDCGr/4a20aVwMPu1OeUuxn40vq6v7y512Pg6P627MNmx+H4v1coE0BQKqjqz3T2W8y
 evuEf/Pra1z26Feg7hdctvJEXC5lh4oUSR9zb1w/cnV8iFWoAoeZgpLc0ofTCJhcLWvHBCoTq
 v5/HZkz+efRFM/kQNurTRtLsY0nfg4thIjwRSPuggS1l9s7YQ8xAqI5H1pqYOFu3nxphSw86x
 PxF9c82z9NzDyXMrZOsWUWMETaijOPRWyywdkyoQnXZ7OCjZypC5XQzDu+ScpkJuBoYmaIXoV
 o8xu98Mn5WTt6hQ5fFtHC+B9YS48gMBZkDHfkRscWGWzClhkIE6zcYWOZLhGIqxwew1FsaSp4
 KD9WEXO8OOuH5LKyjJ/DlugX8BRkqkXiRwkql4f0ENiGUzMImWt1wxbH1VWgkT14OyD2mLQbw
 MrmuYrS6eJeMe6DTzbnHR6rwpirKmB4W0tejvLPaE2MibifhdQZ7wb9poUiEtlx/ckb2beS1x
 8D6/eD0gkWqzSS/PuTZ7u2mz3kHwZtSXRTAovqQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.11.19 23:20, Aleksandar Markovic wrote:
> On Wed, Nov 20, 2019 at 10:13 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>> On Wed, Nov 20, 2019 at 3:58 PM Helge Deller <deller@gmx.de> wrote:
>>>
>>> Improve strace output of various syscalls which either have none
>>> or only int-type parameters.
>>
>> It would be nice if you included a history of the patch (after the line
>> "---", as it is customary for single patch submission). You changed
>> only ioctl() in v2, right?

Yes. Will add history in next round.

>> I missed your v2, but responded with several hints to v1.

Yes, I saw all your mails.
Thanks for your feedback!

> userfaultfd(), membarrier(), mlock2()... - all could be included into
> your patch.

I think there are quite some more which I didn't included.
That's why I wrote "*various*" and not "*all*" in my changelog.
I'm debugging other code, and the ones I fixed are the ones I
actually tested with my code.

Helge

