Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDCFC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665E52189F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSVFyeFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665E52189F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqunP-00007A-LZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent.desnogues@gmail.com>) id 1hqunC-0008AI-Ub
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1hqun6-0003Kz-VE
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:37:26 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1hqun2-0002w9-IQ; Fri, 26 Jul 2019 03:37:20 -0400
Received: by mail-io1-xd44.google.com with SMTP id s7so102751766iob.11;
 Fri, 26 Jul 2019 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j8K0Ad6jbY/ZDFZrzoCMpFV+gdACtgN/1HWWCc6ETVY=;
 b=bSVFyeFzQYV13GWYYaQpZq4BDCTL1+tx7RO2FE1uu9zKCIPq6azEEo9mCBbP9p5Yaj
 h5DNBxg6CU9t2HouoST309KkCxEStXyEmepSIij7hyT3IwM90wOcaqzH70aIYWPOrHAF
 Ikc5yNfhJt5YcXKhHTPjtTlCtshSuk5lxjqTwooogbcnUYsrDTIncVy1US4Z4n9sgkx/
 +MpLs6NDMJtdm1CF3MijBTfmtTz1WhUhyh6V0nR2uiUCG7iilXfOnXyhMjIcUNav45a2
 a4wruIEz3RNgRrLm93uazeEN6RKNgC68mCSFsZJCp7GsLo4+RDiewNjGpg/PisASMRUi
 rbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j8K0Ad6jbY/ZDFZrzoCMpFV+gdACtgN/1HWWCc6ETVY=;
 b=Ekw4DW0C2E8vm45wIRrxkrC9IQ955VtMaJj+vNJWcVtGS4sPOPCUlgJhkiecnIJ4mP
 yBDLdMdax4tBKhcig6iraQXQvgY/MT+5sT4D6WaiqQJJCYzLOOEqpeE8uFDLGLaTohbI
 1wno0+N1BhxoHyCiI3w4UlE5OoKQZ6j6Dxr6kj13Z4H7iEFMFRe3Krt56GSD5TrTWGbl
 /slT+ZPebXw90ZXK6ELC/+bChzQtrMPz/rDZSL2fMQPR7x6o0PufIbxTPK3EVjjOREQc
 ZA1yyJl41/VfOHlxvXirE4LnjqP/y7C5zUo25Dm+w+/7l7M1UExHlBBxbwdTkUziPKbI
 XWMA==
X-Gm-Message-State: APjAAAWvom0JGU9bh9CqKJpyWUrjzAlAeuP+Lq0AkSZKs4cWcsA7cUAo
 H09RAtgHMmnbq8mFvwKyWC/D1YEENPtmzHf9bns=
X-Google-Smtp-Source: APXvYqz/SkKYw/Q4g5ptbO+K6Nh4Xruww9CvBsp4U3opBWQyi+ng59gPpHAIL603zYoUCO6xwFFa8elchpH9AzQJdg0=
X-Received: by 2002:a5d:9752:: with SMTP id c18mr16658845ioo.22.1564126635250; 
 Fri, 26 Jul 2019 00:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190723113301.16867-1-alex.bennee@linaro.org>
 <CAFEAcA9CP0cUkDR4qOKVgM1b2U1KNot=A-5OPEAOKu3=KpMyuw@mail.gmail.com>
 <8736iti7hn.fsf@linaro.org>
In-Reply-To: <8736iti7hn.fsf@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 26 Jul 2019 09:37:02 +0200
Message-ID: <CABoDooPYw5JccST8f9gVSmtA8ijeqmaVrqoDcqucbbctt5QvyA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH for 4.2] target/arm: generate a custom MIDR
 for -cpu max
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 9:24 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 23 Jul 2019 at 12:33, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
[...]
> >  /*
> >   * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a re=
al
> >   * one and try to apply errata workarounds or use impdef features we
> >   * don't provide.
> >   * An IMPLEMENTER field of 0 means "reserved for software use";
> >   * ARCHITECTURE must be 0xf indicating "v7 or later, check ID register=
s
> >   * to see which features are present";
> >   * the VARIANT, PARTNUM and REVISION fields are all implementation
> >   * defined and we choose to leave them all at zero.
> >   */
> >
> > It's also a bit inconsistent to do an explicit deposit of 0
> > for the IMPLEMENTER field but not for the VARIANT/PARTNUM/REVISION.
> >
> > I wonder if we should put 0x51 (ascii 'Q') in the PARTNUM field;
> > then if somebody really needs to distinguish QEMU from random
> > other software-models they have a way to do it.
>
> Q is reserved for Qualcomm - It would be nice if ARM could assign QEMU a
> code but I suspect that's not part of the business model.

That was my reaction at first too, but that Q is reserved for the
Implementer field, while Peter is proposing to put it in the PartNum
field :-)

Laurent

