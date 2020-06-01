Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67133C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C08E2077D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W32VO3Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C08E2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhsK-0004Za-Ag
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfhrC-0003iI-GM
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:39:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfhrB-0004HO-60
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:39:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so10951125wrr.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=122JmFOPRqu5VXkEmA/NrQx0zkFAhVLLoKXS68h4JMU=;
 b=W32VO3JjPESgMtcj8tAxP8pkpAu/G4jDH/dY9PLlkobI+gykePHUWiUSOTkuaqC3kI
 peDCrfblcr9v9mKuzb5lC77k1c44sv6l6/6N5nGQ4/qKTc31o9akCqydn/6eRVVh5euj
 pn5AxxKBQKuMSaAyexI3aGo0oYDpl3uGMhGij6rwU8hifflqYzjpfnDXRYXhjbeEOoJk
 5vwb+Lvzskrd5oE9zZKijsdDFY/H0C9h/VKNAgn1SN3Sk2NlJFfMMXVOwBQpR1dbWjsG
 OMs0g3yYGU/eG9wt97NYHY5zy0DDrq906kK/KjU0bazQC1wTtGpQlDdctgGWCOUoh/dM
 cFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=122JmFOPRqu5VXkEmA/NrQx0zkFAhVLLoKXS68h4JMU=;
 b=O9v/TdYvgTaWwHFN/fJSywPI8rZTzrnnXm3ZpKUZq5j57WI0AquNZ4fq2PbZAwOEdg
 bgTjrRcYCoYNoENNuRc0+LLSk5/owLnBvwbFV8CR8SsL/lje1GLA52JbejNAsfPf3aJC
 IcwbYUq16foGeilfWVGGqjPu6PJDqsbzy07V/P7fUoTxF+7vfCcd9/UvrXw7xoqdSvOu
 rAq6l0NFM5G+pigXmwrwOf8kB7MvuIxGf9Wx0R9GUeJQy9/jkw6XWawbkVrUUA2dVoS1
 hZmLZT4NA8ju0NdfSzO6OEqRuZG41BOv4FKqJ8SsDL0KKA7NvpP/T3cFey4jrjSWmDFn
 Bl1g==
X-Gm-Message-State: AOAM5336/v6Q4E6UGF3GKEnYa2wC+zqjSTIJLTQw2Bll6aCG30wvtfJB
 cLAdmEG/3bpS/ba2qPFk1FZrZw==
X-Google-Smtp-Source: ABdhPJwRqJ305GtQ3pyIfveJtMTLhSoNqXy7lCC3xRnPGv2mz9jyy2ZT4oA/8k0d8LvKAxhkxo6lLw==
X-Received: by 2002:a5d:4c81:: with SMTP id z1mr23059620wrs.371.1591007986193; 
 Mon, 01 Jun 2020 03:39:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm20071252wrh.79.2020.06.01.03.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 03:39:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 175F91FF7E;
 Mon,  1 Jun 2020 11:39:44 +0100 (BST)
References: <20200330153016.2959-1-f4bug@amsat.org>
 <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
 <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
 <CAFEAcA_BJf3k-O4j73kNaPtSHfhqmgtm9LH=nAmNj46kMjbkCA@mail.gmail.com>
 <d5ce42bc-a236-512f-dbbe-7327527419e0@amsat.org>
 <20200531164236.GF3071@jondnuc>
 <CAFEAcA95hfnjBjUT0hCxPUzBnGL9xKDkEjBqDcyVBD6spVZ_4w@mail.gmail.com>
 <20200601072948.GG3071@jondnuc>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
In-reply-to: <20200601072948.GG3071@jondnuc>
Date: Mon, 01 Jun 2020 11:39:44 +0100
Message-ID: <87r1uz6pe7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Edgar E .
 Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-D?= =?utf-8?Q?aud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> On 31/05/2020, Peter Maydell wrote:
>>On Sun, 31 May 2020 at 17:42, Jon Doron <arilou@gmail.com> wrote:
>>>
>>> On 31/05/2020, Philippe Mathieu-Daud=C3=A9 wrote:
>>> >On 3/30/20 6:41 PM, Peter Maydell wrote:
>>> >> PS: do we have any documentation of this new command ?
>>> >> ab4752ec8d9 has the implementation but no documentation...
>>> >
>>> >Jon, do you have documentation on the Qqemu.PhyMemMode packet?
>>
>>> Hi, there is no documentation for this mode, but in general the idea was
>>> very simple.
>>>
>>> I want to have GDB the option to see the physical memory and examine it
>>> and have this option toggled.
>>>
>>> This was useful to me when I was working on nested virtual machine and I
>>> wanted to examine different states of the VMCS12 and EPTs.
>>>
>>> I used this in the following commands:
>>> // Enable
>>> maint packet Qqemu.PhyMemMode:1
>>>
>>> // Disable
>>> maint packet Qqemu.PhyMemMode:0
>>
>>docs/system/gdb.rst would be the place to document QEMU-specific
>>extensions to the gdb protocol (there's an "advanced debugging
>>options" section where we document things like the single-step
>>stuff you can also change via 'maint packet').
>>
>>thanks
>>-- PMM
>
> Thanks, I'll know for next time, when I did all that work and
> re-factored gdbstub, that doc did not exist.

The documentation existed in our old texinfo docs, however they have
been recently updated to rst and are now considerably easier to find and
hack on now.

> Perhaps Peter can just add the documentation to this commit?

Please don't impose extra burden on our overworked maintainer when he's
already given review feedback. Generally maintainers have more work to
do than time to do it in so the easiest way to expedite patches with
features you want added is to send well formed complete patches which
can be easily merged. Otherwise patches tend to end up deep in a pile of
"must get around to that when I can".

--=20
Alex Benn=C3=A9e

