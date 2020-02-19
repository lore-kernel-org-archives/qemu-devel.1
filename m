Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC6C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE0424656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpCy5cQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE0424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PEz-0006Ou-AS
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4PDF-000592-Cf
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4PDE-0006XG-09
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:16:25 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4PDD-0006WP-88
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:16:23 -0500
Received: by mail-oi1-x244.google.com with SMTP id a142so23719877oii.7
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 05:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4XqsGCnjmFDmejIeW5CB0R9beJ6yi3AZX4cE3SBIxYA=;
 b=wpCy5cQ+NWuGReADJzId5vixTXGoW6H2ywMxT++5XNGmX5XeHJ3fdy2IcHLvzFfDjj
 mThnBheX1rsB5lbwaxwcp/+9iAZBr84w9NgtBnrpRsT4lJQ7BEWk/b4BvTrzaSIsFW1O
 1TNsPgi/zLwk7kAQD/wJjZ4SamxH9ggVb20BbB6MF0DCfDyqepdzNyNRDhtltYctPvRu
 kWLzlC6wvT12gqWh1krLXwulRy0lDktstxudv7aXJcsJrs50XlvEMQAzPPXxYxxtjVeg
 1hMvM14FPLzYdUmKO9bcenEux5PbS9BACN23oHWxugRCP8CttMBeRoBy2dBbsQDaurvW
 B8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4XqsGCnjmFDmejIeW5CB0R9beJ6yi3AZX4cE3SBIxYA=;
 b=MjvHPwHuskz19RuOciIPDFrHRSg3VaUxQ0o1SjIoUM+bOt0s8dUL/g6qQodLMxUgCP
 fPJcsE+3Xp09mJFcPajFpwpLcHkno+2+xZuD9t2BJfqxecLrqSxG3AM5oAOCgc0woL9B
 8De+Cl2LrimYpskQuVht8ZfigsGCvpjqJpoEmozU3pIYKMtZp4f4Sfr4Rsf//2YhgMN7
 dOy2Umit9rMrjg3ERC7chhiz7PXfAs3pu/vSu4qPINrss/amvEZHLUX5Gn8+lJZsg7z3
 5oVzt2IZhx08VgdbU1KKrQiwkh9SeBVtMUFPbDt9A3wLdX9SKqU/Nsk1Bq0RYsXp1cZ2
 P5Ig==
X-Gm-Message-State: APjAAAXNRjn5JiD0XfY1nPBAg77FpwVA8tGlH9W94YDIjCQOsuGUp/N0
 9bxd3U2FxEoiziCRv8fWEzzplWB39bcgXGXvJ0wlGg==
X-Google-Smtp-Source: APXvYqz2CjrFTE4pbKGejH6ezrkm5MuW2JPS89rqBxoqJeibidS1v29i8q+8Ah2hOsadfCuqUAuk2XoRs1bTCEIu+Go=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr4359375oie.146.1582118182180; 
 Wed, 19 Feb 2020 05:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20200219114607.1855-1-kchamart@redhat.com>
 <20200219114607.1855-2-kchamart@redhat.com>
In-Reply-To: <20200219114607.1855-2-kchamart@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Feb 2020 13:16:11 +0000
Message-ID: <CAFEAcA94A3doGQthOTrPuMadOfqrSLBadUbi+3BpHr1MGp_w1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: Convert qemu-cpu-models.texi to rST
To: Kashyap Chamarthy <kchamart@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020 at 11:46, Kashyap Chamarthy <kchamart@redhat.com> wrote=
:
>
> This doc was originally written by Daniel P. Berrang=C3=A9
> <berrange@redhat.com>, introduced via commit[1]: 2544e9e4aa (docs: add
> guidance on configuring CPU models for x86, 2018-06-27).
>
> This is a 1-1 conversion of Texinfo to rST, besides a couple of minor
> non-content tweaks that are too trivial to spell out.  Further
> modifications will be done via a separate patch.
>
> (Thanks to Stephen Finucane on IRC for the suggestion to use rST
> "definition lists" instead of bullets in some places.)
>
> [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2544e9e4aa
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  docs/qemu-cpu-models.texi       | 677 --------------------------------
>  docs/system/index.rst           |   1 +
>  docs/system/qemu-cpu-models.rst | 496 +++++++++++++++++++++++
>  3 files changed, 497 insertions(+), 677 deletions(-)
>  delete mode 100644 docs/qemu-cpu-models.texi
>  create mode 100644 docs/system/qemu-cpu-models.rst

Hi; I haven't looked in detail at the actual conversion
parts, but from the diffstat you're missing some parts:

1) qemu-doc.texi has an "@include docs/qemu-cpu-models.texi"
that needs to be removed. That then means that the
"CPU models" section in qemu-doc.texi is empty, so we
can just delete it (the @node and @section directives,
and the reference to it in the earlier @menu)
(I'm surprised this didn't cause 'make' to fail with
an error trying to build the texi docs.)

2) The bit of Makefile which lists the dependencies of
qemu-doc.html needs to be updated to remove
docs/qemu-cpu-models.texi.

3) we create a qemu-cpu-models.7 manpage, so the parts
of Makefile that currently handle creating it from the
texi need to be changed to do it from the rST instead.
You can look at how we handle qemu-block-drivers.7
for an example. Don't forget that you'll need to add
a line to docs/system/conf.py to get Sphinx to build
the manpage, as well as the makefile changes.
You can check how the manpage renders with
'man -l /path/to/builddir/docs/interop/qemu-cpu-models.7'

4) The qemu-cpu-models.texi uses a substitution
"@set qemu_system_x86 qemu-system-x86-64" so that
downstream RedHat can easily update the examples text
to refer to whatever they rename the binary to. The
equivalent of this in rST you can see in qemu-block-drivers.rst:
at the top of the file we have
=EF=BB=BF=EF=BB=BF
.. |qemu_system| replace:: qemu-system-x86_64

and then an example block using it is like:

.. parsed-literal::

  |qemu_system| linux.img -hdb fat:/my_directory

(you have to use a parsed-literal block and not the
usual :: so that the expansion is done.)

thanks
-- PMM

