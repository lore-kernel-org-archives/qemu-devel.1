Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA94C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78B42222B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKeDtOg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78B42222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeU2-0004hD-TY
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kZeSi-0002zg-Sk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:21:50 -0500
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:36922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kZeSg-00074Z-8I
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:21:48 -0500
Received: by mail-ua1-x942.google.com with SMTP id 52so4207484uaj.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zjgNfeKQMSknIQ9nsPnuFj8DLkcAZAMRQyaoOVtXyuw=;
 b=VKeDtOg6uAu1hdHxOfzzL+vA7qb4mcuwPUOG5TzXIrLcxripZ5anUcJXJl7R/qhPmY
 Zh0P51IeYQNz2sT+Itw14lzCx/oN23W3e07CVIb9ev8X3KZ9ddt9pswFsyMnYr/3ugsJ
 jSvMx0ZMJ1seUAClHX6VO1MvIn4e8xQQ/zQhBkRJquwI6UAfPLS5pkVTyD8vJ366RKeT
 vyqNDhv29aVjP5QcKKrRvodFUE76tmzCsX6iG4Sw7+yrYtHOZcvwXnm7gSBx7ewVbVw+
 bkS1ubK0YAaUgevwhDi6Q7lkfER1yN6T0GPJ1F45eVHj7Gju0ul9h8+rYGoWUhjqjC9U
 fdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zjgNfeKQMSknIQ9nsPnuFj8DLkcAZAMRQyaoOVtXyuw=;
 b=S86MnCGVwN/DNPnYeFAxjpGR9rhFp18OWUy62qMIcAaJY8piJ5KtKRMCyLY2vPWT7H
 fFyNbyqwWxhqqnYmNB+0UHdyCAuCC+CDjxCF99L4nwhTRuPJiXczjsRUc3XyqLxy50dL
 bkaJSCv+EyOIrSOVst5PSvY/DbnnNsTs2ibqkRrpm9hJYk1z8wg6xZ3leE1M7UYFqPpF
 yrY2BYDlEROpbQYp6taI5LP59NPhvSV0swTilWEZA7+iSld3KNg4lvJ1vBjaVa+xLDPG
 WDX4EFofLKS5Ez8XXimUJpP/6CoiaY+oMC510OItC3Almsql0SiB5naub/fFWzJjuSFU
 wlwA==
X-Gm-Message-State: AOAM531Lsam/hfVieS6CAr4+gkTdBXWn1UDg7md6632mhM/yDGU20yR/
 2bFTyxDVnJl0DhKCD26yp3lwkjoFS1xGW0inhLp+oA==
X-Google-Smtp-Source: ABdhPJxvzrpPVmaDrBOLPf5jIk5xsCOO1uBxRg5yKREXLcINfZu868B7HX4hHppjyEYaHxv9FESwX1RAPQBti1CgghU=
X-Received: by 2002:ab0:36db:: with SMTP id v27mr1885580uau.66.1604341304327; 
 Mon, 02 Nov 2020 10:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20201023210637.351238-1-hskinnemoen@google.com>
 <20201023210637.351238-5-hskinnemoen@google.com>
 <CAFEAcA8YvmFA7=7+CGVpubVScuKPdy+OQdmJdfMD+Fmk+Hb0SA@mail.gmail.com>
 <CAFQmdRZOKLb6=NJoeY9U3eYq3rbG_OWGFDDZdGTf8vjVOA11TQ@mail.gmail.com>
 <CAFEAcA-KxvtQGsH9yT9FrVnAu4cDWjMzPx_vGoBueGYhB8sziA@mail.gmail.com>
In-Reply-To: <CAFEAcA-KxvtQGsH9yT9FrVnAu4cDWjMzPx_vGoBueGYhB8sziA@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Mon, 2 Nov 2020 10:21:32 -0800
Message-ID: <CAFQmdRYgd3eE3A_aoXvzFvbhVmz_Zc06xJvVgLOk6tDyZRbmNg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] hw/misc: Add npcm7xx random number generator
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 CS20 KFTing <kfting@nuvoton.com>, 
 Patrick Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::942;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x942.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

On Mon, Nov 2, 2020 at 9:14 AM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Mon, 2 Nov 2020 at 16:50, Havard Skinnemoen <hskinnemoen@google.com> w=
rote:
> > But none of this is really specific to the RNG test, so I can remove
> > it if you prefer for consistency.
>
> I would prefer us to be consistent. If you want to propose
> don't-stop-on-asserts then we should set that consistently
> at some higher level of the test suite, not in every
> individual test.

OK, I will remove g_test_set_nonfatal_assertions from all the tests
I've submitted.

As for the randomness failures, I did find a bug in the runs test, but
fixing it doesn't make much of an impact on the flakiness.

I've seen failures from both monobit and runs, both first_bit and
continuous. So it doesn't look like there's a systemic problem
anywhere.

I dumped the random data on failure and put it through the
https://github.com/Honno/coinflip/ implementation of monobit and runs,
and after fixing the runs bug, they consistently produce the same P
value. Here's one example that failed the qtest with P=3D0.000180106965:

$ ./randomness_test.py e1 ec cc 55  29 5d c9 ac  85 45 ed 4b  b6 96 56 ab
Monobit test:
normalised diff  0.53
p-value          0.596
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90
=E2=94=82 value =E2=94=82 count =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
=E2=94=82 1     =E2=94=82    67 =E2=94=82
=E2=94=82 0     =E2=94=82    61 =E2=94=82
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98

Runs test:
no. of runs  85
p-value       0.0

You can find the script at
https://gist.github.com/hskinnemoen/41f7513ca228c2bac959c3b14e87025f

Apparently, successive bits are toggling too often, producing too many
runs of 1s or 0s. This will of course happen from time to time since
the input is random. And the monobit test will fail if there are too
many or too few 1s compared to zeroes, which is also something that
can't really be prevented.

While we can always tune this to happen less often, e.g. by dropping
the P-value threshold or running the tests multiple times, we can
never guarantee that a randomness test won't fail. So I suspect we
should keep these tests disabled by default, but keep them available
so that we can easily do a randomness test if there's any suspicion
that the emulated RNG device produces bad data. Does that make sense?

Havard

