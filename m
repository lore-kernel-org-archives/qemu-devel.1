Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED2C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7303D20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQdBIsC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7303D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR9ug-0007bb-Q4
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 02:30:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hR9tu-0007G4-Ge
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hR9tt-0003vb-DL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:29:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hR9tt-0003vK-7t
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:29:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id 203so1644165oid.13
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 23:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=7B4mPxhu9KsqvYaDyzM5s+Scgd6Yuci0Vchd9j6sU9I=;
	b=fQdBIsC69K1IuM9GwkUrlFjNHRYhmTwmf9iHoKkoFcrvZ4nJzmgOTRIUHetHAxlcE1
	Bybobt6iwh2XjveL63cKXExK5uSDUCQDcxB6Bd3SXXsSC9c+pslzx6bZivfhtwoRYtsl
	QlPtMVPI+GrnvwzTK3EHrF6P+VZV87T6GTZCoxjLzfPi65A4QtF5MQ6ly+xx7QHpW9pf
	6UGqtobGNEJ8+wS+jnFZDQ1LVNp+Pql4L4gk0OjAaq76EAnVOr6FtplbFr2bGk4W+A8a
	5Uin2GLwaeEMrd13uri7th2+tUqlTq2Wgql1K26ZBCQH1woFhrwsmuPDkg/d6ajOTddH
	rULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=7B4mPxhu9KsqvYaDyzM5s+Scgd6Yuci0Vchd9j6sU9I=;
	b=F0vTal5k3YDnglMUkksq1FB/SKTCxDnjqG5LRJLoGcSlarhd8nEltTU3oZrzjveYKw
	jaEsu+Motn41vrzEY/Fdg0Dscfp3rQ+LC7Q86IXSEebEpIRsEsC0vHM8sbu2EtyTwt16
	dPgJECUZNCUILtX3R8zgM+SzFnR5N9vY45t2WxxpHTfqwmh/1gIE/lqoH4r5CzEhftxh
	0UgWmgcxlMnuPddmmfIeBINp9yv++LRnkOn8409/ozB8Cic2igzX9tiGda1WimW25KHT
	/Hj/i81/fw1Ugyx5h6pxS9SLZ2CL31xkg9/FWCREhzZcb22AGaNt+KTzSgvhNytw/trI
	VRsg==
X-Gm-Message-State: APjAAAXUk4eeMzCxHkY7z7K/Hy+iq9uyo/EKJkYGsV2GxxBl7eN5D8t9
	YtE4sRnpw46zyUWqIMk4V7M92tjSj+I+4OqDE/s=
X-Google-Smtp-Source: APXvYqzpUY0ySusq/SBAtln0v8yirocB9/NxYJdov4tc1ywHNGcLtGKpU5w2x7InFE4Xj1a4PbxjCmjrbQ7T2DNPL1A=
X-Received: by 2002:aca:6086:: with SMTP id u128mr1303879oib.79.1557988196489; 
	Wed, 15 May 2019 23:29:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Wed, 15 May 2019 23:29:55
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Wed, 15 May 2019 23:29:55
	-0700 (PDT)
In-Reply-To: <de1b6006-866c-b3a8-9726-4620821a9657@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-19-richard.henderson@linaro.org>
	<CAL1e-=iRwS-1LvP2m5oS2PAKigiDr0g8jRNP6xPV2b_9AYU08Q@mail.gmail.com>
	<de1b6006-866c-b3a8-9726-4620821a9657@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 16 May 2019 08:29:55 +0200
Message-ID: <CAL1e-=jmL=2m7qE82yh9i9Wf6Lu=KBa3wPLeDS1UqRVTg8=FqA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 18/39] target/mips: Use env_cpu,
 env_archcpu
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 8, 2019 4:33 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> On 5/8/19 1:15 AM, Aleksandar Markovic wrote:
> >
> > On May 8, 2019 2:19 AM, "Richard Henderson" <
richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >>
> >>
> >>
> >
> > This commit message doesn=CB=8At explain the reason for the change, and=
 why
is this
> > an improvement. The underlyng reason for distingishing between  env_cpu
and
> > env_archcpu cases is not explained too.
>
> It's certainly explained in the preceeding patches that introduce those
functions.
>
> Are you suggesting that it is beneficial to copy-and-paste a common block
> explanation into 21 commit messages for each of target/foo/?

My objection, as I am the maintainer for MIPS part, is about this very
commit.

If you can't put together a classical standalone commit message which will
be according to our guidelines for writing a good commit message, the
minimum I expect from you is the following commit message:

=E2=80=9CPlease refer to the commit message(s) for commit(s) <here you list=
 the
titles of the commits that contain explanation for this commit> for
details.=E2=80=9D

If I were you, I would do the same in all similar cases, but again, at this
moment I am talking about this commit only, and I am insisting on not
allowing empty commit messages for any code I maintain, without exceptions.

Regards,
Aleksandar

>
> r~
