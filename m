Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URI_NOVOWEL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C2C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 22:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B17020818
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 22:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTlMRgpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B17020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGA5u-0006D5-Du
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 18:28:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hGA54-0005rL-LL
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hGA50-0007ES-Hj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:28:02 -0400
Received: from mail-yw1-xc33.google.com ([2607:f8b0:4864:20::c33]:41331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hGA4z-0007Dr-KD
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:27:58 -0400
Received: by mail-yw1-xc33.google.com with SMTP id l15so6613569ywe.8
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=CzWwOMKuhwRz73sK8E2y0D1/FjnBhMwqyacO7FgQXyc=;
	b=vTlMRgpK/6AWJ+LEGIC3gUpjk9rMuLDYaG2YFBmmHZd6Eojqg5RD9vTAfeQ2Uf+J2j
	ffECmYXokz6uADx3KkOsaY7h2HJyzD2OQzqsOIcWA/O3ga4QKithdN+T0OxE7w80nfnV
	OGWdkSWOa482M7jFOEvAduOIr/o45RUH17GZ7nIeMtOszj3tlrk+V7BrBYUNDfVFCfUY
	bBdzASTyscIdo0r1lYcI+F6JpWQhlmluYGWN+5lj5NO76PpB/q1cEpM3dk5voujoLBGV
	NJW8miRze0jyYUQmQly5gSlQCHRqjKOzGCMeEuP1Y+6seTvU+OWJm2s0/tVRYaWqmdEB
	hXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=CzWwOMKuhwRz73sK8E2y0D1/FjnBhMwqyacO7FgQXyc=;
	b=rk3enXFe/3ZdpO+wiz3VsLy9/316B0cd8IS3e/+5PoG409EzAZiDD+w4t/pGOC/Z2P
	X4+b2mhdRlWc9Et5ZHpGJP81srQELWIraz5We11gX9D8IQeZzoeS8uGkbXII7XXEuXMD
	3ZNylvogE4CWJnrn+6OEitT1MDvIZPfwpxIxqQ4xrXHtbmb1hhBsa99dZOcCvcTKs1kY
	zNVKy+T1p/NXRO1J2KL53Pe/ul09kWu1seQVgHxo/jxx9CimUdlNJ4Bl0yCZIkxCSjGA
	sWEJWP2BBsubB0eeog60MCSdYwlviZfBHemRg8sW1+ULVNVlUK80nd9GqmwBrydkd2mf
	a5Ww==
X-Gm-Message-State: APjAAAV88vVdic9CuacScpL3ICfUIBGcZReevPdbYy8FJbb6zIXhJ20b
	QRhSYk8ZipHSSgHOGbVIyn7/zpif3ndaxhY4wOEGnkE0
X-Google-Smtp-Source: APXvYqwLBLZhMF7NukjNC2GWOJp2VGjL9URRFUVIH1cMJCiFjjjWksfkvsNZVECfpcC8jvnb1KcAeHp3yIT87Lh3feo=
X-Received: by 2002:a81:7d07:: with SMTP id y7mr61339212ywc.395.1555367276410; 
	Mon, 15 Apr 2019 15:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
In-Reply-To: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 15 Apr 2019 15:27:45 -0700
Message-ID:
 <CAMo8BfKNNpDmRqLOnJ9CGzOXhir+R1vsgoFgtOBiEpHU853rMA@mail.gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c33
Subject: Re: [Qemu-devel] recent QEMU-w64 does not load multiboot kernels by
 default
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415222745.pEZVUxvRrKggaMqW9Xu1AuzQy4lt-58L7JpR8tpscV4@z>

On Mon, Apr 15, 2019 at 3:20 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> recent qemu-system-i386 for w64 (e.g. one installed from
> https://qemu.weilnetz.de/w64/qemu-w64-setup-20190218.exe )
> refuses to load multiboot kernel by default:
>
>   "C:\Program Files\qemu\qemu-system-i386.exe" -kernel p:\tmp\kernel
>   C:\Program Files\qemu\qemu-system-i386.exe: Error loading
> uncompressed kernel without PVH ELF Note

Example kernel is available here:
http://jcmvbkbc.spb.ru/~dumb/tmp/201904151526/kernel

-- 
Thanks.
-- Max

