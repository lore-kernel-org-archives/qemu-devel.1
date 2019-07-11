Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56FFC74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9AF20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tqc25jtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9AF20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlUyL-0000IR-Rg
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlUwN-00070x-O1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlUwM-000311-Nr
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:00:35 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlUwM-0002tl-FG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:00:34 -0400
Received: by mail-oi1-x242.google.com with SMTP id w7so3915116oic.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tfwTdkcJBEvZeWdEKfKcZzF1aRHF6elEA4SgwB16G04=;
 b=Tqc25jtd/AxxEGSVVSxd+L7xZ8HpkfIy6Te0O7kZF/C9+p3njcu7cl4Z/1FKQ7W4Te
 sHDDXWpoNqvnmbWYcHhk6f21e3AeVR3b8em2lvW6iQ0CEa7tWTzLub9Q8tAaTFEtKlmN
 xUkODHufLL2WYgOpfn0ye7UC0UetiXAYDLioXG2naofdlE1XJT9vSQaYo4smLTtMzFDj
 WZJI+aNYUCEAWiGkxyBG674ktpP2tXTxSbRIMvsiBD2o3J8yh+Q8M0cFq0kGLQWCBulQ
 1fchWLWzeD/ikEeGO3LFXmZf0Z2x07oL5mrXW9w3nE5O1f2x/8gyBw9GYpkmyE8knPgA
 WDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tfwTdkcJBEvZeWdEKfKcZzF1aRHF6elEA4SgwB16G04=;
 b=g4zQnSNqKZ3AUoVpq72q4ojHWH6WfRv9HCb/Be4sY+CN+8n5inMB5Vi7fszJl1TIb0
 Ug/bmmJns4jzI4Rt/b115klIve0O2JjIbGL8rNxg+3CCEiGtN6XosYaXh6F5/6gqbBBk
 n+utroaw6Scvn9F/CevOvFTVmArFCbdCSBtcxwZhQZkWnBPqQ5M0+Xpw9skc8FdzGYYC
 Pq0yH5C2MwnHnDrj8d2m/rDeD/DeqLlEt9zX5dz4aFoQvjl/Sr7RQPlU0kVW2RdyIXQg
 87BPrmBAbAZlZaDownUtYLULRmqmogAVHKkiLk7yjW04ed7GuAe1k2tQSuZFvj5o1DvN
 kLlw==
X-Gm-Message-State: APjAAAXmTGdcQ/DHj5lvLvHg7aqdNCkLjZf6hHaNT6uOn+Rnhhs4wT31
 wR6k2UNh2ElnBWG7sXP4J1yOvWUga/Fl3EEmDHQsoA==
X-Google-Smtp-Source: APXvYqz1ITVa2brsDnXL2+2grkblmm6w0LeCq04EnWmYp5kumpSZ6GjeYXuTT0g+JBj3fbzraANtOHwKJOfxI9NsWXo=
X-Received: by 2002:aca:6185:: with SMTP id v127mr1796406oib.163.1562835630448; 
 Thu, 11 Jul 2019 02:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
 <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
 <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
 <CALvKS=EbuQOvRx+bmRnqCD6JuHK87dnkx00EiH--aXYWuNF0VQ@mail.gmail.com>
 <87ims9eox5.fsf@zen.linaroharston>
In-Reply-To: <87ims9eox5.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 10:00:19 +0100
Message-ID: <CAFEAcA9EoVv2uStszMmGD4EwJB8CCN_rgCbD8_nru_sUP74dsQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jul 2019 at 19:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Lucien Murray-Pitts <lucienmp.qemu@gmail.com> writes:
> > I am very new to TCG, so it does seem there is a lot of code in the
> > translator_loop that appears to be interacting with the CPU model/state=
.
> > Should I be worried about this, or is this a safe function to call outs=
ide
> > of the translator core proper?
>
> I would recommend against it - the time to do stuff like this would be
> during translation phase where you can save the data. Don't re-invoke the
> translator while trying to process an exception.
>
> Is the instruction format that irregular that you can't do a simple
> disassembly in a helper?

For anything moderately complicated, the use of the tcg_set_insn_param()
and restore_state_to_opc() that RTH recommends is definitely the
way to go. That way you can just save the right information when
you translate the code and don't have two separate bits of decoding
logic that need to agree.

For a more complicated example than the s390 one, you can look
at target/arm, which uses this to generate the 'syndrome' register
value which can include things like "which register was this faulting
load trying to load to".

thanks
-- PMM

