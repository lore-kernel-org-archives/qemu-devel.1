Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8474C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 10:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F01F2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 10:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnqShipK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F01F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49043 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM9Gh-0005MP-JP
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 06:48:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM9Fi-0004zH-NT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM9Fh-0007Z1-PM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:47:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hM9Fh-0007YR-IB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:47:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id y5so1999203wma.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=WaCmP6OGJRS8DDPKKqPi9NvyFnJzzbqz0MdzZS/B5Yo=;
	b=qnqShipK0JE19N1qdiDHAS9zLQtPxbXIVwXM+RUEjwE8nv337HYgO4iTIYJw6tALik
	t7WDKatSSKPIoTvUZi5n3uTzv4xEfjghZKwRVJibz1qA1fp+RM+h61wJ3vMVKlj+BvFv
	fuZPnfYRQ1kQCEE5N81Pp32ReRTT9wuBDHdsRDLvz8mSVQazqjKu0mBdvxfDDfszFAq1
	ynhyR9D5ZeRAu91XV+mQZ+yLIkLKY/f21fCmMGEmQSNfvhVW3LrUT+EdCOOcUZ16JRsO
	Vx949L2yZ0axlxV6+TtOf0D97Pydyuwd+QQO8DOkqTKEZHnj2Y94utrTVWQ1L8eElfCq
	cgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=WaCmP6OGJRS8DDPKKqPi9NvyFnJzzbqz0MdzZS/B5Yo=;
	b=dcIeJ0w8RE/j8M0iobi9fA2APJDz91JCnN49OLy3DIm6qNRA8vHx5wOdzdV/aiQzI2
	MnwFtRov5I8ZPi1rDLPQs/9hI80PBle2gyAs9D/N4Naub/4L7JupweiFNMa74Bs/BWo1
	iVmj/kyVteTUAeTccVKdbStmHLX+6EtiZ+dsykrBX7Y363FOMtKP22E5F/wt3EjvOF07
	JcTZo04M7/PsAQtbhG2QiVt4HE9xLbiFYsa/VyBIi+J9vFs8XKnqk782j7TLr8ughtw1
	VG7mJf8UnJSDWOcThvhzLKL5eDkyDE45K29W3zIzqD3a97QufcFv38PcP7FOJ4KRQCWN
	uESQ==
X-Gm-Message-State: APjAAAXW0pAavoEIhHNmbxEEv6mfK47PeXgeZRZwaGzmvYmjPp46tJlo
	nHAIn347/JpBTcT4xHkle72LTA==
X-Google-Smtp-Source: APXvYqz8dq7UqdaEPY/RZWvCVlCs+Xn945v27F3xtQMDqp1B+m6kjB+N7y4axGaXOcvE986NJtDexA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr1797507wmj.136.1556794063435; 
	Thu, 02 May 2019 03:47:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	p2sm32605860wru.73.2019.05.02.03.47.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 03:47:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 6F4EE1FF87;
	Thu,  2 May 2019 11:47:42 +0100 (BST)
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190502040459.GE13618@umbus.fritz.box>
	<5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
Date: Thu, 02 May 2019 11:47:42 +0100
Message-ID: <87h8ad5e0h.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
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
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502104742.nLao38Eou3VoPcBwbn4AqtLAEHeYy-Z-7yMaZR9ICVw@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/1/19 9:04 PM, David Gibson wrote:
>> I've staged this tentatively in ppc-for-4.1.  However while it removes
>> the "Invalid ELF image" message I still get:
>>
>>   TEST    test-mmap (4096 byte pages) on ppc64le
>> test-mmap: Invalid argument
>> make[2]: *** [/home/dwg/qemu/tests/tcg/multiarch/Makefile.target:35: run=
-test-mmap-4096] Error 255
>> make[2]: Target 'run' not remade because of errors.
>> make[1]: *** [/home/dwg/qemu/tests/tcg/Makefile.include:71: run-guest-te=
sts] Error 2
>> make: *** [/home/dwg/qemu/tests/Makefile.include:1079: run-tcg-tests-ppc=
64le-linux-user] Error 2
>>
>> Running on a POWER9 host.  Do you see that as well?
>
> Yes.
>
> It's a semi-bogus test, really.  We can't run test-mmap
> with a page size smaller than that of the host, and of
> course ppc64le uses 64k pages.

The default run-test-mmap should just run against the host page size
(which may be bogus for the emulated architecture). The additional runs
are all added with EXTRA_RUNS:

  EXTRA_RUNS+=3Drun-test-mmap-4096 #run-test-mmap-65536

Currently the 64k pages are disabled because it crashes so somebody
should probably look into that.

Looking at -p setting the confusing named qemu_host_page_size doesn't
seem to reflect this in:

  #ifdef TARGET_NR_getpagesize
      case TARGET_NR_getpagesize:
          return TARGET_PAGE_SIZE;
  #endif

> This needs a different set of cleanups.  ;-)

I guess this is another use case for softmmu support in linux-user where
HOST_PAGE !=3D TARGET_PAGE?

--
Alex Benn=C3=A9e

