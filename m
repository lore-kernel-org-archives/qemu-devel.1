Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F071C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5829520652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jncnwjbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5829520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41973 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLOvV-0006iR-K0
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:19:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLOuY-0006Ki-BB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLOuX-00079e-GK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:18:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLOuX-000794-BJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:18:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id t189so7636760oih.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=AippH7xrGuSrR1A+ImmCYCJ5URYBDU6FLhOh1qpyWNY=;
	b=jncnwjbheqcuaBZP6rga5Rm7yaSF3ZWi/jLvRoR+W9e9cGdd6JjE5HI9CUS9agQerU
	AMgaABu5MduU/jATV+kUitUK6Tz3DohMTBACcKuRQAs9+BnDPoFjZ6fYphhN6VGbiJKr
	zuNtqz7DbqB+gkiHhJ7If7yFBwCLbdVFCxU8jtVkdDolM5Nruyz1gjB8LPyJ3dc0PszN
	KMHqPE64nylR+S8zHYOd7Rwap5U6qcIJAqUti2uLrY7aHlRhENfX3CLH3A7Y10Wjt5v6
	jgJorM96YeiTStH+PR39bMGL+r5HURVb6fhMZ516AOLO1rGsGRqyaApu9YY7v5FuPFPm
	k8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=AippH7xrGuSrR1A+ImmCYCJ5URYBDU6FLhOh1qpyWNY=;
	b=jPzAxg4UojEz+wJr2/kkBm8iSeoZRJhZkK5iUvi6j8UhRwHRMO48W03fXk0m7YyWH4
	VmjCxR6vE5GgmsSmUh0DGicwiYJ4NYNP8dbSFeaZLA2J2HRH5kfqNbOK81osy1fE6YSR
	NdJT31ecKTD2DM6pDrNU67HzXSx5Xu2lZCVe70DL/132G1vbm2mr7aiBq/RbxRReXdNx
	JrzcleA20yck2Hsnt8XkhWIoatalIzwpWfMQFMGWWE1CEzwomjEBE8hZjfj+hVXA9KoZ
	3vw48vl2enoIqsrxyKvKKpcSGqjpf5NZ8gFVYFXw4wNp+F2cOSZMkpulGuaNrWI7JED8
	DrZA==
X-Gm-Message-State: APjAAAXhB9iShEGn4XEEWQcL6vlDusmXhdgJ/wmgaTs/+nmZy7h1uTHD
	RrZfVQfpbP+1zwC8uLm7Yyk0tjlpJ7vu6UYOBS7mTQ==
X-Google-Smtp-Source: APXvYqwT9aYe78hyrVFlPMIVhcQliomBJCC2ixGg0UFTpJihpr+y3VI727Ez+TlkHQRwtzNFxNqQKxYyl4TKUvIN7Fo=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr2138249oie.48.1556615928276; 
	Tue, 30 Apr 2019 02:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <1556614240-36369-1-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1556614240-36369-1-git-send-email-like.xu@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:18:37 +0100
Message-ID:
 <CAFEAcA-SFrcbQMdv19tJw_baGR8c_ngR2CtsgZKVXMALOo=zoA@mail.gmail.com>
To: Like Xu <like.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] hw/arm/fsl-imx: move cpus initialization
 to realize time after smp_cpus check
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430091837.8x3VBqiGO6_DDybDLghgG3TePVR4fe4LVck4uNNIFlQ@z>

On Tue, 30 Apr 2019 at 09:52, Like Xu <like.xu@linux.intel.com> wrote:
>
> If "smp_cpus> FSL_IMX6_NUM_CPUS" fails in *_realize(), there is no need to
> initialize the CPUs in *_init(). So it could be better to create all cpus
> after the validity in *_realize(). On the other hand, it makes the usages
> of global variable smp_cpus more centrally for maintenance.

I'm not a great fan of this. I think that where possible
we should init child objects in the parent's init
function, and realize them in the realize function.
There are a few cases where we're forced to do the
child init in realize, but this doesn't seem like one of them.

thanks
-- PMM

