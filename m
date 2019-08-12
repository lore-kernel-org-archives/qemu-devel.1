Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E34C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1891020842
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2JkaVmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1891020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCJn-0002RQ-De
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44186)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxCJJ-0001sU-1g
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxCJH-0005Ck-Sb
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:32:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxCJH-0005CT-Hh
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:32:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id z17so41850274otk.13
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pB8ZsW6f7nCkLoXdQ22/WbQ1CvJRblcAcF0FQRwUpKA=;
 b=H2JkaVmhBm6HCITEtgg0sZ/wcxbOOTK2IqMcAChCIh5Nc8JAPfif8tq44EcUrVpRM1
 u6XE9kSgcTfruHysTvq9LZ+nltnw55/dAr8qWFag2rqxN2RXyPzYm6rgxK0P5ukrFmxa
 nwhLOvcDwOUBKVE4ispRxXxsZj6jXNVHtRBpy8AmfEujCmm+/boAdNz40KfpdvgE/F48
 MZ8M7OQ3+4Zz+bNtZHi4L7p0t4BKbvedvv3C27TzTxq0QMblifv+rkZEWnylG8msVBDx
 R8CnKy7cZtzRk71DtRXwQW9CjP/o6PGquWJRjjXFzz08RKCBgXUyyYTssqDu6uhscxBJ
 Kh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pB8ZsW6f7nCkLoXdQ22/WbQ1CvJRblcAcF0FQRwUpKA=;
 b=X0WYrth6NAn/GVbkB8AXKh70u+XOt2rod7lkTejB22SeQMDB/LbaeRVTB+ztl+cQ0U
 /z/d4oLv1/h6hx+ftM1zjAmg09E/5zZfDXga1SkimV6Ec+I+w0ffinoao1hleSaTujpI
 eBFzBOQWy0yQI8eA0WyP6PS7zOPDzyoGNz283EiiBLjc33520KE5wyB/VAUgdXUrVyjS
 mOCcC5S09/MZ38dfR1C3QIEyckRD/YSRGP+r2Np1bKi7OJ6chQZV5UMioFPxcQEnK6Hu
 ytMR3iXyUzBdlH4iznf5yjMrKq8NS1Qxzw9jJSKAxdIe2DJWBmFOEy+U1Zf57UTemlC/
 qL9Q==
X-Gm-Message-State: APjAAAWpKSM1VZCr65gfPlceibHdDwLR1Jb8e35wGu8bg0Y0fRK5M8tT
 Hg5yhfJMYZvLOm12m1a6E4ViFTkiQeaAV79v5hJ00Q==
X-Google-Smtp-Source: APXvYqz4VBZbRtuOovHdSO+K14ISwPPzN0EMWQXNc6iB5oLmfksagXb79ovur+K0TPMfzRoepUV1sbdVmBFxAj2JvVw=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr27265965otj.97.1565623954335; 
 Mon, 12 Aug 2019 08:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGbAg_ANKR9zyAp3+pNRo6eVydQPaWrny62xk5NWr0DOD-7Jxg@mail.gmail.com>
 <CAFEAcA8jh7zxb02Yv-R4h-x99bsGjAg9zQMNgiSc=SQcthnyXw@mail.gmail.com>
 <CAGbAg_C002NyTSesdAj5iqWo07pP03EBbVx7OBkqZgqvRZ8J7Q@mail.gmail.com>
In-Reply-To: <CAGbAg_C002NyTSesdAj5iqWo07pP03EBbVx7OBkqZgqvRZ8J7Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2019 16:32:22 +0100
Message-ID: <CAFEAcA_=HTj_1r+t-JK_aHC=owoEFOZjBAp7W=-DGnSxSvrHXw@mail.gmail.com>
To: Esteban Bosse <estebanbosse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [Qemu-arm] Beagle Board support
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(I've added qemu-devel to the cc list; some people don't
read the qemu-arm list.)

On Sat, 10 Aug 2019 at 16:24, Esteban Bosse <estebanbosse@gmail.com> wrote:
> El s=C3=A1b., 10 ago. 2019 23:01, Peter Maydell <peter.maydell@linaro.org=
> escribi=C3=B3:
>> On Sat, 10 Aug 2019 at 04:39, Esteban Bosse <estebanbosse@gmail.com> wro=
te:
>> > I am new in this world, but I want to port the old beagle support for =
qemu-linaro to mainstream.
>>
>> That would certainly be nice. The major issue is that the
>> patchset in that tree is (a) often in an older style
>> of API that would need to be updated to use the current
>> recommended-practice APIs to go upstream, and (b) in
>> some places still has multiple changes tangled together
>> that would need to be disentangled to form a clean
>> reviewable patchset.
>
> (a) Sounds "not impossible" then for a beginer, hahaha.
> I am looking other boards like Musca to use it as example
>
> (b) I don't know yet how to make the patches I have to learn everything.
>
>>
>> I'm happy to provide advice and code review if you're
>> interested in doing this work and helping to maintain
>> it in the upstream tree.
>
>
> Yes! I am interested, I have a repo where I am doing my firsts trys to un=
derstand how qemu and the beagle are.
>
> How do you recommend to start?

Here's something I wrote up in 2015 the last time somebody
talked about maybe trying to get the beagle/omap3 changes into
master:

The initial steps here would be:
1) rebase the patchset on to qemu master and fix up
  the breakage due to API changes in qemu
[this will be moderately painful if you haven't been
following the API changes as they happened; if you're
interested in taking on the omap3 patches then I could
maybe do this step for you]
2) add support for direct boot of a guest kernel via
  "-kernel" (currently only "boot via an SD card image"
  is supported, which is awkward because the u-boot
  image insists on checking every device on the board
  and won't boot if any are missing)
3) build a cut-down minimally configured kernel that
  only needs the smallest possible set of devices
  [in particular, no SPI, I2C, MMC or graphics]
4) reorder the patchstack so that it starts with
  those relating to the required minimal device set
  and the SoC model and the board model, and the
  complicated ones to do with I2C etc are afterwards;
  check the kernel boots on this initial set
5) update the patches to correspond to current QEMU
  practice for QOM device modelling (the code in that
  tree is somewhat old and does many things in out
  of date ways)
6) submit the minimal-device patches and get them
  through code review and into QEMU
7) then start trying to clean up the remaining
  patches one device at a time

You'll need (or will learn :-)) familiarity with
handling stacks of patches in git, rebasing them,
reordering them, splitting them, and so on. Personally
I use 'stgit' as a frontend to doing that, but you can
do it all with raw git too.

Back in 2014 or whenever it was I abandoned the idea of
doing this upstreaming work I reckoned it was probably
a couple of months worth of (full-time) work to get
everything upstream.

thanks
-- PMM

