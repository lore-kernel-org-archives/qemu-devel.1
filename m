Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244F6C282E3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 05:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16BF214AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 05:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz4Lxc1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16BF214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52123 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJXCD-0002ny-4U
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 01:45:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hJX3j-0003hD-Lc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hJWzE-0006Ms-Ey
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:31:57 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hJWzE-0006Gy-7E; Thu, 25 Apr 2019 01:31:56 -0400
Received: by mail-ot1-x341.google.com with SMTP id s24so18323709otk.13;
	Wed, 24 Apr 2019 22:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=4uyZD2f61WGWLfj/eczIBZtflr9JP7bJKe1rH3EAaJ0=;
	b=fz4Lxc1lfE48CZLo0/6/dzA/FnRyaiS0ZP3+EUlxyBxZFmq0lOjAJ8wzFWdSeaKQrF
	5SMquxN6/H2vVLIWdaP5rOh4ORzz+ljPGFSBrDISlthWlCGVnKW7VvBN62lOOBdwBwXI
	yqkohfGUHqq0Stc/x6eB/R2rdiL4Q4PKJ2jUoLnHpllALq9oMCF2ADMsmoltVYhNPQZU
	seOeCndW+eO//Bhv37gRi9H0PySA90p8+GrnS28VvrMNtEhzW6sjk490EFqMk3uCt2eO
	vpJRV68xTxAgjx0z7ZKRLKh8yA0JbTXETGc9Yu2LiuxwwdONWAPs6tVfXZBS3GjaZHob
	mGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=4uyZD2f61WGWLfj/eczIBZtflr9JP7bJKe1rH3EAaJ0=;
	b=La4KQ//8jZfxTk4rDxY0HgQs7mN9g3Hy3HICD5BfSYY5zqUVPBHd2o+755yxgHsWbp
	uY/FySdOzvgUoOjCK5zB6zWtsJRudRTzCbp7f85R0ApD6mgwpY/0Wouzi5/nUNHkmFCv
	+mxsPOkWvDZ18PjS87brheeszR+u9PFHHRqNfXE943Dsbi05ppLKKxW7AYwI1GQWninM
	uFt1mX5NbYC58MdZ9GLCipjQW3Mt6oiuYhcW92hlllW8HTj2r/lIPVauLKxPgEVy+O3c
	drEM3viohEXelXl5csUAGK4iehjW3SSmps9GG6U8bChWqH4cbr+foAnbQAlsFut0vNC4
	3dJg==
X-Gm-Message-State: APjAAAVuHPD575AypeW+OdC66Ob0NMKYF6lZxbBSrzW1AoVRoQdhiSG2
	Ouvk+XIKAjP10bZYYMl2WJrhJj7HiRO29v7XZpo=
X-Google-Smtp-Source: APXvYqy2WgXUnsw+iLHnt+USkfsMLQTOWEhCAgf4Uvc8T7T8TMBbDedO99JIdDhe6VoBRxEtjTyzxwI3nrGJ3iOHo+0=
X-Received: by 2002:a9d:3ba1:: with SMTP id k30mr23665997otc.171.1556170310624;
	Wed, 24 Apr 2019 22:31:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:2004:0:0:0:0 with HTTP; Wed, 24 Apr 2019 22:31:49
	-0700 (PDT)
Received: by 2002:a05:6830:2004:0:0:0:0 with HTTP; Wed, 24 Apr 2019 22:31:49
	-0700 (PDT)
In-Reply-To: <73a7ce8a-1d73-95f7-84a6-f0960a397c22@linaro.org>
References: <mhng-4fc40e41-5464-469e-9334-1edc4f8294e3@palmer-si-x1e>
	<73a7ce8a-1d73-95f7-84a6-f0960a397c22@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 25 Apr 2019 07:31:49 +0200
Message-ID:
 <CAL1e-=gTwNJ94-ZdhPZR_THAi_TfiToox0KrxLZnhARbjUKLxw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/8] target/riscv: Name the
 argument sets for all of insn32 formats
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425053149.oQ4UZUfXItVh1XZ22zEvSIcWA16u2NoqKtJWrqH2A8Y@z>

On Apr 25, 2019 7:17 AM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> On 4/24/19 8:31 PM, Palmer Dabbelt wrote:
> >>  # Argument sets:
> >> +&empty
> >
> > If I understand decodetree correctly, this isn't used until patch 5.
> > Otherwise,
> >
>
> I think it's used as early as patch 3, but I haven't looked in detail to
be sure.
>
>
> r~
>

I think it is a very bad practice to leave the commit message empty, and,
in my view, the long-time contributor, like you, Richard, have the
obligation to always give examples of commit messages of good quality.
Leaving empty commit messages should not be a =E2=80=9Dprivelage=E2=80=9D t=
hat comes with
seniority, IMHO. On the contrary.

Sincerely,
Aleksandar
