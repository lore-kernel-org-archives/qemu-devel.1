Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F4C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27117204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27117204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBOp-0005G6-Af
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:42:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1hUBMy-0003mu-UC
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1hUBMy-0007mY-3y
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:40:28 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:54830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1hUBMw-0007jO-5n
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:40:26 -0400
Received: by mail-it1-f182.google.com with SMTP id h20so16117904itk.4
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 07:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=QM2LU1LqM/8ZV6jtfzfZ/A7bCnsajI1B2rGsqQYdPOc=;
	b=L7lYs6PRy2jCSVPh9c8zjqZsNc92xNEco7q3LrtQu1CNJS9udSYITRSJfqevF1bjsa
	dhpj1/trOoFrk01sFA15MkO9h5pB4NWX2z7pPf4bKZCCcNpyJmUBHkYzoHZiQb07ktxG
	/6WOLWWLWxHUHDrohUZ1pUua0Drpkgn6hJZl1zivQ1zmSOcPervdgVlZRKAMl2AY32pJ
	A3KtUTqBLdDKLpj383dJTfZyz2j9v2NnXnd5Jk98op6hP0xS2zoT7KrKKJvmD5p7Ddoy
	FvbISZUwh+0BZ6GTL5/099dga0kf7RjHZ90snVkL7G0CL/2wt5+mSu818sVSAAihLJaS
	ofiw==
X-Gm-Message-State: APjAAAW0WEILke+R71Y32QCKj6hKjj2rMdYA2iPs+K9crUPZXQR52b1x
	we3HYgH67oHBGAp9dlla+DYoUIt4g6VrCjIfuHw=
X-Google-Smtp-Source: APXvYqzLH55o3l7aJbGBI1cn167AtGpmn5tQI0QkHMfizGqQ5OrUHFT42yJY4l2HNRhGaJ4YiGICpwdiBHndnZfgYoM=
X-Received: by 2002:a24:ac52:: with SMTP id m18mr16910799iti.146.1558708824816;
	Fri, 24 May 2019 07:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190521105344.11637-1-thuth@redhat.com>
	<20190521105344.11637-14-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-14-thuth@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Fri, 24 May 2019 04:11:11 -0400
Message-ID: <CAPyFy2Bgs6gf1p11rf5z9=h=4o0hhHGMXCSXK4RzmTMNc6VFww@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.166.182
Subject: Re: [Qemu-devel] [PULL 13/13] tests/qemu-iotests: Remove the
 "_supported_os Linux" line from many tests
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	Laurent Vivier <lvivier@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 07:06, Thomas Huth <thuth@redhat.com> wrote:
>
> A lot of tests run fine on FreeBSD and macOS, too - the limitation
> to Linux here was likely just copied-and-pasted from other tests.
> Thus remove the "_supported_os Linux" line from tests that run
> successful in our CI pipelines on FreeBSD and macOS.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Message-Id: <20190502084506.8009-6-thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Ed Maste <emaste@freebsd.org>

