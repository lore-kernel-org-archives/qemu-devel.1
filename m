Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FBBC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF5C2146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2J2ZL4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF5C2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54293 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7ay-0000Bn-0i
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:50:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQ7a6-0008KS-E0
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQ7a4-0000Mz-Dp
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:49:14 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQ7a3-0000Le-VL
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:49:12 -0400
Received: by mail-oi1-x241.google.com with SMTP id y10so8807960oia.8
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=YvyUfM/AoMPARifNjW8j808apcLw985EXye3tHfi0pI=;
	b=K2J2ZL4+4a3Q8wvPZjsHHzP6acrkkT9jn9488PVHL1OE63YwwiNEbQKH05CuBcAqJP
	UYe0zI5ktt2o9jRSkZQg6ejEa6674gu4hZGQNkCtPpmKZT7O+fUbsmDAw/y+HRyq5y0l
	rWvL1+VNwZwzQsTaHxNCL1CCYHUWkjs2AV4+nVLguiJcpDp1Sl9vJ1lGlKCRaikemKj3
	Yp3XiPBPq/CgMT7kVnk16YJ0qgR0mZxprKmLqvOP3gYXBahelLtwHtwjtIhF2cn/ugJ1
	nR+cdIBrRsf2p6gSTQsQa5uGm5EAeTU+4KoRTQ3adgcxK+8foLumTT+r4jgQBejy5hpF
	zQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=YvyUfM/AoMPARifNjW8j808apcLw985EXye3tHfi0pI=;
	b=ADrwu3xYVwigJcTWWj/VB7Ujtyt+SvtW/LvD6nQZ7SuN5S23ZEtMGsfqxyukeeZ06u
	eTq+26o+/trfFNx8Lww9iYTCcitiftIoksWsKeGtpJCtst3lJ+wjYy1gcN6K57RQn1Ck
	unKOPVdDEFI5+ih4MuMTMrM+nbjxDGuoflph86b/GT7edH00RiBJ9YUTkAWcCddW/bSS
	1BTtp/3UaPVn3NNy2yNrk+0RN2Fa/LswJgVN+zUBH0Y7kQl5gFscnMDFnL+D+K2GpI2c
	zeP1FYyNTOKKRoIDBK7yGnzMzjoCW+4EKsGDx4kgg9W7AoSqm2wM6e744f8YkKBu6MmA
	V1TA==
X-Gm-Message-State: APjAAAX4S8IvvTrOkyppcXhw+4wZ7rBrqhlnb9M8KaSfYnERYI669UmA
	vm3Zt8tRbtyNGSR7sUc6Ie+MN2TAPwjTuJGu98sLcRHnttk=
X-Google-Smtp-Source: APXvYqwO+AH/oKPoDnK98XftN8XZj8qGF1u4Fik3zsReBdpSEHFwrWRbdaGI4ugg02OhLSsC+1BHNLIU+NDmwQN0yVI=
X-Received: by 2002:aca:5785:: with SMTP id l127mr11997129oib.48.1557740949733;
	Mon, 13 May 2019 02:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
	<1c4c309a-b785-64d2-60ce-4f0501fcc415@redhat.com>
	<E694EDDC-BFF1-4BE9-BFCC-43B303DE6BF7@gmail.com>
	<99b26a5a-d756-c1d7-0690-5e419075f5e0@redhat.com>
	<3D0C069E-C946-47E0-8A1C-EF5B28CFFB09@gmail.com>
	<2f0545db-a95c-d4ba-cc46-110c3b15e1e8@redhat.com>
	<20190513090830.GB15029@redhat.com>
In-Reply-To: <20190513090830.GB15029@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 10:48:58 +0100
Message-ID: <CAFEAcA9GamvcCmbxgcLNoSxKiJnMk-7p__13ct8GOuVQUM6KXQ@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
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
Cc: Programmingkid <programmingkidx@gmail.com>, Thomas Huth <thuth@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 10:08, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Sun, May 12, 2019 at 03:47:49PM +0200, Thomas Huth wrote:
> > Maybe try to clean the folder first:
> >
> >  rm -r capstone
> >  mkdir capstone
> >  make git-submodule-update
> >
> > If that does not help, maybe try a completely fresh git checkout?
>
> Rather than deleting stuff like that, it is best to use git to put your
> dir back to a clean state.
>
>    git submodule deinit --all --force
>    git clean -f -x -d

That git clean line will blow away any untracked files in
your entire tree, won't it? If so, better move anything
you cared about somewhere else first...

thanks
-- PMM

