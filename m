Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E88C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F04B20843
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PW84igl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F04B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhYF-0004vx-HD
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hzgte-0005QA-FS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hzgtd-0006qh-1n
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:36:26 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hzgtc-0006qL-Pi
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:36:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id k22so1142047oiw.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=io9mEUl7oyr4CMzVlw+cXp2/8mVhIjioh9NVE1TLqUs=;
 b=PW84igl1Qv5mq1rBFJkAWvhW+3c0DGxjrEKPfEjZu28Aq0tOXaayqE+L9UCxmDkEw1
 SK0UUp1VpHI8A3oBU75n+xWUa8Twlrsssbxf8assMbCPMXsjv0GWrmHioKDMiE7a3I57
 tGJdTlOlci+pIwgLiQICdRjC61VwmBAgvQxVE8TDyYJ4ZQV35fkV4Bz6SrXJbrHwc2C2
 ST4/U0mBstFzehno2uAYT2uxPR6z+nLsGQPT15G+fooxpIW6WaWSOvJ2/9FtP+Gc4f+P
 dnPQdloRajz9MdmBNS6AEb/e0GgHs69kI8AKLc6Mpqt08XTmPb/lqfQfZV8pt2vQCWxK
 0l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=io9mEUl7oyr4CMzVlw+cXp2/8mVhIjioh9NVE1TLqUs=;
 b=PmCtRtGeLGDSUGJ376sNJcEJK++h5m8wfnw6XCgcheZnHhBNNtTsyAWztLIywZ0Wy9
 05YbUPQx+A6JKbAo0fIiR6iAneCnj2RcHYl6qNg2cpvpL0aTPzoP1g6zElMj0+1ZOxH8
 TjlOkXyAJPOldce42wMi4G18HZlYeHb2fdavhoHAF+NVXIvsrfwh5GZn2X9XkreRThEp
 gwS+RRaMS/cm6SPb7ouU5vMLaboz7u2jXoNwjojXNV2qjw6mW9apYwGYj4SF9tm562+H
 QLL0SDHYTtYQqzbT7ZZNX000SRTdNTIQ15yKMrCa/GsenIexmMKvE5gDYT9m6oLXIhM7
 R9Cw==
X-Gm-Message-State: APjAAAVTYC5I0lLXjaNCR82CJNqAgOq5mtKs0vGCWEpfZERAZn9NEtK9
 7BZMzyj+PCSfyu10zo0chI5h351FIxcj5FFZUBc9wA==
X-Google-Smtp-Source: APXvYqxyVZGS8Y1/u33q8TN/1J6c6GLiu+/mjZHuFO4UyG34x/K4NkOroI64TCKaZ7Ukyve7cAABmglGHctidd2WtQ4=
X-Received: by 2002:aca:4b86:: with SMTP id y128mr3574201oia.163.1566218183839; 
 Mon, 19 Aug 2019 05:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <8fb538f3-dfdd-b427-727a-2e7c2120da09@gmail.com>
 <20e800e8-846b-a9c3-f840-826238b0818f@redhat.com>
 <CAFEAcA9xbPGSezS60cg6WzqpDR1u38aE0bXL_6pLs+H1TK3Ddw@mail.gmail.com>
 <dff44ac1-10e7-285e-467d-8dfe8c7a469b@redhat.com>
In-Reply-To: <dff44ac1-10e7-285e-467d-8dfe8c7a469b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 13:36:12 +0100
Message-ID: <CAFEAcA_FZrXNgmOFY4c8C=Xw9V-Ei4SNWvprAp_1rEt7P20hCA@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [qemu-s390x] linux-user: s390x issue on Fedora 30
 (dynamic library loader?)
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 13:22, David Hildenbrand <david@redhat.com> wrote:
> Thanks, running
>
> "ldconfig -c etc/ld.so.cache -r ."
>
> Seems to fix the issue for me. So you are sure the bug resides in glic
> and not in the qemu-user pieces of the library loader?

Pretty sure, yes. QEMU doesn't implement any of the dynamic loader:
it just loads the elf interpreter (ld.so) and the binary into
memory, and all dynamic loading is ld.so running as guest code
doing syscall. The problem IIRC is that ld.so just mmap()s
the ld.so.cache file in and wades through it:
https://sourceware.org/git/?p=glibc.git;a=blob;f=elf/dl-cache.c;h=d8d1e2344e612d98689cf7d7ad965822d0ab6ed1;hb=HEAD

and the magic-number checks are memcmp(), so the magic number
is the same for both big and little endian but the data structures
in the file are not endian-independent.

thanks
-- PMM

