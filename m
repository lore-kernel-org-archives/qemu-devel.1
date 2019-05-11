Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD97FC04AB1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 14:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F5F20989
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 14:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5xKfKAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F5F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPT3K-0005eK-Fr
	for qemu-devel@archiver.kernel.org; Sat, 11 May 2019 10:32:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPT2B-00053c-Ng
	for qemu-devel@nongnu.org; Sat, 11 May 2019 10:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPT2A-00011s-M1
	for qemu-devel@nongnu.org; Sat, 11 May 2019 10:31:31 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hPT2A-00011Z-Go
	for qemu-devel@nongnu.org; Sat, 11 May 2019 10:31:30 -0400
Received: by mail-ot1-x343.google.com with SMTP id l17so8127102otq.1
	for <qemu-devel@nongnu.org>; Sat, 11 May 2019 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=UKJnpdD5IBBS6al3F2stiQca1W5UVsxQ9K7YJqEyiGU=;
	b=d5xKfKApajMX/2zCJNDjq72OlgCKZ+ts4U5PnQLV43vBq6vTfBzfL5usp9jrSnH9Xo
	kPg59YWnmj8eNiK9FU28kMNbuQE3Pn8/+jOewp7JKYh2keP5IjTJRVUI5cespjJZySe8
	b78KWwbmNKBjFwPhPEBv9DRhy4m8+JpR0x80mCj5PGkFYVbF36R3QVzsjFjVorkbYcsW
	cjB2yV+MZE91EQXikFWyApM5k7kX3A36iZYjub9G/YhFcsWXHFThqP7yVYCLi1O2tLVU
	GdTYqpnShxfEFt0/d7EEU2nBD092C+TGvEB/4QQzEATp1fTk6Zvoj2IFH/VUYqjkj/wc
	vB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=UKJnpdD5IBBS6al3F2stiQca1W5UVsxQ9K7YJqEyiGU=;
	b=i+8ttElAqHJngh1PTIAdWO0ucbCT0Vb+8mejBa87E5be7wQSrywW3rSNxo/t8uZjk7
	/0DwHnhmncb39JxUxEkGA4ULyK6MuiHPs0eRap5UmguTyxbBcam2vV3Fb9adsmgtPmug
	vr4yn2yOKimnHXeCWvI67mZPhnf1X//j32p4GuOcozewtNywACQTZ/cS8aDcNFoswc6w
	CTZdkhRRslR2hrm8msqzRjffZwEiAt7o3UCFj4Dh5Mg1jRgABwK5SyKVDduz7nc3AlsI
	1UMm+mD2GIkncZAWQRaDyE+fL7XXjHeMAvPNaeQJSt9sHHhasRWQISBfsakpZRCXOUIv
	oZkg==
X-Gm-Message-State: APjAAAXlLQUAZwQ7FwInF35IUkG/uH0YjR8QbtWyrKxOwBqKdlO5mwK8
	z+E42zFwu3WAuAD23AT+yH9HBQzrT4yJViK9R9s=
X-Google-Smtp-Source: APXvYqzlUE0Gi49URf6N7y3FIyHWVX519lvOLCiNxDsSyWvzHl+JJiJDBKnIqWzlIaHKxDYSVskhp9yDMI0be6tznjE=
X-Received: by 2002:a05:6830:2085:: with SMTP id
	y5mr921500otq.68.1557585089668; 
	Sat, 11 May 2019 07:31:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 07:31:28
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 07:31:28
	-0700 (PDT)
In-Reply-To: <de1b6006-866c-b3a8-9726-4620821a9657@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-19-richard.henderson@linaro.org>
	<CAL1e-=iRwS-1LvP2m5oS2PAKigiDr0g8jRNP6xPV2b_9AYU08Q@mail.gmail.com>
	<de1b6006-866c-b3a8-9726-4620821a9657@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 11 May 2019 16:31:28 +0200
Message-ID: <CAL1e-=hDC9XFkNwJHV6phnr2QC-c3bsMpKqhjdZt_sBBmA1_Ug@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

A commit (code+message) should be as standalone as possible, and one should
not be forced to resort to reverse-engineering and perusing mailing list or
patchwork in order to reveal its true meaning in another commit message
altogether.

Thanks,
Aleksandar

> Are you suggesting that it is beneficial to copy-and-paste a common block
> explanation into 21 commit messages for each of target/foo/?
>
>
> r~
