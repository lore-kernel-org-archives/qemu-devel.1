Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB981C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 21:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7406D21744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 21:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UztU697q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7406D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32857 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOqSM-0008D2-Cw
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 17:19:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hOqRW-0007ts-Sp
	for qemu-devel@nongnu.org; Thu, 09 May 2019 17:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hOqRV-0005bJ-6w
	for qemu-devel@nongnu.org; Thu, 09 May 2019 17:19:06 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:33276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hOqRU-0005Zr-SX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 17:19:05 -0400
Received: by mail-oi1-x232.google.com with SMTP id m204so3066131oib.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=d+BfAP7h37+XRSgVM2VQfA6qPrcyDobx0FqHpfWrVz0=;
	b=UztU697qsWv5Xelys+QkCjToDwWpW+iL/kIHQU3ZFb3l0mDRfpPqHZGNuAKpZAJ95m
	Iy9Lo7JFtoWDGnS11OCKgzEVZ1UIejDMlAB81/KE7TF9es5J9QBEaJAdemGWqvygLc4u
	N46cngYtrDJ8isnpNimQI0qgwoC9mIUbeuWIENuvw5fXRpOOZE4o7eallcyj5IDDgwkO
	hdpsTprCLiXBqOatQwMC6NIokTpc3ncrmbw9i7VnXDe6A/6yFWHwA/JrP77U9fKDQFUV
	jIxsF7ccNlcjLE9JTu7bWRhe+k/mukVpTI93UBInXtTVkKW9efXbFZY1LVQTX9vq2ujW
	8uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=d+BfAP7h37+XRSgVM2VQfA6qPrcyDobx0FqHpfWrVz0=;
	b=cfrIgUfXHmktQyuHpFB7lLvjoac5YBOTmQuDYJkIlDKwkIBkkRj/UPtzYaEaT9y0HI
	dmxbi2PIre1pkiaGck4h7aXmAhFi46l/Ww1uzmUCehfesSawE1IOHAqBfEUlcaeUdf80
	UrE5jem0V9mCNoe/9GkpUOGx2uo5xJcJhYijZxWDgMqWVtzkx92aDCzPUq5IxZcf9wj7
	54HFfVsWlaeq+07FhwzR666unrK/6fz/XZKmHFmFfo/Jik0N3B+nc/0smhpaVlbBCH0A
	dejHS9mOsITiivdnyHsoKgDRwUz4Yy8byZHMuFURx/jry3biepmiO8zRRhXgh55b1fre
	X6zw==
X-Gm-Message-State: APjAAAVJIgH6PVaWqTXNUQyh2T68ok46X4FtWpDrnpmBBv6St9Z3EncW
	RCYBL2n5bVz6/T7damp2dyQEvMJl4Tq23W6GyFg=
X-Google-Smtp-Source: APXvYqw20vHwx0F+2h0HoqhgZ3AnUMx2viRZ+CuXghIV0EtEusiuWJg+hB0QQJW5qCE2gt9iCpGFSqQvIPkok590pc8=
X-Received: by 2002:a54:4f99:: with SMTP id g25mr3117480oiy.136.1557436743022; 
	Thu, 09 May 2019 14:19:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP;
	Thu, 9 May 2019 14:19:02 -0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP;
	Thu, 9 May 2019 14:19:02 -0700 (PDT)
In-Reply-To: <b363c6b2-5186-de29-b341-4511da4049b8@redhat.com>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-19-richard.henderson@linaro.org>
	<CAL1e-=iRwS-1LvP2m5oS2PAKigiDr0g8jRNP6xPV2b_9AYU08Q@mail.gmail.com>
	<de1b6006-866c-b3a8-9726-4620821a9657@linaro.org>
	<b363c6b2-5186-de29-b341-4511da4049b8@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 May 2019 23:19:02 +0200
Message-ID: <CAL1e-=iJsjtNvTKjfROEEEd2EOFT+e_RaDr7dqcphOh3qs6zTw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 8, 2019 11:53 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =
wrote:
>
> Hi Richard, Aleksandar.
>
> On 5/8/19 4:32 PM, Richard Henderson wrote:
> > On 5/8/19 1:15 AM, Aleksandar Markovic wrote:
> >>
> >> On May 8, 2019 2:19 AM, "Richard Henderson" <
richard.henderson@linaro.org
> >> <mailto:richard.henderson@linaro.org>> wrote:
> >>>
> >>>
> >>>
> >>
> >> This commit message doesn=CB=8At explain the reason for the change, an=
d why
is this
> >> an improvement. The underlyng reason for distingishing between
env_cpu and
> >> env_archcpu cases is not explained too.
> >
> > It's certainly explained in the preceeding patches that introduce those
functions.
> >
> > Are you suggesting that it is beneficial to copy-and-paste a common
block
> > explanation into 21 commit messages for each of target/foo/?
>
>
> *) Richard:
>
> I tried to put myself in Aleksandar shoes. I believe Aleksandar is
> worried about his MIPS maintainer duty, wanting to Ack-by this patch.
>
> It is true that out of the context of the series, it is hard to see what
> is the problem you try to solve.
>
> You could copy/paste the explanation you used previously,
> with s/$arch/mips/:
>
> "Cleanup in the boilerplate that each target must define."
>
> "Combined uses of CPU(mips_env_get_cpu()) were failures to use
> the more proper, ENV_GET_CPU macro, now replaced by env_cpu."
>
> Now to clearly understand this patch we still need to look at the
> previous two arch-generic patches
> - "cpu: Replace ENV_GET_CPU with env_cpu" and
> - "cpu: Introduce env_archcpu".
>
> Also, it is tedious to copy/paste the same explanation, but thinking of
> forks or stable branch that cherry-pick not all but some commits of a
> series, it might be useful.
>
> Another guess is Aleksandar might have looked at the series cover, which
> is not well explained as your v2:
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07635.html
> I think you mistakenly copied the v1 blurb instead of the v2 one.
>
> So at some point I can understand Aleksandar frustation.
>
>
> *) Aleksandar:
>
> This series fall under the "Overall Guest CPU cores (TCG)" section
> maintained by Richard and Paolo. I think you have to see this series as
> a whole to understand the benefits of it.
>
> With the same reasoning, I believe you shouldn't worry to not give your
> Ack if you don't feel comfortable.
>
> I think Richard sent this v3 to simply address comments raised by the
> previous reviewer during v1/v2, where there was some discussions: I took
> it as "this is the last round before getting merged" (unless someone
> object).
>
> It is hard to make everybody happy on a such big project, with so many
> areas, lines of code, people, culture, etc... I believe we all try to
> give our best, neither the commiters nor the reviewers are perfect, but
> slowly we help this project to improve :)
>
>
> Best regards,
>
> Phil.

Richard, Philippe,

A commit message along the line that Philippe put together would be OK.

I can talk about this commit only - if other submaintainers are fine with
empty commit messages in key files for their target, that is their
business. I am certainly opposed to any empty commit messages in MIPS
files, and please, Richard, include a decent commit message for this
commit. I don't think I am asking much.

Thanks,
Aleksandar
