Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C05BC2D0EC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DCE206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/1+8QaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DCE206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIw9l-0007hD-8m
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jIw8o-0006fu-62
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jIw8m-0002UZ-If
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:15:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jIw8m-0002Qu-9F
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:15:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id 65so22154766wrl.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YeNU6gFjHk71zB0/YjJOaAKbB3hRj/4gDWw2AYq/tWY=;
 b=W/1+8QaV4meLB951lru0PAC3kJ6g8QTYsUH1FdCKpwE4fa8PQ8wNawpls9yEJ7iqrQ
 V/uiQ7CJu5chtbHoVzDjIcRN+RiB+L2VW4oHo0tHkGrsYYZhEm+KXV+KH4lYn2zlNQM5
 kJwaDGVrqBYRazJijFbP7JiWibv09IiosPfTo9+0h+S48iF08IB6dZCwW92Zi/QIPG5W
 8Kvq3nnuDJkYSan6pda6/tvJzLCgDBbGVPy1qO6v7C2Wg2pA6uQX4iJlftefdLVUPc8j
 EnMCmbdVphyuw0ewusCl0+jPAMae4DvFqJt4laoLiog27FsW7escFGkpdrk7A02ZhCVO
 mCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YeNU6gFjHk71zB0/YjJOaAKbB3hRj/4gDWw2AYq/tWY=;
 b=DO9hUZ57cY4zb3gk2n3bs1cYVIuec+QUPDPrfuV4GH/iidY7EHWn0PjnncgWPJ+Biu
 TZfo1PkM8DUmdXNnA1aqPqv9Qa0Sky6HoC2JtCczGeFtLHe574/SsKPeYI020hHgJ8i6
 X4Dsim1odmE+8Ij11EFZ6wEVvA9A+O7tpK3OFMzFeeTszc8ru9I2nZTxjsxjjE+K3Qm6
 POFAbiFbq/CnmMtZM/yNvVcOieCPGEV1Pu3+lwWrPxtRjrLb9W50pzpS5Sq/44xu5zdc
 XmJHKk7px6SWmOGnWC6RvBcI2gUpRavapGIY3bjSTXK3+LwcVaPHG10whLcz5i0pIJ0T
 McVA==
X-Gm-Message-State: ANhLgQ37RVznlxaeSRpAWAKwipTdYgKO0n5po30mbICg74OWCRhI71Fj
 NElNdeUoqCg7C1m4pQUe3UTtPF0YtKU=
X-Google-Smtp-Source: ADFU+vuQd73Q+uYIxfhiZYEq50Aj7o7U9OvWlx4BTBbhDqFT8I9XM2zb1bDe9Dw0sD2qxSkFCHwByQ==
X-Received: by 2002:adf:feca:: with SMTP id q10mr15197773wrs.199.1585581349948; 
 Mon, 30 Mar 2020 08:15:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm16198171wru.62.2020.03.30.08.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 08:15:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 83FD11FF7E;
 Mon, 30 Mar 2020 16:15:47 +0100 (BST)
References: <CAOragkw8XgbEOiaE9n=wKzPAMkzdOcqA5VA5ihN80v-g7V8TRw@mail.gmail.com>
 <20200329111311.272958fe@luklap>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: Qemu TCG Plugins - how to access guest registers?
In-reply-to: <20200329111311.272958fe@luklap>
Date: Mon, 30 Mar 2020 16:15:47 +0100
Message-ID: <878sjhho0s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Benjamin <benjamin@thatjames.org>, qemu-devel@nongnu.org,
 qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Lukas Straub <lukasstraub2@web.de> writes:

> On Fri, 27 Mar 2020 15:40:38 -0600
> Benjamin <benjamin@thatjames.org> wrote:
>
>> Qemu version 4.2.0 includes new functionality for something called TCG
>> Plugins. There are a few examples in the tests/plugins directory, and the
>> API is more or less defined in qemu-plugin.h.
>>=20
>> This file defines two enumerated types, "qemu_plugin_cb_flags" and
>> "qemu_plugin_mem_rw", which are passed into functions that register
>> callbacks. These enums seem to indicate whether the callbacks will read =
or
>> write CPU registers or memory. However, all of the example plugins use
>> "QEMU_PLUGIN_CB_NO_REGS", and only 2 of the plugins use the memory access
>> enum. hotpages.c and mem.c use "QEMU_PLUGIN_MEM_RW" as the default for
>> registering a memory callback (qemu_plugin_register_vcpu_mem_cb). mem.c =
has
>> an argument when the plugin is loaded to choose if it's read or write,
>> however, it doesn't seem to make any difference in the callback
>> function.

You are quite right the flags exist so the TCG can be told if the
callback is going to mess with machine state - they map to the internal
TCG_CALL_* flags which are used for the same reason for the internal
helper functions.

>> My question is, how do I access the guest memory and registers from the
>> plugin callback function? The API seems to indicate that it is possible,
>> since the callback registering requires you to say if you will access th=
em,
>> and if it's RW or just read.

Currently we document what plugins can do in docs/devel/tcg-plugins.rst:

  TCG plugins are unable to change the system state only monitor it
  passively. However they can do this down to an individual instruction
  granularity including potentially subscribing to all load and store
  operations.

This was a conscious decision to avoid plugins being used as an end-run
around the GPL to implement proprietary out-of-tree extensions.

That is not to say we might relax the rules in the future - it was a
topic of discussion at the maintainers summit and we wanted to document
some guidelines around interfacing with QEMU so people didn't get the
wrong idea about what these APIs provide (c.f. multi-process qemu and
vhost-user which could also be abused in similar ways).

Indeed Emilio's original tree did contain these more invasive hooks and
while we deliberate upstream it will hopefully not be as hard to
maintain a light out-of-tree fork should you need such functionality now.

>> Are there any examples of using this part of the API? I realize this is a
>> very new part of Qemu functionality.

So far the examples represent the totality of the API that has been
exercised and I'm keen we add more as new extensions to the API are
added. As to the specific question about accessing register values that
is exactly down to the newness of the API.

Register access is a tricky problem because of the fact that QEMU
supports so many guest architectures. I wasn't keen on slapping in a
functional but ugly API that hard-coded values like gdb register ids so
I left it out for the time being. I'd happily accept patches to add that
functionality assuming it meets the projects quality and taste
guidelines.

Some approaches we could take include:

  - hook into tcg_global_*_new and allow plugin to introspect registers
  - hook into gdbstub in some way

The first approach elides over the fact that a lot of registers aren't
actually known to the TCG - pretty much all vector registers tend to be
loaded into anonymous TCG temps as we go. Maybe this could just be fixed
by just providing a few more registrations functions at the start even
if the TCG itself wouldn't use that knowledge.

The gdbstub provides a lot more visibility of register state and for
some architectures this can be quite comprehensive - for example in
system mode you can access pretty much every ARM co-processor register.
However the gdb interface is a little clunky as there are a lot of magic
register id numbers and the canonical way to enumerate this is to chew
through a bunch of XML that each target generates (see
gdb_register_coprocessor). I'm not keen on exposing that pile of XML via
the register interface. Maybe there is scope to improve our internal
APIs so the enumeration of registers can be handled by helpers that
record mappings and ids and generate the XML for the gdbstub centrally?

There may be other approaches we could take and I'm open to suggestions.

>>=20
>> Thanks
>
> CC'ing the maintainer of TCG Plugins.


--=20
Alex Benn=C3=A9e

